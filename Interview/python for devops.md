# Python for DevOps – Practical Q&A with Code (Batch 1: Q1–Q10)

## Q1. How do you write a simple Python script to start/stop an EC2 instance using boto3?

### Typical question
“Show a small Python script that can start and stop EC2 instances, and explain how it works.”

### Answer – code + explanation

```python
import boto3

REGION = "ap-south-1"
INSTANCE_IDS = ["i-0123456789abcdef0"]  # replace with real IDs

ec2 = boto3.client("ec2", region_name=REGION)

def start_instances():
    response = ec2.start_instances(InstanceIds=INSTANCE_IDS)
    print("Start response:", response)

def stop_instances():
    response = ec2.stop_instances(InstanceIds=INSTANCE_IDS)
    print("Stop response:", response)

if __name__ == "__main__":
    # Example: stop, then start
    stop_instances()
    start_instances()
```

**Step‑by‑step:**

- `boto3.client("ec2", region_name=...)` creates a low‑level EC2 client bound to one region.[web:187][web:196]  
- `start_instances` and `stop_instances` call AWS APIs with the given list of instance IDs.  
- Credentials are taken from environment/instance role/profile (you don’t hardcode keys).  
- In production, you’d add:
  - CLI arguments (e.g., `--action start`),  
  - logging,  
  - error handling (try/except for `ClientError`).

---

## Q2. How do you list all EC2 instances in all regions and write them to CSV with Python?

### Typical question
“Give an example where Python + boto3 is better than manual AWS console clicks.”

### Answer – code + explanation

```python
import csv
import boto3

def get_all_regions():
    ec2 = boto3.client("ec2")
    resp = ec2.describe_regions()
    return [r["RegionName"] for r in resp["Regions"]]

def list_instances_in_region(region):
    ec2 = boto3.client("ec2", region_name=region)
    resp = ec2.describe_instances()
    instances = []
    for reservation in resp["Reservations"]:
        for inst in reservation["Instances"]:
            instances.append({
                "Region": region,
                "InstanceId": inst["InstanceId"],
                "InstanceType": inst["InstanceType"],
                "State": inst["State"]["Name"],
                "PrivateIp": inst.get("PrivateIpAddress", ""),
                "PublicIp": inst.get("PublicIpAddress", ""),
            })
    return instances

if __name__ == "__main__":
    all_instances = []
    for region in get_all_regions():
        all_instances.extend(list_instances_in_region(region))

    with open("ec2-inventory.csv", "w", newline="") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=["Region", "InstanceId", "InstanceType", "State", "PrivateIp", "PublicIp"],
        )
        writer.writeheader()
        writer.writerows(all_instances)
```

**Step‑by‑step:**

- Uses `describe_regions` to dynamically discover all regions, then loops across them.[web:187]  
- For each region, calls `describe_instances` and normalizes the JSON response into a simple list of dicts.  
- Writes a CSV inventory you can share with teams or feed into cost/cleanup scripts.  
- Interview angle: shows using Python to centralize multi‑region visibility.

---

## Q3. How do you safely load YAML config (for pipelines or infra) in Python?

### Typical question
“Your DevOps tooling reads configuration from YAML. Show how you load it safely.”

### Answer – code + explanation

```python
import yaml
from pathlib import Path

def load_config(path: str) -> dict:
    config_path = Path(path)
    if not config_path.exists():
        raise FileNotFoundError(f"Config file not found: {path}")

    with config_path.open() as f:
        # SafeLoader avoids executing arbitrary code in YAML
        data = yaml.safe_load(f)

    if not isinstance(data, dict):
        raise ValueError("Config must be a mapping at top level")
    return data

if __name__ == "__main__":
    cfg = load_config("config.yaml")
    print(cfg)
```

**Step‑by‑step:**

- Uses `yaml.safe_load` instead of `load` to avoid executing arbitrary Python objects from YAML (security).[web:184]  
- `Path.exists()` and explicit errors give clear messages when config is missing or malformed.  
- Typical DevOps configs: environments, cluster names, S3 bucket names, image tags.

---

## Q4. How do you add proper logging (not print) in a Python DevOps script?

### Typical question
“Show how you’d implement logging in a script that runs in CI/CD or as a cron job.”

### Answer – code + explanation

```python
import logging
import sys

logger = logging.getLogger("devops_script")
logger.setLevel(logging.INFO)

handler = logging.StreamHandler(sys.stdout)
fmt = logging.Formatter(
    "%(asctime)s | %(levelname)s | %(name)s | %(message)s"
)
handler.setFormatter(fmt)
logger.addHandler(handler)

if __name__ == "__main__":
    logger.info("Script started")
    try:
        # do some work
        logger.debug("Debug details here")
        logger.info("Script finished successfully")
    except Exception as exc:
        logger.exception("Script failed: %s", exc)
        sys.exit(1)
```

**Step‑by‑step:**

- Uses `logging` module instead of `print`, which is standard for production scripts.[web:188][web:194]  
- Logs to stdout so CI/CD and containers can capture logs easily.  
- `logger.exception` prints stack trace automatically, very useful in on‑call situations.

---

## Q5. How do you handle errors from AWS APIs with boto3 (retry, log, fail clearly)?

### Typical question
“Show how you’d wrap a boto3 call with error handling.”

### Answer – code + explanation

```python
import logging
import time

import boto3
from botocore.exceptions import ClientError

logger = logging.getLogger(__name__)
ec2 = boto3.client("ec2", region_name="ap-south-1")

def safe_stop_instance(instance_id: str, max_retries: int = 3):
    for attempt in range(1, max_retries + 1):
        try:
            logger.info("Stopping instance %s (attempt %d)", instance_id, attempt)
            ec2.stop_instances(InstanceIds=[instance_id])
            return
        except ClientError as e:
            code = e.response["Error"]["Code"]
            logger.error("AWS error %s on attempt %d: %s", code, attempt, e)
            if code in {"RequestLimitExceeded", "Throttling"} and attempt < max_retries:
                time.sleep(2 ** attempt)  # exponential backoff
                continue
            raise

if __name__ == "__main__":
    safe_stop_instance("i-0123456789abcdef0")
```

**Step‑by‑step:**

- Catches `ClientError` to inspect AWS error codes.[web:196]  
- Retries only for throttling‑style errors, with exponential backoff.  
- For other errors (bad ID, permissions), it gives a clear log and re‑raises.  
- This pattern is expected in production automation scripts.

---

## Q6. How do you write a Python script to check EC2 instances’ CPU from CloudWatch and alert if above threshold?

### Typical question
“Use Python to query CloudWatch metrics and raise an alert (or exit with non‑zero) if high.”

### Answer – code + explanation

