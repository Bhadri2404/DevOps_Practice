# Section 3: Control Flow — Conditionals and Loops

---

## 📑 Table of Contents

- [3.1 What Is Control Flow?](#31-what-is-control-flow)
- [3.2 Indentation — Python's Code Block Mechanism](#32-indentation--pythons-code-block-mechanism)
- [3.3 if Statements](#33-if-statements)
- [3.4 if-else Statements](#34-if-else-statements)
- [3.5 if-elif-else Statements](#35-if-elif-else-statements)
- [3.6 Nested if Statements](#36-nested-if-statements)
- [3.7 Ternary Operator (Conditional Expression)](#37-ternary-operator-conditional-expression)
- [3.8 for Loops](#38-for-loops)
- [3.9 The range() Function](#39-the-range-function)
- [3.10 while Loops](#310-while-loops)
- [3.11 break Statement](#311-break-statement)
- [3.12 continue Statement](#312-continue-statement)
- [3.13 pass Statement](#313-pass-statement)
- [3.14 Loop-else Pattern](#314-loop-else-pattern)
- [3.15 Nested Loops](#315-nested-loops)
- [3.16 enumerate() and zip()](#316-enumerate-and-zip)
- [3.17 Common Patterns in DevOps](#317-common-patterns-in-devops)
- [3.18 Section Summary and Review](#318-section-summary-and-review)

---

## 🎯 Learning Objectives

By the end of this section, you will:

1. Understand what control flow is and why programs need it
2. Master Python's indentation rules (why whitespace matters)
3. Write `if`, `elif`, `else` conditional logic confidently
4. Understand the difference between `for` and `while` loops
5. Use `range()` to generate number sequences
6. Control loop behavior with `break`, `continue`, and `pass`
7. Understand Python's unique loop-else pattern
8. Use `enumerate()` and `zip()` for cleaner loop code
9. Write nested conditionals and nested loops
10. Apply control flow to real DevOps scenarios: retry logic, health checks, batch processing

---

## 3.1 What Is Control Flow?

### Real-Life Analogy

Imagine you're driving to work. At every intersection, you make decisions:

- **If** the light is green → keep driving
- **Else if** the light is yellow → slow down
- **Else** (red) → stop

And sometimes you drive in circles:
- **While** you haven't found parking → keep driving around the block
- **For each** floor in the parking garage → check if there's a spot

This decision-making and repetition is **control flow** — the order in which instructions are executed.

### Why Control Flow Exists

Without control flow, a program would execute line 1, then line 2, then line 3... in a straight line forever. That's useless for real work because:

- You need to make **decisions** (if this, do that)
- You need to **repeat** actions (check 100 servers, not just 1)
- You need to **skip** certain things (ignore healthy servers, only alert on sick ones)
- You need to **stop early** (found the problem, no need to keep looking)

### The Two Pillars of Control Flow

```
┌──────────────────────────────────────────────────────────┐
│                    CONTROL FLOW                            │
├────────────────────────────┬─────────────────────────────┤
│      CONDITIONALS          │          LOOPS               │
│   (Making Decisions)       │     (Repeating Actions)      │
│                            │                              │
│   • if                     │   • for loop                 │
│   • if-else                │   • while loop               │
│   • if-elif-else           │   • break                    │
│   • nested if              │   • continue                 │
│   • ternary                │   • pass                     │
│                            │   • loop-else                │
└────────────────────────────┴─────────────────────────────┘
```

### Without Control Flow vs With Control Flow

```python
# WITHOUT control flow — always runs the same way
print("Checking server...")
print("Server is healthy")     # What if it's NOT healthy?
print("Sending traffic")       # This would be WRONG if server is down!

# WITH control flow — makes intelligent decisions
print("Checking server...")
if server_status == "healthy":
    print("Server is healthy")
    print("Sending traffic")
else:
    print("Server is DOWN!")
    print("Triggering failover")
```

---

## 3.2 Indentation — Python's Code Block Mechanism

### Why This Topic Matters So Much

In most programming languages (Java, C, JavaScript), code blocks are defined by curly braces `{}`:

```javascript
// JavaScript
if (x > 5) {
    console.log("big");    // Inside the if block
    console.log("number"); // Inside the if block
}
console.log("done");       // Outside the if block
```

Python uses **indentation** (whitespace at the beginning of a line) instead of braces:

```python
# Python
if x > 5:
    print("big")       # Indented = inside the if block
    print("number")    # Same indentation = still inside
print("done")          # Not indented = outside the if block
```

### The Rules

1. **A colon `:` starts a new block** — after `if`, `else`, `elif`, `for`, `while`, `def`, `class`, etc.
2. **Everything inside the block must be indented** by the same amount
3. **Standard indentation is 4 spaces** (PEP 8 standard)
4. **Do NOT mix tabs and spaces** — Python 3 will throw an error
5. **The block ends when indentation returns** to the previous level

### Visual Explanation

```python
if condition:          # ← Colon starts a block
    line_1             # ← 4 spaces = inside the block
    line_2             # ← 4 spaces = still inside
    if nested:         # ← Another colon = nested block starts
        line_3         # ← 8 spaces = inside nested block
        line_4         # ← 8 spaces = still inside nested block
    line_5             # ← 4 spaces = back to first block (nested block ended)
line_6                 # ← 0 spaces = outside all blocks
```

### Common Mistakes

```python
# ❌ Mistake 1: Forgetting the colon
if x > 5
    print("big")       # SyntaxError: expected ':'

# ❌ Mistake 2: Inconsistent indentation
if x > 5:
    print("big")
      print("number")  # IndentationError: unexpected indent

# ❌ Mistake 3: No indentation after colon
if x > 5:
print("big")           # IndentationError: expected an indented block

# ❌ Mistake 4: Mixing tabs and spaces
if x > 5:
    print("big")       # 4 spaces
	print("number")    # 1 tab — TabError in Python 3!
```

### Best Practice

Configure your code editor to:
- Use **spaces, not tabs**
- Set tab key to insert **4 spaces**
- Show whitespace characters (so you can see problems)

Every modern editor (VS Code, PyCharm, Vim) can be configured this way.

### Why Python Chose Indentation Over Braces

Guido van Rossum's reasoning:
1. Code that LOOKS structured IS structured (no misleading formatting)
2. Forces everyone to write readable code
3. Reduces visual noise (no `{` `}` everywhere)
4. You already indent code for readability — why not make it meaningful?

---

## 3.3 if Statements

### What It Is

The `if` statement evaluates a condition. If the condition is `True`, the indented block runs. If `False`, the block is skipped entirely.

### Syntax

```python
if condition:
    # This code runs ONLY if condition is True
    statement_1
    statement_2
```

### How It Works Internally

```
┌─────────────────────┐
│   Evaluate          │
│   condition         │
└─────────┬───────────┘
          │
    ┌─────┴─────┐
    │           │
  True        False
    │           │
    ▼           ▼
┌────────┐  ┌────────────┐
│ Run    │  │ Skip block │
│ block  │  │ entirely   │
└────────┘  └────────────┘
    │           │
    └─────┬─────┘
          ▼
   Continue with
   next line after block
```

### Simple Example

```python
cpu_usage = 85

if cpu_usage > 80:
    print("⚠️  WARNING: High CPU usage detected!")
    print(f"Current usage: {cpu_usage}%")

print("Monitoring continues...")
```

**Expected Output:**
```
⚠️  WARNING: High CPU usage detected!
Current usage: 85%
Monitoring continues...
```

### Line-by-Line Explanation

| Line | What Happens |
|------|--------------|
| `cpu_usage = 85` | Creates variable pointing to integer 85 |
| `if cpu_usage > 80:` | Evaluates `85 > 80` → `True` → enter the block |
| `print("⚠️ ...")` | Runs because condition was True |
| `print(f"Current...")` | Runs because still inside the block (same indentation) |
| `print("Monitoring...")` | ALWAYS runs — it's outside the if block (no indentation) |

### What If Condition Is False?

```python
cpu_usage = 45

if cpu_usage > 80:
    print("⚠️  WARNING: High CPU usage!")  # SKIPPED
    print(f"Current usage: {cpu_usage}%")   # SKIPPED

print("Monitoring continues...")             # Runs regardless
```

**Output:**
```
Monitoring continues...
```

The entire indented block is skipped because `45 > 80` is `False`.

### Multiple Conditions (Using Logical Operators)

```python
cpu_usage = 90
memory_usage = 85

if cpu_usage > 80 and memory_usage > 80:
    print("🚨 CRITICAL: Both CPU and memory are high!")
```

### Common Mistake: Using `=` Instead of `==`

```python
status = "running"

# ❌ WRONG — This assigns, not compares
if status = "running":      # SyntaxError in Python (thankfully!)
    print("OK")

# ✅ CORRECT
if status == "running":
    print("OK")
```

Python protects you here — unlike C where `if (x = 5)` is valid but buggy.

---

## 3.4 if-else Statements

### What It Is

`if-else` provides two paths: one for when the condition is True, another for when it's False. **Exactly one** path always executes.

### Real-Life Analogy

- **If** you have an umbrella → walk outside
- **Else** → take a taxi

You always do ONE of these. Never both. Never neither.

### Syntax

```python
if condition:
    # Runs when True
    true_block
else:
    # Runs when False
    false_block
```

### Simple Example

```python
disk_usage = 92

if disk_usage < 90:
    print("✅ Disk usage is normal")
    print(f"Current: {disk_usage}%")
else:
    print("🚨 ALERT: Disk usage critical!")
    print(f"Current: {disk_usage}% — cleanup needed!")
    print("Triggering automated cleanup...")
```

**Expected Output:**
```
🚨 ALERT: Disk usage critical!
Current: 92% — cleanup needed!
Triggering automated cleanup...
```

### Flow Diagram

```
          ┌──────────────────┐
          │  disk_usage < 90 │
          └────────┬─────────┘
                   │
         ┌─────── ┴ ───────┐
         │                  │
       True               False
         │                  │
         ▼                  ▼
   ┌───────────┐    ┌─────────────┐
   │ "Normal"  │    │ "Critical!" │
   └───────────┘    └─────────────┘
         │                  │
         └────────┬─────────┘
                  ▼
         Continue program...
```

### Production Example: Deployment Decision

```python
test_passed = True
branch = "main"

if test_passed and branch == "main":
    print("✅ All checks passed — deploying to production")
else:
    print("❌ Deployment blocked — tests failed or wrong branch")
```

---

## 3.5 if-elif-else Statements

### What It Is

When you have **more than two** possible paths, use `elif` (short for "else if"). Python checks conditions **top to bottom** and executes the **first one that is True**. If none are True, the `else` block runs.

### Real-Life Analogy

A traffic light:
- **If** green → drive
- **Elif** yellow → slow down
- **Elif** red → stop
- **Else** → light is broken, proceed with caution

### Syntax

```python
if condition_1:
    block_1
elif condition_2:
    block_2
elif condition_3:
    block_3
else:
    default_block
```

### Critical Behavior: Only ONE Block Executes

Even if multiple conditions are True, Python executes only the **first matching** block, then skips the rest:

```python
score = 95

if score >= 90:
    print("A")     # ← This runs
elif score >= 80:
    print("B")     # ← SKIPPED (even though 95 >= 80 is True!)
elif score >= 70:
    print("C")     # ← SKIPPED
else:
    print("F")     # ← SKIPPED
```

**Output:** `A`

**Key Insight:** Order matters! Put the most specific/restrictive condition first.

### DevOps Example: Server Health Classification

```python
cpu_usage = 73

if cpu_usage >= 95:
    severity = "CRITICAL"
    action = "Page on-call engineer immediately"
elif cpu_usage >= 85:
    severity = "HIGH"
    action = "Send Slack alert to team"
elif cpu_usage >= 70:
    severity = "MEDIUM"
    action = "Log warning, continue monitoring"
elif cpu_usage >= 50:
    severity = "LOW"
    action = "Normal operation, no action needed"
else:
    severity = "IDLE"
    action = "Server is underutilized, consider scaling down"

print(f"CPU: {cpu_usage}% | Severity: {severity}")
print(f"Action: {action}")
```

**Expected Output:**
```
CPU: 73% | Severity: MEDIUM
Action: Log warning, continue monitoring
```

### Line-by-Line Execution

1. `cpu_usage = 73` — Variable set to 73
2. `if cpu_usage >= 95:` — Is `73 >= 95`? → **False** → skip this block
3. `elif cpu_usage >= 85:` — Is `73 >= 85`? → **False** → skip this block
4. `elif cpu_usage >= 70:` — Is `73 >= 70`? → **True** → execute this block!
5. Sets `severity = "MEDIUM"` and `action = "Log warning..."`
6. Remaining `elif` and `else` are **completely skipped** (already found a match)
7. Print statements run with the values set

### Common Mistake: Wrong Order

```python
# ❌ WRONG ORDER — First condition catches everything!
cpu_usage = 98

if cpu_usage >= 50:        # 98 >= 50 is True → runs this
    print("LOW")           # But 98 should be CRITICAL!
elif cpu_usage >= 70:
    print("MEDIUM")        # Never reached
elif cpu_usage >= 95:
    print("CRITICAL")      # Never reached
```

**Rule:** Always go from most restrictive to least restrictive (highest threshold first).

### When `else` Is Optional

```python
# else is not required
http_status = 200

if http_status == 404:
    print("Not found")
elif http_status == 500:
    print("Server error")
elif http_status == 200:
    print("Success")
# No else — if status is something else, nothing happens
```

**Best Practice:** Include `else` as a catch-all when you want to handle unexpected values:

```python
if http_status == 200:
    print("OK")
elif http_status == 404:
    print("Not found")
else:
    print(f"Unexpected status: {http_status}")  # Catches everything else
```

---

## 3.6 Nested if Statements

### What It Is

An `if` statement inside another `if` statement. Used when you need to check a secondary condition only after the first condition passes.

### Real-Life Analogy

- **If** you're at a restaurant:
  - **If** they have pizza:
    - Order pizza
  - **Else:**
    - Order pasta

You only ask about pizza IF you're already at the restaurant.

### Example

```python
server_status = "running"
cpu_usage = 92

if server_status == "running":
    print("Server is up")
    
    if cpu_usage > 90:
        print("🚨 But CPU is critically high!")
        print("Scaling horizontally...")
    elif cpu_usage > 70:
        print("⚠️  CPU is elevated, monitoring closely")
    else:
        print("✅ CPU is normal")
else:
    print("❌ Server is DOWN — initiating restart")
```

**Expected Output:**
```
Server is up
🚨 But CPU is critically high!
Scaling horizontally...
```

### When to Use Nested if vs Combined Conditions

```python
# Nested if
if server_status == "running":
    if cpu_usage > 90:
        print("Alert!")

# Equivalent with combined condition
if server_status == "running" and cpu_usage > 90:
    print("Alert!")
```

Both work, but:
- Use **combined conditions** when both checks are simple
- Use **nested if** when the outer condition needs its own logic, or when you need different actions at each level

### Warning: Don't Nest Too Deep

```python
# ❌ BAD — Too many nested levels (hard to read)
if a:
    if b:
        if c:
            if d:
                print("deep!")

# ✅ BETTER — Use early returns or combined conditions
if a and b and c and d:
    print("deep!")
```

**Production Best Practice:** If you find yourself nesting more than 2-3 levels, refactor your logic using:
- Combined conditions with `and`/`or`
- Early returns (in functions)
- Guard clauses (check failure conditions first, exit early)

---

## 3.7 Ternary Operator (Conditional Expression)

### What It Is

A one-line shorthand for simple if-else assignments. Also called a **conditional expression**.

### Syntax

```python
value = true_result if condition else false_result
```

### Example

```python
cpu_usage = 85

# Long form
if cpu_usage > 80:
    status = "HIGH"
else:
    status = "NORMAL"

# Ternary (one line — same result)
status = "HIGH" if cpu_usage > 80 else "NORMAL"

print(status)  # HIGH
```

### When to Use

✅ Simple value assignment based on a single condition
✅ Short expressions that fit on one line

### When NOT to Use

❌ Complex logic with multiple conditions
❌ When it makes the code harder to read
❌ When the true/false results are long expressions

```python
# ❌ BAD — Too complex for ternary
result = "critical alert" if cpu > 90 and mem > 90 and disk > 90 else "normal" if cpu < 50 else "warning"

# ✅ GOOD — Use regular if-elif-else
if cpu > 90 and mem > 90 and disk > 90:
    result = "critical alert"
elif cpu < 50:
    result = "normal"
else:
    result = "warning"
```

### DevOps Use Case

```python
environment = "production" if branch == "main" else "staging"
log_level = "DEBUG" if env == "development" else "INFO"
protocol = "https" if is_secure else "http"
```

---

## 3.8 for Loops

### What It Is

A `for` loop iterates over a **sequence** (list, string, range, tuple, dictionary, etc.) and executes a block of code **once for each item** in the sequence.

### Real-Life Analogy

Imagine a teacher taking attendance:
- **For each** student in the class roster:
  - Call their name
  - Mark them present or absent

The teacher doesn't decide how many times to loop — they iterate through the entire roster.

### Syntax

```python
for variable in sequence:
    # This block runs once per item
    # 'variable' holds the current item
    do_something_with(variable)
```

### How It Works Internally

```
┌──────────────────────────────────────┐
│  for item in [A, B, C, D]:          │
│      process(item)                   │
└──────────────────────────────────────┘

Iteration 1: item = A → process(A)
Iteration 2: item = B → process(B)
Iteration 3: item = C → process(C)
Iteration 4: item = D → process(D)
Loop ends (no more items)
```

### Simple Example: Iterating Over a List

```python
servers = ["web-01", "web-02", "db-01", "cache-01"]

for server in servers:
    print(f"Checking health of {server}...")
```

**Expected Output:**
```
Checking health of web-01...
Checking health of web-02...
Checking health of db-01...
Checking health of cache-01...
```

### Line-by-Line Explanation

| Execution Step | What Happens |
|----------------|--------------|
| Loop starts | Python looks at `servers` — it has 4 items |
| Iteration 1 | `server` = `"web-01"` → print runs |
| Iteration 2 | `server` = `"web-02"` → print runs |
| Iteration 3 | `server` = `"db-01"` → print runs |
| Iteration 4 | `server` = `"cache-01"` → print runs |
| Loop ends | No more items → move to next line after the loop |

### Iterating Over a String

Strings are sequences of characters, so you can loop through them:

```python
status_code = "404"

for char in status_code:
    print(f"Digit: {char}")
```

**Output:**
```
Digit: 4
Digit: 0
Digit: 4
```

### Iterating Over a Dictionary

```python
server_metrics = {
    "cpu": 78,
    "memory": 85,
    "disk": 62
}

# Iterate over keys (default behavior)
for metric in server_metrics:
    print(metric)
# cpu, memory, disk

# Iterate over key-value pairs
for metric, value in server_metrics.items():
    print(f"{metric}: {value}%")
```

**Output:**
```
cpu: 78%
memory: 85%
disk: 62%
```

### DevOps Production Example: Health Check

```python
servers = ["10.0.0.1", "10.0.0.2", "10.0.0.3", "10.0.0.4"]
healthy_count = 0
unhealthy_servers = []

for ip in servers:
    # Simulated health check (in reality, you'd ping or make HTTP request)
    is_healthy = ip != "10.0.0.3"  # Simulating one failed server
    
    if is_healthy:
        healthy_count += 1
        print(f"  ✅ {ip} — healthy")
    else:
        unhealthy_servers.append(ip)
        print(f"  ❌ {ip} — UNHEALTHY")

print(f"\nSummary: {healthy_count}/{len(servers)} servers healthy")
if unhealthy_servers:
    print(f"Action needed for: {unhealthy_servers}")
```

**Expected Output:**
```
  ✅ 10.0.0.1 — healthy
  ✅ 10.0.0.2 — healthy
  ❌ 10.0.0.3 — UNHEALTHY
  ✅ 10.0.0.4 — healthy

Summary: 3/4 servers healthy
Action needed for: ['10.0.0.3']
```

---

## 3.9 The range() Function

### What It Is

`range()` generates a sequence of numbers. It doesn't create a list in memory — it generates numbers **on demand** (lazy evaluation), making it memory-efficient even for billions of numbers.

### Why It Exists

When you need to run a loop a specific number of times, or need a sequence of numbers, you use `range()`.

### Three Forms

```python
range(stop)              # 0, 1, 2, ..., stop-1
range(start, stop)       # start, start+1, ..., stop-1
range(start, stop, step) # start, start+step, start+2*step, ...
```

### Examples

```python
# range(stop) — starts at 0, goes up to (not including) stop
for i in range(5):
    print(i)
# 0, 1, 2, 3, 4

# range(start, stop) — starts at start
for i in range(1, 6):
    print(i)
# 1, 2, 3, 4, 5

# range(start, stop, step) — jumps by step
for i in range(0, 20, 5):
    print(i)
# 0, 5, 10, 15

# Counting backwards
for i in range(10, 0, -1):
    print(i)
# 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
```

### Critical Detail: Stop Value Is EXCLUDED

```python
for i in range(3):
    print(i)
# 0, 1, 2  ← NOT 3!

# If you want 1 to 10:
for i in range(1, 11):  # Must use 11, not 10!
    print(i)
```

**Why?** This design means `range(n)` gives exactly `n` items (0 through n-1), which aligns with zero-based indexing.

### DevOps Example: Retry Logic

```python
max_retries = 5

for attempt in range(1, max_retries + 1):
    print(f"Attempt {attempt}/{max_retries}: Connecting to database...")
    
    # Simulated connection attempt
    connection_successful = (attempt == 3)  # Succeeds on 3rd try
    
    if connection_successful:
        print(f"✅ Connected on attempt {attempt}!")
        break
    else:
        print(f"  ❌ Failed. Retrying...")
```

**Expected Output:**
```
Attempt 1/5: Connecting to database...
  ❌ Failed. Retrying...
Attempt 2/5: Connecting to database...
  ❌ Failed. Retrying...
Attempt 3/5: Connecting to database...
✅ Connected on attempt 3!
```

### Memory Efficiency

```python
# This does NOT create a list of 1 billion numbers in memory
# It generates them one at a time
for i in range(1_000_000_000):
    if i == 5:
        print("Found it")
        break
# Uses almost zero memory!
```

---

## 3.10 while Loops

### What It Is

A `while` loop repeats a block of code **as long as a condition remains True**. Unlike `for` loops (which iterate over a known sequence), `while` loops run an **unknown number of times** — until some condition changes.

### Real-Life Analogy

- **While** the traffic light is red → keep waiting
- **While** the download is not complete → keep downloading
- **While** the patient has a fever → keep giving medicine

You don't know in advance how long you'll wait.

### Syntax

```python
while condition:
    # This repeats as long as condition is True
    do_something
    # Something must eventually make condition False!
```

### How It Works

```
        ┌──────────────┐
        │  Check       │ ◄──────────────┐
        │  condition   │                │
        └──────┬───────┘                │
               │                        │
        ┌──────┴──────┐                 │
      True          False               │
        │              │                │
        ▼              ▼                │
   ┌─────────┐   Exit loop             │
   │ Execute │                          │
   │ block   │──────────────────────────┘
   └─────────┘     (loop back to check)
```

### Simple Example

```python
count = 1

while count <= 5:
    print(f"Iteration {count}")
    count += 1     # CRITICAL: without this, infinite loop!

print("Loop finished")
```

**Expected Output:**
```
Iteration 1
Iteration 2
Iteration 3
Iteration 4
Iteration 5
Loop finished
```

### Execution Trace

| Step | `count` value | Condition `count <= 5` | Action |
|------|:---:|:---:|--------|
| 1 | 1 | True | Print, count becomes 2 |
| 2 | 2 | True | Print, count becomes 3 |
| 3 | 3 | True | Print, count becomes 4 |
| 4 | 4 | True | Print, count becomes 5 |
| 5 | 5 | True | Print, count becomes 6 |
| 6 | 6 | **False** | **Exit loop** |

### ⚠️ DANGER: Infinite Loops

```python
# ❌ This runs FOREVER — condition never becomes False
count = 1
while count <= 5:
    print(f"Iteration {count}")
    # Forgot count += 1 !!!
```

**How to stop an infinite loop:** Press `Ctrl + C` in the terminal.

**Prevention:** Always ensure something inside the loop eventually makes the condition False.

### When to Use while vs for

| Use `for` when... | Use `while` when... |
|-------------------|---------------------|
| You know the number of iterations | You don't know how many iterations |
| Iterating over a collection | Waiting for a condition to change |
| Processing each item in a list | Polling/checking repeatedly |
| Using `range()` for counting | Retry logic with unknown attempts |

### DevOps Example: Polling Until Service is Ready

```python
import time

max_wait_seconds = 60
elapsed = 0
interval = 5
service_ready = False

print("Waiting for service to become ready...")

while not service_ready and elapsed < max_wait_seconds:
    # Simulated check (in real code: HTTP request to health endpoint)
    service_ready = (elapsed >= 20)  # Simulates ready after 20 seconds
    
    if not service_ready:
        print(f"  ⏳ Not ready yet ({elapsed}s elapsed). Waiting {interval}s...")
        time.sleep(interval)  # Actually wait (commented out for demo)
        elapsed += interval

if service_ready:
    print(f"✅ Service is ready! (took {elapsed}s)")
else:
    print(f"❌ Timeout! Service not ready after {max_wait_seconds}s")
```

**Expected Output:**
```
Waiting for service to become ready...
  ⏳ Not ready yet (0s elapsed). Waiting 5s...
  ⏳ Not ready yet (5s elapsed). Waiting 5s...
  ⏳ Not ready yet (10s elapsed). Waiting 5s...
  ⏳ Not ready yet (15s elapsed). Waiting 5s...
✅ Service is ready! (took 20s)
```

---

## 3.11 break Statement

### What It Is

`break` immediately **exits** the loop entirely. No more iterations happen. Execution continues after the loop.

### Real-Life Analogy

You're searching through a stack of papers for a specific document. The moment you find it, you **stop searching** — you don't continue through the rest of the stack.

### Example

```python
servers = ["web-01", "web-02", "web-03", "db-01", "cache-01"]

print("Looking for the database server...")

for server in servers:
    print(f"  Checking: {server}")
    if server.startswith("db"):
        print(f"  ✅ Found database server: {server}")
        break  # Stop looking — we found it!

print("Search complete.")
```

**Expected Output:**
```
Looking for the database server...
  Checking: web-01
  Checking: web-02
  Checking: web-03
  Checking: db-01
  ✅ Found database server: db-01
Search complete.
```

Notice `cache-01` was never checked — `break` exited the loop early.

### break in while Loops

```python
# Common pattern: infinite loop with break condition
attempt = 0

while True:  # Runs forever... unless we break
    attempt += 1
    print(f"Attempt {attempt}...")
    
    # Simulated success condition
    if attempt == 3:
        print("✅ Success!")
        break
    
    if attempt >= 10:
        print("❌ Max attempts reached")
        break
```

This `while True` + `break` pattern is very common in production for:
- Retry loops
- Event processing
- Daemon processes
- Queue consumers

---

## 3.12 continue Statement

### What It Is

`continue` **skips the rest of the current iteration** and jumps to the next iteration of the loop. Unlike `break` (which exits the loop entirely), `continue` just skips one iteration.

### Real-Life Analogy

You're reviewing a stack of resumes. If a resume doesn't have the required skill, you put it aside (**skip it**) and move to the next one. You don't stop reviewing entirely — you just skip that one.

### Example

```python
servers = ["web-01", "web-02", "MAINTENANCE-db-01", "web-03", "MAINTENANCE-cache-01"]

print("Deploying to available servers:")

for server in servers:
    if server.startswith("MAINTENANCE"):
        print(f"  ⏭️  Skipping {server} (in maintenance)")
        continue  # Skip to next server
    
    print(f"  🚀 Deploying to {server}")

print("Deployment complete.")
```

**Expected Output:**
```
Deploying to available servers:
  ⏭️  Skipping MAINTENANCE-db-01 (in maintenance)
  🚀 Deploying to web-01
  🚀 Deploying to web-02
  🚀 Deploying to web-03
  ⏭️  Skipping MAINTENANCE-cache-01 (in maintenance)
Deployment complete.
```

Wait — the output order depends on list order. Let me correct:

```
Deploying to available servers:
  🚀 Deploying to web-01
  🚀 Deploying to web-02
  ⏭️  Skipping MAINTENANCE-db-01 (in maintenance)
  🚀 Deploying to web-03
  ⏭️  Skipping MAINTENANCE-cache-01 (in maintenance)
Deployment complete.
```

### break vs continue Visual

```
for item in items:
    if skip_condition:
        continue       ─────── Goes back to TOP of loop (next iteration)
    
    if stop_condition:
        break          ─────── Exits loop ENTIRELY

    normal_processing
```

---

## 3.13 pass Statement

### What It Is

`pass` does **absolutely nothing**. It's a placeholder that satisfies Python's syntax requirement for a non-empty block.

### Why It Exists

Python requires indented code after every `:`. If you're not ready to write the code yet (planning, scaffolding), you need `pass` to avoid a syntax error.

```python
# ❌ Error — empty block not allowed
if cpu_usage > 90:
    # TODO: implement alerting
    
# ✅ Works — pass fills the block
if cpu_usage > 90:
    pass  # TODO: implement alerting later
```

### Common Use Cases

```python
# 1. Placeholder during development
def deploy_to_kubernetes():
    pass  # Will implement later

# 2. Intentionally ignoring a condition
for server in servers:
    if server == "legacy-01":
        pass  # Intentionally do nothing for this server
    else:
        restart(server)

# 3. Empty class definition
class CustomError(Exception):
    pass  # No additional behavior needed
```

### pass vs continue

| Statement | Purpose |
|-----------|---------|
| `pass` | Do nothing (placeholder), continue to **next line** in same iteration |
| `continue` | Skip to **next iteration** of the loop |

```python
for i in range(5):
    if i == 2:
        pass           # Does nothing — execution continues below
    print(i)           # Prints ALL numbers: 0, 1, 2, 3, 4

for i in range(5):
    if i == 2:
        continue       # Skips to next iteration
    print(i)           # Prints: 0, 1, 3, 4 (2 is skipped!)
```

---

## 3.14 Loop-else Pattern

### What It Is

Python has a unique feature: you can attach an `else` block to a `for` or `while` loop. The `else` block runs **only if the loop completed normally** (without hitting `break`).

### Real-Life Analogy

- You search every drawer for your keys
- **If** you find them (break) → use them
- **Else** (searched all drawers, didn't find) → call a locksmith

The "else" means "I exhausted all options without finding what I needed."

### Syntax

```python
for item in sequence:
    if found_condition:
        break
else:
    # Runs ONLY if loop completed without break
    print("Not found!")
```

### Example: Finding a Critical Server

```python
servers = ["web-01", "web-02", "web-03", "api-01"]

for server in servers:
    if server.startswith("db"):
        print(f"✅ Found database server: {server}")
        break
else:
    # This runs because no server matched (no break was hit)
    print("❌ No database server found in cluster!")
    print("ACTION: Provision a new database server")
```

**Expected Output:**
```
❌ No database server found in cluster!
ACTION: Provision a new database server
```

### How to Read It

Don't read it as "for-else." Read it as:

> "**For** each item, check if it matches. If we found it, **break**. If we went through everything and didn't break (**else**), then it wasn't found."

Think of `else` as **"no-break"** — it runs when the loop exits normally.

### Common Mistake: Confusing When else Runs

```python
# else runs because loop completed normally (no break)
for i in range(5):
    print(i)
else:
    print("Loop finished normally")  # ← This DOES run

# else does NOT run because break was hit
for i in range(5):
    if i == 3:
        break
else:
    print("Loop finished normally")  # ← This does NOT run
```

### Interview Perspective

> **Q: What is the loop-else pattern in Python?**
>
> A: An `else` block after a `for`/`while` loop executes only if the loop completes without encountering a `break`. It's useful for search patterns — the `else` block handles the "not found" case.

---

## 3.15 Nested Loops

### What It Is

A loop inside another loop. The inner loop runs **completely** for each iteration of the outer loop.

### Real-Life Analogy

Imagine checking every room on every floor of a building:
- **For each** floor:
  - **For each** room on this floor:
    - Check the room

If there are 3 floors with 4 rooms each, you check 3 × 4 = 12 rooms total.

### Example

```python
environments = ["dev", "staging", "prod"]
services = ["api", "web", "worker"]

for env in environments:
    print(f"\n📂 Environment: {env}")
    for service in services:
        print(f"   🔄 Deploying {service} to {env}")
```

**Expected Output:**
```
📂 Environment: dev
   🔄 Deploying api to dev
   🔄 Deploying web to dev
   🔄 Deploying worker to dev

📂 Environment: staging
   🔄 Deploying api to staging
   🔄 Deploying web to staging
   🔄 Deploying worker to staging

📂 Environment: prod
   🔄 Deploying api to prod
   🔄 Deploying web to prod
   🔄 Deploying worker to prod
```

### Execution Flow

```
Outer iteration 1 (env = "dev"):
    Inner iteration 1: service = "api"    → Deploy api to dev
    Inner iteration 2: service = "web"    → Deploy web to dev
    Inner iteration 3: service = "worker" → Deploy worker to dev
    
Outer iteration 2 (env = "staging"):
    Inner iteration 1: service = "api"    → Deploy api to staging
    Inner iteration 2: service = "web"    → Deploy web to staging
    Inner iteration 3: service = "worker" → Deploy worker to staging

... and so on
```

Total iterations: 3 × 3 = 9

### Performance Warning

Nested loops multiply: if outer has N items and inner has M items, you get N × M iterations. With large datasets, this grows quickly:

- 100 × 100 = 10,000 iterations ✅ Fine
- 10,000 × 10,000 = 100,000,000 iterations ⚠️ Slow!

### break in Nested Loops

`break` only exits the **innermost** loop:

```python
for env in ["dev", "staging", "prod"]:
    for service in ["api", "web", "worker"]:
        if env == "prod" and service == "worker":
            print(f"  ⛔ Skipping {service} in {env}")
            break  # Exits only the inner loop!
        print(f"  ✅ {service} → {env}")
    # Outer loop continues even after inner break
```

---

## 3.16 enumerate() and zip()

### enumerate() — Getting Index and Value Together

#### The Problem

```python
servers = ["web-01", "web-02", "web-03"]

# ❌ Ugly way to get index
index = 0
for server in servers:
    print(f"{index}: {server}")
    index += 1

# ❌ Also works but unpythonic
for i in range(len(servers)):
    print(f"{i}: {servers[i]}")
```

#### The Solution: enumerate()

```python
servers = ["web-01", "web-02", "web-03"]

# ✅ Pythonic way
for index, server in enumerate(servers):
    print(f"{index}: {server}")
```

**Output:**
```
0: web-01
1: web-02
2: web-03
```

#### Starting from a Different Number

```python
for num, server in enumerate(servers, start=1):
    print(f"Server #{num}: {server}")
```

**Output:**
```
Server #1: web-01
Server #2: web-02
Server #3: web-03
```

### zip() — Iterating Over Multiple Sequences in Parallel

#### The Problem

You have two related lists and want to process them together:

```python
hostnames = ["web-01", "web-02", "web-03"]
ip_addresses = ["10.0.0.1", "10.0.0.2", "10.0.0.3"]

# ❌ Ugly
for i in range(len(hostnames)):
    print(f"{hostnames[i]} → {ip_addresses[i]}")
```

#### The Solution: zip()

```python
hostnames = ["web-01", "web-02", "web-03"]
ip_addresses = ["10.0.0.1", "10.0.0.2", "10.0.0.3"]
regions = ["us-east-1", "us-west-2", "eu-west-1"]

# ✅ Clean and Pythonic
for hostname, ip, region in zip(hostnames, ip_addresses, regions):
    print(f"{hostname} ({ip}) — Region: {region}")
```

**Output:**
```
web-01 (10.0.0.1) — Region: us-east-1
web-02 (10.0.0.2) — Region: us-west-2
web-03 (10.0.0.3) — Region: eu-west-1
```

#### Important: zip() Stops at the Shortest Sequence

```python
names = ["a", "b", "c"]
values = [1, 2]  # Only 2 items!

for n, v in zip(names, values):
    print(n, v)
# a 1
# b 2
# "c" is ignored!
```

If you want to include all items (padding shorter sequences), use `itertools.zip_longest`.

---

## 3.17 Common Patterns in DevOps

### Pattern 1: Retry with Exponential Backoff

```python
import time

max_retries = 5
base_delay = 1  # seconds

for attempt in range(1, max_retries + 1):
    print(f"Attempt {attempt}: Connecting to API...")
    
    # Simulated result
    success = (attempt == 4)
    
    if success:
        print(f"✅ Connected on attempt {attempt}")
        break
    
    delay = base_delay * (2 ** (attempt - 1))  # 1, 2, 4, 8, 16 seconds
    print(f"  ❌ Failed. Retrying in {delay}s...")
    # time.sleep(delay)  # Uncomment in real code
else:
    print(f"❌ All {max_retries} attempts failed. Escalating to on-call.")
```

### Pattern 2: Processing with Threshold Alerts

```python
nodes = {
    "node-01": {"cpu": 45, "memory": 60},
    "node-02": {"cpu": 88, "memory": 92},
    "node-03": {"cpu": 72, "memory": 55},
    "node-04": {"cpu": 95, "memory": 97},
}

critical_nodes = []

for node_name, metrics in nodes.items():
    cpu = metrics["cpu"]
    memory = metrics["memory"]
    
    if cpu > 90 or memory > 90:
        critical_nodes.append(node_name)
        print(f"🚨 {node_name}: CPU={cpu}%, MEM={memory}% — CRITICAL")
    elif cpu > 75 or memory > 75:
        print(f"⚠️  {node_name}: CPU={cpu}%, MEM={memory}% — WARNING")
    else:
        print(f"✅ {node_name}: CPU={cpu}%, MEM={memory}% — OK")

print(f"\n{'='*40}")
print(f"Critical nodes: {len(critical_nodes)}/{len(nodes)}")
if critical_nodes:
    print(f"Immediate action needed: {critical_nodes}")
```

**Expected Output:**
```
✅ node-01: CPU=45%, MEM=60% — OK
🚨 node-02: CPU=88%, MEM=92% — CRITICAL
⚠️  node-03: CPU=72%, MEM=55% — WARNING
🚨 node-04: CPU=95%, MEM=97% — CRITICAL

========================================
Critical nodes: 2/4
Immediate action needed: ['node-02', 'node-04']
```

### Pattern 3: Batch Processing

```python
all_servers = [f"server-{i:03d}" for i in range(1, 21)]  # 20 servers
batch_size = 5

print(f"Deploying to {len(all_servers)} servers in batches of {batch_size}\n")

for i in range(0, len(all_servers), batch_size):
    batch = all_servers[i:i + batch_size]
    batch_num = (i // batch_size) + 1
    print(f"--- Batch {batch_num} ---")
    
    for server in batch:
        print(f"  🚀 Deploying to {server}")
    
    print(f"  ✅ Batch {batch_num} complete\n")
```

---

## 3.18 Section Summary and Review

### What You Learned

| Topic | Key Takeaway |
|-------|-------------|
| Control flow | Programs make decisions (conditionals) and repeat actions (loops) |
| Indentation | Python uses 4-space indentation to define code blocks — not braces |
| if | Execute block only when condition is True |
| if-else | Two paths — exactly one always executes |
| if-elif-else | Multiple conditions checked top-down; first True wins |
| Nested if | Conditions within conditions — limit to 2-3 levels |
| Ternary | One-line if-else for simple assignments |
| for loop | Iterate over known sequences (lists, strings, ranges) |
| range() | Generate number sequences; memory-efficient |
| while loop | Repeat while condition is True; unknown iterations |
| break | Exit loop immediately |
| continue | Skip current iteration, move to next |
| pass | Do nothing (placeholder) |
| Loop-else | Runs if loop completed without break ("not found" handler) |
| Nested loops | N × M iterations; break only exits innermost |
| enumerate() | Get index + value together |
| zip() | Iterate multiple sequences in parallel |

### Production Scenario Recap

> A deployment automation script uses `for` loops to iterate through server lists, `if-elif-else` to classify server health, `break` to stop on critical failures, `continue` to skip maintenance servers, `while` loops for polling until services are ready, and `enumerate()` for numbered progress output.

### Common Interview Questions

1. **Q: What is the difference between `break` and `continue`?**
   A: `break` exits the entire loop. `continue` skips only the current iteration and moves to the next.

2. **Q: What is the loop-else pattern?**
   A: `else` after a loop runs only if the loop completed without `break`. Useful for search-not-found scenarios.

3. **Q: When would you use `while True`?**
   A: For polling, event loops, retry logic, or daemon processes where you exit with `break` on specific conditions.

4. **Q: What is the difference between `for` and `while`?**
   A: `for` iterates over a known sequence. `while` repeats based on a condition with an unknown number of iterations.

5. **Q: How does Python determine code blocks?**
   A: Through indentation (standard: 4 spaces). A colon `:` starts a block; returning to the previous indentation level ends it.

### Practice Exercises

1. Write a script that classifies HTTP status codes (200=OK, 3xx=Redirect, 4xx=Client Error, 5xx=Server Error)
2. Write retry logic that attempts 5 times with increasing delay (1s, 2s, 4s, 8s, 16s)
3. Loop through a list of servers and skip any containing "test" in the name
4. Use `enumerate()` to print a numbered list of services
5. Use `zip()` to combine hostnames and IP addresses into formatted output
6. Write a `while` loop that simulates waiting for a deployment (polls every 5 seconds, times out at 60 seconds)
7. Use the loop-else pattern to search a list of ports for port 443

### Beginner Quiz (10 Questions)

1. What character ends a conditional/loop statement in Python?
2. How many spaces is standard Python indentation?
3. In `if-elif-else`, how many blocks can execute?
4. What does `range(5)` produce?
5. What does `break` do inside a nested loop?
6. What is the output of `for i in range(3): pass` followed by `print(i)`?
7. When does the `else` block of a for-loop execute?
8. What does `enumerate(["a","b","c"], start=1)` produce?
9. What happens if you forget to update the condition variable in a `while` loop?
10. Can you use `continue` outside a loop?

<details>
<summary>Quiz Answers</summary>

1. A colon `:`
2. 4 spaces
3. Exactly one
4. Numbers 0, 1, 2, 3, 4 (five numbers starting from 0)
5. Exits only the innermost loop
6. `2` — the loop variable retains its last value after the loop
7. Only when the loop completes without hitting `break`
8. Produces pairs: (1, "a"), (2, "b"), (3, "c")
9. Infinite loop — the condition never becomes False
10. No — `SyntaxError: 'continue' not properly in loop`

</details>

### Next Section Preview

**Section 4: Data Structures — Lists, Tuples, Dictionaries, and Sets**

You will learn Python's four core collection types, when to use each one, how they work internally, mutability vs immutability, common methods, iteration patterns, list comprehensions, dictionary comprehensions, nested structures, and real-world DevOps scenarios like managing server inventories, configuration storage, and deduplication.

---

*Ready for Section 4? Let me know and I'll generate it.*
