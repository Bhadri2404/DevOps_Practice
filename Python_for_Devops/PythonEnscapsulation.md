## Original Code — With Multiple Objects

```python
class Database:
    def __init__(self, host, password):
        self.host = host
        self._connection = None
        self.__password = password
    
    @property
    def is_connected(self):
        return self._connection is not None
```

---

## Creating 4 Objects

```python
db1 = Database("localhost", "abc123")
db2 = Database("192.168.1.1", "pass456")
db3 = Database("google.com", "xyz789")
db4 = Database("amazon.com", "secret000")
```

---

## What happens when EACH one is created?

### `db1 = Database("localhost", "abc123")`

```
Python: "Create a new Database object"
     → calls __init__ automatically
     → self = the new object (will be called db1)
     → host = "localhost"
     → password = "abc123"

     → self.host = "localhost"           🟢 public
     → self._connection = None           🟡 protected
     → self.__password = "abc123"        🔴 private (renamed to _Database__password)

     → Done! Assign this object to db1
```

### `db2 = Database("192.168.1.1", "pass456")`

```
Python: "Create ANOTHER new Database object"
     → calls __init__ again (fresh start!)
     → self = a DIFFERENT new object (will be called db2)
     → host = "192.168.1.1"
     → password = "pass456"

     → self.host = "192.168.1.1"
     → self._connection = None
     → self.__password = "pass456"

     → Done! Assign this object to db2
```

### `db3 = Database("google.com", "xyz789")`

```
Same process:
     → self.host = "google.com"
     → self._connection = None
     → self.__password = "xyz789"
     → Done! Assign to db3
```

### `db4 = Database("amazon.com", "secret000")`

```
Same process:
     → self.host = "amazon.com"
     → self._connection = None
     → self.__password = "secret000"
     → Done! Assign to db4
```

---

## Memory — All 4 Objects

```
RAM (Memory)
════════════════════════════════════════════════════════════════

db1 ──→ ┌────────────────────────────────────────┐
         │  host = "localhost"              🟢    │
         │  _connection = None             🟡    │
         │  _Database__password = "abc123" 🔴    │
         └────────────────────────────────────────┘

db2 ──→ ┌────────────────────────────────────────┐
         │  host = "192.168.1.1"            🟢    │
         │  _connection = None             🟡    │
         │  _Database__password = "pass456" 🔴   │
         └────────────────────────────────────────┘

db3 ──→ ┌────────────────────────────────────────┐
         │  host = "google.com"             🟢    │
         │  _connection = None             🟡    │
         │  _Database__password = "xyz789"  🔴   │
         └────────────────────────────────────────┘

db4 ──→ ┌────────────────────────────────────────┐
         │  host = "amazon.com"             🟢    │
         │  _connection = None             🟡    │
         │  _Database__password = "secret000" 🔴 │
         └────────────────────────────────────────┘
```

**Each object is SEPARATE.** Changing one does NOT affect the others.

---

## Now let's USE them — Full Flow

### Step 1: Check all connections

```python
print(db1.is_connected)   # False
print(db2.is_connected)   # False
print(db3.is_connected)   # False
print(db4.is_connected)   # False
```

**Why all False?**

```
db1: self._connection is not None → None is not None → False
db2: self._connection is not None → None is not None → False
db3: self._connection is not None → None is not None → False
db4: self._connection is not None → None is not None → False

All _connection = None, so all are False (not connected)
```

---

### Step 2: Connect db1 and db3 (simulate)

```python
db1._connection = "Connected to MySQL"
db3._connection = "Connected to PostgreSQL"
```

**Memory NOW:**

```
db1 ──→ ┌────────────────────────────────────────┐
         │  host = "localhost"                     │
         │  _connection = "Connected to MySQL" ← CHANGED! │
         │  _Database__password = "abc123"        │
         └────────────────────────────────────────┘

db2 ──→ ┌────────────────────────────────────────┐
         │  host = "192.168.1.1"                   │
         │  _connection = None            ← SAME   │
         │  _Database__password = "pass456"        │
         └────────────────────────────────────────┘

db3 ──→ ┌────────────────────────────────────────┐
         │  host = "google.com"                    │
         │  _connection = "Connected to PostgreSQL" ← CHANGED! │
         │  _Database__password = "xyz789"         │
         └────────────────────────────────────────┘

db4 ──→ ┌────────────────────────────────────────┐
         │  host = "amazon.com"                    │
         │  _connection = None            ← SAME   │
         │  _Database__password = "secret000"      │
         └────────────────────────────────────────┘
```

---

### Step 3: Check connections again

```python
print(db1.is_connected)   # True  ✅
print(db2.is_connected)   # False ❌
print(db3.is_connected)   # True  ✅
print(db4.is_connected)   # False ❌
```