```python
import datetime
import sys

import boto3

cloudwatch = boto3.client("cloudwatch", region_name="ap-south-1")

def get_cpu_avg(instance_id: str, minutes: int = 5) -> float:
    end = datetime.datetime.utcnow()
    start = end - datetime.timedelta(minutes=minutes)

    resp = cloudwatch.get_metric_statistics(
        Namespace="AWS/EC2",
        MetricName="CPUUtilization",
        Dimensions=[{"Name": "InstanceId", "Value": instance_id}],
        StartTime=start,
        EndTime=end,
        Period=60,
        Statistics=["Average"],
    )

    datapoints = resp.get("Datapoints", [])
    if not datapoints:
        return 0.0
    # Take latest datapoint
    latest = sorted(datapoints, key=lambda d: d["Timestamp"])[-1]
    return latest["Average"]

if __name__ == "__main__":
    inst_id = "i-0123456789abcdef0"
    cpu = get_cpu_avg(inst_id, minutes=5)
    print(f"Instance {inst_id} 5‑min avg CPU: {cpu:.2f}%")
    if cpu > 80:
        print("CPU above threshold!")
        sys.exit(2)
```

**Step‑by‑step:**

- Uses `get_metric_statistics` to query CPU utilization over last 5 minutes.[web:196]  
- Returns latest average value; you could aggregate differently if needed.  
- Exits with non‑zero code if threshold is crossed → can be used as custom Nagios/Prometheus alert script.

---

## Q7. How do you read a JSON log file and filter error entries using Python?

### Typical question
“Give a small script that parses log lines (JSON) and extracts only errors – typical DevOps task.”

### Answer – code + explanation

```python
import json
from pathlib import Path

def filter_errors(log_path: str):
    for line in Path(log_path).open():
        line = line.strip()
        if not line:
            continue
        try:
            record = json.loads(line)
        except json.JSONDecodeError:
            continue
        if record.get("level") == "ERROR":
            print(line)

if __name__ == "__main__":
    filter_errors("app.log.json")
```

**Step‑by‑step:**

- Each log line is JSON with fields like `timestamp`, `level`, `message`.  
- Script reads line‑by‑line (streaming) – good for large files.  
- It prints only error‑level lines, which you can pipe into another tool or grep.  
- Very common mini‑tool in SRE/DevOps workflows.

---

## Q8. How do you implement a simple REST API health check using FastAPI for readiness/liveness?

### Typical question
“Show a minimal FastAPI app that exposes `/health` and `/ready` for Kubernetes.”

### Answer – code + explanation

```python
from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/health")
def health():
    # basic liveness – process is running
    return {"status": "ok"}

@app.get("/ready")
def ready():
    # here you would add checks: DB connection, cache, etc.
    # for demo, just return ok
    return {"status": "ready"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

**Step‑by‑step:**

- FastAPI defines two endpoints for liveness (`/health`) and readiness (`/ready`).[web:186]  
- K8s/EKS can use these in `livenessProbe` and `readinessProbe`.  
- Inside `/ready`, you can check dependencies (DB, Redis) to decide if app can serve traffic.

---

## Q9. How do you write a Python script to rotate a secret (e.g., DB password) and store it in AWS Secrets Manager?

### Typical question
“Explain how you’d automate DB password rotation with Python.”

### Answer – code + explanation

```python
import os
import secrets
import string

import boto3

secrets_manager = boto3.client("secretsmanager", region_name="ap-south-1")

def generate_password(length: int = 32) -> str:
    alphabet = string.ascii_letters + string.digits + "!@#$%^&*"
    return "".join(secrets.choice(alphabet) for _ in range(length))

def update_secret(secret_name: str, new_password: str):
    secrets_manager.update_secret(
        SecretId=secret_name,
        SecretString=new_password,
    )

if __name__ == "__main__":
    secret_name = os.environ.get("SECRET_NAME", "mydb-password")
    new_pwd = generate_password()
    update_secret(secret_name, new_pwd)
    print(f"Rotated password for secret {secret_name}")
```

**Step‑by‑step:**

- Uses `secrets` module for strong random password generation.[web:187][web:196]  
- Calls `update_secret` to store new secret value in AWS Secrets Manager.  
- In real flow you would:
  - Update DB user password first,
  - Then update secret,
  - Then trigger app to reload secret (or use rotation Lambda pattern).

---

## Q10. In an interview, how do you summarize where you use Python in DevOps?

### Typical question
“Where does Python actually fit into your DevOps work?”

### Answer – talking points

1. **Cloud automation**
   - Using `boto3`/Azure/GCP SDKs to:
     - Start/stop/resize instances.
     - Generate inventories.
     - Automate backups, snapshots, tagging, cleanups.

2. **CI/CD glue & tools**
   - Small scripts for:
     - Validating config (YAML/JSON).
     - Generating versioned artifacts.
     - Interacting with APIs (GitHub, Jenkins, GitLab, Slack).

3. **Monitoring & operations**
   - Custom checks:
     - Query CloudWatch/Prometheus and exit non‑zero for alerts.
     - Parse logs, generate reports, or auto‑open tickets.

4. **APIs & internal tools**
   - FastAPI/Flask micro‑services to:
     - Wrap complex workflows into simple HTTP endpoints for teams.
     - Provide internal dashboards and “self‑service” automation.

5. **Best‑practice keywords**
   - Mention:
     - Virtualenv/venv for isolation.
     - PEP8 and linting (flake8/pylint).
     - Logging, error handling, and not hardcoding secrets (use env vars/Secrets Manager).

# Python for DevOps – Practical Q&A with Code (Batch 2: Q11–Q20)

## Q11. How do you read/write text and binary files safely in Python for log or config tasks?

### Typical question
“Show basic file handling patterns you use in scripts (logs, reports, configs).”

### Answer – code + explanation

```python
from pathlib import Path

def read_text_file(path: str) -> str:
    p = Path(path)
    return p.read_text(encoding="utf-8")

def write_text_file(path: str, content: str):
    p = Path(path)
    p.write_text(content, encoding="utf-8")

def read_binary_file(path: str) -> bytes:
    p = Path(path)
    return p.read_bytes()

def write_binary_file(path: str, data: bytes):
    p = Path(path)
    p.write_bytes(data)
```

**Key points:**

- `pathlib.Path` is preferred over plain strings; makes path handling cleaner.[web:184]  
- Always specify encoding for text; UTF‑8 is the default modern choice.  
- Use `read_bytes`/`write_bytes` for binary data (archives, images, etc.).

---

## Q12. How do you run a shell command from Python (e.g., kubectl/terraform) and capture output?

### Typical question
“You want to wrap `kubectl` or `terraform` in Python and act on its output. How?”

### Answer – code + explanation

```python
import subprocess

def run_cmd(cmd: list[str]) -> str:
    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        check=False,
    )
    if result.returncode != 0:
        raise RuntimeError(
            f"Command failed: {' '.join(cmd)}\n"
            f"stdout: {result.stdout}\n"
            f"stderr: {result.stderr}"
        )
    return result.stdout

if __name__ == "__main__":
    output = run_cmd(["kubectl", "get", "pods", "-A"])
    print(output)
