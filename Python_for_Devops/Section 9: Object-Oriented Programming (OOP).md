# Section 9: Object-Oriented Programming (OOP) — Classes, Objects, and Inheritance

---

## 📑 Table of Contents

- [9.1 What Is Object-Oriented Programming?](#91-what-is-object-oriented-programming)
- [9.2 Why OOP Exists](#92-why-oop-exists)
- [9.3 Classes and Objects — The Core Concepts](#93-classes-and-objects--the-core-concepts)
- [9.4 Defining Your First Class](#94-defining-your-first-class)
- [9.5 The __init__ Method (Constructor)](#95-the-__init__-method-constructor)
- [9.6 The self Parameter](#96-the-self-parameter)
- [9.7 Instance Variables vs Class Variables](#97-instance-variables-vs-class-variables)
- [9.8 Methods — Instance, Class, and Static](#98-methods--instance-class-and-static)
- [9.9 Encapsulation — Public, Protected, Private](#99-encapsulation--public-protected-private)
- [9.10 Inheritance](#910-inheritance)
- [9.11 Method Overriding and super()](#911-method-overriding-and-super)
- [9.12 Multiple Inheritance and MRO](#912-multiple-inheritance-and-mro)
- [9.13 Polymorphism](#913-polymorphism)
- [9.14 Dunder (Magic) Methods](#914-dunder-magic-methods)
- [9.15 Properties and Descriptors](#915-properties-and-descriptors)
- [9.16 Composition vs Inheritance](#916-composition-vs-inheritance)
- [9.17 Dataclasses (Python 3.7+)](#917-dataclasses-python-37)
- [9.18 Common DevOps OOP Patterns](#918-common-devops-oop-patterns)
- [9.19 Section Summary and Review](#919-section-summary-and-review)

---

## 🎯 Learning Objectives

By the end of this section, you will:

1. Understand what OOP is and what problem it solves
2. Define classes with `__init__`, instance variables, and methods
3. Understand `self` deeply — why it exists and how it works
4. Distinguish between instance variables and class variables
5. Create instance methods, class methods, and static methods
6. Implement encapsulation with naming conventions
7. Use inheritance to create specialized classes
8. Override methods and use `super()` correctly
9. Understand polymorphism and duck typing
10. Implement key dunder methods (`__str__`, `__repr__`, `__eq__`, `__len__`)
11. Use `@property` for controlled attribute access
12. Choose between composition and inheritance
13. Use dataclasses for data-focused classes
14. Apply OOP to DevOps: server objects, deployment managers, config classes

---

## 9.1 What Is Object-Oriented Programming?

### Real-Life Analogy

Think about a **car**:
- A car has **properties** (attributes): color, make, model, fuel level, speed
- A car has **behaviors** (methods): start, accelerate, brake, turn

Every car in the world shares this general structure, but each specific car has its own values (red Toyota vs blue Ford). The general structure is the **class**. Each specific car is an **object** (instance).

```
CLASS (Blueprint):        OBJECTS (Instances):
┌──────────────┐         ┌──────────────────┐
│     Car      │         │ my_car           │
│              │         │   color: "red"   │
│ - color      │────────▶│   make: "Toyota" │
│ - make       │         │   speed: 0       │
│ - speed      │         └──────────────────┘
│              │         ┌──────────────────┐
│ + start()    │────────▶│ your_car         │
│ + accelerate()│        │   color: "blue"  │
│ + brake()    │         │   make: "Ford"   │
└──────────────┘         │   speed: 60      │
                         └──────────────────┘
```

### Definition

Object-Oriented Programming is a programming paradigm that organizes code around **objects** — entities that bundle together:
- **Data** (attributes/properties) — what the object knows
- **Behavior** (methods) — what the object can do

### The Four Pillars of OOP

```
┌─────────────────────────────────────────────────────────────────┐
│                    FOUR PILLARS OF OOP                            │
├──────────────────┬──────────────────────────────────────────────┤
│  Encapsulation   │  Bundle data + methods together;              │
│                  │  hide internal details                        │
├──────────────────┼──────────────────────────────────────────────┤
│  Abstraction     │  Expose only what's necessary;               │
│                  │  hide complexity                              │
├──────────────────┼──────────────────────────────────────────────┤
│  Inheritance     │  Create new classes from existing ones;       │
│                  │  reuse and extend                            │
├──────────────────┼──────────────────────────────────────────────┤
│  Polymorphism    │  Different objects respond to the same        │
│                  │  interface in their own way                   │
└──────────────────┴──────────────────────────────────────────────┘
```

---

## 9.2 Why OOP Exists

### The Problem: Functions + Data Become Unmanageable

With procedural programming (just functions), as complexity grows, you end up with:

```python
# Procedural approach — managing server data with dicts and functions
server1 = {"hostname": "web-01", "ip": "10.0.0.1", "port": 8080, "status": "running"}
server2 = {"hostname": "web-02", "ip": "10.0.0.2", "port": 8080, "status": "stopped"}

def start_server(server):
    server["status"] = "running"
    print(f"Starting {server['hostname']}")

def stop_server(server):
    server["status"] = "stopped"
    print(f"Stopping {server['hostname']}")

def get_url(server):
    return f"http://{server['ip']}:{server['port']}"
```

Problems:
1. Nothing prevents invalid data: `server1["status"] = "banana"` — no validation
2. Functions are disconnected from data — you must pass the dict every time
3. No way to enforce what keys a "server" must have
4. Easy to accidentally corrupt data
5. Doesn't scale — 50 functions operating on the same dict structure

### The OOP Solution

```python
class Server:
    def __init__(self, hostname, ip, port=8080):
        self.hostname = hostname
        self.ip = ip
        self.port = port
        self.status = "stopped"
    
    def start(self):
        self.status = "running"
        print(f"Starting {self.hostname}")
    
    def stop(self):
        self.status = "stopped"
        print(f"Stopping {self.hostname}")
    
    def get_url(self):
        return f"http://{self.ip}:{self.port}"

# Data and behavior are bundled together
server1 = Server("web-01", "10.0.0.1")
server1.start()
print(server1.get_url())
```

Benefits:
1. Data and behavior are together — the server KNOWS how to start itself
2. Clear interface — you know exactly what a Server can do
3. Validation can be enforced in `__init__`
4. Can't accidentally corrupt the structure
5. Easy to extend (inheritance)

### When to Use OOP vs Functions

| Use Functions When | Use OOP When |
|-------------------|-------------|
| Simple scripts (< 100 lines) | Complex systems with multiple entities |
| Stateless operations | Objects have state that changes over time |
| Utility/helper logic | Multiple instances with same behavior |
| Data transformations | Modeling real-world things (servers, deployments) |
| Quick automation | Building libraries/frameworks/tools |

---

## 9.3 Classes and Objects — The Core Concepts

### Terminology

| Term | Meaning | Analogy |
|------|---------|---------|
| **Class** | A blueprint/template for creating objects | Cookie cutter |
| **Object/Instance** | A specific thing created from a class | One cookie |
| **Attribute** | Data stored in an object | Cookie's color/flavor |
| **Method** | Function defined inside a class | What the cookie "does" |
| **Instantiation** | Creating an object from a class | Cutting a cookie |

### The Relationship

```python
# CLASS = blueprint (defined once)
class Server:
    pass

# OBJECTS = instances (created many times)
web1 = Server()    # First instance
web2 = Server()    # Second instance — separate object!
db1 = Server()     # Third instance

# Each is independent
print(web1 is web2)    # False — different objects!
print(type(web1))      # <class '__main__.Server'>
```

### Everything in Python Is an Object

This isn't just theory — it's literal:

```python
print(type(42))           # <class 'int'>
print(type("hello"))      # <class 'str'>
print(type([1, 2, 3]))    # <class 'list'>
print(type(True))         # <class 'bool'>
print(type(print))        # <class 'builtin_function_or_method'>

# Even classes themselves are objects!
print(type(Server))       # <class 'type'>
```

When you use `"hello".upper()`, you're calling the `upper()` method on a `str` object. You've been using OOP all along!

---

## 9.4 Defining Your First Class

### Syntax

```python
class ClassName:
    """Docstring describing the class."""
    
    def method_name(self):
        """Methods are functions inside a class."""
        pass
```

### Minimal Class

```python
class Server:
    """Represents a server in our infrastructure."""
    pass

# Create an instance
web_server = Server()
print(type(web_server))    # <class '__main__.Server'>

# You can attach attributes dynamically (Python is flexible)
web_server.hostname = "web-01"
web_server.ip = "10.0.0.1"
print(web_server.hostname)    # "web-01"
```

### Class with Methods

```python
class Server:
    """Represents a server in our infrastructure."""
    
    def describe(self):
        """Print server information."""
        print(f"Server: {self.hostname} ({self.ip})")
    
    def get_url(self):
        """Return the server's URL."""
        return f"http://{self.ip}:{self.port}"

# Create and configure
web = Server()
web.hostname = "web-01"
web.ip = "10.0.0.1"
web.port = 8080

web.describe()           # Server: web-01 (10.0.0.1)
print(web.get_url())     # http://10.0.0.1:8080
```

But manually setting attributes after creation is messy and error-prone. What if you forget to set `port`? That's why we need `__init__`.

---

## 9.5 The \_\_init\_\_ Method (Constructor)

### What It Is

`__init__` is a special method (called a **dunder method** — double underscore) that Python calls **automatically** when you create a new object. It initializes (sets up) the object with its starting data.

### Real-Life Analogy

When a baby is born, certain things are set up immediately: name, birth date, weight. You don't wait until later to decide these things. `__init__` is that "birth setup" — it runs the moment the object is created.

### Syntax

```python
class Server:
    def __init__(self, hostname, ip, port=8080):
        """Initialize a new Server object."""
        self.hostname = hostname    # Store as instance attribute
        self.ip = ip                # Store as instance attribute
        self.port = port            # Store as instance attribute
        self.status = "stopped"     # Default value
        self.uptime = 0             # Default value
```

### How It Works

```python
# When you write:
web = Server("web-01", "10.0.0.1")

# Python internally does:
# 1. Creates a new empty Server object
# 2. Calls Server.__init__(new_object, "web-01", "10.0.0.1")
# 3. Returns the initialized object to 'web'
```

```
Server("web-01", "10.0.0.1")
   │
   ├── Step 1: Python creates empty object in memory
   │
   ├── Step 2: Python calls __init__(self, "web-01", "10.0.0.1")
   │            │
   │            ├── self.hostname = "web-01"
   │            ├── self.ip = "10.0.0.1"
   │            ├── self.port = 8080 (default)
   │            ├── self.status = "stopped"
   │            └── self.uptime = 0
   │
   └── Step 3: Returns the fully initialized object
               │
               ▼
         web ──────▶ Server object with all attributes set
```

### Complete Example

```python
class Server:
    """Represents a server in our infrastructure."""
    
    def __init__(self, hostname, ip, port=8080, environment="production"):
        self.hostname = hostname
        self.ip = ip
        self.port = port
        self.environment = environment
        self.status = "stopped"
        self._connections = 0    # Internal tracking
    
    def start(self):
        """Start the server."""
        if self.status == "running":
            print(f"⚠️  {self.hostname} is already running")
            return
        self.status = "running"
        print(f"✅ {self.hostname} started")
    
    def stop(self):
        """Stop the server."""
        self.status = "stopped"
        self._connections = 0
        print(f"⛔ {self.hostname} stopped")
    
    def get_url(self):
        """Return the server's URL."""
        return f"http://{self.ip}:{self.port}"
    
    def describe(self):
        """Print a summary of the server."""
        print(f"  Hostname:    {self.hostname}")
        print(f"  IP:          {self.ip}:{self.port}")
        print(f"  Environment: {self.environment}")
        print(f"  Status:      {self.status}")


# Create instances
web1 = Server("web-01", "10.0.0.1")
web2 = Server("web-02", "10.0.0.2", port=9090, environment="staging")

# Use them
web1.start()          # ✅ web-01 started
web1.describe()
print(web1.get_url()) # http://10.0.0.1:8080

web2.describe()       # Shows different values — separate instance!
```

### Common Mistake: Forgetting self in \_\_init\_\_

```python
class Server:
    def __init__(self, hostname):
        hostname = hostname    # ❌ This creates a LOCAL variable, not an attribute!
        # Should be: self.hostname = hostname

web = Server("web-01")
print(web.hostname)    # ❌ AttributeError: 'Server' object has no attribute 'hostname'
```

### Validation in \_\_init\_\_

```python
class Server:
    def __init__(self, hostname, ip, port=8080):
        # Validate inputs
        if not hostname or not isinstance(hostname, str):
            raise ValueError(f"hostname must be a non-empty string, got: {hostname!r}")
        
        if not 1 <= port <= 65535:
            raise ValueError(f"port must be 1-65535, got: {port}")
        
        # Only assign if validation passes
        self.hostname = hostname
        self.ip = ip
        self.port = port
        self.status = "stopped"
```

---

## 9.6 The self Parameter

### What self Is

`self` is a reference to **the current instance** — the specific object on which the method is being called.

### Why self Exists

When you have multiple instances of a class, Python needs to know WHICH instance you're working with:

```python
class Server:
    def __init__(self, hostname):
        self.hostname = hostname    # THIS instance's hostname
    
    def describe(self):
        print(f"I am {self.hostname}")    # THIS instance's hostname

web1 = Server("web-01")
web2 = Server("web-02")

web1.describe()    # "I am web-01" — self = web1
web2.describe()    # "I am web-02" — self = web2
```

### How self Works Internally

```python
# When you write:
web1.describe()

# Python internally translates this to:
Server.describe(web1)    # Passes the object as the first argument!
```

So `self` is just the first argument that Python automatically passes — it's the object itself.

```python
# These two calls are IDENTICAL:
web1.describe()           # Normal syntax — Python passes web1 as self
Server.describe(web1)     # Explicit — you pass web1 manually
```

### The Name "self" Is Just a Convention

```python
class Server:
    def __init__(this, hostname):    # "this" works but DON'T do it
        this.hostname = hostname

    def describe(s):                 # "s" works but DON'T do it
        print(s.hostname)
```

Python doesn't enforce the name — but **ALWAYS use `self`**. It's a universal convention. Using anything else will confuse every Python developer who reads your code.

### Common Mistake: Forgetting self

```python
class Server:
    def __init__(self, hostname):
        self.hostname = hostname
    
    def describe():    # ❌ Forgot self!
        print(f"Server: {self.hostname}")

web = Server("web-01")
web.describe()
# TypeError: describe() takes 0 positional arguments but 1 was given
```

Python automatically passes the instance as the first argument. If your method doesn't accept it (no `self`), you get this error.

---

## 9.7 Instance Variables vs Class Variables

### Instance Variables

Belong to a **specific instance**. Each object has its own copy:

```python
class Server:
    def __init__(self, hostname):
        self.hostname = hostname    # Instance variable — unique per object
        self.status = "stopped"     # Instance variable

web1 = Server("web-01")
web2 = Server("web-02")

web1.status = "running"
print(web1.status)    # "running"
print(web2.status)    # "stopped" — unaffected!
```

### Class Variables

Belong to the **class itself** — shared among ALL instances:

```python
class Server:
    # Class variables — defined outside __init__, shared by all instances
    MAX_CONNECTIONS = 1000
    DEFAULT_PORT = 8080
    instance_count = 0
    
    def __init__(self, hostname, ip):
        self.hostname = hostname    # Instance variable
        self.ip = ip                # Instance variable
        Server.instance_count += 1  # Modify the class variable
    
    def get_url(self):
        return f"http://{self.ip}:{Server.DEFAULT_PORT}"

# All instances share class variables
web1 = Server("web-01", "10.0.0.1")
web2 = Server("web-02", "10.0.0.2")

print(Server.instance_count)       # 2
print(Server.MAX_CONNECTIONS)      # 1000

print(web1.MAX_CONNECTIONS)        # 1000 (accessed via instance)
print(web2.MAX_CONNECTIONS)        # 1000 (same value)
```

### How Python Resolves Attribute Lookups

```
When you access object.attribute, Python looks:
1. Instance's __dict__ (instance variables)
2. Class's __dict__ (class variables)
3. Parent classes (inheritance chain)
```

```python
class Server:
    DEFAULT_PORT = 8080    # Class variable
    
    def __init__(self, hostname):
        self.hostname = hostname    # Instance variable

web = Server("web-01")

print(web.hostname)       # Found in instance __dict__
print(web.DEFAULT_PORT)   # NOT in instance, found in class __dict__

# ⚠️ Assigning through instance creates a NEW instance variable!
web.DEFAULT_PORT = 9090   # Creates instance variable, doesn't change class!
print(web.DEFAULT_PORT)           # 9090 (instance)
print(Server.DEFAULT_PORT)        # 8080 (class — unchanged!)
```

### When to Use Each

| Use Instance Variables | Use Class Variables |
|----------------------|-------------------|
| Unique per object (hostname, ip, status) | Shared constants (MAX_RETRIES, DEFAULT_PORT) |
| Set in `__init__` | Defined at class level (outside methods) |
| `self.variable = value` | `ClassName.variable` or defined at top of class |
| Changes to one don't affect others | Changes affect ALL instances |

### ⚠️ Mutable Class Variable Trap

```python
class Server:
    tags = []    # ❌ MUTABLE class variable — shared by ALL instances!
    
    def __init__(self, hostname):
        self.hostname = hostname
    
    def add_tag(self, tag):
        self.tags.append(tag)    # Modifies the SHARED list!

web1 = Server("web-01")
web2 = Server("web-02")

web1.add_tag("production")
print(web2.tags)    # ["production"] ← web2 is affected too!
```

**Fix:** Initialize mutable attributes in `__init__`:

```python
class Server:
    def __init__(self, hostname):
        self.hostname = hostname
        self.tags = []    # ✅ Each instance gets its OWN list
```

---

## 9.8 Methods — Instance, Class, and Static

### Instance Methods (Most Common)

Operate on a specific instance. First parameter is `self`:

```python
class Server:
    def __init__(self, hostname, ip):
        self.hostname = hostname
        self.ip = ip
        self.status = "stopped"
    
    def start(self):    # Instance method — operates on self
        self.status = "running"
        return self     # Common pattern: return self for method chaining
    
    def stop(self):
        self.status = "stopped"
        return self
```

### Class Methods (@classmethod)

Operate on the **class itself**, not a specific instance. First parameter is `cls` (the class). Used for alternative constructors:

```python
class Server:
    def __init__(self, hostname, ip, port):
        self.hostname = hostname
        self.ip = ip
        self.port = port
    
    @classmethod
    def from_connection_string(cls, conn_string):
        """Alternative constructor: create from 'hostname:ip:port' string."""
        hostname, ip, port = conn_string.split(":")
        return cls(hostname, ip, int(port))    # cls() creates a new instance
    
    @classmethod
    def from_dict(cls, data):
        """Alternative constructor: create from dictionary."""
        return cls(
            hostname=data["hostname"],
            ip=data["ip"],
            port=data.get("port", 8080)
        )

# Normal construction
web1 = Server("web-01", "10.0.0.1", 8080)

# Alternative constructors
web2 = Server.from_connection_string("web-02:10.0.0.2:9090")
web3 = Server.from_dict({"hostname": "web-03", "ip": "10.0.0.3"})
```

### Why Class Methods — The Factory Pattern

Real-world data comes in many formats. Rather than forcing callers to pre-process data, provide multiple ways to create objects:

```python
# From YAML config
server = Server.from_dict(yaml.safe_load(config_file))

# From command-line argument
server = Server.from_connection_string(sys.argv[1])

# From AWS API response
server = Server.from_aws_instance(boto3_response)
```

### Static Methods (@staticmethod)

Don't operate on the instance OR the class. They're just regular functions that logically belong to the class:

```python
class Server:
    def __init__(self, hostname, ip, port):
        self.hostname = hostname
        self.ip = ip
        self.port = port
    
    @staticmethod
    def validate_ip(ip):
        """Validate IP address format (utility function)."""
        parts = ip.split(".")
        if len(parts) != 4:
            return False
        return all(0 <= int(p) <= 255 for p in parts)
    
    @staticmethod
    def validate_port(port):
        """Validate port number range."""
        return isinstance(port, int) and 1 <= port <= 65535

# Can be called without creating an instance
print(Server.validate_ip("10.0.0.1"))     # True
print(Server.validate_ip("999.0.0.1"))    # False
print(Server.validate_port(8080))          # True
```

### When to Use Each

| Type | Use When | First Param |
|------|----------|:-----------:|
| Instance method | Needs access to instance data (`self.something`) | `self` |
| Class method | Alternative constructor, or needs class-level data | `cls` |
| Static method | Utility function related to the class but needs no instance/class data | None |

---

## 9.9 Encapsulation — Public, Protected, Private

### What Encapsulation Means

Encapsulation means **hiding internal details** and exposing only what's necessary. Users of your class shouldn't need to know or touch internal implementation details.

### Python's Convention (Not Enforcement)

Python does NOT have true private variables (unlike Java/C++). It uses **naming conventions**:

| Convention | Meaning | Access |
|-----------|---------|--------|
| `self.name` | Public — anyone can use | Full access |
| `self._name` | Protected — "internal, don't touch" | Accessible but discouraged |
| `self.__name` | Private — name-mangled | Harder to access (but still possible) |

### Examples

```python
class DatabaseConnection:
    def __init__(self, host, port, password):
        self.host = host              # Public — OK to access externally
        self._port = port             # Protected — internal detail
        self.__password = password    # Private — should never be accessed directly
    
    def connect(self):
        """Public interface — users call this."""
        url = self._build_url()       # Internal method
        return self._authenticate(url)
    
    def _build_url(self):
        """Protected: internal helper, not for external use."""
        return f"{self.host}:{self._port}"
    
    def __authenticate(self, url):
        """Private: truly internal implementation detail."""
        return f"Connected to {url} with secret credentials"

db = DatabaseConnection("db.internal", 5432, "s3cr3t")

# Public — fine
print(db.host)         # "db.internal"

# Protected — works but signals "you shouldn't do this"
print(db._port)        # 5432 (no error, but convention says don't!)

# Private — name-mangled
print(db.__password)   # ❌ AttributeError!
print(db._DatabaseConnection__password)  # "s3cr3t" (Python's name mangling)
```

### Name Mangling Explained

When you use `__name` (double underscore prefix), Python renames it internally to `_ClassName__name`. This prevents accidental access and name collisions in inheritance — but determined users can still access it.

### Python's Philosophy: "We're All Consenting Adults"

Python trusts developers. Rather than hard enforcement:
- Single underscore `_` = "Please don't touch this"
- Double underscore `__` = "Really please don't touch this"
- No underscore = "Feel free to use this"

**Production Practice:** Use single underscore `_` for internal attributes. Double underscore `__` is mainly useful to avoid name collisions in complex inheritance hierarchies.

---

## 9.10 Inheritance

### What It Is

Inheritance allows you to create a new class (child/subclass) based on an existing class (parent/superclass). The child inherits all attributes and methods of the parent, and can add or override them.

### Real-Life Analogy

- **Parent class:** Vehicle (has wheels, engine, can move)
- **Child classes:** Car (has trunk), Truck (has cargo bed), Motorcycle (has 2 wheels)

All vehicles share common properties, but each type adds specific features.

### Why Inheritance Exists

Without inheritance:
```python
# ❌ Massive code duplication
class WebServer:
    def __init__(self, hostname, ip, port):
        self.hostname = hostname
        self.ip = ip
        self.port = port
        self.status = "stopped"
    
    def start(self): ...
    def stop(self): ...
    def health_check(self): ...
    # + web-specific methods

class DatabaseServer:
    def __init__(self, hostname, ip, port):
        self.hostname = hostname  # SAME code!
        self.ip = ip              # SAME code!
        self.port = port          # SAME code!
        self.status = "stopped"   # SAME code!
    
    def start(self): ...          # SAME!
    def stop(self): ...           # SAME!
    def health_check(self): ...   # SAME!
    # + database-specific methods
```

With inheritance:
```python
# ✅ Share common logic, specialize where needed
class Server:
    """Base class with common server functionality."""
    def __init__(self, hostname, ip, port):
        self.hostname = hostname
        self.ip = ip
        self.port = port
        self.status = "stopped"
    
    def start(self):
        self.status = "running"
        print(f"✅ {self.hostname} started")
    
    def stop(self):
        self.status = "stopped"
        print(f"⛔ {self.hostname} stopped")
    
    def health_check(self):
        return self.status == "running"

class WebServer(Server):
    """Inherits from Server, adds web-specific features."""
    def __init__(self, hostname, ip, port=80, document_root="/var/www"):
        super().__init__(hostname, ip, port)    # Call parent's __init__
        self.document_root = document_root      # Web-specific attribute
    
    def serve_static(self, path):
        """Web-specific method."""
        return f"Serving {self.document_root}/{path}"

class DatabaseServer(Server):
    """Inherits from Server, adds database-specific features."""
    def __init__(self, hostname, ip, port=5432, db_engine="postgresql"):
        super().__init__(hostname, ip, port)
        self.db_engine = db_engine
        self.connections = 0
    
    def execute_query(self, query):
        """Database-specific method."""
        self.connections += 1
        return f"Executing on {self.db_engine}: {query}"
```

### Using Inherited Classes

```python
# Create instances
web = WebServer("web-01", "10.0.0.1")
db = DatabaseServer("db-01", "10.0.0.2")

# Inherited methods work
web.start()          # ✅ web-01 started (inherited from Server)
db.start()           # ✅ db-01 started (inherited from Server)

# Specific methods work
print(web.serve_static("index.html"))    # Serving /var/www/index.html
print(db.execute_query("SELECT 1"))      # Executing on postgresql: SELECT 1

# Type checking
print(isinstance(web, WebServer))   # True
print(isinstance(web, Server))      # True (is also a Server!)
print(isinstance(db, WebServer))    # False (db is not a WebServer)
```

### Checking Inheritance

```python
print(issubclass(WebServer, Server))        # True
print(issubclass(DatabaseServer, Server))   # True
print(issubclass(WebServer, DatabaseServer)) # False
```

---

## 9.11 Method Overriding and super()

### Method Overriding

A child class can **override** (replace) a parent's method with its own implementation:

```python
class Server:
    def __init__(self, hostname):
        self.hostname = hostname
    
    def describe(self):
        print(f"Server: {self.hostname}")

class WebServer(Server):
    def __init__(self, hostname, domain):
        super().__init__(hostname)
        self.domain = domain
    
    def describe(self):    # OVERRIDES parent's describe()
        print(f"Web Server: {self.hostname}")
        print(f"  Domain: {self.domain}")

web = WebServer("web-01", "example.com")
web.describe()
# Web Server: web-01
#   Domain: example.com
```

### super() — Calling Parent Methods

`super()` gives you access to the parent class's methods. Essential when you want to **extend** (not replace) parent behavior:

```python
class Server:
    def __init__(self, hostname, ip):
        self.hostname = hostname
        self.ip = ip
        self.status = "stopped"
    
    def start(self):
        self.status = "running"
        print(f"[Server] {self.hostname} started")
    
    def describe(self):
        print(f"  Host: {self.hostname}")
        print(f"  IP: {self.ip}")
        print(f"  Status: {self.status}")

class MonitoredServer(Server):
    def __init__(self, hostname, ip, monitoring_endpoint):
        super().__init__(hostname, ip)    # Call parent's __init__
        self.monitoring_endpoint = monitoring_endpoint
        self.metrics_history = []
    
    def start(self):
        super().start()    # Call parent's start() first
        # Then add our own logic
        print(f"[Monitoring] Registering {self.hostname} with monitoring system")
        self._register_with_monitoring()
    
    def describe(self):
        super().describe()    # Call parent's describe() first
        print(f"  Monitoring: {self.monitoring_endpoint}")
    
    def _register_with_monitoring(self):
        print(f"  → Registered at {self.monitoring_endpoint}")

# Usage
server = MonitoredServer("web-01", "10.0.0.1", "http://prometheus:9090")
server.start()
# [Server] web-01 started
# [Monitoring] Registering web-01 with monitoring system
#   → Registered at http://prometheus:9090

server.describe()
#   Host: web-01
#   IP: 10.0.0.1
#   Status: running
#   Monitoring: http://prometheus:9090
```

### Why super() Instead of Parent Name

```python
# ❌ Works but fragile — hardcodes the parent class name
class Child(Parent):
    def __init__(self):
        Parent.__init__(self)    # Breaks if you change the parent

# ✅ Better — automatically refers to the correct parent
class Child(Parent):
    def __init__(self):
        super().__init__()    # Works even if parent changes
```

`super()` is especially important with multiple inheritance (next section).

---

## 9.12 Multiple Inheritance and MRO

### What Multiple Inheritance Is

A class inheriting from MORE than one parent:

```python
class Loggable:
    """Mixin: adds logging capability."""
    def log(self, message):
        print(f"[LOG] {self.__class__.__name__}: {message}")

class Serializable:
    """Mixin: adds JSON serialization."""
    def to_dict(self):
        return {k: v for k, v in self.__dict__.items() if not k.startswith("_")}

class Server(Loggable, Serializable):
    """Inherits from both Loggable and Serializable."""
    def __init__(self, hostname, ip):
        self.hostname = hostname
        self.ip = ip
    
    def start(self):
        self.log(f"Starting {self.hostname}")    # From Loggable
        self.status = "running"

server = Server("web-01", "10.0.0.1")
server.start()                  # [LOG] Server: Starting web-01
print(server.to_dict())         # {'hostname': 'web-01', 'ip': '10.0.0.1', 'status': 'running'}
```

### MRO — Method Resolution Order

When multiple parents have the same method, Python uses the **MRO** (C3 linearization algorithm) to determine which method to call:

```python
class A:
    def greet(self):
        print("A")

class B(A):
    def greet(self):
        print("B")

class C(A):
    def greet(self):
        print("C")

class D(B, C):
    pass

d = D()
d.greet()    # "B" — B comes before C in the inheritance list

# View the MRO
print(D.__mro__)
# (<class 'D'>, <class 'B'>, <class 'C'>, <class 'A'>, <class 'object'>)
```

### Mixins — The Practical Use of Multiple Inheritance

In DevOps, multiple inheritance is most useful as **mixins** — small, focused classes that add a single capability:

```python
class RetryMixin:
    """Adds retry capability to any class."""
    max_retries = 3
    
    def retry(self, func, *args, **kwargs):
        for attempt in range(1, self.max_retries + 1):
            try:
                return func(*args, **kwargs)
            except Exception as e:
                if attempt == self.max_retries:
                    raise
                print(f"  Retry {attempt}/{self.max_retries}: {e}")

class MetricsMixin:
    """Adds metrics collection."""
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._metrics = {}
    
    def record_metric(self, name, value):
        self._metrics[name] = value
    
    def get_metrics(self):
        return self._metrics.copy()

class Server(RetryMixin, MetricsMixin):
    def __init__(self, hostname):
        super().__init__()
        self.hostname = hostname
```

### When to Avoid Multiple Inheritance

Multiple inheritance can create complexity (the "diamond problem"). Use it sparingly:
- ✅ Mixins (small, focused capabilities)
- ❌ Deep inheritance hierarchies with multiple parents that have overlapping methods

**Prefer composition over inheritance** when relationships get complex (covered in section 9.16).

---

## 9.13 Polymorphism

### What It Is

Polymorphism means **different objects respond to the same interface in their own way**. You call the same method name on different objects, and each one does the right thing for its type.

### Real-Life Analogy

Consider the action "make a sound":
- A dog barks
- A cat meows
- A bird chirps

Same command ("make sound"), different behavior depending on the animal. You don't need to know what kind of animal it is — you just say "make sound."

### Example: Deployers

```python
class KubernetesDeployer:
    def deploy(self, service, version):
        print(f"  [K8s] kubectl set image {service}={service}:{version}")
    
    def rollback(self, service):
        print(f"  [K8s] kubectl rollout undo deployment/{service}")

class DockerDeployer:
    def deploy(self, service, version):
        print(f"  [Docker] docker service update {service} --image {service}:{version}")
    
    def rollback(self, service):
        print(f"  [Docker] docker service rollback {service}")

class LambdaDeployer:
    def deploy(self, service, version):
        print(f"  [Lambda] aws lambda update-function-code --function {service}")
    
    def rollback(self, service):
        print(f"  [Lambda] aws lambda update-function-code --function {service} --previous")


# Polymorphism in action — same interface, different behavior
def deploy_service(deployer, service, version):
    """Works with ANY deployer that has deploy() and rollback() methods."""
    print(f"Deploying {service} v{version}...")
    try:
        deployer.deploy(service, version)
        print(f"✅ {service} deployed successfully")
    except Exception as e:
        print(f"❌ Deployment failed: {e}")
        deployer.rollback(service)


# Same function, different deployers
deploy_service(KubernetesDeployer(), "api-gateway", "2.3.1")
deploy_service(DockerDeployer(), "web-frontend", "1.5.0")
deploy_service(LambdaDeployer(), "data-processor", "3.0.0")
```

### Duck Typing

Python doesn't check types — it checks behavior. If an object has the required methods, it works:

> "If it walks like a duck and quacks like a duck, it's a duck."

```python
# deploy_service() doesn't care about the CLASS of the deployer.
# It only cares that the object HAS deploy() and rollback() methods.
# No inheritance required! No interface declaration needed!
```

This is different from Java/C# where you'd need a formal `interface Deployer` or abstract class. Python trusts that if you pass an object with the right methods, it will work.

---

## 9.14 Dunder (Magic) Methods

### What They Are

Dunder methods (double underscore) are special methods that Python calls automatically in specific situations. They let your custom objects behave like built-in types.

### \_\_str\_\_ and \_\_repr\_\_

```python
class Server:
    def __init__(self, hostname, ip, port=8080):
        self.hostname = hostname
        self.ip = ip
        self.port = port
    
    def __str__(self):
        """Called by print() and str() — human-friendly."""
        return f"{self.hostname} ({self.ip}:{self.port})"
    
    def __repr__(self):
        """Called in REPL and by repr() — developer-friendly, unambiguous."""
        return f"Server(hostname={self.hostname!r}, ip={self.ip!r}, port={self.port})"

server = Server("web-01", "10.0.0.1")

print(server)           # web-01 (10.0.0.1:8080)  ← __str__
print(repr(server))     # Server(hostname='web-01', ip='10.0.0.1', port=8080)  ← __repr__
print(f"Info: {server}")  # Info: web-01 (10.0.0.1:8080)  ← __str__

# In a list, __repr__ is used:
servers = [Server("web-01", "10.0.0.1"), Server("db-01", "10.0.0.2", 5432)]
print(servers)
# [Server(hostname='web-01', ip='10.0.0.1', port=8080), Server(hostname='db-01', ip='10.0.0.2', port=5432)]
```

**Rule:** Always implement `__repr__`. Implement `__str__` if you want a user-friendly format that differs from `__repr__`.

### \_\_eq\_\_ and Comparison Methods

```python
class Server:
    def __init__(self, hostname, ip):
        self.hostname = hostname
        self.ip = ip
    
    def __eq__(self, other):
        """Called when using == operator."""
        if not isinstance(other, Server):
            return NotImplemented
        return self.hostname == other.hostname and self.ip == other.ip
    
    def __lt__(self, other):
        """Called when using < operator. Enables sorting."""
        if not isinstance(other, Server):
            return NotImplemented
        return self.hostname < other.hostname
    
    def __hash__(self):
        """Required if you define __eq__ and want to use in sets/dict keys."""
        return hash((self.hostname, self.ip))

s1 = Server("web-01", "10.0.0.1")
s2 = Server("web-01", "10.0.0.1")
s3 = Server("web-02", "10.0.0.2")

print(s1 == s2)    # True (same hostname and ip)
print(s1 == s3)    # False
print(s1 < s3)     # True ("web-01" < "web-02" alphabetically)

# Can now sort Server objects!
servers = [s3, s1, s2]
sorted_servers = sorted(servers)
print([s.hostname for s in sorted_servers])    # ['web-01', 'web-01', 'web-02']

# Can use in sets (because __hash__ is defined)
unique = {s1, s2, s3}
print(len(unique))    # 2 (s1 and s2 are equal)
```

### \_\_len\_\_

```python
class ServerCluster:
    def __init__(self, name):
        self.name = name
        self.servers = []
    
    def add(self, server):
        self.servers.append(server)
    
    def __len__(self):
        """Called by len()."""
        return len(self.servers)
    
    def __contains__(self, hostname):
        """Called by 'in' operator."""
        return any(s.hostname == hostname for s in self.servers)

cluster = ServerCluster("production")
cluster.add(Server("web-01", "10.0.0.1"))
cluster.add(Server("web-02", "10.0.0.2"))

print(len(cluster))              # 2
print("web-01" in cluster)       # True
print("db-01" in cluster)        # False
```

### \_\_iter\_\_ and \_\_getitem\_\_

```python
class ServerCluster:
    def __init__(self, name):
        self.name = name
        self.servers = []
    
    def add(self, server):
        self.servers.append(server)
    
    def __iter__(self):
        """Makes the cluster iterable (for loops work)."""
        return iter(self.servers)
    
    def __getitem__(self, index):
        """Allows indexing: cluster[0], cluster[1:3]."""
        return self.servers[index]
    
    def __len__(self):
        return len(self.servers)

cluster = ServerCluster("production")
cluster.add(Server("web-01", "10.0.0.1"))
cluster.add(Server("web-02", "10.0.0.2"))
cluster.add(Server("db-01", "10.0.0.3"))

# Now you can iterate
for server in cluster:
    print(server)

# And index
print(cluster[0])      # web-01 (10.0.0.1:8080)
print(cluster[-1])     # db-01 (10.0.0.3:8080)
```

### Summary of Key Dunder Methods

| Method | Triggered By | Purpose |
|--------|-------------|---------|
| `__init__` | `MyClass()` | Initialize new object |
| `__str__` | `print(obj)`, `str(obj)` | Human-friendly string |
| `__repr__` | `repr(obj)`, REPL | Developer-friendly string |
| `__eq__` | `obj1 == obj2` | Equality comparison |
| `__lt__` | `obj1 < obj2`, `sorted()` | Less-than comparison |
| `__hash__` | `hash(obj)`, sets, dict keys | Hashing |
| `__len__` | `len(obj)` | Length/size |
| `__contains__` | `item in obj` | Membership test |
| `__iter__` | `for x in obj` | Iteration |
| `__getitem__` | `obj[key]` | Subscript access |
| `__setitem__` | `obj[key] = value` | Subscript assignment |
| `__enter__`/`__exit__` | `with obj:` | Context manager |
| `__call__` | `obj()` | Make object callable |

---

## 9.15 Properties and Descriptors

### The Problem

Sometimes you want to control access to an attribute — validate on set, compute on get, or prevent modification:

```python
# ❌ Direct access — no control
class Server:
    def __init__(self, hostname, port):
        self.hostname = hostname
        self.port = port    # Anyone can set this to -1 or "banana"!

s = Server("web-01", 8080)
s.port = -999    # No validation! Bad data in the system!
```

### The @property Solution

`@property` lets you define methods that LOOK like attributes:

```python
class Server:
    def __init__(self, hostname, port=8080):
        self.hostname = hostname
        self._port = port    # Private storage (note: underscore)
    
    @property
    def port(self):
        """Getter — called when you READ server.port"""
        return self._port
    
    @port.setter
    def port(self, value):
        """Setter — called when you WRITE server.port = value"""
        if not isinstance(value, int):
            raise TypeError(f"Port must be an integer, got {type(value).__name__}")
        if not 1 <= value <= 65535:
            raise ValueError(f"Port must be 1-65535, got {value}")
        self._port = value
    
    @property
    def url(self):
        """Read-only computed property (no setter defined)."""
        return f"http://{self.hostname}:{self._port}"

# Usage — looks like normal attribute access!
server = Server("web-01")
print(server.port)       # 8080 (calls getter)
server.port = 9090       # Calls setter with validation
print(server.port)       # 9090

server.port = -1         # ❌ ValueError: Port must be 1-65535, got -1
server.port = "hello"    # ❌ TypeError: Port must be an integer

print(server.url)        # http://web-01:9090 (computed property)
server.url = "x"         # ❌ AttributeError: can't set attribute (no setter)
```

### When to Use Properties

- **Validation** on attribute assignment
- **Computed values** that depend on other attributes
- **Read-only attributes** (only define getter, no setter)
- **Lazy loading** (compute on first access, then cache)
- **API compatibility** (change internal representation without breaking callers)

### Practical Example: Server Status with Side Effects

```python
class Server:
    def __init__(self, hostname):
        self.hostname = hostname
        self._status = "stopped"
    
    @property
    def status(self):
        return self._status
    
    @status.setter
    def status(self, new_status):
        valid_statuses = {"running", "stopped", "maintenance", "error"}
        if new_status not in valid_statuses:
            raise ValueError(f"Invalid status: {new_status}. Must be one of {valid_statuses}")
        
        old_status = self._status
        self._status = new_status
        
        # Side effect: log the transition
        if old_status != new_status:
            print(f"  [{self.hostname}] Status: {old_status} → {new_status}")

server = Server("web-01")
server.status = "running"       # [web-01] Status: stopped → running
server.status = "maintenance"   # [web-01] Status: running → maintenance
server.status = "broken"        # ❌ ValueError: Invalid status
```

---

## 9.16 Composition vs Inheritance

### The Problem with Deep Inheritance

```python
# ❌ Deep inheritance chains become rigid and confusing
class Machine: ...
class NetworkedMachine(Machine): ...
class Server(NetworkedMachine): ...
class MonitoredServer(Server): ...
class WebServer(MonitoredServer): ...
class LoadBalancedWebServer(WebServer): ...
# Where does any specific behavior live? Hard to follow!
```

### Composition: "Has-A" vs Inheritance: "Is-A"

- **Inheritance (Is-A):** A WebServer **IS A** Server
- **Composition (Has-A):** A WebServer **HAS A** Logger, **HAS A** HealthChecker

### Composition Example

```python
class Logger:
    """Handles logging for any component."""
    def __init__(self, name):
        self.name = name
    
    def info(self, message):
        print(f"[INFO] [{self.name}] {message}")
    
    def error(self, message):
        print(f"[ERROR] [{self.name}] {message}")

class HealthChecker:
    """Handles health checking logic."""
    def __init__(self, endpoint="/health", interval=30):
        self.endpoint = endpoint
        self.interval = interval
    
    def check(self, host, port):
        url = f"http://{host}:{port}{self.endpoint}"
        # In reality: make HTTP request
        return {"url": url, "healthy": True}

class MetricsCollector:
    """Collects and stores metrics."""
    def __init__(self):
        self.metrics = {}
    
    def record(self, name, value):
        self.metrics[name] = value
    
    def get_all(self):
        return self.metrics.copy()

class Server:
    """Composed of smaller, focused components."""
    
    def __init__(self, hostname, ip, port=8080):
        self.hostname = hostname
        self.ip = ip
        self.port = port
        self.status = "stopped"
        
        # Composition: Server HAS these components
        self.logger = Logger(hostname)
        self.health_checker = HealthChecker()
        self.metrics = MetricsCollector()
    
    def start(self):
        self.status = "running"
        self.logger.info("Server started")
        self.metrics.record("start_count", 
                          self.metrics.metrics.get("start_count", 0) + 1)
    
    def check_health(self):
        result = self.health_checker.check(self.ip, self.port)
        self.logger.info(f"Health check: {result['healthy']}")
        return result

# Usage
server = Server("web-01", "10.0.0.1")
server.start()
# [INFO] [web-01] Server started

server.check_health()
# [INFO] [web-01] Health check: True
```

### When to Use Composition vs Inheritance

| Use Inheritance | Use Composition |
|----------------|----------------|
| Clear "is-a" relationship | "Has-a" relationship |
| Child is a specialized parent | Object uses another object's capabilities |
| Shallow hierarchy (1-2 levels) | Deep hierarchies would emerge |
| Framework requires it | Maximum flexibility needed |
| Overriding specific behavior | Swapping components at runtime |

### The Rule of Thumb

> **"Favor composition over inheritance."** — Gang of Four Design Patterns

Use inheritance for genuine type hierarchies. Use composition for adding capabilities.

---

## 9.17 Dataclasses (Python 3.7+)

### What They Are

Dataclasses are a shortcut for creating classes that primarily hold data. They auto-generate `__init__`, `__repr__`, `__eq__`, and more.

### The Problem They Solve

```python
# ❌ Boilerplate-heavy class just to hold data
class Server:
    def __init__(self, hostname, ip, port, environment, status):
        self.hostname = hostname
        self.ip = ip
        self.port = port
        self.environment = environment
        self.status = status
    
    def __repr__(self):
        return (f"Server(hostname={self.hostname!r}, ip={self.ip!r}, "
                f"port={self.port}, environment={self.environment!r}, "
                f"status={self.status!r})")
    
    def __eq__(self, other):
        if not isinstance(other, Server):
            return NotImplemented
        return (self.hostname == other.hostname and self.ip == other.ip 
                and self.port == other.port)
```

### The Dataclass Solution

```python
from dataclasses import dataclass, field
from typing import List

@dataclass
class Server:
    hostname: str
    ip: str
    port: int = 8080
    environment: str = "production"
    status: str = "stopped"
    tags: List[str] = field(default_factory=list)    # Mutable default!

# Auto-generated: __init__, __repr__, __eq__
server = Server("web-01", "10.0.0.1")
print(server)
# Server(hostname='web-01', ip='10.0.0.1', port=8080, environment='production', status='stopped', tags=[])

s1 = Server("web-01", "10.0.0.1")
s2 = Server("web-01", "10.0.0.1")
print(s1 == s2)    # True (auto-generated __eq__)
```

### Dataclass Features

```python
from dataclasses import dataclass, field, asdict, astuple
from typing import List, Optional

@dataclass
class DeploymentConfig:
    service: str
    version: str
    environment: str
    replicas: int = 3
    cpu_limit: str = "1000m"
    memory_limit: str = "2Gi"
    labels: dict = field(default_factory=dict)
    created_by: Optional[str] = None
    
    def __post_init__(self):
        """Runs after __init__ — for validation."""
        if self.replicas < 1:
            raise ValueError(f"replicas must be >= 1, got {self.replicas}")
        valid_envs = {"production", "staging", "development"}
        if self.environment not in valid_envs:
            raise ValueError(f"Invalid environment: {self.environment}")

# Usage
config = DeploymentConfig(
    service="api-gateway",
    version="2.3.1",
    environment="production",
    replicas=5,
    labels={"team": "platform"}
)

# Convert to dict (great for JSON serialization)
config_dict = asdict(config)
print(config_dict)
# {'service': 'api-gateway', 'version': '2.3.1', 'environment': 'production', 
#  'replicas': 5, 'cpu_limit': '1000m', 'memory_limit': '2Gi', ...}
```

### Frozen Dataclasses (Immutable)

```python
@dataclass(frozen=True)
class ServerAddress:
    """Immutable server address — great for dict keys and sets."""
    hostname: str
    ip: str
    port: int = 8080

addr = ServerAddress("web-01", "10.0.0.1")
addr.port = 9090    # ❌ FrozenInstanceError: cannot assign to field 'port'

# Can be used as dict key or in sets (hashable because frozen)
connections = {addr: "active"}
```

### When to Use Dataclasses

✅ Data containers (server info, configs, API responses)
✅ DTOs (Data Transfer Objects) between layers
✅ Replacing named tuples when you need mutability
✅ Configuration objects

❌ Complex classes with lots of methods and logic
❌ Classes that need fine-grained control over `__init__`

---

## 9.18 Common DevOps OOP Patterns

### Pattern 1: Infrastructure Manager

```python
from dataclasses import dataclass, field
from typing import List, Dict, Optional
from datetime import datetime

@dataclass
class ServerInfo:
    hostname: str
    ip: str
    port: int = 8080
    environment: str = "production"
    status: str = "stopped"
    last_checked: Optional[str] = None

class InfrastructureManager:
    """Manages a fleet of servers."""
    
    def __init__(self):
        self._servers: Dict[str, ServerInfo] = {}
        self._history: List[str] = []
    
    def add_server(self, server: ServerInfo):
        """Register a server."""
        self._servers[server.hostname] = server
        self._log(f"Added {server.hostname}")
    
    def remove_server(self, hostname: str):
        """Deregister a server."""
        if hostname in self._servers:
            del self._servers[hostname]
            self._log(f"Removed {hostname}")
    
    def get_server(self, hostname: str) -> Optional[ServerInfo]:
        """Get server by hostname."""
        return self._servers.get(hostname)
    
    def get_by_environment(self, env: str) -> List[ServerInfo]:
        """Get all servers in an environment."""
        return [s for s in self._servers.values() if s.environment == env]
    
    def get_unhealthy(self) -> List[ServerInfo]:
        """Get all servers not in 'running' status."""
        return [s for s in self._servers.values() if s.status != "running"]
    
    def health_check_all(self):
        """Run health checks on all servers."""
        print(f"Running health checks on {len(self._servers)} servers...")
        for hostname, server in self._servers.items():
            # Simulated health check
            server.last_checked = datetime.now().isoformat()
            print(f"  {'✅' if server.status == 'running' else '❌'} {hostname}")
    
    @property
    def server_count(self) -> int:
        return len(self._servers)
    
    def _log(self, message: str):
        timestamp = datetime.now().strftime("%H:%M:%S")
        self._history.append(f"[{timestamp}] {message}")
    
    def __len__(self):
        return len(self._servers)
    
    def __contains__(self, hostname: str):
        return hostname in self._servers
    
    def __iter__(self):
        return iter(self._servers.values())

# Usage
infra = InfrastructureManager()
infra.add_server(ServerInfo("web-01", "10.0.0.1", status="running"))
infra.add_server(ServerInfo("web-02", "10.0.0.2", status="running"))
infra.add_server(ServerInfo("db-01", "10.0.0.3", port=5432, status="error"))

print(f"Total servers: {len(infra)}")
print(f"web-01 registered: {'web-01' in infra}")

infra.health_check_all()
unhealthy = infra.get_unhealthy()
print(f"\nUnhealthy: {[s.hostname for s in unhealthy]}")
```

### Pattern 2: Deployment Pipeline

```python
class DeploymentPipeline:
    """Orchestrates a multi-step deployment process."""
    
    def __init__(self, service, version, environment):
        self.service = service
        self.version = version
        self.environment = environment
        self.steps_completed = []
        self.status = "pending"
    
    def run(self):
        """Execute the full deployment pipeline."""
        steps = [
            ("Validate config", self._validate),
            ("Run tests", self._run_tests),
            ("Build artifact", self._build),
            ("Deploy", self._deploy),
            ("Health check", self._health_check),
        ]
        
        self.status = "running"
        print(f"🚀 Deploying {self.service} v{self.version} to {self.environment}")
        print("=" * 50)
        
        for step_name, step_func in steps:
            print(f"\n▶ {step_name}...")
            try:
                step_func()
                self.steps_completed.append(step_name)
                print(f"  ✅ {step_name} — passed")
            except Exception as e:
                print(f"  ❌ {step_name} — FAILED: {e}")
                self.status = "failed"
                self._rollback()
                return False
        
        self.status = "completed"
        print(f"\n{'='*50}")
        print(f"✅ Deployment complete! {self.service} v{self.version} is live.")
        return True
    
    def _validate(self):
        if not self.service or not self.version:
            raise ValueError("Service and version are required")
    
    def _run_tests(self):
        print("  Running unit tests... 45/45 passed")
        print("  Running integration tests... 12/12 passed")
    
    def _build(self):
        print(f"  Building {self.service}:{self.version} image...")
    
    def _deploy(self):
        print(f"  Updating deployment in {self.environment}...")
    
    def _health_check(self):
        print(f"  Checking /health endpoint...")
    
    def _rollback(self):
        print(f"\n🔄 Rolling back...")
        for step in reversed(self.steps_completed):
            print(f"  ↩️  Undoing: {step}")
        print(f"  Rollback complete. Service unchanged.")

# Usage
pipeline = DeploymentPipeline("api-gateway", "2.3.1", "production")
pipeline.run()
```

### Pattern 3: Abstract Base Class (Interface Definition)

```python
from abc import ABC, abstractmethod

class CloudProvider(ABC):
    """Abstract base class — defines the interface all cloud providers must implement."""
    
    @abstractmethod
    def create_instance(self, name, instance_type):
        """Create a compute instance."""
        pass
    
    @abstractmethod
    def terminate_instance(self, instance_id):
        """Terminate a compute instance."""
        pass
    
    @abstractmethod
    def list_instances(self):
        """List all instances."""
        pass

class AWSProvider(CloudProvider):
    def __init__(self, region="us-east-1"):
        self.region = region
    
    def create_instance(self, name, instance_type="t3.medium"):
        print(f"[AWS] Creating EC2 {instance_type} in {self.region}: {name}")
        return f"i-{name[:8]}"
    
    def terminate_instance(self, instance_id):
        print(f"[AWS] Terminating {instance_id}")
    
    def list_instances(self):
        return [{"id": "i-abc123", "state": "running"}]

class GCPProvider(CloudProvider):
    def __init__(self, project="my-project"):
        self.project = project
    
    def create_instance(self, name, instance_type="n1-standard-1"):
        print(f"[GCP] Creating {instance_type} in {self.project}: {name}")
        return f"gcp-{name}"
    
    def terminate_instance(self, instance_id):
        print(f"[GCP] Deleting {instance_id}")
    
    def list_instances(self):
        return [{"name": "vm-1", "status": "RUNNING"}]

# Can't instantiate the abstract class directly:
# provider = CloudProvider()  # ❌ TypeError: Can't instantiate abstract class

# Must use a concrete implementation:
def provision_infrastructure(provider: CloudProvider):
    """Works with ANY cloud provider that implements the interface."""
    instance_id = provider.create_instance("web-server", "large")
    instances = provider.list_instances()
    return instance_id

# Polymorphism — same function, different providers
provision_infrastructure(AWSProvider(region="eu-west-1"))
provision_infrastructure(GCPProvider(project="prod-project"))
```

---

## 9.19 Section Summary and Review

### What You Learned

| Topic | Key Takeaway |
|-------|-------------|
| OOP concept | Bundle data + behavior into objects for organization and reuse |
| Class | Blueprint/template for creating objects |
| Object/Instance | Specific entity created from a class |
| `__init__` | Constructor — sets up initial state; called automatically |
| `self` | Reference to the current instance; must be first param in methods |
| Instance vs class variables | Instance: unique per object; Class: shared by all instances |
| Instance methods | Operate on `self`; most common method type |
| Class methods | `@classmethod`; alternative constructors; receive `cls` |
| Static methods | `@staticmethod`; utility functions; no `self` or `cls` |
| Encapsulation | `_protected`, `__private`; naming conventions, not enforcement |
| Inheritance | Child classes reuse and extend parent classes |
| `super()` | Call parent's methods from child |
| MRO | Method Resolution Order for multiple inheritance |
| Polymorphism | Same interface, different behavior (duck typing) |
| Dunder methods | `__str__`, `__repr__`, `__eq__`, `__len__`, `__iter__`, etc. |
| `@property` | Controlled attribute access with validation |
| Composition | "Has-a" — prefer over deep inheritance |
| Dataclasses | Auto-generated boilerplate for data-focused classes |
| ABC | Abstract base classes define required interfaces |

### Production Scenario Recap

> An infrastructure automation tool uses:
> - **Dataclasses** for server info, deployment configs, and API responses
> - **InfrastructureManager class** with dunder methods (`__len__`, `__contains__`, `__iter__`)
> - **DeploymentPipeline class** orchestrating multi-step processes with rollback
> - **Abstract base class** `CloudProvider` ensuring all providers implement the same interface
> - **Composition** for Logger, HealthChecker, MetricsCollector injected into Server
> - **Properties** for validated attribute access (port, status)
> - **Class methods** as alternative constructors (`from_dict`, `from_yaml`)

### Common Interview Questions

1. **Q: What is the difference between a class and an object?**
   A: A class is a blueprint/template defining structure and behavior. An object (instance) is a specific entity created from that class with its own data. You can create many objects from one class.

2. **Q: What is `self` in Python?**
   A: `self` is a reference to the current instance of the class. It's passed automatically as the first argument to instance methods, allowing the method to access and modify the instance's attributes.

3. **Q: What is the difference between instance and class variables?**
   A: Instance variables are unique per object (defined in `__init__` with `self.x = value`). Class variables are shared among all instances (defined at class level). Modifying a class variable affects all instances; modifying an instance variable affects only that instance.

4. **Q: When would you use composition over inheritance?**
   A: When the relationship is "has-a" rather than "is-a", when you need flexibility to swap components at runtime, when inheritance would create deep confusing hierarchies, or when you want to reuse behavior without being locked into a type hierarchy.

5. **Q: What are dunder methods?**
   A: Special methods with double underscores (e.g., `__init__`, `__str__`, `__eq__`) that Python calls automatically in specific situations. They let custom objects behave like built-in types (printable, comparable, iterable, etc.).

6. **Q: What is polymorphism in Python?**
   A: The ability for different objects to respond to the same method/interface in their own way. Python uses duck typing — if an object has the right methods, it works regardless of its class.

### Practice Exercises

1. Create a `Server` class with hostname, ip, port, status and methods to start/stop/describe
2. Add `__str__` and `__repr__` to your Server class
3. Create `WebServer` and `DatabaseServer` that inherit from Server, each with specialized methods
4. Implement a `ServerCluster` class that supports `len()`, `in`, and `for` loop iteration
5. Create a dataclass `DeploymentRecord` with service, version, environment, timestamp, and success fields
6. Build a simple `Pipeline` class using composition (has a Logger, has a HealthChecker)
7. Define an abstract `Notifier` class with `send()` method, then implement `SlackNotifier` and `EmailNotifier`

### Beginner Quiz (10 Questions)

1. What keyword defines a class in Python?
2. What method is called automatically when creating an object?
3. What is the first parameter of every instance method?
4. How do you call a parent class's method from a child class?
5. What decorator creates a class method?
6. What does `@property` enable?
7. Can you create an instance of an abstract class (ABC)?
8. What is the difference between `__str__` and `__repr__`?
9. What does `@dataclass` auto-generate?
10. What does "composition over inheritance" mean?

<details>
<summary>Quiz Answers</summary>

1. `class`
2. `__init__` (the constructor/initializer)
3. `self` — a reference to the current instance
4. `super().method_name()` — calls the parent's version of the method
5. `@classmethod` — method receives `cls` (the class) instead of `self`
6. Defining getter/setter methods that look like normal attribute access, enabling validation and computed values
7. No — instantiating an ABC with unimplemented abstract methods raises `TypeError`
8. `__str__` is human-friendly (used by `print()`). `__repr__` is developer-friendly, unambiguous (used in REPL and debugging).
9. `__init__`, `__repr__`, `__eq__` (and optionally `__hash__`, `__order__`, etc.)
10. Prefer building objects by combining smaller components ("has-a") rather than creating deep inheritance trees ("is-a"), for flexibility and maintainability.

</details>

### Next Section Preview

**Section 10: Iterators, Generators, and the Iteration Protocol**

You will learn how Python's `for` loop actually works under the hood, the iterator protocol (`__iter__` and `__next__`), `StopIteration`, creating custom iterators, generator functions with `yield`, generator expressions, lazy evaluation, memory efficiency, `itertools` module, and how generators are used in DevOps for processing large log files, streaming data, and building pipelines.

---

*Ready for Section 10? Let me know and I'll generate it.*