**How Python thinks for EACH one:**

```
db1: self._connection is not None
     "Connected to MySQL" is not None
     → True ✅ (it HAS something, so it's connected)

db2: self._connection is not None
     None is not None
     → False ❌ (still empty, not connected)

db3: self._connection is not None
     "Connected to PostgreSQL" is not None
     → True ✅ (it HAS something, so it's connected)

db4: self._connection is not None
     None is not None
     → False ❌ (still empty, not connected)
```

---

### Step 4: Access public data (host)

```python
print(db1.host)   # "localhost"
print(db2.host)   # "192.168.1.1"
print(db3.host)   # "google.com"
print(db4.host)   # "amazon.com"
```

🟢 All work. Public = no restrictions.

---

### Step 5: Try to access passwords

```python
print(db1.__password)   # ❌ ERROR! AttributeError
print(db2.__password)   # ❌ ERROR!
print(db3.__password)   # ❌ ERROR!
print(db4.__password)   # ❌ ERROR!
```

🔴 ALL fail. Python hid them.

```python
# The "hack" way (Python renamed them):
print(db1._Database__password)   # "abc123"
print(db2._Database__password)   # "pass456"
print(db3._Database__password)   # "xyz789"
print(db4._Database__password)   # "secret000"
```

---

### Step 6: Disconnect db1

```python
db1._connection = None
print(db1.is_connected)   # False (back to not connected)
```

```
db1: self._connection is not None
     None is not None
     → False (disconnected now)
```

---

## Complete Flowchart

```
           DATABASE BLUEPRINT
           ┌──────────────────┐
           │  class Database   │
           │  (the plan)       │
           └────────┬─────────┘
                    │
      ┌─────────┬──┴───┬──────────┐
      ▼         ▼      ▼          ▼
   CREATE    CREATE  CREATE     CREATE
   db1       db2     db3        db4
      │         │      │          │
      ▼         ▼      ▼          ▼
   __init__  __init__ __init__  __init__
   runs      runs     runs      runs
      │         │      │          │
      ▼         ▼      ▼          ▼
┌─────────┐┌────────┐┌────────┐┌──────────┐
│localhost ││192.168 ││google  ││amazon    │
│None      ││None    ││None    ││None      │
│abc123    ││pass456 ││xyz789  ││secret000 │
└─────────┘└────────┘└────────┘└──────────┘
      │         │      │          │
      ▼         ▼      ▼          ▼
  .is_connected?  .is_connected?  .is_connected?
      │         │      │          │
      ▼         ▼      ▼          ▼
   False     False   False      False
      │                │
      ▼                ▼
 CONNECT db1      CONNECT db3
 _connection =    _connection =
 "MySQL"          "PostgreSQL"
      │                │
      ▼                ▼
  .is_connected?  .is_connected?
      │                │
      ▼                ▼
    True             True
```

---

## Key Takeaway: `self` means "MY OWN copy"

```
When db1 runs __init__:  self = db1  →  db1.host = "localhost"
When db2 runs __init__:  self = db2  →  db2.host = "192.168.1.1"
When db3 runs __init__:  self = db3  →  db3.host = "google.com"
When db4 runs __init__:  self = db4  →  db4.host = "amazon.com"
```

Each object gets its **OWN** separate data. Like 4 people each filling out their **OWN** form. Vinay's form doesn't affect Rahul's form.

---

## Runnable Code (copy-paste and try!)

```python
class Database:
    def __init__(self, host, password):
        self.host = host
        self._connection = None
        self.__password = password
    
    @property
    def is_connected(self):
        return self._connection is not None

# Create 4 databases
db1 = Database("localhost", "abc123")
db2 = Database("192.168.1.1", "pass456")
db3 = Database("google.com", "xyz789")
db4 = Database("amazon.com", "secret000")

# All start disconnected
print("--- Before connecting ---")
print(db1.host, "→", db1.is_connected)   # localhost → False
print(db2.host, "→", db2.is_connected)   # 192.168.1.1 → False
print(db3.host, "→", db3.is_connected)   # google.com → False
print(db4.host, "→", db4.is_connected)   # amazon.com → False

# Connect db1 and db3
db1._connection = "MySQL"
db3._connection = "PostgreSQL"

# Check again
print("\n--- After connecting db1 and db3 ---")
print(db1.host, "→", db1.is_connected)   # localhost → True
print(db2.host, "→", db2.is_connected)   # 192.168.1.1 → False
print(db3.host, "→", db3.is_connected)   # google.com → True
print(db4.host, "→", db4.is_connected)   # amazon.com → False

# Try accessing password
print("\n--- Password access ---")
print(db1._Database__password)   # abc123 (hack way)
```

---

Any part still unclear?