```

**Key points:**

- Use `subprocess.run` instead of the older `os.system`.[web:191]  
- `capture_output=True, text=True` gives you decoded stdout/stderr as strings.  
- Always check `returncode` and raise clear errors so CI/on‑call sees what failed.

---

## Q13. How do you run multiple independent tasks in parallel (e.g., describe EC2 in many regions)?

### Typical question
“Show a simple example of concurrency for DevOps tasks (I/O‑bound).”

### Answer – code + explanation

```python
import concurrent.futures
import boto3

def list_instance_ids(region: str) -> list[str]:
    ec2 = boto3.client("ec2", region_name=region)
    resp = ec2.describe_instances()
    ids = []
    for r in resp["Reservations"]:
        for inst in r["Instances"]:
            ids.append(inst["InstanceId"])
    return ids

regions = ["ap-south-1", "us-east-1", "eu-west-1"]

if __name__ == "__main__":
    all_ids = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        futures = {executor.submit(list_instance_ids, r): r for r in regions}
        for fut in concurrent.futures.as_completed(futures):
            region = futures[fut]
            try:
                ids = fut.result()
                print(region, ":", ids)
                all_ids.extend(ids)
            except Exception as e:
                print("Error in region", region, ":", e)
```

**Key points:**

- `ThreadPoolExecutor` is a good fit for I/O‑bound tasks like AWS API calls.[web:190]  
- Each worker uses `boto3` in its own client/context; AWS requests run concurrently.  
- Collect results and handle exceptions per future.

---

## Q14. How do you parse and merge two YAML config files (base + environment override)?

### Typical question
“You have `config.base.yaml` and `config.prod.yaml`. How do you merge them with Python?”

### Answer – code + explanation

```python
import copy
from pathlib import Path
import yaml

def load_yaml(path: str) -> dict:
    return yaml.safe_load(Path(path).read_text(encoding="utf-8")) or {}

def deep_merge(base: dict, override: dict) -> dict:
    result = copy.deepcopy(base)
    for key, value in override.items():
        if (
            key in result
            and isinstance(result[key], dict)
            and isinstance(value, dict)
        ):
            result[key] = deep_merge(result[key], value)
        else:
            result[key] = value
    return result

if __name__ == "__main__":
    base = load_yaml("config.base.yaml")
    prod = load_yaml("config.prod.yaml")
    merged = deep_merge(base, prod)
    print(yaml.dump(merged, sort_keys=False))
```

**Key points:**

- `deep_merge` recursively merges dictionaries, letting overrides replace leaf values.[web:184]  
- Useful pattern for environment-specific configs (dev/stage/prod) in CI/CD pipelines.  
- Keeps base defaults in one file, while overridables live in smaller environment files.

---

## Q15. How do you write a small Python tool that validates a Kubernetes manifest YAML before applying?

### Typical question
“Show how you’d do preflight checks on K8s manifests in a pipeline.”

### Answer – code + explanation

```python
import sys
import yaml
from pathlib import Path

def validate_k8s_manifest(path: str):
    content = Path(path).read_text(encoding="utf-8")
    docs = list(yaml.safe_load_all(content))
    if not docs:
        raise ValueError("No YAML documents found")

    for i, doc in enumerate(docs, start=1):
        if not isinstance(doc, dict):
            raise ValueError(f"Document {i} is not a mapping")
        if "kind" not in doc or "metadata" not in doc:
            raise ValueError(f"Document {i} missing kind/metadata")
        if "name" not in doc["metadata"]:
            raise ValueError(f"Document {i} metadata missing name")

if __name__ == "__main__":
    manifest_path = sys.argv[3]
    try:
        validate_k8s_manifest(manifest_path)
        print("Manifest validation passed")
    except Exception as e:
        print("Manifest validation failed:", e)
        sys.exit(1)
```

**Key points:**

- Reads multi‑document YAML via `yaml.safe_load_all`.  
- Performs simple structural checks (kind, metadata.name) before `kubectl apply`.  
- In CI, failing this script blocks broken manifests from reaching clusters.

---

## Q16. How do you send a Slack notification from Python when a deployment or job finishes?

### Typical question
“Show a simple Python snippet to send messages to Slack (or similar) from CI.”

### Answer – code + explanation

```python
import json
import os
import sys
import urllib.request

def send_slack_message(webhook_url: str, text: str):
    data = {"text": text}
    req = urllib.request.Request(
        webhook_url,
        data=json.dumps(data).encode("utf-8"),
        headers={"Content-Type": "application/json"},
    )
    with urllib.request.urlopen(req) as resp:
        if resp.status != 200:
            raise RuntimeError(f"Slack webhook failed with status {resp.status}")

if __name__ == "__main__":
    webhook = os.environ.get("SLACK_WEBHOOK_URL")
    if not webhook:
        print("SLACK_WEBHOOK_URL not set", file=sys.stderr)
        sys.exit(1)
    send_slack_message(webhook, "Deployment finished successfully ✅")
```

**Key points:**

- Uses Slack Incoming Webhook URL stored in environment variable (no hard‑coded secret).[web:185]  
- Simple JSON payload with `text`; can be extended with blocks/attachments.  
- CI pipelines can call this after success/failure to notify teams.

---

## Q17. How do you write a Python CLI tool with arguments (for DevOps scripts)?

### Typical question
“Show how you add `--region` or `--env` flags to your scripts.”

### Answer – code + explanation

```python
import argparse

def main():
    parser = argparse.ArgumentParser(description="DevOps helper tool")
    parser.add_argument("--env", choices=["dev", "stage", "prod"], required=True)
    parser.add_argument("--region", default="ap-south-1")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    print(f"Environment: {args.env}, Region: {args.region}, Dry run: {args.dry_run}")
    # use args.env, args.region, args.dry_run in your logic

if __name__ == "__main__":
    main()
```

**Key points:**

- `argparse` is the standard library way to build CLIs for automation scripts.[web:189]  
- Restricting env choices avoids typos (`prod1` etc.).  
- `--dry-run` is common DevOps pattern for non‑destructive previews.

---

## Q18. How do you use Python to tail a log file and act when a pattern appears?

### Typical question
“Write a Python script that follows a log like `tail -f` and triggers something when it sees `ERROR`.”

### Answer – code + explanation

```python
import time

def follow(path: str):
    with open(path, "r") as f:
        f.seek(0, 2)  # go to end of file
        while True:
            line = f.readline()
            if not line:
                time.sleep(0.5)
                continue
            yield line.rstrip("\n")

if __name__ == "__main__":
    log_path = "/var/log/myapp.log"
    for line in follow(log_path):
        if "ERROR" in line:
            print("Found ERROR:", line)
            # Here you could send Slack alert, open ticket, etc.
```

**Key points:**

- Implements `tail -f` behavior in Python, useful when you need programmatic reactions to log events.  
- Easy to extend with regex matching, metrics counters, or integration with alerting APIs.

---

## Q19. How do you combine Python with Git in CI to generate a changelog between two tags?

### Typical question
“Show how you might use Python + `git` to build a simple release note from commit messages.”

### Answer – code + explanation

```python
import subprocess
import sys

