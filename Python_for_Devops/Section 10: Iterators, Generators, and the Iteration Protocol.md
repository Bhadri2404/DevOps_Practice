# Section 10: Iterators, Generators, and the Iteration Protocol

---

## 📑 Table of Contents

- [10.1 What Is Iteration?](#101-what-is-iteration)
- [10.2 The Iteration Protocol — How for Loops Really Work](#102-the-iteration-protocol--how-for-loops-really-work)
- [10.3 Iterables vs Iterators — The Critical Difference](#103-iterables-vs-iterators--the-critical-difference)
- [10.4 The iter() Function](#104-the-iter-function)
- [10.5 The next() Function](#105-the-next-function)
- [10.6 StopIteration — How Loops Know When to Stop](#106-stopiteration--how-loops-know-when-to-stop)
- [10.7 Building Custom Iterators](#107-building-custom-iterators)
- [10.8 What Are Generators?](#108-what-are-generators)
- [10.9 The yield Keyword — Deep Dive](#109-the-yield-keyword--deep-dive)
- [10.10 Generator Functions vs Regular Functions](#1010-generator-functions-vs-regular-functions)
- [10.11 Generator Expressions](#1011-generator-expressions)
- [10.12 Lazy Evaluation and Memory Efficiency](#1012-lazy-evaluation-and-memory-efficiency)
- [10.13 Generator Pipelines](#1013-generator-pipelines)
- [10.14 yield from — Delegating to Sub-generators](#1014-yield-from--delegating-to-sub-generators)
- [10.15 The itertools Module](#1015-the-itertools-module)
- [10.16 Common DevOps Iterator/Generator Patterns](#1016-common-devops-iteratorgenerator-patterns)
- [10.17 Section Summary and Review](#1017-section-summary-and-review)

---

## 🎯 Learning Objectives

By the end of this section, you will:

1. Understand what iteration means and why Python's iteration system is special
2. Know exactly how a `for` loop works under the hood
3. Clearly distinguish between iterables and iterators
4. Use `iter()` and `next()` manually
5. Understand `StopIteration` and why it exists
6. Build custom iterator classes with `__iter__` and `__next__`
7. Understand generators deeply — what they are, why they exist, how they work
8. Use `yield` to create generator functions
9. Write generator expressions (one-line generators)
10. Understand lazy evaluation and its memory benefits
11. Build generator pipelines for data processing
12. Use `itertools` for advanced iteration patterns
13. Apply generators to DevOps: log streaming, large file processing, pagination

---

## 10.1 What Is Iteration?

### Real-Life Analogy

Imagine you have a **deck of cards face-down on a table**. Iteration is the process of:
1. Pick up the top card
2. Look at it (process it)
3. Put it aside
4. Repeat until no cards remain

You don't need to see all cards at once. You process them **one at a time, in sequence**. This is fundamentally different from having all cards spread face-up on the table (which would be like having all data in memory at once).

### Definition

**Iteration** is the process of going through a collection of items **one at a time, in sequence**. Each pass through one item is called one **iteration**.

### Why Iteration Is So Important in Python

In Python, iteration is EVERYWHERE:

```python
# These ALL use iteration internally:
for item in my_list:          # Obvious iteration
    print(item)

result = sum(numbers)          # Iterates through numbers
words = "hello world".split()  # Returns an iterable
big = max(scores)              # Iterates to find maximum
joined = ", ".join(names)      # Iterates through names
exists = "x" in my_list       # Iterates to search
squared = [x**2 for x in nums]  # List comprehension iterates
```

Understanding HOW iteration works internally unlocks deep Python knowledge.

### Why This Section Matters for DevOps

In DevOps, you frequently deal with:
- **Millions of log lines** — can't load all into memory
- **Paginated API responses** — data comes in chunks
- **Streaming metrics** — continuous flow of data
- **Large file processing** — GBs of configuration or state data
- **Infinite sequences** — monitoring loops that never end

Generators and iterators let you handle all of these **efficiently** without running out of memory.

---

## 10.2 The Iteration Protocol — How for Loops Really Work

### What Most Beginners Think

Most beginners think `for item in my_list` just magically goes through the list. But there's a precise mechanism underneath.

### What Actually Happens

When Python encounters:
```python
for item in my_list:
    print(item)
```

It secretly does this:

```python
# Step 1: Get an iterator from the iterable
_iterator = iter(my_list)    # Calls my_list.__iter__()

# Step 2: Repeatedly call next() until StopIteration
while True:
    try:
        item = next(_iterator)    # Calls _iterator.__next__()
        print(item)               # Your loop body
    except StopIteration:
        break                     # Loop ends
```

### Visual Diagram

```
┌────────────────────────────────────────────────────────────────┐
│  for item in [10, 20, 30]:                                      │
│      print(item)                                                │
│                                                                  │
│  WHAT PYTHON ACTUALLY DOES:                                      │
│                                                                  │
│  ┌─────────────────────────────────────────────────────┐        │
│  │ 1. _iter = iter([10, 20, 30])                       │        │
│  │    → Creates an iterator object from the list       │        │
│  └──────────────────────────┬──────────────────────────┘        │
│                             │                                    │
│  ┌──────────────────────────▼──────────────────────────┐        │
│  │ 2. next(_iter) → 10     (item = 10, print it)       │        │
│  │ 3. next(_iter) → 20     (item = 20, print it)       │        │
│  │ 4. next(_iter) → 30     (item = 30, print it)       │        │
│  │ 5. next(_iter) → StopIteration raised!              │        │
│  │ 6. Python catches StopIteration → loop ends         │        │
│  └─────────────────────────────────────────────────────┘        │
└────────────────────────────────────────────────────────────────┘
```

### Why This Matters

Understanding this protocol means you can:
1. Create your own objects that work with `for` loops
2. Understand why some objects can only be iterated ONCE
3. Build memory-efficient data processors (generators)
4. Debug iteration-related bugs confidently

### Beginner Program: Manually Doing What for Does

```python
# Let's manually do what "for item in fruits" does

fruits = ["apple", "banana", "cherry"]

# Step 1: Get the iterator
my_iterator = iter(fruits)

# Step 2: Call next() repeatedly
print(next(my_iterator))    # apple
print(next(my_iterator))    # banana
print(next(my_iterator))    # cherry
# print(next(my_iterator))  # Would raise StopIteration!
```

**Line-by-Line Explanation:**

| Line | What Happens | Internal Detail |
|------|-------------|-----------------|
| `fruits = ["apple", "banana", "cherry"]` | Creates a list (an iterable) | List is stored in memory with 3 references |
| `my_iterator = iter(fruits)` | Creates an iterator FROM the list | Calls `fruits.__iter__()`, returns a list_iterator object that has an internal pointer starting at position 0 |
| `next(my_iterator)` → `"apple"` | Gets the next item | Calls `my_iterator.__next__()`, returns item at position 0, advances pointer to 1 |
| `next(my_iterator)` → `"banana"` | Gets the next item | Returns item at position 1, advances pointer to 2 |
| `next(my_iterator)` → `"cherry"` | Gets the next item | Returns item at position 2, advances pointer to 3 |
| `next(my_iterator)` again | No more items! | Raises `StopIteration` exception |

---

## 10.3 Iterables vs Iterators — The Critical Difference

### This Is the Most Confusing Part for Beginners

Many people use "iterable" and "iterator" interchangeably. They are NOT the same thing. Understanding the difference is crucial.

### Iterable — Something You CAN Iterate Over

An **iterable** is any object that:
- Has an `__iter__()` method that returns an iterator
- OR has a `__getitem__()` method for indexed access

**Analogy:** An iterable is like a **book**. The book contains information you can read through. But the book itself doesn't track where you are — you need a **bookmark** (iterator) for that.

**Common iterables:** list, tuple, dict, set, string, range, file

```python
# These are all ITERABLES:
my_list = [1, 2, 3]           # Iterable
my_string = "hello"           # Iterable
my_dict = {"a": 1, "b": 2}   # Iterable
my_range = range(10)          # Iterable
my_file = open("data.txt")    # Iterable (AND an iterator!)
```

### Iterator — Something That IS Iterating

An **iterator** is any object that:
- Has a `__next__()` method that returns the next item
- Has an `__iter__()` method that returns itself
- Raises `StopIteration` when exhausted

**Analogy:** An iterator is like a **bookmark IN a book**. It knows where you are right now and can move to the next page. Once you reach the last page, it signals "done" (StopIteration).

### Key Differences

```
┌─────────────────────────────────────────────────────────────────┐
│  ITERABLE                    │  ITERATOR                         │
├──────────────────────────────┼───────────────────────────────────┤
│  Has __iter__() method       │  Has __iter__() AND __next__()    │
│  Can be iterated multiple    │  Can be iterated only ONCE        │
│  times (creates new iterator │  (exhausted after one pass)       │
│  each time)                  │                                   │
│                              │                                   │
│  Examples:                   │  Examples:                        │
│  list, tuple, dict, string,  │  list_iterator, generator,        │
│  range, set                  │  file object, map/filter objects   │
│                              │                                   │
│  [1, 2, 3] is an iterable   │  iter([1, 2, 3]) is an iterator   │
└──────────────────────────────┴───────────────────────────────────┘
```

### The Critical Insight: Iterables Can Be Iterated Multiple Times

```python
# ITERABLE — can loop multiple times
my_list = [1, 2, 3]

for item in my_list:
    print(item)    # 1, 2, 3

for item in my_list:
    print(item)    # 1, 2, 3 again! Works every time!

# Each for loop creates a NEW iterator from the iterable
```

### Iterators Are Exhausted After One Pass

```python
# ITERATOR — can only go through once!
my_list = [1, 2, 3]
my_iterator = iter(my_list)    # Create iterator

# First pass — works
for item in my_iterator:
    print(item)    # 1, 2, 3

# Second pass — NOTHING! Iterator is exhausted!
for item in my_iterator:
    print(item)    # Nothing prints! Empty!
```

**Why?** The iterator has already moved past all items. It doesn't "reset." Once `StopIteration` is raised, it stays exhausted.

### Beginner Program: Demonstrating the Difference

```python
# Let's prove iterables and iterators behave differently

print("=== ITERABLE (list) — Can iterate multiple times ===")
servers = ["web-01", "web-02", "web-03"]

print("First loop:")
for s in servers:
    print(f"  {s}")

print("Second loop:")
for s in servers:
    print(f"  {s}")    # Works again!

print("\n=== ITERATOR — Can only iterate ONCE ===")
server_iterator = iter(servers)    # Create iterator from list

print("First loop:")
for s in server_iterator:
    print(f"  {s}")

print("Second loop:")
for s in server_iterator:
    print(f"  {s}")    # Nothing prints! Exhausted!

print("(Nothing printed — iterator is done)")
```

**Expected Output:**
```
=== ITERABLE (list) — Can iterate multiple times ===
First loop:
  web-01
  web-02
  web-03
Second loop:
  web-01
  web-02
  web-03

=== ITERATOR — Can only iterate ONCE ===
First loop:
  web-01
  web-02
  web-03
Second loop:
(Nothing printed — iterator is done)
```

### How to Check If Something Is Iterable or Iterator

```python
# Check using the collections.abc module
from collections.abc import Iterable, Iterator

my_list = [1, 2, 3]
my_iter = iter(my_list)

print(isinstance(my_list, Iterable))    # True — it's iterable
print(isinstance(my_list, Iterator))    # False — it's NOT an iterator

print(isinstance(my_iter, Iterable))    # True — iterators are ALSO iterable!
print(isinstance(my_iter, Iterator))    # True — it IS an iterator
```

**Key fact:** Every iterator is also an iterable (because it has `__iter__` returning itself). But NOT every iterable is an iterator.

---

## 10.4 The iter() Function

### What It Does

`iter()` is a built-in function that takes an iterable and returns an iterator from it. It calls the object's `__iter__()` method internally.

### Why It Exists

You rarely call `iter()` manually in everyday code — `for` loops do it automatically. But understanding `iter()` is essential for:
1. Understanding how Python works under the hood
2. Building custom iterators
3. Manual iteration when needed (processing one item at a time)
4. Using the two-argument form of `iter()` (advanced)

### Basic Usage

```python
# iter() converts an iterable into an iterator
numbers = [10, 20, 30, 40, 50]

# The list itself is NOT an iterator
print(type(numbers))    # <class 'list'>

# iter() creates an iterator FROM the list
numbers_iter = iter(numbers)
print(type(numbers_iter))    # <class 'list_iterator'>
```

### Beginner Program: Using iter() Step by Step

```python
# Simulating how Python processes a for loop

print("=== Processing servers one at a time ===\n")

servers = ["web-01", "web-02", "db-01", "cache-01"]

# Step 1: Create an iterator (for loop does this automatically)
server_iter = iter(servers)
print(f"Created iterator: {type(server_iter)}")
print()

# Step 2: Get items one at a time with next()
print("Getting items manually:")
server = next(server_iter)
print(f"  Got: {server}")    # web-01

server = next(server_iter)
print(f"  Got: {server}")    # web-02

server = next(server_iter)
print(f"  Got: {server}")    # db-01

server = next(server_iter)
print(f"  Got: {server}")    # cache-01

# Step 3: What happens when we ask for one more?
print("\nTrying to get one more item...")
try:
    server = next(server_iter)
except StopIteration:
    print("  StopIteration raised! No more items.")
    print("  This is how Python knows the for loop should end.")
```

**Expected Output:**
```
=== Processing servers one at a time ===

Created iterator: <class 'list_iterator'>

Getting items manually:
  Got: web-01
  Got: web-02
  Got: db-01
  Got: cache-01

Trying to get one more item...
  StopIteration raised! No more items.
  This is how Python knows the for loop should end.
```

### iter() with Different Iterables

```python
# iter() works with any iterable

# String
char_iter = iter("Python")
print(next(char_iter))    # P
print(next(char_iter))    # y
print(next(char_iter))    # t

# Dictionary (iterates over KEYS by default)
config = {"host": "localhost", "port": 5432, "db": "myapp"}
key_iter = iter(config)
print(next(key_iter))    # "host"
print(next(key_iter))    # "port"

# Range
range_iter = iter(range(100, 105))
print(next(range_iter))    # 100
print(next(range_iter))    # 101

# Set (order not guaranteed!)
unique_iter = iter({3, 1, 4, 1, 5})
print(next(unique_iter))    # Some element (order varies)
```

### The Two-Argument Form of iter() (Advanced)

`iter()` has a second form: `iter(callable, sentinel)`. It calls the callable repeatedly until it returns the sentinel value.

```python
# Read lines from user until they type "quit"
# iter(input, "quit") — calls input() until it returns "quit"

# Read fixed-size blocks from a file
with open("data.bin", "rb") as f:
    # Read 1024 bytes at a time until empty bytes (end of file)
    for block in iter(lambda: f.read(1024), b""):
        process(block)
```

This is less common but useful for specific patterns.

---

## 10.5 The next() Function

### What It Does

`next()` retrieves the **next item** from an iterator. Each call advances the iterator's internal position by one.

### Why It Exists

`next()` is the fundamental mechanism that drives ALL iteration in Python. Every time a `for` loop gets the next item, it's calling `next()` internally.

### Basic Usage

```python
colors = ["red", "green", "blue"]
color_iter = iter(colors)

print(next(color_iter))    # "red"    — first call gets first item
print(next(color_iter))    # "green"  — second call gets second item
print(next(color_iter))    # "blue"   — third call gets third item
# next(color_iter)         — would raise StopIteration!
```

### The Default Value — Preventing StopIteration

`next()` accepts a second argument — a default value returned instead of raising `StopIteration`:

```python
colors = ["red", "green"]
color_iter = iter(colors)

print(next(color_iter, "no more"))    # "red"
print(next(color_iter, "no more"))    # "green"
print(next(color_iter, "no more"))    # "no more" (default — no exception!)
print(next(color_iter, "no more"))    # "no more" (still safe)
```

### Beginner Program: Processing One Item at a Time with next()

```python
# Scenario: You're processing a queue of deployment requests
# You want to process them one at a time with pauses between

deployment_queue = [
    "Deploy api-gateway v2.3.1 to production",
    "Deploy web-frontend v1.5.0 to staging",
    "Deploy data-service v4.0.0 to production",
    "Deploy auth-service v1.2.0 to staging",
]

# Create an iterator for controlled processing
queue_iter = iter(deployment_queue)

print("=== Deployment Queue Processor ===\n")

# Process first deployment
current = next(queue_iter, None)
if current:
    print(f"▶ Processing: {current}")
    print(f"  ✅ Complete\n")

# Process second deployment
current = next(queue_iter, None)
if current:
    print(f"▶ Processing: {current}")
    print(f"  ✅ Complete\n")

# Check how many remain
remaining = list(queue_iter)    # Consume the rest into a list
print(f"📋 Remaining in queue: {len(remaining)} deployments")
for dep in remaining:
    print(f"   - {dep}")
```

**Expected Output:**
```
=== Deployment Queue Processor ===

▶ Processing: Deploy api-gateway v2.3.1 to production
  ✅ Complete

▶ Processing: Deploy web-frontend v1.5.0 to staging
  ✅ Complete

📋 Remaining in queue: 2 deployments
   - Deploy data-service v4.0.0 to production
   - Deploy auth-service v1.2.0 to staging
```

### Why Use next() Instead of a for Loop?

| Use for loop when | Use next() when |
|-------------------|-----------------|
| You want ALL items | You want ONE item at a time |
| Processing is uniform | Processing changes between items |
| Simple iteration | Need to peek at first item |
| Complete pass needed | Partial consumption |

```python
# Peek at first item without consuming the whole thing
with open("large_file.log") as f:
    first_line = next(iter(f), "")
    print(f"First line: {first_line}")
    # File isn't fully read into memory!
```

---

## 10.6 StopIteration — How Loops Know When to Stop

### What It Is

`StopIteration` is a **built-in exception** that an iterator raises when it has no more items to produce. It's the signal that says "I'm done."

### Why It's an Exception (Not a Return Value)

You might wonder: "Why not just return `None` or a special value to mean 'done'?" Because `None` could be a legitimate value in the sequence! Consider:

```python
data = [1, None, 3, None, 5]
# If None meant "done", you'd stop at the second item!
# StopIteration is unambiguous — it ONLY means "no more items"
```

### How for Loops Handle StopIteration

```python
# for loops AUTOMATICALLY catch StopIteration
# You never see it — Python handles it silently

numbers = [10, 20, 30]

# This:
for n in numbers:
    print(n)

# Is secretly:
_iter = iter(numbers)
while True:
    try:
        n = next(_iter)
        print(n)
    except StopIteration:    # ← Python catches this for you!
        break
```

### Beginner Program: Seeing StopIteration in Action

```python
print("=== Understanding StopIteration ===\n")

# Small list with 3 items
metrics = [78.5, 92.3, 45.1]
metric_iter = iter(metrics)

# Call next() 4 times (one more than items available)
for i in range(4):
    try:
        value = next(metric_iter)
        print(f"  Call {i+1}: Got {value}%")
    except StopIteration:
        print(f"  Call {i+1}: StopIteration! Iterator exhausted.")
        print(f"           This is how Python knows to end a for loop.")
        break

print("\n--- Same thing with next()'s default parameter ---\n")

# Using default value avoids the exception entirely
metric_iter2 = iter(metrics)

for i in range(5):
    value = next(metric_iter2, "DONE")    # "DONE" instead of exception
    if value == "DONE":
        print(f"  Call {i+1}: No more items (got default: 'DONE')")
        break
    else:
        print(f"  Call {i+1}: Got {value}%")
```

**Expected Output:**
```
=== Understanding StopIteration ===

  Call 1: Got 78.5%
  Call 2: Got 92.3%
  Call 3: Got 45.1%
  Call 4: StopIteration! Iterator exhausted.
           This is how Python knows to end a for loop.

--- Same thing with next()'s default parameter ---

  Call 1: Got 78.5%
  Call 2: Got 92.3%
  Call 3: Got 45.1%
  Call 4: No more items (got default: 'DONE')
```

### Important: You Should Almost Never Catch StopIteration Manually

In everyday code, `for` loops handle `StopIteration` for you. The only time you catch it manually is:
- When using `next()` directly
- When building custom iteration logic
- In rare advanced patterns

---

## 10.7 Building Custom Iterators

### Why Build Your Own?

Sometimes built-in iterables (list, range, etc.) aren't enough. You might need:
- Infinite sequences (counting forever, monitoring continuously)
- Computed sequences (values calculated on demand)
- Controlled access to data (paginated results)
- Custom behavior during iteration

### How to Build an Iterator

An iterator class must implement TWO methods:
1. `__iter__(self)` — returns `self` (the iterator itself)
2. `__next__(self)` — returns the next value OR raises `StopIteration`

### Beginner Program: Simple Counter Iterator

```python
class Counter:
    """
    A simple iterator that counts from 'start' up to (not including) 'stop'.
    
    This is similar to range() but we're building it ourselves to understand
    how iterators work internally.
    """
    
    def __init__(self, start, stop):
        self.current = start    # Where we are now
        self.stop = stop        # Where to stop
    
    def __iter__(self):
        """Return self — this object IS the iterator."""
        return self
    
    def __next__(self):
        """Return the next value, or raise StopIteration when done."""
        if self.current >= self.stop:
            raise StopIteration    # Signal: no more items!
        
        value = self.current       # Save current value to return
        self.current += 1          # Move forward for next call
        return value               # Give the value to the caller


# Usage — works with for loops!
print("Counting from 1 to 5:")
for number in Counter(1, 6):
    print(f"  {number}")
```

**Expected Output:**
```
Counting from 1 to 5:
  1
  2
  3
  4
  5
```

**Detailed Explanation of Each Method:**

| Method | When Python Calls It | What It Must Do |
|--------|---------------------|-----------------|
| `__iter__` | At the START of a for loop (`iter()` is called) | Return the iterator object (return `self`) |
| `__next__` | EACH iteration of the for loop (`next()` is called) | Return next value OR raise `StopIteration` |

### Beginner Program: Server Health Iterator

```python
class ServerHealthChecker:
    """
    Iterates through a list of servers, checking health one at a time.
    
    This demonstrates a practical iterator that does WORK during iteration,
    not just returning stored values.
    """
    
    def __init__(self, servers):
        self.servers = servers
        self.index = 0
    
    def __iter__(self):
        return self
    
    def __next__(self):
        if self.index >= len(self.servers):
            raise StopIteration
        
        server = self.servers[self.index]
        self.index += 1
        
        # Simulate a health check (in real code: HTTP request)
        import random
        is_healthy = random.random() > 0.2    # 80% chance healthy
        response_time = random.uniform(10, 200)
        
        return {
            "server": server,
            "healthy": is_healthy,
            "response_time_ms": round(response_time, 1)
        }


# Usage
print("=== Server Health Check Report ===\n")

servers = ["web-01", "web-02", "web-03", "db-01", "cache-01"]
checker = ServerHealthChecker(servers)

healthy_count = 0
for result in checker:
    status = "✅" if result["healthy"] else "❌"
    print(f"  {status} {result['server']}: {result['response_time_ms']}ms")
    if result["healthy"]:
        healthy_count += 1

print(f"\n  Summary: {healthy_count}/{len(servers)} healthy")
```

### Why This Is Better Than Just Using a List

In this example, the iterator DOES WORK (health check) on each iteration. If we used a list, we'd have to check ALL servers before getting any results. With an iterator, we get results one at a time — useful if:
- We want to stop early (first failure = abort)
- We want to show real-time progress
- The checks are slow and we want results as they come

---

## 10.8 What Are Generators?

### The Problem with Custom Iterators

Building custom iterators (like we did above) requires:
- A class with `__init__`, `__iter__`, `__next__`
- Manual state tracking (`self.index`, `self.current`)
- Manual `StopIteration` raising

That's a LOT of boilerplate for something conceptually simple.

### Generators: The Elegant Solution

A **generator** is a special kind of function that produces a sequence of values lazily (one at a time, on demand) using the `yield` keyword. It's the easiest way to create an iterator — no class needed!

### Real-Life Analogy

Think of a generator like a **factory worker on an assembly line**:
- They produce one item at a time
- After producing an item, they **pause** and wait for the next request
- When asked "give me another one," they **resume** exactly where they left off
- Eventually, they signal "I'm done" (function returns)

Compare this to a factory that produces ALL items first and stores them in a warehouse (loading everything into a list). The assembly line worker (generator) uses almost no warehouse space (memory).

### Your First Generator

```python
def count_up_to(maximum):
    """A generator that counts from 1 up to maximum."""
    current = 1
    while current <= maximum:
        yield current    # Produce a value and PAUSE
        current += 1     # Resume here on next call

# Using the generator
for number in count_up_to(5):
    print(number)
# Output: 1, 2, 3, 4, 5
```

That's it! The `yield` keyword is what makes this a generator instead of a regular function.

### What Makes It Different from a Regular Function

```python
# REGULAR function: computes everything, returns a list
def get_numbers_regular(n):
    result = []
    for i in range(1, n + 1):
        result.append(i)
    return result    # Returns ALL values at once

# GENERATOR function: produces one value at a time
def get_numbers_generator(n):
    for i in range(1, n + 1):
        yield i    # Produces ONE value, then pauses

# Regular: creates entire list in memory
all_numbers = get_numbers_regular(1000000)    # 1 million items in memory!

# Generator: creates values on demand
number_gen = get_numbers_generator(1000000)   # Almost no memory used!
first = next(number_gen)    # Just produces 1
second = next(number_gen)   # Just produces 2
```

---

## 10.9 The yield Keyword — Deep Dive

### What yield Does

`yield` does THREE things:
1. **Produces a value** — sends it back to the caller
2. **Pauses the function** — remembers exactly where it stopped (all local variables preserved)
3. **Waits** — until `next()` is called again, then resumes from that exact point

### How yield Differs from return

| Feature | `return` | `yield` |
|---------|----------|---------|
| Function type | Regular function | Generator function |
| Execution | Runs to completion | Pauses and resumes |
| Number of values | One (then done forever) | Many (one per call) |
| State | Destroyed after return | Preserved between yields |
| Memory | Must store all results | Produces one at a time |

### Beginner Program: Tracing Generator Execution

```python
def simple_generator():
    """Watch the execution flow carefully."""
    print("  → Starting generator (before first yield)")
    yield "FIRST"
    
    print("  → Resumed after first yield (before second yield)")
    yield "SECOND"
    
    print("  → Resumed after second yield (before third yield)")
    yield "THIRD"
    
    print("  → Resumed after third yield (about to finish)")
    # No more yields — StopIteration will be raised automatically

print("=== Tracing Generator Execution ===\n")
print("Creating generator object:")
gen = simple_generator()
print(f"  Type: {type(gen)}")
print(f"  (Nothing has executed yet!)\n")

print("Calling next() — first time:")
value = next(gen)
print(f"  Got: {value}\n")

print("Calling next() — second time:")
value = next(gen)
print(f"  Got: {value}\n")

print("Calling next() — third time:")
value = next(gen)
print(f"  Got: {value}\n")

print("Calling next() — fourth time (no more yields!):")
try:
    value = next(gen)
except StopIteration:
    print("  StopIteration raised — generator is exhausted!")
```

**Expected Output:**
```
=== Tracing Generator Execution ===

Creating generator object:
  Type: <class 'generator'>
  (Nothing has executed yet!)

Calling next() — first time:
  → Starting generator (before first yield)
  Got: FIRST

Calling next() — second time:
  → Resumed after first yield (before second yield)
  Got: SECOND

Calling next() — third time:
  → Resumed after second yield (before third yield)
  Got: THIRD

Calling next() — fourth time (no more yields!):
  → Resumed after third yield (about to finish)
  StopIteration raised — generator is exhausted!
```

### Key Insights from This Example

1. **Creating the generator (`gen = simple_generator()`) does NOT execute any code.** The function body doesn't run until `next()` is called.

2. **Each `next()` call runs the code UNTIL the next `yield`**, then pauses.

3. **The generator remembers its state** — local variables, position in the code — between calls.

4. **When the function runs to completion** (no more yields), `StopIteration` is raised automatically.

### Beginner Program: Practical Generator — Log Level Filter

```python
def filter_log_lines(log_lines, level):
    """
    Generator that yields only log lines matching the given level.
    
    Instead of creating a new list of matching lines (memory!),
    this produces matching lines one at a time.
    """
    for line in log_lines:
        if f"[{level}]" in line:
            yield line.strip()

# Simulated log data
logs = [
    "2024-01-15 08:00:01 [INFO] Server started",
    "2024-01-15 08:00:05 [INFO] Database connected",
    "2024-01-15 08:01:22 [ERROR] Disk usage at 95%",
    "2024-01-15 08:02:10 [WARNING] Memory usage high",
    "2024-01-15 08:03:45 [ERROR] Connection timeout to cache",
    "2024-01-15 08:04:00 [INFO] Retry successful",
    "2024-01-15 08:05:12 [ERROR] Out of memory on worker-03",
]

print("=== Error Log Entries ===\n")

# The generator only processes lines as needed
error_gen = filter_log_lines(logs, "ERROR")

# Process errors one at a time
for i, error in enumerate(error_gen, 1):
    print(f"  Error #{i}: {error}")

print(f"\n  Total errors found: {i}")
```

**Expected Output:**
```
=== Error Log Entries ===

  Error #1: 2024-01-15 08:01:22 [ERROR] Disk usage at 95%
  Error #2: 2024-01-15 08:03:45 [ERROR] Connection timeout to cache
  Error #3: 2024-01-15 08:05:12 [ERROR] Out of memory on worker-03

  Total errors found: 3
```

---

## 10.10 Generator Functions vs Regular Functions

### Side-by-Side Comparison

```python
# REGULAR function
def get_squares_list(n):
    """Creates and returns a complete list."""
    result = []              # Allocates memory for list
    for i in range(1, n+1):
        result.append(i**2)  # Stores each value in memory
    return result            # Returns everything at once

# GENERATOR function
def get_squares_gen(n):
    """Produces squares one at a time, on demand."""
    for i in range(1, n+1):
        yield i**2           # Produces one value, pauses

# Using the regular function
squares_list = get_squares_list(5)    # [1, 4, 9, 16, 25] — all in memory
print(type(squares_list))             # <class 'list'>
print(squares_list)                   # [1, 4, 9, 16, 25]

# Using the generator function
squares_gen = get_squares_gen(5)      # Generator object — almost no memory
print(type(squares_gen))              # <class 'generator'>
print(squares_gen)                    # <generator object at 0x...>
print(list(squares_gen))              # [1, 4, 9, 16, 25] — converts to list
```

### Beginner Program: Memory Comparison

```python
import sys

def big_list(n):
    """Returns a list of n numbers — ALL in memory."""
    return [i for i in range(n)]

def big_generator(n):
    """Yields n numbers — one at a time, constant memory."""
    for i in range(n):
        yield i

n = 1_000_000  # One million numbers

# Compare memory usage
the_list = big_list(n)
the_gen = big_generator(n)

print("=== Memory Comparison ===\n")
print(f"  List with {n:,} items:")
print(f"    Memory: {sys.getsizeof(the_list):,} bytes ({sys.getsizeof(the_list) / 1024 / 1024:.1f} MB)")
print(f"    Type: {type(the_list)}")

print(f"\n  Generator for {n:,} items:")
print(f"    Memory: {sys.getsizeof(the_gen):,} bytes")
print(f"    Type: {type(the_gen)}")

print(f"\n  Memory ratio: List uses {sys.getsizeof(the_list) / sys.getsizeof(the_gen):.0f}x more memory!")
```

**Expected Output (approximate):**
```
=== Memory Comparison ===

  List with 1,000,000 items:
    Memory: 8,448,728 bytes (8.1 MB)
    Type: <class 'list'>

  Generator for 1,000,000 items:
    Memory: 200 bytes
    Type: <class 'generator'>

  Memory ratio: List uses 42244x more memory!
```

### When to Use Each

| Use a Regular Function (return list) | Use a Generator (yield) |
|--------------------------------------|------------------------|
| Small data that fits in memory | Large/infinite data |
| Need random access (items by index) | Sequential processing only |
| Need to iterate multiple times | Single pass is enough |
| Need `len()`, slicing, etc. | Memory efficiency is priority |
| Consumer needs all data at once | Consumer processes one at a time |

---

## 10.11 Generator Expressions

### What They Are

A **generator expression** is a one-line shorthand for simple generators — just like list comprehensions, but with parentheses instead of brackets.

```python
# List comprehension (creates a full list in memory)
squares_list = [x**2 for x in range(1000000)]    # 8+ MB

# Generator expression (creates a generator — lazy, low memory)
squares_gen = (x**2 for x in range(1000000))     # ~200 bytes!
```

The ONLY syntax difference: `[]` vs `()`

### Syntax

```python
gen = (expression for item in iterable)
gen = (expression for item in iterable if condition)
```

### Beginner Program: List Comprehension vs Generator Expression

```python
import sys

print("=== List Comprehension vs Generator Expression ===\n")

# List comprehension — creates full list
cpu_list = [cpu for cpu in range(1, 101)]
print(f"List comprehension:")
print(f"  Type: {type(cpu_list)}")
print(f"  Memory: {sys.getsizeof(cpu_list)} bytes")
print(f"  Can index: cpu_list[5] = {cpu_list[5]}")
print(f"  Has length: len = {len(cpu_list)}")

print()

# Generator expression — creates a generator
cpu_gen = (cpu for cpu in range(1, 101))
print(f"Generator expression:")
print(f"  Type: {type(cpu_gen)}")
print(f"  Memory: {sys.getsizeof(cpu_gen)} bytes")
print(f"  Can NOT index (no random access)")
print(f"  Has NO length (doesn't know how many items)")

print()

# Both produce the same values when iterated
print("Both produce same results:")
print(f"  List sum: {sum([x for x in range(101)])}")
print(f"  Gen sum:  {sum(x for x in range(101))}")    # Note: no extra parentheses!
```

### Using Generator Expressions with Functions

When passing a generator expression as the ONLY argument to a function, you can omit the extra parentheses:

```python
# These are equivalent:
total = sum((x**2 for x in range(100)))    # Extra parentheses
total = sum(x**2 for x in range(100))      # No extra parentheses (cleaner)

# More examples:
max_cpu = max(server["cpu"] for server in servers)
any_critical = any(s["status"] == "critical" for s in servers)
all_healthy = all(s["healthy"] for s in health_results)
names = ", ".join(s["name"] for s in servers)
```

### Beginner Program: Practical Generator Expressions

```python
# Server metrics processing with generator expressions

servers = [
    {"name": "web-01", "cpu": 45, "memory": 62, "status": "running"},
    {"name": "web-02", "cpu": 92, "memory": 88, "status": "running"},
    {"name": "db-01", "cpu": 78, "memory": 95, "status": "running"},
    {"name": "cache-01", "cpu": 12, "memory": 30, "status": "stopped"},
    {"name": "api-01", "cpu": 85, "memory": 70, "status": "running"},
]

print("=== Server Metrics Analysis (Generator Expressions) ===\n")

# Average CPU (only running servers)
running_cpus = (s["cpu"] for s in servers if s["status"] == "running")
running_list = [s["cpu"] for s in servers if s["status"] == "running"]
avg_cpu = sum(running_list) / len(running_list)
print(f"  Average CPU (running): {avg_cpu:.1f}%")

# Any server critical? (CPU > 90)
has_critical = any(s["cpu"] > 90 for s in servers)
print(f"  Any critical (CPU > 90): {has_critical}")

# All servers running?
all_running = all(s["status"] == "running" for s in servers)
print(f"  All running: {all_running}")

# Max memory usage
max_mem = max(s["memory"] for s in servers)
max_server = next(s["name"] for s in servers if s["memory"] == max_mem)
print(f"  Highest memory: {max_mem}% ({max_server})")

# Count critical servers
critical_count = sum(1 for s in servers if s["cpu"] > 80)
print(f"  Critical servers (CPU > 80): {critical_count}")

# Server names as comma-separated string
running_names = ", ".join(s["name"] for s in servers if s["status"] == "running")
print(f"  Running servers: {running_names}")
```

**Expected Output:**
```
=== Server Metrics Analysis (Generator Expressions) ===

  Average CPU (running): 75.0%
  Any critical (CPU > 90): True
  All running: False
  Highest memory: 95% (db-01)
  Critical servers (CPU > 80): 2
  Running servers: web-01, web-02, db-01, api-01
```

---

## 10.12 Lazy Evaluation and Memory Efficiency

### What Is Lazy Evaluation?

**Lazy evaluation** means values are computed **only when needed** — not in advance. Generators are lazy; lists are eager (computed immediately).

### Analogy: Restaurant vs Buffet

- **Eager (list):** A buffet prepares ALL food before any guest arrives. If 100 dishes are prepared and only 3 are eaten, 97 are wasted. (Memory for all items allocated upfront.)

- **Lazy (generator):** A restaurant cooks each dish ONLY when a customer orders it. No wasted food, no wasted kitchen space. (Memory only for current item.)

### Why Lazy Evaluation Matters for DevOps

```python
# Scenario: Processing a 50GB log file

# ❌ EAGER — Loads entire file into memory → CRASH (out of memory!)
all_lines = open("huge_50gb.log").readlines()    # 50GB in RAM!
errors = [line for line in all_lines if "ERROR" in line]

# ✅ LAZY — Processes one line at a time → Works on any file size!
def find_errors(filepath):
    with open(filepath) as f:
        for line in f:    # File iterator — reads one line at a time
            if "ERROR" in line:
                yield line.strip()

# Uses constant memory regardless of file size!
for error in find_errors("huge_50gb.log"):
    print(error)
```

### Beginner Program: Lazy vs Eager — The Difference

```python
def eager_approach(n):
    """
    EAGER: Computes ALL values first, stores them, then processes.
    Problem: If n is 1 billion, you need 8GB+ of RAM!
    """
    print(f"  Eager: Computing all {n:,} values...")
    all_values = [i * 2 for i in range(n)]    # ALL in memory!
    print(f"  Eager: Done! Using {len(all_values)} items in memory")
    
    # Now process (find first value > 100)
    for val in all_values:
        if val > 100:
            return val

def lazy_approach(n):
    """
    LAZY: Computes values one at a time, on demand.
    Uses almost no memory, regardless of n!
    """
    print(f"  Lazy: Starting (no pre-computation)...")
    
    def generate_values():
        for i in range(n):
            yield i * 2
    
    # Process as they're generated
    count = 0
    for val in generate_values():
        count += 1
        if val > 100:
            print(f"  Lazy: Found answer after computing only {count} values!")
            return val

print("=== Lazy vs Eager ===\n")

n = 10_000_000    # 10 million

print("Eager approach:")
result = eager_approach(n)
print(f"  Result: {result}\n")

print("Lazy approach:")
result = lazy_approach(n)
print(f"  Result: {result}")
```

**Expected Output:**
```
=== Lazy vs Eager ===

Eager approach:
  Eager: Computing all 10,000,000 values...
  Eager: Done! Using 10000000 items in memory
  Result: 102

Lazy approach:
  Lazy: Starting (no pre-computation)...
  Lazy: Found answer after computing only 52 values!
  Result: 102
```

**The lazy approach computed only 52 values instead of 10 million!** It stopped the moment it found the answer, wasting no computation or memory.

### Infinite Generators — Only Possible with Laziness

```python
def infinite_counter(start=0):
    """Counts forever — only possible because it's lazy!"""
    n = start
    while True:    # Never ends!
        yield n
        n += 1

# You can't store infinity in a list!
# But you can generate infinite values on demand:
counter = infinite_counter(1)
print(next(counter))    # 1
print(next(counter))    # 2
print(next(counter))    # 3
# ... can continue forever!

# Take just the first 5 from infinity
from itertools import islice
first_five = list(islice(infinite_counter(100), 5))
print(first_five)    # [100, 101, 102, 103, 104]
```

---

## 10.13 Generator Pipelines

### What Is a Generator Pipeline?

A generator pipeline connects multiple generators together, where each generator **feeds into the next**. Data flows through the pipeline one item at a time — like water flowing through connected pipes.

### Real-Life Analogy

Think of a car factory assembly line:
```
Raw Metal → Stamping → Welding → Painting → Assembly → Quality Check → Ship
```

Each station works on ONE car at a time and passes it to the next station. The entire pipeline runs with just a few cars "in flight" at once — not millions of cars piled up at any station.

### Why Pipelines Are Powerful

Each stage:
1. Processes one item at a time (low memory)
2. Is independent and reusable
3. Can be tested separately
4. Can be rearranged easily

### Beginner Program: Log Processing Pipeline

```python
def read_lines(filepath):
    """Stage 1: Read file line by line (lazy!)."""
    with open(filepath, "r") as f:
        for line in f:
            yield line

def strip_lines(lines):
    """Stage 2: Remove whitespace from each line."""
    for line in lines:
        yield line.strip()

def filter_errors(lines):
    """Stage 3: Only pass through ERROR lines."""
    for line in lines:
        if "[ERROR]" in line:
            yield line

def extract_message(lines):
    """Stage 4: Extract just the message part."""
    for line in lines:
        # Format: "2024-01-15 08:00:00 [ERROR] message here"
        parts = line.split("] ", 1)
        if len(parts) > 1:
            yield parts[1]

# Build the pipeline — each generator feeds into the next
# (For demo, using a list since we don't have a real file)
sample_logs = [
    "2024-01-15 08:00:01 [INFO] Server started\n",
    "2024-01-15 08:01:22 [ERROR] Disk full on /dev/sda1\n",
    "2024-01-15 08:02:10 [WARNING] Memory at 85%\n",
    "2024-01-15 08:03:45 [ERROR] Connection timeout to db-01\n",
    "2024-01-15 08:04:00 [INFO] Retry successful\n",
    "2024-01-15 08:05:12 [ERROR] Worker-03 out of memory\n",
]

# Pipeline assembly
lines = iter(sample_logs)           # Stage 1: source
stripped = strip_lines(lines)        # Stage 2: clean
errors_only = filter_errors(stripped) # Stage 3: filter
messages = extract_message(errors_only) # Stage 4: extract

# Process the pipeline (nothing executes until we iterate!)
print("=== Error Messages (Pipeline) ===\n")
for i, message in enumerate(messages, 1):
    print(f"  {i}. {message}")
```

**Expected Output:**
```
=== Error Messages (Pipeline) ===

  1. Disk full on /dev/sda1
  2. Connection timeout to db-01
  3. Worker-03 out of memory
```

### How Data Flows Through the Pipeline

```
sample_logs → strip_lines → filter_errors → extract_message → print
    │              │              │               │
    │   "...ERROR  │  "...ERROR   │  "Disk full   │
    │   Disk...\n" │  Disk..."    │  on /dev/sda1"│  → printed!
    │              │              │               │
    │   "...INFO   │  "...INFO    │  (filtered    │
    │   Server..\n"│  Server.."   │   out! ✗)     │
```

**Key insight:** Each line flows through ALL stages before the next line enters. The pipeline processes one item end-to-end at a time — constant memory usage.

---

## 10.14 yield from — Delegating to Sub-generators

### What It Does

`yield from` delegates iteration to another iterable or generator. Instead of writing a loop to yield each item from a sub-sequence, you can delegate in one line.

### The Problem It Solves

```python
# ❌ Without yield from — verbose
def combined_servers():
    web_servers = get_web_servers()
    db_servers = get_db_servers()
    
    for server in web_servers:
        yield server
    for server in db_servers:
        yield server

# ✅ With yield from — clean
def combined_servers():
    yield from get_web_servers()
    yield from get_db_servers()
```

### Beginner Program: Combining Multiple Sources

```python
def web_servers():
    """Generator for web servers."""
    yield "web-01"
    yield "web-02"
    yield "web-03"

def db_servers():
    """Generator for database servers."""
    yield "db-01"
    yield "db-02"

def cache_servers():
    """Generator for cache servers."""
    yield "cache-01"

def all_servers():
    """
    Combines all server generators into one.
    yield from delegates to each sub-generator.
    """
    print("  (Getting web servers...)")
    yield from web_servers()
    
    print("  (Getting db servers...)")
    yield from db_servers()
    
    print("  (Getting cache servers...)")
    yield from cache_servers()


print("=== All Servers (using yield from) ===\n")
for server in all_servers():
    print(f"  → {server}")
```

**Expected Output:**
```
=== All Servers (using yield from) ===

  (Getting web servers...)
  → web-01
  → web-02
  → web-03
  (Getting db servers...)
  → db-01
  → db-02
  (Getting cache servers...)
  → cache-01
```

### yield from with Any Iterable

```python
def flatten(nested_list):
    """Flatten a nested list using yield from."""
    for item in nested_list:
        if isinstance(item, list):
            yield from flatten(item)    # Recursive!
        else:
            yield item

nested = [1, [2, 3], [4, [5, 6]], 7, [8, 9, [10]]]
flat = list(flatten(nested))
print(flat)    # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

### DevOps Use Case: Multi-Region Server Discovery

```python
def discover_servers(region):
    """Simulate discovering servers in a region."""
    # In reality: API call to cloud provider
    fake_servers = {
        "us-east-1": ["east-web-01", "east-db-01"],
        "us-west-2": ["west-web-01", "west-web-02"],
        "eu-west-1": ["eu-web-01"],
    }
    for server in fake_servers.get(region, []):
        yield server

def all_region_servers(regions):
    """Discover servers across ALL regions."""
    for region in regions:
        yield from discover_servers(region)

regions = ["us-east-1", "us-west-2", "eu-west-1"]
for server in all_region_servers(regions):
    print(f"  Found: {server}")
```

---

## 10.15 The itertools Module

### What It Is

`itertools` is a standard library module providing **fast, memory-efficient tools** for working with iterators. Think of it as a toolbox of pre-built iterator patterns.

### Why It Exists

Many iteration patterns are common enough to be standardized:
- Chaining multiple iterables together
- Taking the first N items
- Grouping items
- Creating combinations/permutations
- Repeating values

### Most Useful Functions for DevOps

#### itertools.chain() — Combine Multiple Iterables

```python
from itertools import chain

web = ["web-01", "web-02"]
db = ["db-01"]
cache = ["cache-01", "cache-02"]

# ❌ Without chain (creates a new list in memory)
all_servers = web + db + cache

# ✅ With chain (lazy — no new list created)
all_servers = chain(web, db, cache)

for server in all_servers:
    print(server)
# web-01, web-02, db-01, cache-01, cache-02
```

#### itertools.islice() — Take First N Items

```python
from itertools import islice

def infinite_logs():
    """Simulate infinite log stream."""
    i = 0
    while True:
        i += 1
        yield f"Log entry #{i}"

# Take just the first 5 from an infinite generator
first_five = list(islice(infinite_logs(), 5))
print(first_five)
# ['Log entry #1', 'Log entry #2', 'Log entry #3', 'Log entry #4', 'Log entry #5']

# Skip first 2, take next 3
some_logs = list(islice(infinite_logs(), 2, 5))
print(some_logs)
# ['Log entry #3', 'Log entry #4', 'Log entry #5']
```

#### itertools.count() — Infinite Counter

```python
from itertools import count

# Count from 1 forever
for i in count(1):
    print(i)
    if i >= 5:
        break
# 1, 2, 3, 4, 5

# Count with step
for i in count(start=10, step=5):
    print(i)
    if i >= 30:
        break
# 10, 15, 20, 25, 30
```

#### itertools.cycle() — Repeat a Sequence Forever

```python
from itertools import cycle, islice

# Round-robin server assignment
servers = cycle(["web-01", "web-02", "web-03"])

# Assign 7 requests to 3 servers (round-robin)
requests = [f"Request-{i}" for i in range(1, 8)]

print("=== Round-Robin Load Balancing ===\n")
for request in requests:
    server = next(servers)
    print(f"  {request} → {server}")
```

**Expected Output:**
```
=== Round-Robin Load Balancing ===

  Request-1 → web-01
  Request-2 → web-02
  Request-3 → web-03
  Request-4 → web-01
  Request-5 → web-02
  Request-6 → web-03
  Request-7 → web-01
```

#### itertools.repeat() — Repeat a Value

```python
from itertools import repeat

# Repeat a value N times
default_configs = list(repeat({"status": "pending", "retries": 0}, 5))
print(f"Created {len(default_configs)} default configs")
```

#### itertools.groupby() — Group Consecutive Items

```python
from itertools import groupby

# Servers sorted by environment
servers = [
    {"name": "web-01", "env": "production"},
    {"name": "web-02", "env": "production"},
    {"name": "api-01", "env": "staging"},
    {"name": "api-02", "env": "staging"},
    {"name": "test-01", "env": "development"},
]

# Group by environment (MUST be sorted by key first!)
print("=== Servers by Environment ===\n")
for env, group in groupby(servers, key=lambda s: s["env"]):
    server_list = list(group)
    print(f"  {env}: {[s['name'] for s in server_list]}")
```

**Output:**
```
=== Servers by Environment ===

  production: ['web-01', 'web-02']
  staging: ['api-01', 'api-02']
  development: ['test-01']
```

#### itertools.batched() (Python 3.12+) or Manual Batching

```python
from itertools import islice

def batch(iterable, size):
    """Split iterable into chunks of given size."""
    iterator = iter(iterable)
    while True:
        chunk = list(islice(iterator, size))
        if not chunk:
            break
        yield chunk

# Deploy in batches of 3
servers = [f"server-{i:02d}" for i in range(1, 11)]

print("=== Batch Deployment ===\n")
for i, batch_group in enumerate(batch(servers, 3), 1):
    print(f"  Batch {i}: {batch_group}")
```

**Output:**
```
=== Batch Deployment ===

  Batch 1: ['server-01', 'server-02', 'server-03']
  Batch 2: ['server-04', 'server-05', 'server-06']
  Batch 3: ['server-07', 'server-08', 'server-09']
  Batch 4: ['server-10']
```

---

## 10.16 Common DevOps Iterator/Generator Patterns

### Pattern 1: Paginated API Consumer

```python
def fetch_all_pages(base_url, page_size=100):
    """
    Generator that handles API pagination automatically.
    Yields individual items from all pages.
    
    Instead of loading thousands of records at once,
    fetches one page at a time.
    """
    page = 1
    while True:
        # Simulate API call (in reality: requests.get())
        print(f"  📡 Fetching page {page}...")
        
        # Simulated response
        if page <= 3:
            items = [f"item-{(page-1)*page_size + i}" for i in range(1, page_size + 1)]
        else:
            items = []    # Empty page = no more data
        
        if not items:
            print("  📡 No more pages.")
            break
        
        # Yield individual items (not the whole page!)
        for item in items:
            yield item
        
        page += 1


# Usage — consumer doesn't know about pagination!
print("=== Paginated API Consumer ===\n")
all_items = fetch_all_pages("https://api.example.com/servers")

# Take just the first 5 (only fetches 1 page!)
from itertools import islice
first_five = list(islice(all_items, 5))
print(f"  First 5 items: {first_five}")
```

### Pattern 2: Continuous Log Tailer

```python
import time

def tail_log(filepath, poll_interval=1):
    """
    Generator that continuously reads new lines from a log file.
    Similar to 'tail -f' command.
    
    Yields new lines as they appear — runs indefinitely.
    """
    with open(filepath, "r") as f:
        # Go to end of file
        f.seek(0, 2)    # Seek to end
        
        while True:
            line = f.readline()
            if line:
                yield line.strip()
            else:
                time.sleep(poll_interval)    # Wait for new data

# Usage (commented out — would run forever):
# for line in tail_log("/var/log/app.log"):
#     if "ERROR" in line:
#         send_alert(line)
```

### Pattern 3: Retry Generator with Exponential Backoff

```python
def retry_delays(max_retries=5, initial_delay=1, backoff=2, max_delay=60):
    """
    Generator that yields delay durations for retry logic.
    
    Produces: 1, 2, 4, 8, 16, 32, 60, 60, 60... (capped at max_delay)
    """
    delay = initial_delay
    for attempt in range(max_retries):
        yield delay
        delay = min(delay * backoff, max_delay)

# Usage
print("=== Retry Schedule ===\n")
for attempt, delay in enumerate(retry_delays(max_retries=7, initial_delay=1), 1):
    print(f"  Attempt {attempt}: wait {delay}s before retrying")
```

**Output:**
```
=== Retry Schedule ===

  Attempt 1: wait 1s before retrying
  Attempt 2: wait 2s before retrying
  Attempt 3: wait 4s before retrying
  Attempt 4: wait 8s before retrying
  Attempt 5: wait 16s before retrying
  Attempt 6: wait 32s before retrying
  Attempt 7: wait 60s before retrying
```

### Pattern 4: Resource-Efficient File Search

```python
from pathlib import Path

def find_files_with_content(root_dir, extensions, search_text):
    """
    Generator that searches files for specific content.
    
    Yields (filepath, line_number, line) for each match.
    Memory efficient — never loads more than one file at a time.
    """
    root = Path(root_dir)
    
    for ext in extensions:
        for filepath in root.rglob(f"*{ext}"):
            try:
                with open(filepath, "r", encoding="utf-8") as f:
                    for line_num, line in enumerate(f, 1):
                        if search_text in line:
                            yield (str(filepath), line_num, line.strip())
            except (PermissionError, UnicodeDecodeError):
                continue    # Skip files we can't read

# Usage
# for path, line_num, line in find_files_with_content("./project", [".py", ".yaml"], "password"):
#     print(f"  ⚠️  {path}:{line_num}: {line}")
```

### Pattern 5: Metric Window Calculator

```python
from collections import deque

def sliding_window_average(metrics_generator, window_size=5):
    """
    Generator that computes a sliding window average over streaming metrics.
    
    As new metrics arrive, yields the average of the last N values.
    Uses constant memory (deque of fixed size).
    """
    window = deque(maxlen=window_size)
    
    for value in metrics_generator:
        window.append(value)
        yield sum(window) / len(window)


# Simulate streaming CPU metrics
def cpu_stream():
    import random
    for _ in range(20):
        yield random.randint(40, 95)

print("=== Sliding Window Average (window=5) ===\n")
cpu_values = list(cpu_stream())
avg_gen = sliding_window_average(iter(cpu_values), window_size=5)

print(f"  {'Raw':>5} | {'Avg':>6}")
print(f"  {'---':>5} | {'---':>6}")
for raw, avg in zip(cpu_values, avg_gen):
    print(f"  {raw:>5} | {avg:>6.1f}")
```

---

## 10.17 Section Summary and Review

### What You Learned

| Topic | Key Takeaway |
|-------|-------------|
| Iteration | Going through items one at a time, sequentially |
| Iteration protocol | `iter()` gets iterator; `next()` gets items; `StopIteration` ends |
| Iterable | Object that CAN be iterated (list, str, dict) — has `__iter__` |
| Iterator | Object that IS iterating — has `__next__`, exhausted after one pass |
| `iter()` | Converts iterable to iterator; called by `for` automatically |
| `next()` | Gets next item from iterator; optional default prevents exception |
| `StopIteration` | Exception that signals "no more items" — caught by `for` |
| Custom iterators | Class with `__iter__` + `__next__`; manual but flexible |
| Generators | Functions with `yield`; easiest way to create iterators |
| `yield` | Produces value AND pauses; resumes on next `next()` call |
| Generator expressions | `(expr for x in iter)` — one-line lazy generators |
| Lazy evaluation | Compute on demand; constant memory; handles infinity |
| Generator pipelines | Chain generators; data flows one item at a time |
| `yield from` | Delegate to sub-generator; cleaner than `for x in gen: yield x` |
| `itertools` | Standard library of iterator tools (chain, islice, cycle, groupby) |

### Production Scenario Recap

> A log analysis system uses:
> - **Generator function** to read 50GB log files line by line (constant memory)
> - **Generator pipeline** for staged processing (read → strip → filter → extract → alert)
> - **`itertools.islice()`** to take samples from infinite monitoring streams
> - **`itertools.cycle()`** for round-robin load balancing
> - **Paginated API generator** that yields individual items from multi-page responses
> - **Sliding window generator** for computing rolling averages on streaming metrics
> - **Retry delay generator** producing exponential backoff schedules

### Common Interview Questions

1. **Q: What is the difference between an iterable and an iterator?**
   A: An iterable has `__iter__()` and can produce an iterator. An iterator has `__next__()` and produces values one at a time. Iterables can be iterated multiple times (each time creates a new iterator). Iterators are exhausted after one pass.

2. **Q: What does `yield` do?**
   A: `yield` produces a value to the caller and PAUSES the function, preserving all local state. When `next()` is called again, execution resumes exactly where it left off, after the yield.

3. **Q: Why use a generator instead of a list?**
   A: Memory efficiency. A generator produces values on demand (one at a time) using constant memory, while a list stores ALL values simultaneously. For large/infinite sequences, generators are essential.

4. **Q: How does a `for` loop work internally?**
   A: `for item in iterable:` calls `iter(iterable)` to get an iterator, then repeatedly calls `next()` on that iterator. When `StopIteration` is raised, the loop ends.

5. **Q: Can a generator be reused after exhaustion?**
   A: No. Once a generator is exhausted (no more yields), it cannot be reset. You must create a new generator by calling the generator function again.

6. **Q: What is lazy evaluation?**
   A: Computing values only when they're needed, not in advance. Generators are lazy — they compute the next value only when `next()` is called. This enables processing infinite sequences and saves memory.

7. **Q: What is `yield from`?**
   A: `yield from iterable` delegates iteration to another iterable/generator. It's equivalent to `for item in iterable: yield item` but cleaner and slightly more efficient.

### Practice Exercises

1. Write a generator `countdown(n)` that yields numbers from n down to 1
2. Create a custom iterator class `EvenNumbers(limit)` that yields even numbers up to limit
3. Write a generator pipeline: read server names → convert to uppercase → filter names containing "web" → add port number
4. Use `itertools.cycle()` to assign 10 tasks to 3 workers in round-robin fashion
5. Write a generator `fibonacci()` that yields Fibonacci numbers infinitely
6. Create a generator `batch(iterable, size)` that yields chunks of the given size
7. Write a generator that simulates paginated API responses and yields individual items
8. Compare memory usage of a list comprehension vs generator expression for 10 million items

### Beginner Quiz (10 Questions)

1. What method must an iterator have that an iterable doesn't necessarily have?
2. What exception signals that an iterator has no more items?
3. What keyword makes a function into a generator function?
4. What happens when you call a generator function? (Does it execute the body?)
5. What is the memory size of a generator expression for 10 million items?
6. Can you iterate over a generator more than once?
7. What does `yield from [1, 2, 3]` do?
8. What `itertools` function combines multiple iterables into one?
9. What is the difference between `[x for x in range(10)]` and `(x for x in range(10))`?
10. What does `next(my_gen, "default")` return when the generator is exhausted?

<details>
<summary>Quiz Answers</summary>

1. `__next__()` — iterators must have it; plain iterables only need `__iter__()`
2. `StopIteration`
3. `yield` — any function containing yield becomes a generator function
4. No! It returns a generator object without executing any body code. Body executes only when `next()` is called.
5. Approximately 100-200 bytes (constant) — regardless of how many items it can produce
6. No. Once exhausted, a generator cannot be reset. You must create a new one.
7. It yields 1, then 2, then 3 — equivalent to `for x in [1,2,3]: yield x`
8. `itertools.chain()` — chains multiple iterables sequentially
9. First creates a list (all in memory). Second creates a generator (lazy, constant memory).
10. `"default"` — the default value is returned instead of raising `StopIteration`

</details>

### Next Section Preview

**Section 11: Decorators — Modifying Function Behavior**

You will learn what decorators are, why they exist, how they work under the hood (closures + first-class functions), the `@` syntax, writing your own decorators, decorators with arguments, `functools.wraps`, class-based decorators, stacking decorators, and real DevOps applications: retry decorators, timing decorators, authentication decorators, caching decorators, and logging decorators.

---

*Ready for Section 11? Let me know and I'll generate it.*
