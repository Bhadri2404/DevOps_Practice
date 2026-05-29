# Section 4: Data Structures — Lists, Tuples, Dictionaries, and Sets

---

## 📑 Table of Contents

- [4.1 Why Data Structures Matter](#41-why-data-structures-matter)
- [4.2 Lists — The Workhorse Collection](#42-lists--the-workhorse-collection)
- [4.3 List Methods — Complete Guide](#43-list-methods--complete-guide)
- [4.4 List Slicing and Copying](#44-list-slicing-and-copying)
- [4.5 List Comprehensions](#45-list-comprehensions)
- [4.6 Tuples — Immutable Sequences](#46-tuples--immutable-sequences)
- [4.7 Tuple Unpacking and Named Tuples](#47-tuple-unpacking-and-named-tuples)
- [4.8 Dictionaries — Key-Value Storage](#48-dictionaries--key-value-storage)
- [4.9 Dictionary Methods — Complete Guide](#49-dictionary-methods--complete-guide)
- [4.10 Dictionary Comprehensions](#410-dictionary-comprehensions)
- [4.11 Nested Dictionaries](#411-nested-dictionaries)
- [4.12 Sets — Unique Collections](#412-sets--unique-collections)
- [4.13 Set Operations](#413-set-operations)
- [4.14 Choosing the Right Data Structure](#414-choosing-the-right-data-structure)
- [4.15 Common DevOps Patterns with Data Structures](#415-common-devops-patterns-with-data-structures)
- [4.16 Section Summary and Review](#416-section-summary-and-review)

---

## 🎯 Learning Objectives

By the end of this section, you will:

1. Understand what data structures are and why they exist
2. Master lists: creation, indexing, slicing, methods, nested lists
3. Understand mutability — why lists can change but strings cannot
4. Write list comprehensions fluently
5. Understand tuples and when to choose them over lists
6. Master dictionaries: key-value pairs, methods, nested dicts
7. Write dictionary comprehensions
8. Understand sets: uniqueness, mathematical operations
9. Know when to use each data structure (list vs tuple vs dict vs set)
10. Apply data structures to DevOps: server inventories, configs, deduplication, lookups

---

## 4.1 Why Data Structures Matter

### Real-Life Analogy

Think about organizing physical objects:

- **List** → A numbered line of people (ordered, can have duplicates, can change)
- **Tuple** → A sealed envelope with fixed items (ordered, can't change)
- **Dictionary** → A phonebook (look up by name, get a phone number)
- **Set** → A bag of unique marbles (no order, no duplicates)

Each organization method is best for different purposes. You wouldn't use a phonebook to track a queue of people.

### The Problem: Single Variables Don't Scale

```python
# ❌ Managing 100 servers like this is impossible
server_1 = "web-01"
server_2 = "web-02"
server_3 = "web-03"
# ... 97 more?

# ✅ One data structure holds them all
servers = ["web-01", "web-02", "web-03", ..., "web-100"]
```

### What Data Structures Provide

| Capability | Why It Matters |
|-----------|----------------|
| Group related data together | One variable for 1000 servers |
| Access by position or key | Find server #5, or find server by hostname |
| Iterate efficiently | Loop through all items |
| Add/remove dynamically | Scale up/down at runtime |
| Search quickly | Find if an IP exists in a blocklist |
| Maintain order (or not) | Process items in sequence |

### Python's Core Data Structures at a Glance

```
┌──────────────────────────────────────────────────────────────────┐
│  Type       │ Ordered │ Mutable │ Duplicates │ Syntax            │
├─────────────┼─────────┼─────────┼────────────┼───────────────────┤
│  list       │   Yes   │   Yes   │    Yes     │  [1, 2, 3]        │
│  tuple      │   Yes   │   No    │    Yes     │  (1, 2, 3)        │
│  dict       │   Yes*  │   Yes   │  Keys: No  │  {"a": 1, "b": 2} │
│  set        │   No    │   Yes   │    No      │  {1, 2, 3}        │
│  frozenset  │   No    │   No    │    No      │  frozenset({1,2}) │
└─────────────┴─────────┴─────────┴────────────┴───────────────────┘
* dict maintains insertion order since Python 3.7
```

---

## 4.2 Lists — The Workhorse Collection

### What Is a List?

A list is an **ordered, mutable collection** that can hold items of any type. It is the most commonly used data structure in Python.

- **Ordered** — Items maintain the order you put them in
- **Mutable** — You can add, remove, and change items after creation
- **Heterogeneous** — Can mix types (though usually you shouldn't)
- **Allows duplicates** — The same value can appear multiple times

### Real-Life Analogy

A list is like a **numbered queue** at a deli counter. People have positions (indexes), new people can join (append), people can leave (remove), and you can have two people with the same name.

### Creating Lists

```python
# Empty list
servers = []
servers = list()    # Also creates empty list

# List with initial values
ports = [80, 443, 8080, 3000]
regions = ["us-east-1", "us-west-2", "eu-west-1"]
mixed = [42, "hello", True, 3.14, None]  # Valid but usually bad practice

# List from other iterables
chars = list("hello")           # ['h', 'e', 'l', 'l', 'o']
numbers = list(range(1, 6))    # [1, 2, 3, 4, 5]
```

### How Lists Work Internally

A Python list is NOT a linked list (like in C). It's implemented as a **dynamic array** — a contiguous block of memory containing **references** (pointers) to objects.

```
┌─────────────────────────────────────────────────────────┐
│  servers = ["web-01", "web-02", "db-01"]                │
│                                                          │
│  List object in memory:                                  │
│  ┌───────┬───────┬───────┐                              │
│  │ ptr-0 │ ptr-1 │ ptr-2 │   (array of pointers)        │
│  └───┬───┴───┬───┴───┬───┘                              │
│      │       │       │                                   │
│      ▼       ▼       ▼                                   │
│  "web-01" "web-02" "db-01"   (actual string objects)     │
└─────────────────────────────────────────────────────────┘
```

**Implications:**
- **Indexing is O(1)** — Jump directly to position N (fast!)
- **Append is O(1) amortized** — Add to end is fast
- **Insert at beginning is O(n)** — Must shift all elements (slow for large lists)
- **Search is O(n)** — Must check each element one by one

### Accessing List Items (Indexing)

```python
servers = ["web-01", "web-02", "db-01", "cache-01", "api-01"]
#  Index:     0         1         2          3          4
#  Negative: -5        -4        -3         -2         -1

print(servers[0])      # "web-01"   (first item)
print(servers[2])      # "db-01"    (third item)
print(servers[-1])     # "api-01"   (last item)
print(servers[-2])     # "cache-01" (second from last)
```

### Common Mistake: IndexError

```python
servers = ["web-01", "web-02", "web-03"]
print(servers[3])    # ❌ IndexError: list index out of range
# Valid indexes are 0, 1, 2 (or -1, -2, -3)
```

**Why beginners make this mistake:** They confuse length (3 items) with the highest index (2). Remember: indexes go from 0 to `len(list) - 1`.

### Modifying List Items

```python
servers = ["web-01", "web-02", "web-03"]

# Change an item (lists are mutable!)
servers[1] = "web-02-new"
print(servers)    # ["web-01", "web-02-new", "web-03"]
```

This is what makes lists different from strings and tuples — you can change items in place.

### List Length

```python
servers = ["web-01", "web-02", "web-03"]
print(len(servers))    # 3
```

### Checking If Item Exists

```python
servers = ["web-01", "web-02", "db-01"]

if "db-01" in servers:
    print("Database server found")    # ✅ Runs

if "cache-01" not in servers:
    print("No cache server!")          # ✅ Runs
```

---

## 4.3 List Methods — Complete Guide

### Adding Items

```python
servers = ["web-01", "web-02"]

# append() — Add ONE item to the END
servers.append("web-03")
print(servers)    # ["web-01", "web-02", "web-03"]

# insert() — Add item at a SPECIFIC position
servers.insert(0, "lb-01")  # Insert at beginning
print(servers)    # ["lb-01", "web-01", "web-02", "web-03"]

# extend() — Add MULTIPLE items from another iterable
new_servers = ["db-01", "cache-01"]
servers.extend(new_servers)
print(servers)    # ["lb-01", "web-01", "web-02", "web-03", "db-01", "cache-01"]
```

### Critical Difference: append() vs extend()

```python
a = [1, 2, 3]
a.append([4, 5])     # Adds the LIST as a single item!
print(a)             # [1, 2, 3, [4, 5]]  ← Nested list!

b = [1, 2, 3]
b.extend([4, 5])     # Adds each ITEM individually
print(b)             # [1, 2, 3, 4, 5]    ← Flat list
```

This is one of the **most common beginner mistakes**. If you want to add multiple items, use `extend()` or `+=`:

```python
servers = ["web-01"]
servers += ["web-02", "web-03"]    # Same as extend()
print(servers)    # ["web-01", "web-02", "web-03"]
```

### Removing Items

```python
servers = ["web-01", "web-02", "db-01", "web-03", "web-02"]

# remove() — Remove FIRST occurrence of a value
servers.remove("web-02")
print(servers)    # ["web-01", "db-01", "web-03", "web-02"]
# Note: second "web-02" still exists!

# pop() — Remove and RETURN item at index (default: last item)
last = servers.pop()
print(last)       # "web-02"
print(servers)    # ["web-01", "db-01", "web-03"]

first = servers.pop(0)
print(first)      # "web-01"
print(servers)    # ["db-01", "web-03"]

# clear() — Remove ALL items
servers.clear()
print(servers)    # []

# del — Remove by index or slice
servers = ["a", "b", "c", "d", "e"]
del servers[1]       # Remove index 1
print(servers)       # ["a", "c", "d", "e"]
del servers[1:3]     # Remove slice
print(servers)       # ["a", "e"]
```

### Common Mistake: remove() with Non-Existent Value

```python
servers = ["web-01", "web-02"]
servers.remove("db-01")    # ❌ ValueError: list.remove(x): x not in list

# Safe pattern:
if "db-01" in servers:
    servers.remove("db-01")
```

### Searching and Counting

```python
servers = ["web-01", "db-01", "web-02", "db-01", "web-03"]

# index() — Find position of first occurrence
pos = servers.index("db-01")
print(pos)    # 1

# count() — Count occurrences
num = servers.count("db-01")
print(num)    # 2
```

### Sorting

```python
numbers = [3, 1, 4, 1, 5, 9, 2, 6]

# sort() — Modifies the list IN PLACE (returns None!)
numbers.sort()
print(numbers)    # [1, 1, 2, 3, 4, 5, 6, 9]

# Reverse sort
numbers.sort(reverse=True)
print(numbers)    # [9, 6, 5, 4, 3, 2, 1, 1]

# sorted() — Returns a NEW sorted list (original unchanged)
original = [3, 1, 4, 1, 5]
new_sorted = sorted(original)
print(original)      # [3, 1, 4, 1, 5]  ← unchanged!
print(new_sorted)    # [1, 1, 3, 4, 5]  ← new list
```

### Critical Mistake: sort() Returns None

```python
# ❌ WRONG — sort() returns None, not the sorted list!
servers = ["web-03", "web-01", "web-02"]
result = servers.sort()
print(result)     # None  ← NOT what you expected!

# ✅ CORRECT — sort() modifies in place
servers.sort()
print(servers)    # ["web-01", "web-02", "web-03"]

# ✅ Or use sorted() if you need the return value
result = sorted(servers)
```

### Reversing

```python
servers = ["web-01", "web-02", "web-03"]

# reverse() — Reverses in place
servers.reverse()
print(servers)    # ["web-03", "web-02", "web-01"]

# Slice reversal — Returns new list
original = [1, 2, 3, 4, 5]
reversed_list = original[::-1]
print(reversed_list)   # [5, 4, 3, 2, 1]
print(original)        # [1, 2, 3, 4, 5]  ← unchanged
```

### Summary Table of List Methods

| Method | Effect | Returns | Modifies Original? |
|--------|--------|---------|:---:|
| `append(x)` | Add x to end | None | Yes |
| `insert(i, x)` | Add x at index i | None | Yes |
| `extend(iterable)` | Add all items from iterable | None | Yes |
| `remove(x)` | Remove first x | None | Yes |
| `pop(i)` | Remove & return item at i | The item | Yes |
| `clear()` | Remove all items | None | Yes |
| `index(x)` | Find first position of x | Integer | No |
| `count(x)` | Count occurrences of x | Integer | No |
| `sort()` | Sort in place | None | Yes |
| `reverse()` | Reverse in place | None | Yes |
| `copy()` | Shallow copy | New list | No |

---

## 4.4 List Slicing and Copying

### Slicing Recap

```python
servers = ["lb-01", "web-01", "web-02", "web-03", "db-01", "cache-01"]
#  Index:     0        1        2        3        4         5

print(servers[1:4])     # ["web-01", "web-02", "web-03"]
print(servers[:3])      # ["lb-01", "web-01", "web-02"]
print(servers[4:])      # ["db-01", "cache-01"]
print(servers[::2])     # ["lb-01", "web-02", "db-01"] (every 2nd)
print(servers[::-1])    # Reversed list
```

### Slice Assignment (Modifying Portions)

```python
servers = ["web-01", "web-02", "web-03", "web-04"]

# Replace a range
servers[1:3] = ["api-01", "api-02", "api-03"]
print(servers)    # ["web-01", "api-01", "api-02", "api-03", "web-04"]
# Notice: replaced 2 items with 3 — list grows!
```

### ⚠️ The Shallow Copy Problem — Critical Understanding

```python
# Assignment does NOT copy — both names point to SAME list!
original = ["web-01", "web-02", "web-03"]
reference = original    # NOT a copy!

reference.append("db-01")
print(original)    # ["web-01", "web-02", "web-03", "db-01"]  ← MODIFIED!
```

**Why?** Remember from Section 2: variables are names pointing to objects. `reference = original` makes both names point to the **same list object**.

```
                         ┌─────────────────────────────────┐
  original ─────────────▶│  ["web-01", "web-02", "web-03"] │
  reference ────────────▶│                                  │
                         └─────────────────────────────────┘
                         Same object! Changes through either name affect both.
```

### How to Actually Copy a List

```python
original = ["web-01", "web-02", "web-03"]

# Method 1: copy() method
copy1 = original.copy()

# Method 2: slice
copy2 = original[:]

# Method 3: list() constructor
copy3 = list(original)

# Now changes to copies don't affect original
copy1.append("new")
print(original)    # ["web-01", "web-02", "web-03"]  ← unchanged!
```

### Shallow vs Deep Copy

A **shallow copy** copies the list but NOT nested objects inside it:

```python
# Nested list problem
original = [["web-01", "web-02"], ["db-01", "db-02"]]
shallow = original.copy()

# Modifying the outer list is safe
shallow.append(["cache-01"])
print(len(original))    # 2 (original not affected)

# But modifying a NESTED list affects both!
shallow[0].append("web-03")
print(original[0])    # ["web-01", "web-02", "web-03"]  ← MODIFIED!
```

**Why?** Shallow copy copies the pointers to nested lists, not the nested lists themselves.

```python
# Solution: Deep copy
import copy

original = [["web-01", "web-02"], ["db-01", "db-02"]]
deep = copy.deepcopy(original)

deep[0].append("web-03")
print(original[0])    # ["web-01", "web-02"]  ← Safe!
```

### When This Matters in DevOps

```python
# You fetch a server config and want to modify it for a different environment
prod_config = {"servers": ["web-01", "web-02"], "region": "us-east-1"}

import copy
staging_config = copy.deepcopy(prod_config)
staging_config["servers"].append("web-03")    # Only affects staging!
staging_config["region"] = "us-west-2"
```

---

## 4.5 List Comprehensions

### What They Are

A list comprehension is a **concise, one-line way to create a new list** by transforming or filtering items from an existing iterable.

### Why They Exist

```python
# Traditional approach (4 lines)
squared = []
for n in range(1, 6):
    squared.append(n ** 2)
print(squared)    # [1, 4, 9, 16, 25]

# List comprehension (1 line — same result)
squared = [n ** 2 for n in range(1, 6)]
print(squared)    # [1, 4, 9, 16, 25]
```

Same result, but more readable (once you understand the syntax) and slightly faster (Python optimizes comprehensions internally).

### Syntax

```python
new_list = [expression for item in iterable]
new_list = [expression for item in iterable if condition]
```

Read it as English:
> "Give me `expression` **for each** `item` **in** `iterable` [**if** `condition` is True]"

### Simple Examples

```python
# Double each number
numbers = [1, 2, 3, 4, 5]
doubled = [n * 2 for n in numbers]
print(doubled)    # [2, 4, 6, 8, 10]

# Convert to uppercase
servers = ["web-01", "db-01", "cache-01"]
upper_servers = [s.upper() for s in servers]
print(upper_servers)    # ["WEB-01", "DB-01", "CACHE-01"]

# Extract lengths
names = ["kubernetes", "docker", "terraform", "ansible"]
lengths = [len(name) for name in names]
print(lengths)    # [10, 6, 9, 7]
```

### With Filtering (if condition)

```python
# Only even numbers
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
evens = [n for n in numbers if n % 2 == 0]
print(evens)    # [2, 4, 6, 8, 10]

# Only servers starting with "web"
servers = ["web-01", "db-01", "web-02", "cache-01", "web-03"]
web_servers = [s for s in servers if s.startswith("web")]
print(web_servers)    # ["web-01", "web-02", "web-03"]

# Ports above 1024
ports = [22, 80, 443, 3000, 5432, 8080, 8443]
high_ports = [p for p in ports if p > 1024]
print(high_ports)    # [3000, 5432, 8080, 8443]
```

### With if-else (Conditional Expression)

```python
# Classify each server
servers = ["web-01", "db-01", "web-02", "cache-01"]
types = ["web" if s.startswith("web") else "other" for s in servers]
print(types)    # ["web", "other", "web", "other"]

# Tag ports
ports = [22, 80, 443, 8080]
tagged = [f"{p} (secure)" if p == 443 else f"{p} (standard)" for p in ports]
print(tagged)    # ['22 (standard)', '80 (standard)', '443 (secure)', '8080 (standard)']
```

**Note the syntax difference:**
- **Filter** (include/exclude): `[x for x in items if condition]` — `if` at the **end**
- **Transform** (change value): `[A if condition else B for x in items]` — `if/else` at the **beginning**

### DevOps Production Example

```python
# From a list of log lines, extract only ERROR lines and clean them
log_lines = [
    "2024-01-15 INFO Server started",
    "2024-01-15 ERROR Disk full on /dev/sda1",
    "2024-01-15 INFO Request processed",
    "2024-01-15 ERROR Connection timeout to db-01",
    "2024-01-15 WARNING Memory at 85%",
]

errors = [line.split(" ", 2)[2] for line in log_lines if "ERROR" in line]
print(errors)
# ['ERROR Disk full on /dev/sda1', 'ERROR Connection timeout to db-01']
```

### When NOT to Use List Comprehensions

```python
# ❌ Too complex — hard to read
result = [transform(x) for x in data if validate(x) and x.status == "active" for y in x.items if y > threshold]

# ✅ Use a regular loop instead
result = []
for x in data:
    if validate(x) and x.status == "active":
        for y in x.items:
            if y > threshold:
                result.append(transform(x))
```

**Rule of thumb:** If the comprehension doesn't fit on one readable line, use a regular loop.

---

## 4.6 Tuples — Immutable Sequences

### What Is a Tuple?

A tuple is an **ordered, immutable collection**. Once created, you cannot add, remove, or change items.

### Real-Life Analogy

A tuple is like a **sealed envelope** with a fixed set of items. You can look at what's inside (read), but you cannot change the contents. To change anything, you'd need to create a new envelope.

Or think of **GPS coordinates** — latitude and longitude are a fixed pair. It wouldn't make sense to change just the latitude of a location; you'd have a different location entirely.

### Creating Tuples

```python
# With parentheses
coordinates = (40.7128, -74.0060)
rgb_color = (255, 128, 0)
server_info = ("web-01", "10.0.0.1", 8080)

# Without parentheses (comma creates the tuple!)
point = 10, 20
print(type(point))    # <class 'tuple'>

# Single-element tuple (MUST have trailing comma!)
single = (42,)        # ✅ Tuple with one item
not_tuple = (42)      # ❌ Just an integer with parentheses!
print(type(single))      # <class 'tuple'>
print(type(not_tuple))   # <class 'int'>

# Empty tuple
empty = ()
empty = tuple()

# From a list
from_list = tuple(["web-01", "web-02", "web-03"])
```

### Why Use Tuples When Lists Exist?

| Reason | Explanation |
|--------|-------------|
| **Safety** | Can't be accidentally modified |
| **Performance** | Slightly faster than lists (less overhead) |
| **Hashable** | Can be used as dictionary keys or in sets |
| **Intent** | Signals "this data should not change" |
| **Memory** | Uses less memory than lists |

### Accessing Items (Same as Lists)

```python
server = ("web-01", "10.0.0.1", 8080, "us-east-1")

print(server[0])     # "web-01"
print(server[-1])    # "us-east-1"
print(server[1:3])   # ("10.0.0.1", 8080)
print(len(server))   # 4
```

### Immutability Demonstrated

```python
server = ("web-01", "10.0.0.1", 8080)

server[0] = "web-02"    # ❌ TypeError: 'tuple' object does not support item assignment
server.append("new")     # ❌ AttributeError: 'tuple' object has no attribute 'append'
```

### When to Use Tuples in DevOps

```python
# Fixed configuration that should never change
DB_CONFIG = ("db-master.internal", 5432, "production")

# Function returning multiple values
def get_server_status(hostname):
    # ... check server ...
    return ("healthy", 78.5, 62.3)    # (status, cpu, memory)

status, cpu, memory = get_server_status("web-01")

# As dictionary keys (lists can't do this!)
server_locations = {
    ("us-east-1", "web"): ["web-01", "web-02"],
    ("us-west-2", "db"): ["db-01"],
    ("eu-west-1", "cache"): ["cache-01", "cache-02"],
}
```

---

## 4.7 Tuple Unpacking and Named Tuples

### Tuple Unpacking

Unpacking assigns each element of a tuple to a separate variable in one line:

```python
# Basic unpacking
server_info = ("web-01", "10.0.0.1", 8080)
hostname, ip, port = server_info

print(hostname)    # "web-01"
print(ip)          # "10.0.0.1"
print(port)        # 8080
```

### Unpacking with * (Star Expression)

```python
# Capture remaining items with *
numbers = (1, 2, 3, 4, 5, 6, 7)
first, second, *rest = numbers

print(first)     # 1
print(second)    # 2
print(rest)      # [3, 4, 5, 6, 7]  ← Note: becomes a LIST

# Get first and last
first, *middle, last = numbers
print(first)     # 1
print(middle)    # [2, 3, 4, 5, 6]
print(last)      # 7
```

### Underscore Convention for Unused Values

```python
# You only need the IP address
server_info = ("web-01", "10.0.0.1", 8080, "us-east-1")
_, ip, _, _ = server_info    # _ means "I don't need this"
print(ip)    # "10.0.0.1"

# Or with star
_, ip, *_ = server_info
```

### Swapping Variables (Uses Tuple Unpacking Internally)

```python
a = "primary"
b = "secondary"

a, b = b, a    # Swap! Python creates a temporary tuple (b, a) then unpacks it

print(a)    # "secondary"
print(b)    # "primary"
```

### Named Tuples — Self-Documenting Tuples

Regular tuples use numeric indexes, which can be confusing:

```python
server = ("web-01", "10.0.0.1", 8080, "healthy")
print(server[2])    # 8080 — but what IS index 2? Not obvious!
```

Named tuples give names to positions:

```python
from collections import namedtuple

# Define a named tuple type
Server = namedtuple("Server", ["hostname", "ip", "port", "status"])

# Create instances
web = Server(hostname="web-01", ip="10.0.0.1", port=8080, status="healthy")

# Access by name (clear!) or by index (still works)
print(web.hostname)    # "web-01"
print(web.port)        # 8080
print(web[1])          # "10.0.0.1" (index still works)

# Still immutable
web.port = 9090    # ❌ AttributeError
```

### Why Named Tuples in DevOps

They're perfect for structured data that shouldn't change:
- Server records
- Configuration entries
- API response parsing
- CSV row representation

---

## 4.8 Dictionaries — Key-Value Storage

### What Is a Dictionary?

A dictionary (dict) stores **key-value pairs**. You look up a value by its key, just like looking up a word's definition in a physical dictionary.

- **Ordered** — Maintains insertion order (Python 3.7+)
- **Mutable** — Can add, remove, change entries
- **Keys must be unique** — Duplicate keys overwrite previous values
- **Keys must be hashable** — Strings, numbers, tuples can be keys; lists cannot

### Real-Life Analogy

A dictionary is like a **contact book**:
- **Key** = Person's name (unique identifier)
- **Value** = Phone number, address, etc.

You don't search sequentially — you go directly to the name and get the info.

### Why Dictionaries Exist

```python
# ❌ Without dictionaries — parallel lists (error-prone!)
hostnames = ["web-01", "db-01", "cache-01"]
ips = ["10.0.0.1", "10.0.0.2", "10.0.0.3"]
# Which IP belongs to which hostname? Must keep indexes aligned!

# ✅ With dictionaries — self-documenting and safe
servers = {
    "web-01": "10.0.0.1",
    "db-01": "10.0.0.2",
    "cache-01": "10.0.0.3"
}
print(servers["db-01"])    # "10.0.0.2" — direct, clear, fast
```

### Creating Dictionaries

```python
# Curly braces (most common)
server = {
    "hostname": "web-01",
    "ip": "10.0.0.1",
    "port": 8080,
    "is_healthy": True,
    "tags": ["production", "web"]
}

# dict() constructor
config = dict(host="localhost", port=5432, db="myapp")

# From list of tuples
pairs = [("cpu", 78), ("memory", 85), ("disk", 62)]
metrics = dict(pairs)
print(metrics)    # {"cpu": 78, "memory": 85, "disk": 62}

# Empty dict
empty = {}
empty = dict()
```

### Accessing Values

```python
server = {"hostname": "web-01", "ip": "10.0.0.1", "port": 8080}

# Square bracket access (raises KeyError if missing!)
print(server["hostname"])    # "web-01"
print(server["region"])      # ❌ KeyError: 'region'

# .get() method (returns None or default if missing — SAFE!)
print(server.get("hostname"))       # "web-01"
print(server.get("region"))         # None (no error!)
print(server.get("region", "us-east-1"))  # "us-east-1" (custom default)
```

### ⚠️ Best Practice: Always Use `.get()` for Uncertain Keys

```python
# ❌ Dangerous in production — can crash your script
region = config["region"]

# ✅ Safe — returns a default
region = config.get("region", "us-east-1")
```

### Adding and Modifying Entries

```python
server = {"hostname": "web-01", "ip": "10.0.0.1"}

# Add new key
server["port"] = 8080
server["status"] = "running"

# Modify existing key
server["status"] = "stopped"

print(server)
# {"hostname": "web-01", "ip": "10.0.0.1", "port": 8080, "status": "stopped"}
```

### Removing Entries

```python
server = {"hostname": "web-01", "ip": "10.0.0.1", "port": 8080, "temp": "delete_me"}

# del — Remove by key (KeyError if missing)
del server["temp"]

# pop() — Remove and return value (can set default)
port = server.pop("port")
print(port)       # 8080
print(server)     # {"hostname": "web-01", "ip": "10.0.0.1"}

missing = server.pop("region", "not found")
print(missing)    # "not found" (no error!)

# popitem() — Remove and return last inserted pair
server["z"] = "last"
last_pair = server.popitem()
print(last_pair)    # ("z", "last")

# clear() — Remove all
server.clear()
print(server)    # {}
```

### Iterating Over Dictionaries

```python
metrics = {"cpu": 78, "memory": 85, "disk": 62, "network": 45}

# Iterate over keys (default)
for key in metrics:
    print(key)
# cpu, memory, disk, network

# Iterate over values
for value in metrics.values():
    print(value)
# 78, 85, 62, 45

# Iterate over key-value pairs (MOST COMMON)
for metric_name, value in metrics.items():
    print(f"{metric_name}: {value}%")
# cpu: 78%
# memory: 85%
# disk: 62%
# network: 45%
```

### How Dictionaries Work Internally (Hash Tables)

Dictionaries use a **hash table** — a data structure that provides O(1) average lookup time.

```
┌────────────────────────────────────────────────────────┐
│  server = {"hostname": "web-01", "port": 8080}        │
│                                                         │
│  When you access server["hostname"]:                    │
│                                                         │
│  1. Python computes hash("hostname") → integer         │
│  2. Uses that integer to find the "bucket" (slot)       │
│  3. Returns the value stored in that bucket             │
│                                                         │
│  This is O(1) — constant time regardless of dict size! │
└────────────────────────────────────────────────────────┘
```

**Why keys must be hashable:**
- Hashing requires the object to never change (immutable)
- Strings ✅, numbers ✅, tuples ✅ → hashable
- Lists ❌, dicts ❌, sets ❌ → NOT hashable (mutable)

---

## 4.9 Dictionary Methods — Complete Guide

```python
server = {"hostname": "web-01", "ip": "10.0.0.1", "port": 8080}

# keys() — All keys
print(list(server.keys()))      # ["hostname", "ip", "port"]

# values() — All values
print(list(server.values()))    # ["web-01", "10.0.0.1", 8080]

# items() — All key-value pairs as tuples
print(list(server.items()))     # [("hostname", "web-01"), ("ip", "10.0.0.1"), ("port", 8080)]

# update() — Merge another dict (overwrites existing keys)
server.update({"port": 9090, "region": "us-east-1"})
print(server)
# {"hostname": "web-01", "ip": "10.0.0.1", "port": 9090, "region": "us-east-1"}

# setdefault() — Get value if key exists; set and return default if not
server.setdefault("status", "unknown")
print(server["status"])    # "unknown" (was added)
server.setdefault("hostname", "default")
print(server["hostname"]) # "web-01" (already existed — not changed)
```

### Merge Operator (Python 3.9+)

```python
defaults = {"port": 80, "protocol": "http", "timeout": 30}
overrides = {"port": 443, "protocol": "https"}

# Merge (overrides win for duplicate keys)
config = defaults | overrides
print(config)    # {"port": 443, "protocol": "https", "timeout": 30}

# In-place merge
defaults |= overrides
```

### Checking Key Existence

```python
server = {"hostname": "web-01", "port": 8080}

# ✅ Correct
if "hostname" in server:
    print("Key exists")

# ❌ Common mistake — checks VALUES, not keys!
if "web-01" in server:    # False! "web-01" is a value, not a key
    print("Found")
```

---

## 4.10 Dictionary Comprehensions

### Syntax

```python
new_dict = {key_expr: value_expr for item in iterable}
new_dict = {key_expr: value_expr for item in iterable if condition}
```

### Examples

```python
# Create a dict from two lists
hostnames = ["web-01", "web-02", "web-03"]
ips = ["10.0.0.1", "10.0.0.2", "10.0.0.3"]

server_map = {host: ip for host, ip in zip(hostnames, ips)}
print(server_map)
# {"web-01": "10.0.0.1", "web-02": "10.0.0.2", "web-03": "10.0.0.3"}

# Square numbers
squares = {n: n**2 for n in range(1, 6)}
print(squares)    # {1: 1, 2: 4, 3: 9, 4: 16, 5: 25}

# Filter — only high metrics
metrics = {"cpu": 78, "memory": 92, "disk": 45, "network": 88}
alerts = {k: v for k, v in metrics.items() if v > 80}
print(alerts)    # {"memory": 92, "network": 88}

# Transform keys to uppercase
config = {"host": "localhost", "port": "5432"}
upper_config = {k.upper(): v for k, v in config.items()}
print(upper_config)    # {"HOST": "localhost", "PORT": "5432"}
```

### DevOps Example: Environment Variable Parsing

```python
# Simulate environment variables
raw_env = "DB_HOST=localhost;DB_PORT=5432;DB_NAME=myapp;DB_USER=admin"

env_dict = {
    pair.split("=")[0]: pair.split("=")[1]
    for pair in raw_env.split(";")
}
print(env_dict)
# {"DB_HOST": "localhost", "DB_PORT": "5432", "DB_NAME": "myapp", "DB_USER": "admin"}
```

---

## 4.11 Nested Dictionaries

### What They Are

Dictionaries containing other dictionaries (or lists of dictionaries). This is how real-world data is structured — JSON APIs, configuration files, and infrastructure definitions are all nested.

### Example: Server Inventory

```python
infrastructure = {
    "web-01": {
        "ip": "10.0.0.1",
        "port": 8080,
        "region": "us-east-1",
        "metrics": {
            "cpu": 72,
            "memory": 65,
            "disk": 45
        },
        "tags": ["production", "web", "primary"]
    },
    "db-01": {
        "ip": "10.0.0.2",
        "port": 5432,
        "region": "us-east-1",
        "metrics": {
            "cpu": 88,
            "memory": 92,
            "disk": 78
        },
        "tags": ["production", "database", "master"]
    }
}
```

### Accessing Nested Data

```python
# Access nested values by chaining keys
print(infrastructure["web-01"]["ip"])                    # "10.0.0.1"
print(infrastructure["db-01"]["metrics"]["cpu"])         # 88
print(infrastructure["web-01"]["tags"][0])               # "production"

# Safe nested access with .get()
cpu = infrastructure.get("web-01", {}).get("metrics", {}).get("cpu", 0)
print(cpu)    # 72
```

### Iterating Nested Structures

```python
print("=== Infrastructure Health Report ===\n")

for hostname, details in infrastructure.items():
    cpu = details["metrics"]["cpu"]
    memory = details["metrics"]["memory"]
    
    # Determine severity
    if cpu > 90 or memory > 90:
        status = "🚨 CRITICAL"
    elif cpu > 75 or memory > 75:
        status = "⚠️  WARNING"
    else:
        status = "✅ HEALTHY"
    
    print(f"{hostname} ({details['ip']}:{details['port']})")
    print(f"  Region: {details['region']}")
    print(f"  CPU: {cpu}% | Memory: {memory}% | Status: {status}")
    print(f"  Tags: {', '.join(details['tags'])}")
    print()
```

**Expected Output:**
```
=== Infrastructure Health Report ===

web-01 (10.0.0.1:8080)
  Region: us-east-1
  CPU: 72% | Memory: 65% | Status: ✅ HEALTHY
  Tags: production, web, primary

db-01 (10.0.0.2:5432)
  Region: us-east-1
  CPU: 88% | Memory: 92% | Status: 🚨 CRITICAL
  Tags: production, database, master
```

### Why This Matters

This nested dictionary structure mirrors:
- **JSON responses** from APIs (AWS, Kubernetes, Terraform)
- **YAML configuration** files (Ansible, Docker Compose, K8s manifests)
- **Terraform state** files
- **Cloud resource descriptions** (EC2 instances, pods, etc.)

If you master nested dictionaries, you master DevOps data handling.

---

## 4.12 Sets — Unique Collections

### What Is a Set?

A set is an **unordered collection of unique items**. It automatically removes duplicates and provides fast membership testing.

- **Unordered** — No indexes, no guaranteed order
- **Mutable** — Can add/remove items (but frozenset is immutable)
- **No duplicates** — Adding an existing item does nothing
- **Items must be hashable** — Strings, numbers, tuples only (no lists or dicts)

### Real-Life Analogy

A set is like a **bag of unique marbles**. You can check "is the red marble in the bag?" very quickly, you can add new marbles (duplicates are ignored), but you can't say "give me the 3rd marble" (no order).

### Creating Sets

```python
# Curly braces
ports = {80, 443, 8080, 3000}
regions = {"us-east-1", "us-west-2", "eu-west-1"}

# Duplicates are automatically removed!
numbers = {1, 2, 2, 3, 3, 3, 4}
print(numbers)    # {1, 2, 3, 4}

# Empty set (MUST use set(), not {} — that creates a dict!)
empty_set = set()       # ✅ Empty set
empty_dict = {}         # ← This is a dict, NOT a set!

# From a list (deduplication!)
server_list = ["web-01", "web-02", "web-01", "db-01", "web-02"]
unique_servers = set(server_list)
print(unique_servers)    # {"web-01", "web-02", "db-01"}
```

### Basic Operations

```python
ports = {80, 443, 8080}

# Add
ports.add(3000)
print(ports)    # {80, 443, 8080, 3000}

ports.add(80)   # Already exists — no error, no change
print(ports)    # {80, 443, 8080, 3000}

# Remove
ports.remove(8080)       # Removes; KeyError if not found
ports.discard(9999)      # Removes if exists; NO error if not found

# Membership testing (VERY fast — O(1)!)
print(443 in ports)      # True
print(9090 in ports)     # False
```

### Why Sets Are Fast for Membership Testing

```python
# List membership: O(n) — checks each item one by one
big_list = list(range(1_000_000))
999_999 in big_list    # Slow! Checks up to 1 million items

# Set membership: O(1) — uses hash table, instant lookup
big_set = set(range(1_000_000))
999_999 in big_set     # Fast! Constant time regardless of size
```

**Use sets whenever you need to check "is X in this collection?" frequently.**

---

## 4.13 Set Operations

### Mathematical Set Operations

Sets support the same operations you learned in math class:

```python
team_a = {"Alice", "Bob", "Charlie", "Diana"}
team_b = {"Charlie", "Diana", "Eve", "Frank"}
```

### Union (All items from both sets)

```python
# Everyone in either team
all_members = team_a | team_b    # Operator
all_members = team_a.union(team_b)    # Method
print(all_members)    # {"Alice", "Bob", "Charlie", "Diana", "Eve", "Frank"}
```

### Intersection (Only items in BOTH sets)

```python
# People in both teams
common = team_a & team_b    # Operator
common = team_a.intersection(team_b)    # Method
print(common)    # {"Charlie", "Diana"}
```

### Difference (Items in first but NOT in second)

```python
# People only in team A
only_a = team_a - team_b    # Operator
only_a = team_a.difference(team_b)    # Method
print(only_a)    # {"Alice", "Bob"}
```

### Symmetric Difference (Items in either but NOT both)

```python
# People in exactly one team (not shared)
exclusive = team_a ^ team_b    # Operator
exclusive = team_a.symmetric_difference(team_b)    # Method
print(exclusive)    # {"Alice", "Bob", "Eve", "Frank"}
```

### Visual Diagram

```
        team_a                     team_b
   ┌──────────────────┐    ┌──────────────────┐
   │                  │    │                  │
   │  Alice   Bob     │    │     Eve   Frank  │
   │              ┌───┼────┼───┐              │
   │              │Charlie │   │              │
   │              │ Diana  │   │              │
   │              └───┼────┼───┘              │
   │                  │    │                  │
   └──────────────────┘    └──────────────────┘
   
   Union:        {Alice, Bob, Charlie, Diana, Eve, Frank}
   Intersection: {Charlie, Diana}
   A - B:        {Alice, Bob}
   B - A:        {Eve, Frank}
   Symmetric:    {Alice, Bob, Eve, Frank}
```

### DevOps Production Examples

```python
# 1. Find servers that need updates
all_servers = {"web-01", "web-02", "db-01", "cache-01", "api-01"}
already_updated = {"web-01", "cache-01"}
needs_update = all_servers - already_updated
print(f"Still need patching: {needs_update}")
# {"web-02", "db-01", "api-01"}

# 2. Find which ports are open that shouldn't be
allowed_ports = {22, 80, 443}
actual_open_ports = {22, 80, 443, 3306, 6379, 8080}
unauthorized = actual_open_ports - allowed_ports
print(f"⚠️  Unauthorized open ports: {unauthorized}")
# {3306, 6379, 8080}

# 3. Find common tags between two services
service_a_tags = {"production", "web", "us-east-1", "critical"}
service_b_tags = {"production", "api", "us-east-1", "internal"}
shared_tags = service_a_tags & service_b_tags
print(f"Shared tags: {shared_tags}")
# {"production", "us-east-1"}

# 4. Deduplicate a list while preserving order (Python 3.7+)
log_sources = ["app.log", "error.log", "app.log", "auth.log", "error.log"]
unique_sources = list(dict.fromkeys(log_sources))
print(unique_sources)    # ["app.log", "error.log", "auth.log"]
```

---

## 4.14 Choosing the Right Data Structure

### Decision Flowchart

```
Do you need key-value pairs?
├── YES → Use DICT
│         Need ordered? → dict (Python 3.7+ is ordered)
│         Need unordered/faster? → still dict
└── NO
    │
    Do you need uniqueness?
    ├── YES → Use SET
    │         Need it immutable? → frozenset
    └── NO
        │
        Do you need mutability (add/remove items)?
        ├── YES → Use LIST
        └── NO  → Use TUPLE
```

### Quick Reference

| Scenario | Best Choice | Why |
|----------|-------------|-----|
| Collection of servers to iterate | list | Ordered, can add/remove |
| Server with attributes (hostname, ip, port) | dict | Key-value access |
| Fixed config that shouldn't change | tuple | Immutable, safe |
| Unique IPs to check against | set | Fast lookup, auto-dedupe |
| Log entries in order | list | Preserves insertion order |
| Environment variables | dict | Name → value mapping |
| Allowed ports | set | Membership testing |
| Function return: multiple values | tuple | Convention, immutable |
| API response | dict (nested) | Mirrors JSON structure |
| Items to process in batch | list | Ordered, iterable |

### Performance Comparison

| Operation | list | dict | set |
|-----------|:----:|:----:|:---:|
| Access by index | O(1) | N/A | N/A |
| Access by key | N/A | O(1) | N/A |
| Search (is X in?) | O(n) | O(1) | O(1) |
| Add item | O(1)* | O(1) | O(1) |
| Remove item | O(n) | O(1) | O(1) |
| Memory usage | Low | High | Medium |

*O(1) amortized for append; O(n) for insert at beginning

### Interview Perspective

> **Q: When would you use a set instead of a list?**
>
> A: Use a set when: (1) you need to eliminate duplicates, (2) you need fast O(1) membership testing (checking if an item exists), (3) you need mathematical set operations (union, intersection, difference), (4) you don't care about order. Example: maintaining a blocklist of IPs to check incoming connections against.

> **Q: Why can't a list be a dictionary key?**
>
> A: Dictionary keys must be hashable (immutable). Lists are mutable — if you changed a list used as a key, the hash would change and the dictionary wouldn't be able to find the value anymore. Tuples can be keys because they're immutable.

---

## 4.15 Common DevOps Patterns with Data Structures

### Pattern 1: Server Inventory with Health Status

```python
servers = [
    {"hostname": "web-01", "ip": "10.0.0.1", "cpu": 45, "status": "healthy"},
    {"hostname": "web-02", "ip": "10.0.0.2", "cpu": 92, "status": "critical"},
    {"hostname": "db-01", "ip": "10.0.0.3", "cpu": 78, "status": "warning"},
    {"hostname": "cache-01", "ip": "10.0.0.4", "cpu": 23, "status": "healthy"},
]

# Find all critical servers
critical = [s["hostname"] for s in servers if s["status"] == "critical"]
print(f"Critical servers: {critical}")    # ["web-02"]

# Calculate average CPU
avg_cpu = sum(s["cpu"] for s in servers) / len(servers)
print(f"Average CPU: {avg_cpu:.1f}%")     # 59.5%

# Group by status
from collections import defaultdict
by_status = defaultdict(list)
for server in servers:
    by_status[server["status"]].append(server["hostname"])

print(dict(by_status))
# {"healthy": ["web-01", "cache-01"], "critical": ["web-02"], "warning": ["db-01"]}
```

### Pattern 2: Configuration Management

```python
# Default config with environment overrides
default_config = {
    "log_level": "INFO",
    "max_retries": 3,
    "timeout": 30,
    "port": 8080,
    "debug": False
}

production_overrides = {
    "log_level": "WARNING",
    "max_retries": 5,
    "timeout": 10,
    "debug": False
}

development_overrides = {
    "log_level": "DEBUG",
    "debug": True,
    "port": 3000
}

# Merge configs (later values override earlier)
def get_config(environment):
    config = default_config.copy()
    if environment == "production":
        config.update(production_overrides)
    elif environment == "development":
        config.update(development_overrides)
    return config

prod_config = get_config("production")
print(prod_config)
# {"log_level": "WARNING", "max_retries": 5, "timeout": 10, "port": 8080, "debug": False}
```

### Pattern 3: Deduplication and Comparison

```python
# Find new, removed, and unchanged servers between deployments
previous_deployment = {"web-01", "web-02", "web-03", "db-01"}
current_deployment = {"web-01", "web-02", "web-04", "db-01", "cache-01"}

added = current_deployment - previous_deployment
removed = previous_deployment - current_deployment
unchanged = previous_deployment & current_deployment

print(f"🆕 Added:     {added}")        # {"web-04", "cache-01"}
print(f"🗑️  Removed:   {removed}")      # {"web-03"}
print(f"✅ Unchanged: {unchanged}")     # {"web-01", "web-02", "db-01"}
```

### Pattern 4: Batch Processing with Chunking

```python
def chunk_list(items, chunk_size):
    """Split a list into chunks of specified size."""
    return [items[i:i + chunk_size] for i in range(0, len(items), chunk_size)]

all_instances = [f"i-{i:04d}" for i in range(1, 22)]  # 21 instances
batches = chunk_list(all_instances, 5)

for i, batch in enumerate(batches, 1):
    print(f"Batch {i}: {batch}")
```

**Output:**
```
Batch 1: ['i-0001', 'i-0002', 'i-0003', 'i-0004', 'i-0005']
Batch 2: ['i-0006', 'i-0007', 'i-0008', 'i-0009', 'i-0010']
Batch 3: ['i-0011', 'i-0012', 'i-0013', 'i-0014', 'i-0015']
Batch 4: ['i-0016', 'i-0017', 'i-0018', 'i-0019', 'i-0020']
Batch 5: ['i-0021']
```

### Pattern 5: Counting and Aggregation

```python
from collections import Counter

# Count error types in logs
error_types = [
    "ConnectionTimeout", "DiskFull", "ConnectionTimeout",
    "PermissionDenied", "DiskFull", "ConnectionTimeout",
    "OutOfMemory", "DiskFull", "ConnectionTimeout"
]

counts = Counter(error_types)
print(counts)
# Counter({"ConnectionTimeout": 4, "DiskFull": 3, "PermissionDenied": 1, "OutOfMemory": 1})

# Top 2 most common
print(counts.most_common(2))
# [("ConnectionTimeout", 4), ("DiskFull", 3)]
```

---

## 4.16 Section Summary and Review

### What You Learned

| Topic | Key Takeaway |
|-------|-------------|
| Lists | Ordered, mutable, indexed, allows duplicates |
| List methods | append, extend, insert, remove, pop, sort, reverse |
| Shallow vs deep copy | Shallow copies share nested objects; deepcopy doesn't |
| List comprehensions | Concise list creation with optional filtering |
| Tuples | Ordered, immutable, hashable (can be dict keys) |
| Tuple unpacking | `a, b, c = tuple_value` for clean multiple assignment |
| Dictionaries | Key-value pairs, O(1) lookup, ordered (3.7+) |
| Dict methods | get(), items(), keys(), values(), update(), pop() |
| Dict comprehensions | `{k: v for ...}` one-line dict creation |
| Nested dicts | Mirrors JSON/YAML; chain keys for access |
| Sets | Unique, unordered, O(1) membership, mathematical operations |
| Set operations | Union, intersection, difference, symmetric difference |
| Choosing structures | Dict for lookups, set for uniqueness, list for ordered collections |

### Production Scenario Recap

> An infrastructure monitoring system stores server data as a list of dictionaries (each server is a dict with hostname, IP, metrics). It uses set operations to find newly added/removed servers between deployments, Counter to identify the most common errors, and dict comprehensions to build alert configurations dynamically.

### Common Interview Questions

1. **Q: What is the difference between a list and a tuple?**
   A: Lists are mutable (can change); tuples are immutable (cannot change). Tuples are hashable (can be dict keys), use less memory, and signal "this data is fixed."

2. **Q: How is dict lookup O(1)?**
   A: Dicts use hash tables. The key is hashed to an integer that maps directly to a memory slot. No need to search sequentially.

3. **Q: What happens if you use a duplicate key in a dict?**
   A: The later value silently overwrites the earlier one. No error.

4. **Q: How do you remove duplicates from a list while preserving order?**
   A: `list(dict.fromkeys(original_list))` — works in Python 3.7+ because dicts maintain insertion order.

5. **Q: When would you use a set over a list for membership testing?**
   A: Always when the collection is large and you check `in` frequently. `in` on a set is O(1); on a list it's O(n).

### Practice Exercises

1. Create a list of 10 server hostnames. Sort them, reverse them, and find the 3rd from last.
2. Write a list comprehension that extracts all IPs from a list of `"hostname:ip"` strings.
3. Create a nested dictionary representing 3 AWS regions, each with 2 servers and their metrics.
4. Use set operations to find which ports are open that aren't in an allowed list.
5. Given a list of log entries, use Counter to find the top 3 most frequent error messages.
6. Write a function that merges two configs (dicts), where the second overrides the first.
7. Create a named tuple for `Deployment` with fields: service, version, environment, timestamp.

### Beginner Quiz (10 Questions)

1. What is the output of `[1, 2, 3] + [4, 5]`?
2. Can a set contain a list as an element?
3. What does `dict.get("key", "default")` return if "key" doesn't exist?
4. What is the difference between `append()` and `extend()`?
5. How do you create an empty set? (Not `{}`)
6. What is the output of `len({"a": 1, "b": 2, "a": 3})`?
7. Can a tuple be used as a dictionary key?
8. What does `{1, 2, 3} & {2, 3, 4}` return?
9. What method removes and returns the last item from a list?
10. What is the time complexity of checking `x in my_set`?

<details>
<summary>Quiz Answers</summary>

1. `[1, 2, 3, 4, 5]` — concatenation creates a new list
2. No — set elements must be hashable; lists are not hashable
3. `"default"` — .get() returns the default value instead of raising KeyError
4. `append()` adds one item (even if it's a list); `extend()` adds each item from an iterable individually
5. `set()` — `{}` creates an empty dict
6. `2` — duplicate key "a" is overwritten, so only {"a": 3, "b": 2} remains
7. Yes — tuples are immutable and hashable
8. `{2, 3}` — intersection (items in both sets)
9. `pop()` — with no argument, removes and returns the last item
10. O(1) — constant time, regardless of set size

</details>

### Next Section Preview

**Section 5: Functions — Definition, Parameters, Return Values, and Scope**

You will learn what functions are, why they exist, how to define them, positional vs keyword arguments, default parameters, `*args` and `**kwargs`, return values, variable scope (local/global/enclosing), docstrings, type hints, lambda functions, and how Python functions are first-class objects. We'll cover real DevOps scenarios like health check functions, retry wrappers, and configuration builders.

---

*Ready for Section 5? Let me know and I'll generate it.*