def get_commits(from_ref: str, to_ref: str) -> list[str]:
    cmd = ["git", "log", f"{from_ref}..{to_ref}", "--pretty=format:%s"]
    result = subprocess.run(cmd, capture_output=True, text=True, check=True)
    lines = result.stdout.strip().splitlines()
    return lines

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: changelog.py <from_ref> <to_ref>")
        sys.exit(1)
    from_ref, to_ref = sys.argv, sys.argv[4][3]
    commits = get_commits(from_ref, to_ref)
    print("# Changelog")
    for msg in commits:
        print(f"- {msg}")
```

**Key points:**

- Wraps git CLI to get commit summaries between two refs (tags/branches).  
- Outputs markdown bullet list suitable for release notes or PR description.  
- Typical task in release pipelines to auto‑generate changelog sections.

---

## Q20. In an interview, how do you summarize your Python engineering practices for DevOps work?

### Typical question
“Beyond scripts, what practices do you follow to keep Python code production‑grade?”

### Answer – talking points

1. **Structure & packaging**
   - Use:
     - `src/` layout for bigger tools.
     - Virtual environments (`python -m venv .venv`) per project.
   - Properly separate config from code (YAML/JSON/env vars).

2. **Quality**
   - Use:
     - `black` / `isort` for formatting.
     - `flake8`/`pylint` for linting.
     - `pytest` for unit tests of key functions.[web:184][web:188]

3. **Observability**
   - Consistent logging format (JSON or structured) for ingestion into ELK/CloudWatch.  
   - Error handling with clear messages and well‑chosen exit codes.

4. **Security**
   - No hard‑coded secrets; use env vars, Secrets Manager, or KMS.  
   - Validate inputs (CLI args, YAML/JSON) and avoid `eval`/unsafe deserialization.

5. **Maintainability**
   - Small, focused scripts/tools.  
   - Docstrings and README with examples, especially for teammates and future you.

# Python for DevOps – Practical Q&A with Code (Batch 3: Q21–Q30 – boto3 Deep Dive)

## Q21. How do you list all objects in an S3 bucket and download only those with a given prefix?

### Typical question
“Show a Python script that lists S3 objects and downloads only a specific folder/prefix.”

### Answer – code + explanation

```python
import boto3
from pathlib import Path

s3 = boto3.client("s3")

def download_prefix(bucket: str, prefix: str, dest_dir: str):
    paginator = s3.get_paginator("list_objects_v2")
    for page in paginator.paginate(Bucket=bucket, Prefix=prefix):
        for obj in page.get("Contents", []):
            key = obj["Key"]
            rel_path = key[len(prefix):].lstrip("/")
            local_path = Path(dest_dir) / rel_path
            local_path.parent.mkdir(parents=True, exist_ok=True)
            print(f"Downloading s3://{bucket}/{key} -> {local_path}")
            s3.download_file(bucket, key, str(local_path))

if __name__ == "__main__":
    download_prefix("my-bucket-name", "exports/2026-05-26/", "./downloads")
```

**Key points:**

- Uses an S3 paginator to handle large buckets safely.[web:197][web:199]  
- Preserves folder structure under the given prefix when downloading.  
- Typical DevOps usage: backup exports, logs, artifact bundles.

---

## Q22. How do you upload a file to S3 with proper metadata and server‑side encryption?

### Typical question
“Show how to upload a file to S3 with content-type and SSE enabled.”

### Answer – code + explanation

```python
import boto3
from pathlib import Path

s3 = boto3.client("s3")

def upload_file(
    filename: str,
    bucket: str,
    key: str,
    content_type: str = "text/plain",
):
    s3.upload_file(
        filename,
        bucket,
        key,
        ExtraArgs={
            "ContentType": content_type,
            "ServerSideEncryption": "AES256",
        },
    )

if __name__ == "__main__":
    path = "report.txt"
    if Path(path).exists():
        upload_file(path, "my-bucket-name", "reports/report.txt", "text/plain")
```

**Key points:**

- Uses `upload_file` with `ExtraArgs` to set metadata and SSE.[web:197]  
- `ServerSideEncryption: AES256` enables S3‑managed keys (SSE‑S3); can also use `aws:kms` with `SSEKMSKeyId`.  
- This is often required in regulated environments for backups/logs.

---

## Q23. How do you generate a simple S3 “inventory” CSV (bucket, key, size, last_modified)?

### Typical question
“Give a script that inventories all objects and writes a CSV we can use for cost/cleanup.”

### Answer – code + explanation

```python
import csv
import boto3

s3 = boto3.client("s3")

def s3_inventory(bucket: str, out_csv: str):
    paginator = s3.get_paginator("list_objects_v2")
    rows = []

    for page in paginator.paginate(Bucket=bucket):
        for obj in page.get("Contents", []):
            rows.append({
                "Bucket": bucket,
                "Key": obj["Key"],
                "Size": obj["Size"],
                "LastModified": obj["LastModified"].isoformat(),
            })

    with open(out_csv, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["Bucket", "Key", "Size", "LastModified"])
        writer.writeheader()
        writer.writerows(rows)

if __name__ == "__main__":
    s3_inventory("my-bucket-name", "s3-inventory.csv")
```

**Key points:**

- Good example of using boto3 for cost/governance visibility.[web:209]  
- CSV can be sorted/filtered for large objects, old data, or specific prefixes.  
- Interview angle: shows “auditing/cleanup” mindset, not just basic CRUD.

---

## Q24. How do you start/stop an RDS instance with Python (for cost saving)?

### Typical question
“Show a boto3 script to stop dev RDS at night and start in the morning.”

### Answer – code + explanation

```python
import boto3

rds = boto3.client("rds", region_name="ap-south-1")

def stop_rds(db_identifier: str):
    print(f"Stopping RDS instance: {db_identifier}")
    rds.stop_db_instance(DBInstanceIdentifier=db_identifier)

def start_rds(db_identifier: str):
    print(f"Starting RDS instance: {db_identifier}")
    rds.start_db_instance(DBInstanceIdentifier=db_identifier)

if __name__ == "__main__":
    db_id = "my-dev-db"
    # Example: schedule via cron or EventBridge
    stop_rds(db_id)
    # start_rds(db_id)
```

**Key points:**

- Uses `start_db_instance` and `stop_db_instance` for non‑Aurora RDS instances.[web:205][web:210]  
- Common DevOps automation to reduce dev/test cost outside office hours.  
- Combine with tags or config to target the right DBs.

---

## Q25. How do you run a SQL statement against Aurora Serverless or RDS Data API using boto3?

### Typical question
“Show how you’d query an Aurora Serverless cluster via Data API (no direct DB connection).”

### Answer – code + explanation

```python
import boto3

rds_data = boto3.client("rds-data", region_name="ap-south-1")

DB_CLUSTER_ARN = "arn:aws:rds:ap-south-1:123456789012:cluster:my-aurora-cluster"
SECRET_ARN = "arn:aws:secretsmanager:ap-south-1:123456789012:secret:mydb-secret"

