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

## 6. FastAPI and Simple Automation APIs

### Q16. Show a minimal FastAPI service that exposes a `/health` endpoint and a `/version` endpoint.

**Answer:**

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/version")
def version():
    return {"version": "1.0.0"}
```

**Usage:** run with `uvicorn main:app --reload`. This pattern is useful for internal tools (e.g., deployment dashboards, config APIs).[web:110]

**Follow-up Question:**

- How would you add a `POST /deploy` endpoint that accepts a JSON payload to trigger a deployment job?

---

### Q17. How do you handle request validation in FastAPI for a deployment API?

**Answer:**

Use Pydantic models for request bodies:

```python
from fastapi import FastAPI
from pydantic import BaseModel, Field

app = FastAPI()

class DeployRequest(BaseModel):
    service: str = Field(..., regex=r"^[a-z0-9-]+$")
    environment: str
    version: str

@app.post("/deploy")
def deploy(req: DeployRequest):
    # Trigger Jenkins, ArgoCD, or internal script here
    return {"status": "scheduled", "service": req.service, "env": req.environment}
```

**Benefits:**

- Automatic validation and clear error responses.
- Self-documenting OpenAPI schema.

**Follow-up Question:**

- How would you secure this endpoint (auth token, IP allowlist, etc.)?

---

## 7. HTTP/REST Automation (Requests)

### Q18. Program: Query a REST API (e.g., GitHub) to list open issues for a repo.

**Answer:**

```python
import requests

def get_open_issues(owner: str, repo: str):
    url = f"https://api.github.com/repos/{owner}/{repo}/issues"
    resp = requests.get(url, params={"state": "open"})
    resp.raise_for_status()
    return [
        {"number": issue["number"], "title": issue["title"]}
        for issue in resp.json()
    ]

for issue in get_open_issues("kubernetes", "kubernetes"):
    print(f"#{issue['number']}: {issue['title']}")
```

**DevOps Use Case:** building tooling to sync GitHub issues with Jira, or to auto-label incidents.[web:106]

**Follow-up Question:**

- How would you handle API rate limiting (e.g., backoff when hitting 403/429)?

---

### Q19. Program: Send a Slack message when a health check fails.

**Answer:**

```python
import requests

def send_slack(webhook_url: str, text: str):
    payload = {"text": text}
    resp = requests.post(webhook_url, json=payload, timeout=5)
    resp.raise_for_status()

def check_and_alert(url: str, webhook_url: str):
    try:
        resp = requests.get(url, timeout=3)
        if resp.status_code != 200:
            send_slack(webhook_url, f"ALERT: Health check failed for {url} ({resp.status_code})")
    except requests.RequestException as e:
        send_slack(webhook_url, f"ALERT: Error checking {url}: {e}")

# Example (webhook_url from secrets):
# check_and_alert("https://service/health", WEBHOOK_URL)
```

**Follow-up Question:**

- How would you batch multiple health check results into a single Slack message?

---

## 8. boto3 and Cloud Automation

### Q20. Program: List all running EC2 instances in a region with their Name tags.

**Answer:**

```python
import boto3

ec2 = boto3.client("ec2", region_name="ap-south-1")

resp = ec2.describe_instances(
    Filters=[{"Name": "instance-state-name", "Values": ["running"]}]
)

instances = []
for reservation in resp["Reservations"]:
    for inst in reservation["Instances"]:
        name_tag = next(
            (t["Value"] for t in inst.get("Tags", []) if t["Key"] == "Name"),
            None,
        )
        instances.append({"id": inst["InstanceId"], "name": name_tag})

for i in instances:
    print(i["id"], i["name"])
```

**DevOps Use Case:** quick inventory, targeting instances for Ansible, or cost analysis.[web:106]

**Follow-up Question:**

- How would you extend this to include CPU utilization using CloudWatch?

---

### Q21. Program: Find S3 objects older than N days and print their keys (potential cleanup candidates).

**Answer:**

```python
import boto3
from datetime import datetime, timezone, timedelta

s3 = boto3.client("s3")
bucket = "my-logs-bucket"
days = 30
cutoff = datetime.now(timezone.utc) - timedelta(days=days)

resp = s3.list_objects_v2(Bucket=bucket)

old_keys = []
for obj in resp.get("Contents", []):
    if obj["LastModified"] < cutoff:
        old_keys.append(obj["Key"])

print(f"Objects older than {days} days:")
for key in old_keys:
    print(key)
```

**Follow-up Question:**

- How would you safely delete them in batches with error handling and dry-run option?

---

## 9. Multithreading for IO-Bound DevOps Tasks

### Q22. Why is multithreading useful for many DevOps scripts, and give a simple example.

**Answer:**  
Many DevOps tasks are **IO-bound** (network calls, API requests, disk reads). Python’s `threading` is effective here because while one thread waits on IO, others can run. For CPU-bound tasks, prefer `multiprocessing`.[web:109]

**Example: parallel URL health checks:**

```python
import threading
import requests

urls = ["https://service1/health", "https://service2/health", "https://service3/health"]

def check(url):
    try:
        r = requests.get(url, timeout=3)
        print(url, r.status_code)
    except Exception as e:
        print(url, "ERROR", e)

threads = []
for url in urls:
    t = threading.Thread(target=check, args=(url,))
    t.start()
    threads.append(t)

