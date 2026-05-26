# Python for DevOps – 50 Questions, Programs, and Patterns

> Focus areas: core Python, scripting patterns for DevOps, file/JSON/YAML handling, subprocess/OS, API calls, error handling, logging, multithreading, boto3, and FastAPI basics.[web:106][web:112]

---

## 1. Core Python and Data Structures (Intermediate Level)

### Q1. Write a Python program to print duplicate elements from a list and their counts.

**Answer:**

**Concepts used:**

- `collections.Counter` for counting.
- List comprehension to filter duplicates.

```python
from collections import Counter

items = ["nginx", "redis", "nginx", "python", "redis", "redis"]

counter = Counter(items)

duplicates = {item: count for item, count in counter.items() if count > 1}

print("Duplicates:", duplicates)
```

**Output (example):**

```text
Duplicates: {'nginx': 2, 'redis': 3}
```

**Follow-up Questions:**

- How would you keep only unique items while preserving order?
- How would you handle case-insensitive duplicates (e.g., "App" vs "app")?

---

### Q2. Given a list of dictionaries representing servers, filter only running servers and print their IPs.

**Question:**

```python
servers = [
    {"name": "web-1", "ip": "10.0.0.10", "status": "running"},
    {"name": "web-2", "ip": "10.0.0.11", "status": "stopped"},
    {"name": "db-1",  "ip": "10.0.1.5",  "status": "running"},
]
```

Write a Python snippet to get a list of IPs where `status == "running"`.

**Answer:**

```python
running_ips = [s["ip"] for s in servers if s.get("status") == "running"]
print(running_ips)  # ['10.0.0.10', '10.0.0.11', '10.0.1.5'] (if any)
```

**DevOps Twist:** imagine `servers` is output from `boto3` (EC2 `describe_instances`); same pattern applies when filtering AWS resources.[web:106]

**Follow-up Question:**

- How would you adapt this to filter by tag and state using boto3?

---

### Q3. Explain list comprehension and give a DevOps-relevant example.

**Answer:**  
List comprehension is a concise way to create lists by applying an expression to each item in an iterable, optionally with filtering.

**Example (extract failed pod names from `kubectl` JSON output):**

```python
pods = [
    {"name": "api-1", "status": "Running"},
    {"name": "api-2", "status": "CrashLoopBackOff"},
    {"name": "api-3", "status": "Pending"},
]

failed_pods = [p["name"] for p in pods if p["status"] != "Running"]
print(failed_pods)  # ['api-2', 'api-3']
```

**Follow-up Question:**

- How would you rewrite the same logic without list comprehension, and which is more readable in this context?

---

### Q4. Program: Remove duplicates from a list while preserving order.

**Answer:**

```python
items = ["nginx", "redis", "nginx", "python", "redis", "prometheus"]
seen = set()
unique_items = []

for item in items:
    if item not in seen:
        unique_items.append(item)
        seen.add(item)

print(unique_items)  # ['nginx', 'redis', 'python', 'prometheus']
```

**Use case:** unique list of hosts, services, or tags from log files or inventory data.

**Follow-up Question:**

- How would you wrap this in a reusable function and add type hints?

---

### Q5. Program: Merge two dictionaries representing environment variables, with precedence rules.

**Scenario:**  
You have default env vars and environment-specific overrides.

```python
defaults = {"ENV": "dev", "LOG_LEVEL": "INFO", "RETRIES": 3}
overrides = {"ENV": "prod", "LOG_LEVEL": "WARN"}
```

**Answer:**

```python
merged = {**defaults, **overrides}
print(merged)  # {'ENV': 'prod', 'LOG_LEVEL': 'WARN', 'RETRIES': 3}
```

**Explanation:** later dict values override earlier ones when keys collide.

**Follow-up Question:**

- How would you merge deeply nested dicts (e.g., config trees) safely?

---

## 2. File, JSON, and YAML Handling

### Q6. Program: Read a JSON file containing server metadata and print names of servers in “prod”.

**Sample `servers.json`:**

```json
[
  {"name": "app-1", "env": "dev"},
  {"name": "app-2", "env": "prod"},
  {"name": "api-1", "env": "prod"}
]
```

**Answer:**

```python
import json
from pathlib import Path

data = json.loads(Path("servers.json").read_text())

prod_servers = [s["name"] for s in data if s.get("env") == "prod"]
print(prod_servers)
```

**DevOps Use Case:** reading inventory-like metadata from an API or file and filtering by environment.[web:112]

**Follow-up Question:**

- How would you handle invalid JSON with proper error messages?

---

### Q7. Program: Parse a YAML file (e.g., Kubernetes manifest) and list all container images.

**Answer:**

```python
import yaml
from pathlib import Path

content = Path("deployment.yaml").read_text()
doc = yaml.safe_load(content)

containers = doc["spec"]["template"]["spec"]["containers"]
images = [c["image"] for c in containers]
print(images)
```

**Notes:**

- Use `yaml.safe_load` instead of `load` for safety.[web:112]
- This can be extended to scan manifests for disallowed base images.

**Follow-up Question:**

- How would you handle multiple YAML documents separated by `---` in one file?

---

### Q8. Explain context managers (`with` statement) and show a file-handling example.

**Answer:**  
Context managers automatically handle setup and teardown (like opening/closing files, acquiring/releasing locks). `with` ensures cleanup even if exceptions occur.