def run_query(sql: str):
    resp = rds_data.execute_statement(
        resourceArn=DB_CLUSTER_ARN,
        secretArn=SECRET_ARN,
        database="mydb",
        sql=sql,
    )
    return resp.get("records", [])

if __name__ == "__main__":
    rows = run_query("SELECT now() as ts;")
    print(rows)
```

**Key points:**

- Uses `rds-data` client to run SQL via the RDS Data API.[web:202][web:210]  
- Credentials are taken from Secrets Manager secret referenced by `SECRET_ARN`.  
- Great for Lambda‑based automation where opening traditional DB connections is painful.

---

## Q26. How do you stream CloudWatch Logs (tail) from a log group in Python?

### Typical question
“Write a script that does a live tail of CloudWatch Logs with a filter pattern.”

### Answer – code + explanation

```python
import time
import boto3

logs = boto3.client("logs", region_name="ap-south-1")

def live_tail(log_group: str, filter_pattern: str = ""):
    start_time = int(time.time() - 60) * 1000  # last 1 minute

    while True:
        resp = logs.filter_log_events(
            logGroupName=log_group,
            startTime=start_time,
            filterPattern=filter_pattern,
            interleaved=True,
        )
        events = resp.get("events", [])
        for ev in events:
            ts = ev["timestamp"]
            msg = ev["message"].rstrip()
            print(f"{ts} | {msg}")
            if ts > start_time:
                start_time = ts + 1
        time.sleep(2)

if __name__ == "__main__":
    live_tail("/aws/lambda/my-func", filter_pattern='"ERROR"')
```

**Key points:**

- Uses `filter_log_events` in a loop to simulate `tail -f` with server‑side filter.[web:203][web:206]  
- `start_time` advances so you don’t re‑print old events.  
- Great for debugging Lambda/ECS logs without jumping into console.

---

## Q27. How do you write CloudWatch Logs from a custom Python script (non‑Lambda)?

### Typical question
“Show how a Python script can push logs directly into a CloudWatch Log Group.”

### Answer – code + explanation

```python
import time
import boto3

logs = boto3.client("logs", region_name="ap-south-1")

LOG_GROUP = "/custom/devops-tools"
LOG_STREAM = "script-logs"

def ensure_log_group_stream():
    try:
        logs.create_log_group(logGroupName=LOG_GROUP)
    except logs.exceptions.ResourceAlreadyExistsException:
        pass

    try:
        logs.create_log_stream(logGroupName=LOG_GROUP, logStreamName=LOG_STREAM)
    except logs.exceptions.ResourceAlreadyExistsException:
        pass

def put_log(message: str, sequence_token: str | None = None) -> str:
    ts = int(time.time() * 1000)
    kwargs = {
        "logGroupName": LOG_GROUP,
        "logStreamName": LOG_STREAM,
        "logEvents": [{"timestamp": ts, "message": message}],
    }
    if sequence_token:
        kwargs["sequenceToken"] = sequence_token

    resp = logs.put_log_events(**kwargs)
    return resp.get("nextSequenceToken")

if __name__ == "__main__":
    ensure_log_group_stream()
    token = None
    for i in range(5):
        token = put_log(f"Hello CloudWatch #{i}", sequence_token=token)
        time.sleep(1)
```

**Key points:**

- Creates log group and stream idempotently, then uses `put_log_events`.[web:206]  
- Tracks `sequenceToken` as required by CloudWatch Logs API.  
- Useful for on‑prem or EC2 scripts that must centralize logs.

---

## Q28. How do you snapshot all EBS volumes with a specific tag using Python?

### Typical question
“Show automation that finds EBS volumes by tag and creates snapshots with a description.”

### Answer – code + explanation

```python
import datetime
import boto3

ec2 = boto3.client("ec2", region_name="ap-south-1")

def snapshot_tagged_volumes(tag_key: str, tag_value: str):
    resp = ec2.describe_volumes(
        Filters=[
            {"Name": f"tag:{tag_key}", "Values": [tag_value]},
        ]
    )
    date_str = datetime.datetime.utcnow().strftime("%Y-%m-%d")

    for vol in resp["Volumes"]:
        vol_id = vol["VolumeId"]
        desc = f"Auto snapshot {vol_id} {date_str}"
        print("Creating snapshot:", desc)
        ec2.create_snapshot(
            VolumeId=vol_id,
            Description=desc,
            TagSpecifications=[
                {
                    "ResourceType": "snapshot",
                    "Tags": [
                        {"Key": tag_key, "Value": tag_value},
                        {"Key": "CreatedOn", "Value": date_str},
                    ],
                }
            ],
        )

if __name__ == "__main__":
    snapshot_tagged_volumes("Backup", "Daily")
```

**Key points:**

- Uses tag filters to select which volumes to snapshot.[web:190]  
- Tags snapshots for easier cleanup/reporting.  
- Typical daily backup automation via cron/EventBridge + Lambda.

---

## Q29. How do you generate a simple EC2 “cost‑oriented” report: running instances by type and count?

### Typical question
“Show how you’d use boto3 to help FinOps – e.g., summarise how many t3.large vs m5.xlarge running.”

### Answer – code + explanation

```python
import collections
import boto3

ec2 = boto3.client("ec2", region_name="ap-south-1")

def count_instances_by_type():
    resp = ec2.describe_instances(
        Filters=[{"Name": "instance-state-name", "Values": ["running"]}]
    )
    counter = collections.Counter()
    for r in resp["Reservations"]:
        for inst in r["Instances"]:
            itype = inst["InstanceType"]
            counter[itype] += 1
    return counter

if __name__ == "__main__":
    counts = count_instances_by_type()
    print("Running instances by type:")
    for itype, count in counts.items():
        print(f"{itype}: {count}")
```

**Key points:**

- Simple but powerful: shows where the fleet’s spend is concentrated by instance type.[web:190]  
- Can extend to multi‑region (loop regions) and include `InstanceId`, tags, etc.  
- Great story in interviews around “we wrote small Python tools to assist FinOps/cleanup.”

---

## Q30. In an interview, how do you tie together your boto3 usage story?

### Typical question
“What are some real‑world automations you’ve built with boto3 as a DevOps engineer?”

### Answer – talking points

1. **Visibility & inventory**
   - EC2/S3/RDS inventory scripts (CSV/JSON) used by ops and management.  
   - Tag audits: find untagged resources, wrong env tags, or aged snapshots.

2. **Cost optimization**
   - Start/stop dev EC2 and RDS outside office hours.  
   - Detect and notify on unattached EBS volumes or unused Elastic IPs.

3. **Backup and DR**
   - Automated EBS snapshots by tag and copy to DR region.  
   - S3 object lifecycle checks and archival automation (e.g., Glacier transitions).[web:199][web:209]

4. **Operations & troubleshooting**
   - CloudWatch Logs live tail tools for faster debugging.  
   - Custom scripts to pull metrics or run Logs Insights queries for incidents.[web:203][web:208]

5. **Security & compliance**
   - Scripts to scan SGs for 0.0.0.0/0 on sensitive ports.  
   - IAM policy checks, orphan keys reports, and S3 public access detection.

# Python for DevOps – Practical Q&A with Code (Batch 4: Q31–Q40 – FastAPI for DevOps Tools)

## Q31. How do you build a minimal FastAPI service that lists EC2 instances via an HTTP endpoint?

### Typical question
“Show a small internal API that ops can hit to see EC2 instances, instead of everyone using the AWS console.”

### Answer – code + explanation

```python
from fastapi import FastAPI
import boto3

