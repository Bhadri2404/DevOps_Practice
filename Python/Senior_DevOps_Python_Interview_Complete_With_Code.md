# Senior DevOps Engineer — Complete Python Scripting & Coding Interview Notes

**Focus:** AWS / EKS / Linux / Terraform / CI/CD / Python coding  
**Level:** Senior DevOps Engineer  
**Style:** Simple-English explanations, small code examples, practical scenarios

> All Python programs are provided **in full fenced code blocks** for easy reading and copying. Sample cloud IDs, bucket names, endpoints and namespaces are placeholders. Do not run destructive examples against production without approvals. AWS scripts assume temporary IAM credentials through an appropriate role or profile. Some code requires `boto3`, `requests`, `psutil`, or `PyYAML`.

## Clickable Table of Contents

- [Part 1 — Python fundamentals: Q1–Q10](#part1)
- [Part 2 — DevOps automation scripts: Q11–Q20](#part2)
- [Part 3 — EKS, Docker, Terraform, APIs and CI/CD: Q21–Q28](#part3)
- [Part 4 — 37 Python coding questions with code](#part4)
- [Part 5 — 40 frequently asked theory questions](#part5)
- [Part 6 — Five production scenarios with scripts](#part6)
- [Part 7 — Last-minute revision](#part7)

---

<a id="part1"></a>
## Part 1 — Python Fundamentals for DevOps

### Q1. Why do DevOps engineers use Python?

**Simple interview answer:** Python is useful for automating repetitive tasks such as server monitoring, AWS management, log analysis, REST API integration and CI/CD checks.

**Python code:**

```python
import subprocess

subprocess.run(["df", "-h"], check=True)
```

**DevOps scenario:** Run automated disk checks instead of manually accessing every EC2 server.

### Q2. What are the main Python data types?

**Simple interview answer:** String, integer, float, boolean, list, tuple, set and dictionary. Lists and dictionaries are very common in Boto3/JSON responses.

**Python code:**

```python
name = "payment-service"           # str
replicas = 3                     # int
cpu = 75.5                       # float
healthy = True                   # bool
servers = ["web1", "web2"]        # list
regions = ("mumbai", "hyderabad") # tuple
ports = {80, 443}                # set
instance = {"name": "web1", "state": "running"}  # dict
print(instance["state"])
```

### Q3. Difference between list, tuple, set and dictionary?

**Simple interview answer:** List: ordered and mutable. Tuple: ordered and immutable. Set: unique hashable elements. Dictionary: key–value pairs.

**Python code:**

```python
servers = ["web1", "web2"]
servers.append("web3")
regions = ("ap-south-1", "us-east-1")
ports = {80, 443, 80}
config = {"environment": "production", "replicas": 3}
print(servers, regions, ports, config["replicas"])
```

### Q4. How do you use a for loop?

**Simple interview answer:** A for loop repeats an operation for each item, such as checking many servers or instances.

**Python code:**

```python
servers = ["web1", "web2", "web3"]
for server in servers:
    print("Checking:", server)
```

### Q5. What is a function? Explain print vs return.

**Simple interview answer:** A function is reusable code. `print` displays output; `return` sends a result to the caller.

**Python code:**

```python
def check_server(server):
    return f"Checking {server}"

for name in ["web1", "web2"]:
    print(check_server(name))
```

### Q6. What is exception handling?

**Simple interview answer:** We use try/except to handle expected errors, and finally for cleanup if needed.

**Python code:**

```python
try:
    result = 10 / 0
except ZeroDivisionError:
    print("Cannot divide by zero")
finally:
    print("Operation finished")
```

**DevOps scenario:** When an AWS API call fails, catch and log a meaningful exception instead of silently ignoring it.

### Q7. How do you read environment variables?

**Simple interview answer:** Use `os.getenv()` so environment-specific values do not have to be hardcoded.

**Python code:**

```python
import os

region = os.getenv("AWS_REGION", "ap-south-1")
print("AWS Region:", region)
```

**Follow-up:** In Linux: `export AWS_REGION=ap-south-1`; never print passwords or tokens.

### Q8. How do you execute Linux commands using Python?

**Simple interview answer:** Use subprocess. It supports command arguments, captured output, exit codes and timeouts.

**Python code:**

```python
import subprocess

result = subprocess.run(
    ["df", "-h"],
    capture_output=True,
    text=True,
    check=True,
    timeout=10,
)
print(result.stdout)
```

**Follow-up:** Prefer a list of arguments; avoid unsafe shell=True with untrusted input.

### Q9. How do you read and write files?

**Simple interview answer:** `with open()` handles closing a file automatically.

**Python code:**

```python
with open("report.txt", "w", encoding="utf-8") as f:
    f.write("Server status: Healthy\n")

with open("report.txt", "r", encoding="utf-8") as f:
    print(f.read())
```

### Q10. How do you read JSON and YAML?

**Simple interview answer:** Use the built-in `json` module and `yaml.safe_load()` from PyYAML.

**Python code:**

```python
import json
import yaml

with open("config.json", encoding="utf-8") as f:
    json_config = json.load(f)
print(json_config["application"])

with open("config.yaml", encoding="utf-8") as f:
    yaml_config = yaml.safe_load(f)
print(yaml_config["replicas"])
```

**Follow-up:** Install YAML support using `python -m pip install PyYAML`. Example JSON: `{"application":"payment-service"}`; example YAML: `replicas: 3`.

---
<a id="part2"></a>
## Part 2 — Real-Time DevOps Python Automation Scripts

These are the examples to practise *writing* as well as explaining. Commands may require permissions or installed utilities.

### Q11. Disk usage >80% — write a health check

**Simple interview answer:** Use `shutil.disk_usage` and calculate percentage. Exit non-zero when the filesystem is above the threshold.

**Python code:**

```python
import shutil
import sys

total, used, free = shutil.disk_usage("/")
usage = used / total * 100
print(f"Disk: {usage:.2f}%")
if usage > 80:
    print("ALERT: high disk usage")
    sys.exit(1)
print("Disk usage normal")
```

**DevOps scenario:** A pipeline or monitoring agent schedules this check and alerts if it exits with code 1.

### Q12. Monitor CPU and memory usage

**Simple interview answer:** Use `psutil` for live CPU and memory percentages. Install with `pip install psutil`.

**Python code:**

```python
import psutil

cpu = psutil.cpu_percent(interval=1)
mem = psutil.virtual_memory().percent
print(f"CPU: {cpu}% | Memory: {mem}%")
if cpu > 80:
    print("ALERT: high CPU")
if mem > 85:
    print("ALERT: high memory")
```

**Follow-up:** This is a sample measurement; historical CPU/memory requires a metrics store such as Prometheus or CloudWatch.

### Q13. Check an HTTP application health endpoint

**Simple interview answer:** Use requests with a timeout and fail on unsuccessful responses.

**Python code:**

```python
import requests
import sys

try:
    response = requests.get("https://example.com/health", timeout=5)
    response.raise_for_status()
    print("Application healthy")
except requests.RequestException as exc:
    print("Health check failed:", exc)
    sys.exit(1)
```

**DevOps scenario:** Run after an EKS deployment so the pipeline fails if the endpoint is unavailable.

### Q14. Print and count ERROR log lines

**Simple interview answer:** Stream each line from the file rather than reading a huge log into memory.

**Python code:**

```python
count = 0
with open("app.log", encoding="utf-8") as file:
    for line in file:
        if "ERROR" in line:
            print(line.rstrip())
            count += 1
print("Total errors:", count)
```

**DevOps scenario:** Filter errors during production troubleshooting.

### Q15. Check if Nginx systemd service is running

**Simple interview answer:** Use subprocess to execute systemctl and check its return code.

**Python code:**

```python
import subprocess

result = subprocess.run(
    ["systemctl", "is-active", "nginx"],
    capture_output=True,
    text=True,
)
if result.returncode == 0:
    print("Nginx running")
else:
    print("Nginx is not running")
```

**Follow-up:** For an approved recovery action, `subprocess.run(["sudo", "-n", "systemctl", "restart", "nginx"], check=True)`; avoid endless auto-restarts.

### Q16. List all EC2 instances with Boto3

**Simple interview answer:** Use Boto3 EC2 client and paginator to handle large accounts.

**Python code:**

```python
import boto3

ec2 = boto3.client("ec2", region_name="ap-south-1")
pages = ec2.get_paginator("describe_instances").paginate()
for page in pages:
    for reservation in page["Reservations"]:
        for instance in reservation["Instances"]:
            print(instance["InstanceId"], instance["State"]["Name"])
```

**DevOps scenario:** Create an inventory of running and stopped EC2 instances.

### Q17. Start or stop an approved EC2 instance

**Simple interview answer:** Use Boto3 but require an explicit selection and approval for real resource changes.

**Python code:**

```python
import boto3

ec2 = boto3.client("ec2", region_name="ap-south-1")
instance_id = "i-0123456789abcdef0"  # example ID
if input("Type YES to STOP this approved instance: ") == "YES":
    ec2.stop_instances(InstanceIds=[instance_id])
    print("Stop requested")
else:
    print("Cancelled")
```

**Follow-up:** To start: `ec2.start_instances(InstanceIds=[instance_id])`. An API response confirms submission, not completion.

### Q18. Upload a log file to S3

**Simple interview answer:** Use the S3 upload_file method. Authenticate using temporary IAM credentials.

**Python code:**

```python
import boto3

s3 = boto3.client("s3")
s3.upload_file(
    "app.log",
    "example-devops-backups",  # replace with approved bucket
    "logs/app.log",
)
print("Upload completed")
```

**DevOps scenario:** Copy approved log files or reports to S3.

### Q19. List unattached EBS volumes

**Simple interview answer:** Filter volumes with status available and review them for cost optimization.

**Python code:**

```python
import boto3

ec2 = boto3.client("ec2", region_name="ap-south-1")
paginator = ec2.get_paginator("describe_volumes")
for page in paginator.paginate(Filters=[{"Name": "status", "Values": ["available"]}]):
    for volume in page["Volumes"]:
        print(volume["VolumeId"], volume["Size"], "GiB")
```

**Follow-up:** Do not delete an available volume without ownership and backup checks.

### Q20. Create and verify a standard RDS snapshot

**Simple interview answer:** Use create_db_snapshot, then a waiter to confirm completion. This example is for standard RDS, not Aurora.

**Python code:**

```python
import boto3
from datetime import datetime, timezone

rds = boto3.client("rds", region_name="ap-south-1")
name = "payment-" + datetime.now(timezone.utc).strftime("%Y%m%d-%H%M%S")
rds.create_db_snapshot(
    DBInstanceIdentifier="payment-db",
    DBSnapshotIdentifier=name,
)
print("Requested snapshot:", name)
rds.get_waiter("db_snapshot_completed").wait(DBSnapshotIdentifier=name)
print("Snapshot completed")
```

**DevOps scenario:** A backup is verified before approved database maintenance.

---
<a id="part3"></a>
## Part 3 — EKS, Docker, Terraform, APIs and Azure DevOps

### Q21. Check Kubernetes pod status from Python

**Simple interview answer:** Execute kubectl, request JSON, and loop over pod details.

**Python code:**

```python
import json
import subprocess

output = subprocess.check_output(
    ["kubectl", "get", "pods", "-n", "production", "-o", "json"],
    text=True,
)
for pod in json.loads(output)["items"]:
    print(pod["metadata"]["name"], pod["status"]["phase"])
```

**Follow-up:** Running is not the same as Ready; inspect conditions and container statuses.

### Q22. Find unhealthy pods and CrashLoopBackOff

**Simple interview answer:** Check both phase and container waiting reasons, because CrashLoopBackOff is not a pod phase.

**Python code:**

```python
import json
import subprocess

output = subprocess.check_output(
    ["kubectl", "get", "pods", "-A", "-o", "json"], text=True
)
for pod in json.loads(output)["items"]:
    name = pod["metadata"]["name"]
    phase = pod["status"]["phase"]
    if phase not in ("Running", "Succeeded"):
        print(name, "phase:", phase)
    for container in pod["status"].get("containerStatuses", []):
        reason = container.get("state", {}).get("waiting", {}).get("reason")
        if reason:
            print(name, "container issue:", reason)
```

### Q23. List Docker containers and inspect exit code

**Simple interview answer:** Run docker ps and docker inspect through subprocess.

**Python code:**

```python
import subprocess

subprocess.run(["docker", "ps", "-a"], check=True)
container = "payment-service"
result = subprocess.run(
    ["docker", "inspect", "--format", "{{.State.ExitCode}}", container],
    capture_output=True, text=True, check=True
)
print("Exit code:", result.stdout.strip())
```

**Follow-up:** Past CPU or memory history must have been recorded by monitoring; docker stats is primarily live.

### Q24. Check Terraform plan exit codes

**Simple interview answer:** Terraform detailed-exitcode: 0 no changes, 2 changes, 1 error.

**Python code:**

```python
import subprocess
import sys

result = subprocess.run(["terraform", "plan", "-detailed-exitcode"])
if result.returncode == 0:
    print("No changes")
elif result.returncode == 2:
    print("Changes detected; send for approval")
else:
    print("Plan failed")
    sys.exit(1)
```

**Follow-up:** For plan review/apply in production, save the reviewed plan with `terraform plan -out=tfplan` and apply that exact saved plan after approval.

### Q25. Call REST APIs using GET and POST

**Simple interview answer:** Use the requests library, timeouts and raise_for_status for HTTP failures.

**Python code:**

```python
import requests

health = requests.get("https://example.com/health", timeout=5)
health.raise_for_status()
print("Status:", health.status_code)

response = requests.post(
    "https://api.example.com/events",
    json={"service": "payment", "status": "healthy"},
    timeout=5,
)
response.raise_for_status()
print("Event submitted")
```

**Follow-up:** 401: missing/invalid auth; 403: forbidden; 404: not found; 5xx: server-side issue.

### Q26. Run a Python script from Azure DevOps

**Simple interview answer:** Use a pipeline step to install dependencies and run a script; nonzero exit codes fail the step.

**Python code:**

```python
# File: scripts/health_check.py
import sys

healthy = True  # replace with real HTTP health check
if not healthy:
    print("Unhealthy")
    sys.exit(1)
print("Healthy")
```

**Follow-up:** See YAML below. Agents should use pinned dependencies and secure secrets handling.

**Example `azure-pipelines.yml`:**

```yaml
trigger:
  - main
pool:
  name: SelfHosted-Linux
steps:
  - checkout: self
  - script: python3 -m pip install -r requirements.txt
    displayName: Install dependencies
  - script: python3 scripts/health_check.py
    displayName: Application health check
```

### Q27. Schedule a Python script

**Simple interview answer:** Use cron/systemd timers on Linux or AWS EventBridge Scheduler, Lambda, or a CI/CD schedule.

**Python code:**

```python
# File: scheduled_check.py
from datetime import datetime, timezone
print("Running check at", datetime.now(timezone.utc).isoformat())
```

**Follow-up:** Linux cron expression for every 5 minutes: `*/5 * * * * /usr/bin/python3 /opt/scripts/scheduled_check.py`.

### Q28. Make a Python script production-ready

**Simple interview answer:** Add validation, logging, timeouts, error handling, least-privilege IAM and clear exit codes.

**Python code:**

```python
import logging
import sys

logging.basicConfig(level=logging.INFO)
try:
    logging.info("Starting checks")
    # Call approved API or check a service here.
    logging.info("Checks completed")
except Exception:
    logging.exception("Unexpected failure")
    sys.exit(1)
```

**Follow-up:** Use targeted exceptions for known failures and consider idempotency/retries for external APIs.

---
<a id="part4"></a>
## Part 4 — 37 Coding Questions With Python Programs

**Practice instructions:** Try to write each from memory. Explain the algorithm in two sentences before coding. The programs are examples and most use fixed inputs for easy memorization.

### Coding 1. Reverse string with slicing

**Python code:**

```python
text = "DevOps"
print(text[::-1])
```

**Expected result:** `spOveD`

### Coding 2. Check palindrome

**Python code:**

```python
text = "madam"
print("Palindrome" if text == text[::-1] else "Not palindrome")
```

**Expected result:** `Palindrome`

### Coding 3. Find duplicates in list

**Python code:**

```python
nums = [1, 2, 3, 2, 4, 3]
seen = set()
duplicates = set()
for num in nums:
    if num in seen:
        duplicates.add(num)
    seen.add(num)
print(sorted(duplicates))
```

**Expected result:** `[2, 3]`

### Coding 4. Remove duplicates, preserving order

**Python code:**

```python
nums = [1, 2, 2, 3, 4, 4]
unique = list(dict.fromkeys(nums))
print(unique)
```

**Expected result:** `[1, 2, 3, 4]`

### Coding 5. Find second largest distinct number

**Python code:**

```python
nums = [10, 30, 20, 50, 40]
unique = sorted(set(nums))
if len(unique) >= 2:
    print(unique[-2])
else:
    print("Not available")
```

**Expected result:** `40`

### Coding 6. Count word frequency

**Python code:**

```python
text = "aws eks aws terraform eks aws"
frequency = {}
for word in text.split():
    frequency[word] = frequency.get(word, 0) + 1
print(frequency)
```

**Expected result:** `{'aws': 3, 'eks': 2, 'terraform': 1}`

### Coding 7. Print even numbers

**Python code:**

```python
nums = [1, 2, 3, 4, 5, 6]
for num in nums:
    if num % 2 == 0:
        print(num)
```

**Expected result:** `2`, `4`, `6`

### Coding 8. Check prime number

**Python code:**

```python
num = 7
if num < 2:
    print("Not prime")
else:
    for divisor in range(2, num):
        if num % divisor == 0:
            print("Not prime")
            break
    else:
        print("Prime")
```

**Expected result:** `Prime`

### Coding 9. Print Fibonacci series

**Python code:**

```python
a, b = 0, 1
for _ in range(7):
    print(a)
    a, b = b, a + b
```

**Expected result:** `0 1 1 2 3 5 8` (on separate lines)

### Coding 10. Find largest number without max

**Python code:**

```python
nums = [10, 50, 20, 80, 30]
largest = nums[0]
for num in nums:
    if num > largest:
        largest = num
print(largest)
```

**Expected result:** `80`

### Coding 11. Sort dictionary by values

**Python code:**

```python
servers = {"server1": 80, "server2": 40, "server3": 95}
result = sorted(servers.items(), key=lambda item: item[1])
print(result)
```

**Expected result:** `[('server2', 40), ('server1', 80), ('server3', 95)]`

### Coding 12. Validate minimum Kubernetes replicas

**Python code:**

```python
config = {"app": "payment", "replicas": 2}
if config["replicas"] < 3:
    print("Insufficient replicas")
else:
    print("OK")
```

**Expected result:** `Insufficient replicas`

### Coding 13. Swap two variables

**Python code:**

```python
a, b = 10, 20
a, b = b, a
print(a, b)
```

**Expected result:** `20 10`

### Coding 14. Calculate factorial

**Python code:**

```python
n = 5
answer = 1
for i in range(1, n + 1):
    answer *= i
print(answer)
```

**Expected result:** `120`

### Coding 15. Count vowels in a string

**Python code:**

```python
text = "DevOps Engineer"
count = 0
for ch in text.lower():
    if ch in "aeiou":
        count += 1
print(count)
```

**Expected result:** `6`

### Coding 16. Character frequency

**Python code:**

```python
text = "banana"
counts = {}
for ch in text:
    counts[ch] = counts.get(ch, 0) + 1
print(counts)
```

**Expected result:** `{'b': 1, 'a': 3, 'n': 2}`

### Coding 17. Check anagrams

**Python code:**

```python
a, b = "listen", "silent"
print("Anagrams" if sorted(a) == sorted(b) else "Not anagrams")
```

**Expected result:** `Anagrams`

**Note:** This basic example checks exact character frequencies and is case-sensitive.

### Coding 18. First non-repeating character

**Python code:**

```python
text = "aabbcde"
for ch in text:
    if text.count(ch) == 1:
        print(ch)
        break
```

**Expected result:** `c`

### Coding 19. Reverse a positive integer

**Python code:**

```python
num = 12345
print(int(str(num)[::-1]))
```

**Expected result:** `54321`

**Note:** This simple example assumes a non-negative integer.

### Coding 20. Sum the digits of a positive number

**Python code:**

```python
num = 12345
total = 0
for digit in str(num):
    total += int(digit)
print(total)
```

**Expected result:** `15`

### Coding 21. Count even and odd numbers

**Python code:**

```python
nums = [1, 2, 3, 4, 5, 6]
even = sum(num % 2 == 0 for num in nums)
odd = len(nums) - even
print("Even:", even, "Odd:", odd)
```

**Expected result:** `Even: 3 Odd: 3`

### Coding 22. Find a missing number in 1..N

**Python code:**

```python
nums = [1, 2, 3, 5]
n = 5
expected = n * (n + 1) // 2
print(expected - sum(nums))
```

**Expected result:** `4` (assumes exactly one missing number)

### Coding 23. Find common elements in two lists

**Python code:**

```python
left = [1, 2, 3, 4]
right = [3, 4, 5, 6]
print(sorted(set(left) & set(right)))
```

**Expected result:** `[3, 4]`

### Coding 24. Merge two dictionaries

**Python code:**

```python
a = {"name": "payment"}
b = {"replicas": 3}
print({**a, **b})
```

**Expected result:** `{'name': 'payment', 'replicas': 3}`

### Coding 25. Sort list without built-in sorting (bubble sort)

**Python code:**

```python
nums = [5, 2, 8, 1, 3]
for i in range(len(nums)):
    for j in range(len(nums) - 1 - i):
        if nums[j] > nums[j + 1]:
            nums[j], nums[j + 1] = nums[j + 1], nums[j]
print(nums)
```

**Expected result:** `[1, 2, 3, 5, 8]`

### Coding 26. FizzBuzz

**Python code:**

```python
for num in range(1, 21):
    if num % 15 == 0:
        print("FizzBuzz")
    elif num % 3 == 0:
        print("Fizz")
    elif num % 5 == 0:
        print("Buzz")
    else:
        print(num)
```

**Expected result:** Multiples of 3 → Fizz, 5 → Buzz, both → FizzBuzz

### Coding 27. Read dictionary keys safely

**Python code:**

```python
server = {"name": "prod-ec2", "status": "running"}
print(server.get("status", "unknown"))
print(server.get("region", "not configured"))
```

**Expected result:** `running` and `not configured`

### Coding 28. Flatten a two-level nested list

**Python code:**

```python
nested = [[1, 2], [3, 4], [5, 6]]
result = []
for group in nested:
    for num in group:
        result.append(num)
print(result)
```

**Expected result:** `[1, 2, 3, 4, 5, 6]`

### Coding 29. Count ERROR lines in an application log

**Python code:**

```python
count = 0
with open("app.log", encoding="utf-8") as file:
    for line in file:
        if "ERROR" in line:
            count += 1
print("Total errors:", count)
```

**Expected result:** Count depends on contents of `app.log`

**Note:** Create the `app.log` file first. Example content: `INFO started`, `ERROR database timeout`.

### Coding 30. Check disk usage threshold

**Python code:**

```python
import shutil

total, used, free = shutil.disk_usage("/")
percent = 100 * used / total
print(f"Disk usage: {percent:.1f}%")
if percent > 80:
    print("ALERT")
```

**Expected result:** Displays current root filesystem usage

### Coding 31. Check whether a website is UP

**Python code:**

```python
import requests

try:
    response = requests.get("https://example.com/health", timeout=5)
    print("UP" if response.status_code == 200 else "DOWN")
except requests.RequestException:
    print("DOWN")
```

**Expected result:** Depends on endpoint availability

### Coding 32. Read JSON configuration

**Python code:**

```python
import json

with open("config.json", encoding="utf-8") as file:
    data = json.load(file)
print(data["application"])
print(data["replicas"])
```

**Expected result:** Assumes config.json contains keys `application`, `replicas`

### Coding 33. List only running EC2 instances

**Python code:**

```python
import boto3

ec2 = boto3.client("ec2", region_name="ap-south-1")
paginator = ec2.get_paginator("describe_instances")
for page in paginator.paginate(Filters=[{
    "Name": "instance-state-name", "Values": ["running"]
}]):
    for reservation in page["Reservations"]:
        for instance in reservation["Instances"]:
            print(instance["InstanceId"])
```

**Expected result:** Actual running EC2 IDs

### Coding 34. Find Kubernetes pods in failed phases

**Python code:**

```python
import json
import subprocess

output = subprocess.check_output(
    ["kubectl", "get", "pods", "-A", "-o", "json"], text=True
)
for pod in json.loads(output)["items"]:
    phase = pod["status"]["phase"]
    if phase in ("Pending", "Failed", "Unknown"):
        print(pod["metadata"]["name"], phase)
```

**Expected result:** Lists problematic pod phases; CrashLoopBackOff is a waiting reason

### Coding 35. Check multiple application URLs

**Python code:**

```python
import requests

urls = ["https://example.com", "https://www.python.org"]
for url in urls:
    try:
        response = requests.get(url, timeout=5)
        print(url, response.status_code)
    except requests.RequestException:
        print(url, "UNREACHABLE")
```

**Expected result:** HTTP status for each URL

### Coding 36. Execute a Linux command and check exit code

**Python code:**

```python
import subprocess

result = subprocess.run(
    ["systemctl", "is-active", "nginx"],
    capture_output=True, text=True
)
print("Running" if result.returncode == 0 else "Stopped")
```

**Expected result:** Running or Stopped

### Coding 37. Find server with highest CPU usage

**Python code:**

```python
servers = {"server1": 45, "server2": 92, "server3": 70}
highest = max(servers, key=servers.get)
print(highest, servers[highest], "%")
```

**Expected result:** `server2 92 %`

---
<a id="part5"></a>
## Part 5 — 40 Common Python Theory Questions (Short Answers)

| # | Interview question | Simple answer |
|---:|---|---|

| 1 | What is Python? | A high-level language used for automation, APIs, scripting and applications. |

| 2 | Is Python compiled or interpreted? | Python is typically compiled to bytecode, which the interpreter executes. |

| 3 | What is a variable? | A name bound to a Python object. |

| 4 | What is mutable vs immutable? | Mutable objects can change in place; immutable objects cannot. |

| 5 | Is a list mutable? | Yes; it can be extended, updated or shortened. |

| 6 | Is a tuple mutable? | No, but a tuple can contain mutable objects. |

| 7 | Difference between list and set? | A list is ordered and allows duplicates; a set stores unique hashable values. |

| 8 | Difference between == and is? | == compares equality of values; is checks object identity. |

| 9 | append() vs extend()? | append adds one object; extend adds each element from an iterable. |

| 10 | remove() vs pop()? | remove deletes the first matching value; pop removes and returns an element. |

| 11 | What is slicing? | Selecting part of a sequence using start, stop, step. |

| 12 | What is lambda? | A small anonymous function defined with an expression. |

| 13 | What is *args? | Collects extra positional arguments into a tuple. |

| 14 | What is **kwargs? | Collects extra keyword arguments into a dictionary. |

| 15 | print vs return? | print displays output; return passes a value to the caller. |

| 16 | What is a decorator? | A callable that wraps or modifies a function or class. |

| 17 | What is a generator? | An iterator often produced by a function containing yield. |

| 18 | What is __init__? | An initializer invoked when a class instance is created. |

| 19 | What is inheritance? | A class derives or extends behavior from another class. |

| 20 | What is exception handling? | Handling failures with try/except and related constructs. |

| 21 | What is finally? | A block that normally executes after the try statement, whether or not an exception occurs. |

| 22 | What does raise do? | It raises an exception explicitly. |

| 23 | What is a context manager? | A pattern for resource setup/cleanup using with. |

| 24 | Shallow copy vs deep copy? | Shallow copies reference nested objects; deep copies recursively copy them. |

| 25 | What is Boto3? | AWS SDK for Python. |

| 26 | What is subprocess? | Module for running external programs and reading exit codes/output. |

| 27 | What is requests? | Third-party Python library for HTTP communication. |

| 28 | What is a virtual environment? | Isolates Python packages for an application. |

| 29 | What is requirements.txt? | A list of Python dependencies to install. |

| 30 | What is logging? | Structured recording of program events and errors. |

| 31 | What is idempotency? | Repeating a command without unintended additional changes. |

| 32 | What is a Boto3 paginator? | Helper for retrieving every page from paginated AWS APIs. |

| 33 | What is a Boto3 waiter? | Helper that polls an AWS resource until a state is reached. |

| 34 | How do you handle API timeout? | Set a deadline, catch specific exceptions and safely retry when appropriate. |

| 35 | How do you secure Python automation? | Least-privilege IAM, temporary credentials, no secrets in logs and input checks. |

| 36 | How do you schedule scripts? | Cron, systemd timer, EventBridge Scheduler/Lambda, or CI/CD schedule. |

| 37 | How do you test Python? | pytest or unittest, mocks, and integration checks. |

| 38 | What does if __name__ == "__main__" mean? | Run code only when the file is executed directly. |

| 39 | Threads vs processes? | Threads share process memory; processes have separate address spaces. |

| 40 | What is Python GIL? | In conventional CPython builds it restricts parallel execution of Python bytecode by threads. |

### Five small theory-code examples

**List comprehension**

```python
nums = [1, 2, 3, 4, 5]
even = [n for n in nums if n % 2 == 0]
print(even)
```

**`*args` and `**kwargs`**

```python
def show(*args, **kwargs):
    print(args)
    print(kwargs)
show("AWS", "EKS", region="Mumbai")
```

**Class and object**

```python
class Server:
    def __init__(self, name):
        self.name = name
    def check(self):
        print(self.name, "is running")
Server("prod-ec2").check()
```

**Direct-execution guard**

```python
def main():
    print("Starting checks")
if __name__ == "__main__":
    main()
```

**API exception handling**

```python
import requests
try:
    response = requests.get("https://example.com", timeout=5)
    response.raise_for_status()
    print("Success")
except requests.RequestException as exc:
    print("Failed:", exc)
```

---
<a id="part6"></a>
## Part 6 — Five Production Scenarios With Python Code

### QS1. Daily AWS EC2 inventory report

**Simple interview answer:** Use Boto3 to fetch resources, check states and generate a report or alert. For true health also check EC2 status checks and application metrics.

**Python code:**

```python
import boto3

ec2 = boto3.client("ec2", region_name="ap-south-1")
for page in ec2.get_paginator("describe_instances").paginate():
    for reservation in page["Reservations"]:
        for instance in reservation["Instances"]:
            print(instance["InstanceId"], instance["State"]["Name"])
```

### QS2. Verify whether an expected S3 backup object exists

**Simple interview answer:** Use head_object; report an error for missing or inaccessible backups. A full backup test must also validate the restore.

**Python code:**

```python
import boto3
from botocore.exceptions import ClientError

s3 = boto3.client("s3")
try:
    s3.head_object(
        Bucket="example-devops-backups",
        Key="backups/database-backup.sql",
    )
    print("Object exists")
except ClientError as exc:
    print("Could not verify backup:", exc)
    raise
```

### QS3. Verify an EKS deployment rollout

**Simple interview answer:** Use kubectl rollout status and fail the CI/CD job if the deployment fails.

**Python code:**

```python
import subprocess
import sys

result = subprocess.run([
    "kubectl", "rollout", "status", "deployment/payment-service",
    "-n", "production", "--timeout=120s"
])
if result.returncode != 0:
    print("Deployment verification failed")
    sys.exit(1)
print("Deployment rolled out")
```

### QS4. Check SQS backlog

**Simple interview answer:** Use Boto3 queue attributes. This is approximate; additionally monitor age of oldest message.

**Python code:**

```python
import boto3

sqs = boto3.client("sqs", region_name="ap-south-1")
queue_url = "<approved-queue-url>"
response = sqs.get_queue_attributes(
    QueueUrl=queue_url,
    AttributeNames=["ApproximateNumberOfMessages"],
)
count = int(response["Attributes"]["ApproximateNumberOfMessages"])
print("Pending messages:", count)
if count > 100:
    print("ALERT: SQS backlog")
```

### QS5. Check several HTTP endpoints

**Simple interview answer:** Store service endpoints in a list, send requests with timeouts, and count failures.

**Python code:**

```python
import requests

urls = ["https://example.com/health", "https://www.python.org/"]
failed = 0
for url in urls:
    try:
        response = requests.get(url, timeout=5)
        response.raise_for_status()
        print(url, "healthy")
    except requests.RequestException as exc:
        failed += 1
        print(url, "failed:", exc)
print("Failed endpoints:", failed)
```

---
<a id="part7"></a>
## Part 7 — Last-Minute Revision

### Python libraries and their DevOps use

| Library | Use |
|---|---|
| `os` | Environment variables |
| `sys` | Exit codes and command-line arguments |
| `subprocess` | Execute Linux, Docker, Terraform and kubectl |
| `shutil` | Disk and file operations |
| `json` | JSON configuration and API results |
| `yaml` (PyYAML) | YAML manifests |
| `requests` | HTTP GET/POST and health checks |
| `boto3` | EC2, S3, RDS, SQS and AWS automation |
| `psutil` | CPU, memory and processes |
| `logging` | Logs and error diagnostics |
| `datetime` | Backup and report timestamps |
| `pathlib` | Filesystem paths |
| `argparse` | CLI argument parsing |
| `collections.Counter` | Counting errors and words |

### Quick commands

```bash
python3 --version
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install boto3 requests psutil PyYAML pytest
python3 script.py
python3 -m py_compile script.py
python3 -m pytest -q
aws sts get-caller-identity
kubectl get pods -n production
```

### The 12 programs to practise first

1. Reverse string, palindrome and duplicates
2. Second-largest value and dictionary frequency count
3. For loop, function, try/except and file handling
4. Disk usage alert using `shutil`
5. CPU/memory using `psutil`
6. Health check using `requests`
7. Count application ERROR log lines
8. List EC2 instances with Boto3 and pagination
9. Identify unattached EBS volumes
10. Upload a file to S3 and verify a backup
11. Check EKS pod state and rollout
12. Terraform detailed exit code and CI/CD integration

### Example answer: How have you used Python in DevOps?

> I use Python to automate repetitive operations such as checking Linux resources, analyzing logs and testing application health. For AWS tasks, Boto3 can retrieve EC2 states, check S3 backups and automate approved maintenance operations. For EKS, I use kubectl with JSON output or the Kubernetes Python client to verify deployments. I keep automation reliable by using temporary IAM credentials, timeouts, logging and proper error handling.

**Use the parts that accurately describe your own real experience.**

### Four points to mention after writing any interview code

- Explain the input and expected output.
- Explain why you chose the library or method.
- Explain failure handling and timeouts.
- Explain how the script will authenticate and run safely in CI/CD.

**End — Full Python interview notes with all code included.**