**Example:**

```python
with open("app.log") as f:
    for line in f:
        print(line.strip())
```

**DevOps Angle:** use context managers for file handles, temporary directories, network connections, and even locks in multi-threaded scripts.

**Follow-up Question:**

- How would you write a custom context manager to acquire a file-based lock?

---

## 3. OS, Subprocess, and CLI Automation

### Q9. Program: Run a shell command (`kubectl get pods -o json`) and parse its output.

**Answer:**

```python
import subprocess
import json

cmd = ["kubectl", "get", "pods", "-A", "-o", "json"]
result = subprocess.run(cmd, capture_output=True, text=True, check=True)
data = json.loads(result.stdout)

pods = [
    (item["metadata"]["namespace"], item["metadata"]["name"])
    for item in data["items"]
]

print(pods)
```

**Key Practices:**

- Prefer `subprocess.run` with `check=True` to catch errors.
- Avoid `shell=True` unless needed for shell features.[web:112]

**Follow-up Question:**

- How would you handle command failures gracefully and log stderr?

---

### Q10. Program: Check disk usage on Linux and alert if usage > threshold.

**Answer:**

```python
import shutil

total, used, free = shutil.disk_usage("/")
percent_used = used / total * 100

threshold = 80

if percent_used > threshold:
    print(f"ALERT: Disk usage is {percent_used:.1f}% (threshold {threshold}%)")
else:
    print(f"OK: Disk usage is {percent_used:.1f}%")
```

**Use case:** embed this into a simple cron-based health script or extend to send Slack/email.

**Follow-up Question:**

- How would you scan all mount points and alert per filesystem?

---

### Q11. Explain `argparse` and why it’s useful for DevOps scripts.

**Answer:**  
`argparse` is the standard library module for parsing command-line arguments, providing robust CLI interfaces with help, defaults, and validation.[web:105]

**Example:**

```python
import argparse

parser = argparse.ArgumentParser(description="Check disk usage")
parser.add_argument("--threshold", type=int, default=80, help="Usage threshold (%)")

args = parser.parse_args()

print("Using threshold:", args.threshold)
```

**DevOps Use Cases:**

- Scripts that can be parameterized by env, region, or resource names.
- Better than reading `sys.argv` directly.

**Follow-up Question:**

- How would you define mutually exclusive flags (e.g., `--start` vs `--stop`)?

---

## 4. Error Handling, Logging, and Best Practices

### Q12. Show how you would wrap an API call with proper exception handling and logging.

**Answer:**

```python
import logging
import requests

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s [%(name)s] %(message)s",
)

logger = logging.getLogger("health-check")

def check_service(url: str, timeout: int = 5) -> bool:
    try:
        resp = requests.get(url, timeout=timeout)
        resp.raise_for_status()
        logger.info("Service healthy: %s (status %s)", url, resp.status_code)
        return True
    except requests.exceptions.Timeout:
        logger.error("Timeout while checking %s", url)
    except requests.exceptions.HTTPError as e:
        logger.error("HTTP error from %s: %s", url, e)
    except requests.exceptions.RequestException as e:
        logger.error("Request error for %s: %s", url, e)
    return False
```

**DevOps Angle:** this pattern is reusable for health checks, control scripts, and integrations with Jenkins/GitHub Actions.[web:106]

**Follow-up Question:**

- How would you expose this health check as a CLI command using `argparse`?

---

### Q13. Explain `try/except/else/finally` and provide a file+network example.

**Answer:**  

- `try`: block where you expect exceptions.
- `except`: handle specific errors.
- `else`: runs if no exception occurs.
- `finally`: runs always (cleanup).

**Example:**

```python
import json

try:
    with open("config.json") as f:
        config = json.load(f)
except FileNotFoundError:
    print("config.json not found, using defaults")
    config = {}
else:
    print("Loaded config successfully")
finally:
    print("Config init complete")
```

**Follow-up Question:**

- When would you prefer to let exceptions bubble up vs catching them?

---

## 5. Small DevOps-Focused Practice Programs

### Q14. Program: From a list of log lines, count HTTP status codes and print the top offenders.

**Sample logs:**

```python
logs = [
    "2024-01-01T10:00:01 GET /health 200",
    "2024-01-01T10:00:02 GET /api 500",
    "2024-01-01T10:00:03 GET /api 500",
    "2024-01-01T10:00:04 GET /login 401",
]
```

**Answer:**

```python
from collections import Counter

status_codes = [line.split()[-1] for line in logs]
counter = Counter(status_codes)

for code, count in counter.most_common():
    print(code, count)
```

**Use case:** quick analysis of app logs in a troubleshooting session.

**Follow-up Question:**

- How would you extend this to parse a real Nginx/ALB log file?

---

### Q15. Program: Given a list of hostnames and a mapping env→domain, generate FQDNs.

**Input:**

```python
hosts = ["api", "web", "db"]
domains = {"dev": "dev.bank.local", "prod": "bank.com"}
env = "prod"
```

**Answer:**

```python
env_domain = domains[env]
fqdns = [f"{host}.{env_domain}" for host in hosts]
print(fqdns)  # ['api.bank.com', 'web.bank.com', 'db.bank.com']
```

**DevOps Use Case:** generating inventory, DNS records, or config for different environments.

**Follow-up Question:**

- How would you validate that `env` is a valid key and fail gracefully otherwise?