app = FastAPI()
ec2 = boto3.client("ec2", region_name="ap-south-1")

@app.get("/instances")
def list_instances():
    resp = ec2.describe_instances()
    instances = []
    for r in resp["Reservations"]:
        for inst in r["Instances"]:
            instances.append({
                "InstanceId": inst["InstanceId"],
                "InstanceType": inst["InstanceType"],
                "State": inst["State"]["Name"],
                "PrivateIp": inst.get("PrivateIpAddress"),
                "PublicIp": inst.get("PublicIpAddress"),
            })
    return {"instances": instances}
```

**Key points:**

- Wraps a boto3 call behind an HTTP GET endpoint so anyone with access can query fleet state.  
- Can be fronted by an internal ingress, API gateway, or corporate auth.

---

## Q32. How do you add basic request logging and error handling to a FastAPI DevOps tool?

### Typical question
“FastAPI app is for ops users. How do you ensure all requests and errors are logged?”

### Answer – code + explanation

```python
import logging
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(name)s | %(message)s",
)
logger = logging.getLogger("devops-api")

app = FastAPI()

@app.middleware("http")
async def log_requests(request: Request, call_next):
    logger.info("Request %s %s", request.method, request.url.path)
    response = await call_next(request)
    logger.info("Response %s %s -> %d", request.method, request.url.path, response.status_code)
    return response

@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logger.exception("Unhandled error during %s %s: %s", request.method, request.url.path, exc)
    return JSONResponse(
        status_code=500,
        content={"detail": "Internal server error"},
    )

@app.get("/health")
def health():
    return {"status": "ok"}
```

**Key points:**

- Middleware logs every request and response status for audit and debugging.  
- Global exception handler prevents raw stack traces leaking to users, but logs full details.

---

## Q33. How do you create a FastAPI endpoint that triggers a long‑running job (e.g., snapshot EBS) without blocking?

### Typical question
“User hits an endpoint to start a backup, but the backup is long. How do you design it?”

### Answer – code + explanation

```python
from fastapi import FastAPI, BackgroundTasks
import boto3
import datetime

app = FastAPI()
ec2 = boto3.client("ec2", region_name="ap-south-1")

def snapshot_volume(volume_id: str):
    desc = f"Manual snapshot {volume_id} {datetime.datetime.utcnow().isoformat()}"
    ec2.create_snapshot(VolumeId=volume_id, Description=desc)

@app.post("/snapshot/{volume_id}")
def trigger_snapshot(volume_id: str, background_tasks: BackgroundTasks):
    background_tasks.add_task(snapshot_volume, volume_id)
    return {"status": "started", "volume_id": volume_id}
```

**Key points:**

- Uses FastAPI’s `BackgroundTasks` to run blocking AWS calls after returning HTTP response.  
- Good for “fire‑and‑forget” automation where caller doesn’t need immediate result.

---

## Q34. How do you secure a FastAPI DevOps tool with a simple token (e.g., X-API-Key header)?

### Typical question
“Internal tools still need basic auth; show a light‑weight pattern without full OAuth setup.”

### Answer – code + explanation

```python
import os
from fastapi import FastAPI, Header, HTTPException, status

API_KEY = os.environ.get("DEVOPS_API_KEY", "changeme")

app = FastAPI()

def verify_api_key(api_key: str | None):
    if api_key is None or api_key != API_KEY:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or missing API key",
        )

@app.get("/secure/health")
def secure_health(x_api_key: str | None = Header(default=None)):
    verify_api_key(x_api_key)
    return {"status": "ok"}
```

**Key points:**

- Uses a shared API key via header; real deployments would store key in a secret manager.  
- Simple pattern for internal use where network and IAM controls already exist.

---

## Q35. How do you integrate a FastAPI endpoint with Slack notifications for deployments?

### Typical question
“Expose an endpoint that CI calls after deployment, which then notifies Slack.”

### Answer – code + explanation

```python
import json
import os
import urllib.request

from fastapi import FastAPI

app = FastAPI()
SLACK_WEBHOOK = os.environ.get("SLACK_WEBHOOK_URL", "")

def send_slack(text: str):
    if not SLACK_WEBHOOK:
        return
    data = {"text": text}
    req = urllib.request.Request(
        SLACK_WEBHOOK,
        data=json.dumps(data).encode("utf-8"),
        headers={"Content-Type": "application/json"},
    )
    with urllib.request.urlopen(req) as resp:
        if resp.status != 200:
            raise RuntimeError(f"Slack error: {resp.status}")

@app.post("/notify/deploy")
def notify_deploy(service: str, env: str, version: str):
    msg = f"Service {service} deployed to {env} with version {version}"
    send_slack(msg)
    return {"status": "sent", "message": msg}
```

**Key points:**

- CI job calls `/notify/deploy?service=x&env=y&version=z` (or sends JSON body if you prefer).  
- Endpoint centralizes formatting and delivery of deployment notifications.

---

## Q36. How do you add pydantic models for request/response validation in a DevOps API?

### Typical question
“Show structured validation for a ‘run job’ endpoint so inputs can’t be garbage.”

### Answer – code + explanation

```python
from fastapi import FastAPI
from pydantic import BaseModel, field_validator

app = FastAPI()

class JobRequest(BaseModel):
    env: str
    region: str
    action: str

    @field_validator("env")
    @classmethod
    def env_must_be_valid(cls, v):
        allowed = {"dev", "stage", "prod"}
        if v not in allowed:
            raise ValueError(f"env must be one of {allowed}")
        return v

class JobResponse(BaseModel):
    job_id: str
    status: str

@app.post("/jobs", response_model=JobResponse)
def create_job(req: JobRequest):
    job_id = f"{req.env}-{req.region}-{req.action}"
    return JobResponse(job_id=job_id, status="queued")
```

**Key points:**

- pydantic validates and documents the schema automatically, improving reliability.  
- Validation errors become clear 422 responses; great for CI or other automated clients.

---

## Q37. How do you expose a health endpoint that checks dependencies (e.g., S3 and RDS connectivity)?

### Typical question
“Kubernetes readiness needs more than ‘process is running’. Show dependency checks.”

### Answer – code + explanation

```python
from fastapi import FastAPI, status
from fastapi.responses import JSONResponse
import boto3
from botocore.exceptions import BotoCoreError, ClientError

app = FastAPI()
s3 = boto3.client("s3", region_name="ap-south-1")
rds = boto3.client("rds", region_name="ap-south-1")