for t in threads:
    t.join()
```

**Follow-up Question:**

- How would you limit concurrency (e.g., at most 5 threads) to avoid overloading services?

---

### Q23. Program: Use `concurrent.futures` to speed up multiple API calls.

**Answer:**

```python
import concurrent.futures
import requests

urls = ["https://service1/health", "https://service2/health", "https://service3/health"]

def fetch_status(url: str) -> tuple[str, int]:
    r = requests.get(url, timeout=3)
    return url, r.status_code

with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
    futures = [executor.submit(fetch_status, url) for url in urls]
    for f in concurrent.futures.as_completed(futures):
        url, status = f.result()
        print(url, status)
```

**Advantages:** easy API, built-in thread pooling, error propagation.

**Follow-up Question:**

- How would you capture exceptions per future and log them, instead of letting them crash the executor?

---

## 10. More Small Coding Tasks (Interview-ish, DevOps flavor)

### Q24. Program: Given a list of log lines, group them by service name and count errors.

**Input:**

```python
logs = [
    "api serviceA ERROR timeout",
    "api serviceB INFO started",
    "api serviceA ERROR db-fail",
    "api serviceB ERROR auth-fail",
]
```

**Answer:**

```python
from collections import Counter

error_counter = Counter()

for line in logs:
    parts = line.split()
    if len(parts) < 3:
        continue
    _, service, level = parts[:3]
    if level == "ERROR":
        error_counter[service] += 1

print(error_counter)  # e.g., Counter({'serviceA': 2, 'serviceB': 1})
```

**Follow-up Question:**

- How would you modify this to also store the last error message per service?

---

### Q25. Program: From a list of IP addresses, print only unique IPs and sort them.

**Input:**

```python
ips = ["10.0.0.1", "10.0.0.2", "10.0.0.1", "192.168.1.5"]
```

**Answer:**

```python
unique_sorted = sorted(set(ips))
print(unique_sorted)
```

**Use case:** deduplicating IPs from logs or firewall rules.

**Follow-up Question:**

- How would you validate that each string is a valid IPv4 address?

---

### Q26. Program: Given a list of tuples `(service, status)`, find services that are down on more than one node.

**Input:**

```python
statuses = [
    ("api", "up"),
    ("api", "down"),
    ("db", "down"),
    ("db", "down"),
    ("cache", "up"),
]
```

**Answer:**

```python
from collections import Counter

c = Counter(service for service, status in statuses if status == "down")
down_multi = [svc for svc, count in c.items() if count > 1]
print(down_multi)  # ['db']
```

**Follow-up Question:**

- How would you integrate this with actual health check results from multiple nodes?

---

### Q27. Program: Read a large log file and stream process it line by line to find slow requests (>1s).

**Answer:**

```python
from pathlib import Path

log_path = Path("access.log")

slow_requests = 0

with log_path.open() as f:
    for line in f:
        parts = line.strip().split()
        if not parts:
            continue
        # assume last field is response time in seconds
        try:
            rt = float(parts[-1])
        except ValueError:
            continue
        if rt > 1.0:
            slow_requests += 1

print("Slow requests:", slow_requests)
```

**Patterns:**

- Streaming vs reading entire file (memory efficient).
- Basic log analysis pattern.

**Follow-up Question:**

- How would you also compute p95 and p99 latencies from that log?

---

### Q28. Program: Validate a JSON configuration file against required keys and print missing keys.

**Answer:**

```python
import json
from pathlib import Path

required_keys = {"host", "port", "database", "user"}

data = json.loads(Path("db_config.json").read_text())
missing = required_keys - data.keys()

if missing:
    print("Missing keys:", missing)
else:
    print("Config OK")
```

**DevOps use:** ensure config files are valid before deploying.

**Follow-up Question:**

- How would you extend this to validate nested keys (e.g., `logging.level`)?

---

### Q29. Program: Given a mapping env→URL, check all envs and print which ones are down.

**Input:**

```python
env_urls = {
    "dev": "https://dev.api/health",
    "qa": "https://qa.api/health",
    "prod": "https://prod.api/health",
}
```

**Answer:**

```python
import requests

down_envs = []

for env, url in env_urls.items():
    try:
        r = requests.get(url, timeout=3)
        if r.status_code != 200:
            down_envs.append(env)
    except requests.RequestException:
        down_envs.append(env)

print("Down envs:", down_envs)
```

**Follow-up Question:**

- How would you parallelize this check and send a single summary alert?

---

### Q30. Program: Basic retry decorator for flaky operations (e.g., HTTP call or shell command).

**Answer:**

```python
import time
import functools

def retry(times: int = 3, delay: float = 1.0):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            last_exc = None
            for attempt in range(1, times + 1):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    last_exc = e
                    if attempt < times:
                        time.sleep(delay)
            raise last_exc
        return wrapper
    return decorator

@retry(times=3, delay=2)
def flaky_operation():
    # example: call external API, run kubectl, etc.
    raise RuntimeError("still failing")

# flaky_operation()  # will try 3 times then raise
```

**DevOps Use Case:** wrap network calls, deployment steps, or health checks to handle transient failures correctly.

**Follow-up Question:**

- How would you make this decorator log each retry attempt with backoff (e.g., exponential)?