@app.get("/ready")
def ready():
    checks = {}
    ok = True

    try:
        s3.list_buckets()
        checks["s3"] = "ok"
    except (BotoCoreError, ClientError):
        checks["s3"] = "error"
        ok = False

    try:
        rds.describe_db_instances(MaxRecords=5)
        checks["rds"] = "ok"
    except (BotoCoreError, ClientError):
        checks["rds"] = "error"
        ok = False

    status_code = status.HTTP_200_OK if ok else status.HTTP_503_SERVICE_UNAVAILABLE
    return JSONResponse(status_code=status_code, content={"checks": checks})
```

**Key points:**

- Readiness endpoint returns 503 if AWS dependencies are unavailable.  
- Kubernetes can use this to avoid routing traffic to a pod that can’t reach AWS.

---

## Q38. How do you schedule periodic tasks in a FastAPI‑based tool (without Celery)?

### Typical question
“You have a small internal service; you want a simple ‘every N seconds’ task.”

### Answer – code + explanation

```python
import asyncio
import logging
from fastapi import FastAPI

logger = logging.getLogger(__name__)
app = FastAPI()

async def periodic_job():
    while True:
        try:
            logger.info("Running periodic job...")
            # do something: cleanup, metrics push, etc.
        except Exception as exc:
            logger.exception("Periodic job failed: %s", exc)
        await asyncio.sleep(60)

@app.on_event("startup")
async def start_periodic():
    asyncio.create_task(periodic_job())

@app.get("/health")
def health():
    return {"status": "ok"}
```

**Key points:**

- Uses `asyncio.create_task` on startup to run a background coroutine.  
- Works for lightweight periodic tasks; heavier workloads should use a separate scheduler or worker.

---

## Q39. How do you containerize a FastAPI DevOps tool for deployment on Kubernetes?

### Typical question
“Give a minimal Dockerfile pattern for FastAPI + uvicorn in production.”

### Answer – code + explanation

```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Non-root user (good practice)
RUN useradd -m appuser
USER appuser

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

**Key points:**

- `requirements.txt` and then code; layer caching speeds rebuilds.  
- Runs as non‑root user, which is often a security requirement in clusters.

---

## Q40. In an interview, how do you explain the value of FastAPI for DevOps and SRE work?

### Typical speaking points

1. **Internal self‑service portals**
   - Wrap complex workflows (backups, deployments, scaling) behind simple HTTP endpoints.  
   - Allow developers or support teams to trigger actions without AWS console access.

2. **Lightweight control planes**
   - FastAPI services that orchestrate AWS/GCP/K8s actions using SDKs and CLIs.  
   - Integrate with Slack, GitHub, and CI jobs via webhooks.

3. **Observability and safety**
   - Centralized logging, validation, and error handling make operations predictable.  
   - Health/readiness endpoints integrate cleanly with Kubernetes and load balancers.

4. **Developer experience**
   - Automatic OpenAPI docs for every endpoint, so teams discover capabilities easily.  
   - Strong typing and models reduce bugs and make refactoring safer.


# Python for DevOps – Practical Q&A with Code (Batch 5: Q41–Q50 – CI/CD & SCM Integration)

## Q41. How do you trigger a Jenkins job from a Python script with parameters?

### Typical question
“Show how you’d start a Jenkins job from Python and pass build parameters.”

### Answer – code + explanation

```python
import os
import requests

JENKINS_URL = os.environ.get("JENKINS_URL")          # e.g. http://jenkins:8080
JOB_NAME = "deploy-service"
USER = os.environ.get("JENKINS_USER")
API_TOKEN = os.environ.get("JENKINS_API_TOKEN")

def trigger_build(env: str, version: str):
    url = f"{JENKINS_URL}/job/{JOB_NAME}/buildWithParameters"
    params = {"ENV": env, "VERSION": version}
    resp = requests.post(url, params=params, auth=(USER, API_TOKEN))
    resp.raise_for_status()
    print("Triggered build, status:", resp.status_code)

if __name__ == "__main__":
    trigger_build("prod", "v1.2.3")
```

**Key points:**

- Uses Jenkins’ remote access API endpoint `buildWithParameters`.[web:212][web:215]  
- Auth is handled via username + API token stored in env vars, not hard‑coded.  
- Very common for promoting builds between environments or triggering from internal tools.

---

## Q42. How do you query Jenkins for the status of the last build of a job using Python?

### Typical question
“After triggering, how do you check if the build succeeded or failed?”

### Answer – code + explanation

```python
import os
import requests

JENKINS_URL = os.environ["JENKINS_URL"]
JOB_NAME = "deploy-service"
USER = os.environ["JENKINS_USER"]
API_TOKEN = os.environ["JENKINS_API_TOKEN"]

def get_last_build_status():
    url = f"{JENKINS_URL}/job/{JOB_NAME}/lastBuild/api/json"
    resp = requests.get(url, auth=(USER, API_TOKEN))
    resp.raise_for_status()
    data = resp.json()
    return {
        "number": data["number"],
        "result": data["result"],   # e.g. SUCCESS, FAILURE, ABORTED
        "url": data["url"],
    }

if __name__ == "__main__":
    info = get_last_build_status()
    print(info)
```

**Key points:**

- Uses Jenkins JSON API to inspect the last build.[web:212][web:215]  
- Result can drive further automation (e.g., only tag release in Git if build success).  
- Good story for integrating Jenkins with external orchestration scripts.

---

## Q43. How do you list GitHub issues for a repo with Python, filtered by label?

### Typical question
“Show how you’d pull DevOps tickets (e.g., infra changes) from GitHub via API.”

### Answer – code + explanation

```python
import os
import requests

GITHUB_TOKEN = os.environ["GITHUB_TOKEN"]
OWNER = "my-org"
REPO = "my-repo"

def list_issues(label: str | None = None):
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/issues"
    headers = {"Authorization": f"Bearer {GITHUB_TOKEN}"}
    params = {"state": "open"}
    if label:
        params["labels"] = label
    resp = requests.get(url, headers=headers, params=params)
    resp.raise_for_status()
    for issue in resp.json():
        print(f"#{issue['number']} {issue['title']} [{issue.get('labels', [])}]")

if __name__ == "__main__":
    list_issues(label="devops")
```

**Key points:**

- Uses Personal Access Token in Authorization header.[web:216][web:219]  
- Useful for building small dashboards or automation (e.g., check if there are open “infra‑change” tickets before deploy).

---

## Q44. How do you trigger a GitHub Actions workflow dispatch via Python?

### Typical question
“From a central orchestrator, you want to kick off a GitHub Actions workflow with inputs.”

### Answer – code + explanation

```python
import os
import requests

GITHUB_TOKEN = os.environ["GITHUB_TOKEN"]
OWNER = "my-org"
REPO = "my-repo"
WORKFLOW_FILE = "deploy.yml"  # .github/workflows/deploy.yml

def dispatch_workflow(ref: str, env: str):
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/actions/workflows/{WORKFLOW_FILE}/dispatches"
    headers = {
        "Authorization": f"Bearer {GITHUB_TOKEN}",
        "Accept": "application/vnd.github+json",
    }
    payload = {
        "ref": ref,  # branch or tag
        "inputs": {
            "environment": env,
        },
    }
    resp = requests.post(url, headers=headers, json=payload)
    resp.raise_for_status()
    print("Workflow dispatched:", resp.status_code)

if __name__ == "__main__":
    dispatch_workflow("main", "prod")
```

**Key points:**

- Calls the GitHub Actions “workflow dispatch” endpoint to run a workflow manually.[web:219][web:222]  
- Inputs must match those defined in the workflow `on: workflow_dispatch: inputs:` section.

---

## Q45. How do you list GitLab pipelines and their statuses using python‑gitlab?

### Typical question
“Give a short Python example that shows GitLab pipelines and indicates failures.”

### Answer – code + explanation

```python
import gitlab
import os

GITLAB_URL = os.environ.get("GITLAB_URL", "https://gitlab.com")
GITLAB_TOKEN = os.environ["GITLAB_TOKEN"]
PROJECT_ID = 123456  # or "group/project"

gl = gitlab.Gitlab(GITLAB_URL, private_token=GITLAB_TOKEN)

def list_pipelines(limit: int = 10):
    project = gl.projects.get(PROJECT_ID)
    pipelines = project.pipelines.list(per_page=limit)
    for p in pipelines:
        print(p.id, p.status, p.ref, p.web_url)

if __name__ == "__main__":
    list_pipelines(10)
```

**Key points:**

- Uses `python-gitlab` library, which wraps GitLab REST API.[web:217][web:223]  
- Handy for building dashboards, internal bots, or cleanup tooling around pipeline history.

---

## Q46. How do you automatically retry a failed GitLab pipeline job using Python?

### Typical question
“Show how to identify failed jobs in a pipeline and retry them programmatically.”

### Answer – code + explanation

```python
import gitlab
import os

GITLAB_URL = os.environ.get("GITLAB_URL", "https://gitlab.com")
GITLAB_TOKEN = os.environ["GITLAB_TOKEN"]
PROJECT_ID = 123456

gl = gitlab.Gitlab(GITLAB_URL, private_token=GITLAB_TOKEN)

def retry_failed_jobs(pipeline_id: int):
    project = gl.projects.get(PROJECT_ID)
    pipeline = project.pipelines.get(pipeline_id)
    jobs = pipeline.jobs.list(all=True)
    for job in jobs:
        if job.status == "failed":
            print("Retrying job:", job.id, job.name)
            job.retry()

if __name__ == "__main__":
    retry_failed_jobs(789012)
```

**Key points:**

- Shows SRE/DevOps automation to reduce manual retries for flaky jobs.[web:217][web:223]  
- You can add filters (only certain stages, only specific tags) before retrying.

---

## Q47. How do you use the Azure DevOps Python API to list builds of a pipeline?

### Typical question
“Give a short example using azure‑devops Python SDK to see build history.”

### Answer – code + explanation

```python
from azure.devops.connection import Connection
from msrest.authentication import BasicAuthentication
import os

ORGANIZATION_URL = os.environ["AZDO_ORG_URL"]  # e.g. https://dev.azure.com/myorg
PROJECT = "my-project"
PIPELINE_DEFINITION_ID = 42

def get_connection():
    token = os.environ["AZDO_PAT"]
    credentials = BasicAuthentication("", token)
    return Connection(base_url=ORGANIZATION_URL, creds=credentials)

def list_builds():
    connection = get_connection()
    build_client = connection.clients.get_build_client()
    builds = build_client.get_builds(project=PROJECT, definitions=[PIPELINE_DEFINITION_ID])
    for b in builds:
        print(b.id, b.status, b.result, b.source_branch)

if __name__ == "__main__":
    list_builds()
```

**Key points:**

- Uses `azure-devops` Python API, which wraps Azure DevOps REST.[web:225]  
- Useful for cross‑platform orchestration or reporting across Jenkins/GitLab/AzDO.

---

## Q48. How do you post a comment into a GitHub PR from a Python script (e.g., with validation results)?

### Typical question
“After running a custom DevOps check, how do you comment the results back on the PR?”

### Answer – code + explanation

```python
import os
import requests

GITHUB_TOKEN = os.environ["GITHUB_TOKEN"]
OWNER = "my-org"
REPO = "my-repo"

def comment_on_pr(pr_number: int, message: str):
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/issues/{pr_number}/comments"
    headers = {
        "Authorization": f"Bearer {GITHUB_TOKEN}",
        "Accept": "application/vnd.github+json",
    }
    payload = {"body": message}
    resp = requests.post(url, headers=headers, json=payload)
    resp.raise_for_status()
    print("Comment posted:", resp.status_code)

if __name__ == "__main__":
    comment_on_pr(123, "Custom validation passed ✅")
```

**Key points:**

- Uses the GitHub Issues comments endpoint (PRs are a type of issue).[web:219][web:222]  
- Great for surfacing custom checks (infra policy, security scans) directly in PR UX.

---

## Q49. How do you design a Python CLI that can be used in CI pipelines to standardize DevOps checks?

### Typical question
“Explain how you’d build a reusable Python CLI used across Jenkins/GitHub/GitLab.”

### Answer – code + explanation

```python
import argparse
import sys

def check_branch_name(branch: str) -> bool:
    # Example policy: branch must start with feature/ or bugfix/
    allowed_prefixes = ("feature/", "bugfix/")
    return branch.startswith(allowed_prefixes)

def main():
    parser = argparse.ArgumentParser(description="DevOps policy checks")
    parser.add_argument("--branch", required=True, help="Branch name to check")
    args = parser.parse_args()

    if not check_branch_name(args.branch):
        print(f"Branch '{args.branch}' does not follow naming convention", file=sys.stderr)
        sys.exit(2)
    print("Branch name OK")

if __name__ == "__main__":
    main()
```

**Key points:**

- Single CLI can be called from Jenkins, GitHub Actions, GitLab CI, or Azure Pipelines.  
- Exit codes drive pipeline decisions; message explains to developer what to fix.

---

## Q50. In an interview, how do you narrate your “Python + CI/CD” story?

### Talking points

1. **Orchestration and glue**
   - Use Python to trigger builds, deployments, and promotions across Jenkins, GitHub Actions, GitLab, and Azure DevOps.[web:214][web:217][web:221][web:225]  
   - Centralize complex flows (multi‑repo, multi‑pipeline) behind scripts or FastAPI services.

2. **Feedback to developers**
   - Scripts that comment on PRs with results of custom checks, infra scans, or cost impact.  
   - Auto‑retry of flaky jobs and summarizing pipeline health in Slack.

3. **Visibility & reporting**
   - Aggregating build data, durations, failure reasons into dashboards.  
   - Cross‑platform reports (e.g., show all failing main‑branch pipelines across systems).

4. **Policy & governance**
   - Branch naming, required labels, tagging policies enforced via Python CLIs in pipelines.  
   - Ensuring compliance while keeping automation code readable and maintainable.
