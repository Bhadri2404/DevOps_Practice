
# Python for DevOps — Notes (Deep + Practical)

These notes are designed for a **DevOps Engineer** to use Python for **automation, reliability, CI/CD glue scripts, AWS/K8s tooling, and operational scripting**.

> **How to use this doc:**  
> 1) Read each topic section (What/Why/Use cases/Mistakes/Best practices)  
> 2) Run the examples (each has **expected output** or what to expect)  
> 3) Complete mini-projects and exercises  
> 4) Follow the 30-day plan

---

## Prerequisites & Setup

### Recommended
- Python: **3.11+**
- Use venv
- Install common DevOps libraries:

```bash
python -m venv .venv
source .venv/bin/activate   # Linux/macOS
# Windows PowerShell: .\.venv\Scripts\Activate.ps1

pip install requests pyyaml boto3 paramiko
```

---

## 1) Python Basics (DevOps-focused)

### What it is
Core language features used in automation scripts: data types, loops, functions, exceptions, collections, basic OOP.

### Why DevOps engineers use it
To build scripts that:
- read configs/logs
- call CLI tools/APIs
- make decisions and output reports
- run safely in CI/CD with exit codes

### Real-world use cases
- Parse logs and generate alerts
- Validate deployments before/after release
- Orchestrate `kubectl`, `docker`, `terraform`
- Batch operations in AWS using boto3

### Common mistakes
- Hardcoding values instead of args/config
- No error handling (crashes in production)
- Not using functions (unmaintainable scripts)
- Printing secrets/tokens

### Best practices
- Small scripts, strong input validation
- Use `argparse`, `logging`, clear exit codes
- Prefer pure functions where possible
- Type hints for readability

### 10+ Examples (each explained line-by-line)

#### Example 1 — Variables + f-string
```python
service = "payments"          # (1) store value
status = "OK"                 # (2) store value
print(f"{service}={status}")  # (3) format output
```
Expected output: `payments=OK`

#### Example 2 — List + loop
```python
hosts = ["10.0.0.1", "10.0.0.2"]    # (1) list of hosts
for h in hosts:                     # (2) iterate list
    print("ping", h)                # (3) print action (replace with real ping)
```
Expected output: two lines like `ping 10.0.0.1`

#### Example 3 — Dictionary config lookup with default
```python
sizes = {"dev": "t3.micro", "prod": "m6i.large"}  # (1) config map
env = "prod"                                      # (2) environment
print(sizes.get(env, "t3.micro"))                 # (3) safe lookup with default
```
Expected output: `m6i.large`

#### Example 4 — Condition + fail logic
```python
cpu = 92                   # (1) current CPU %
if cpu > 90:               # (2) threshold check
    print("ALERT: high")   # (3) alert branch
else:
    print("OK")            # (4) normal branch
```
Expected output: `ALERT: high`

#### Example 5 — Function (reusable)
```python
def is_prod(env: str) -> bool:   # (1) define function + type hints
    return env.lower() == "prod" # (2) boolean return

print(is_prod("Prod"))           # (3) call function
```
Expected output: `True`

#### Example 6 — Exceptions (safe scripting)
```python
try:                 # (1) start protected block
    x = 10 / 0       # (2) throws error
except ZeroDivisionError:
    x = 0            # (3) fallback
print(x)             # (4) continue safely
```
Expected output: `0`

#### Example 7 — List comprehension filter
```python
lines = ["INFO ok", "ERROR fail", "WARN slow"]           # (1) sample logs
errors = [l for l in lines if l.startswith("ERROR")]     # (2) filter
print(errors)                                            # (3) output list
```
Expected output: `['ERROR fail']`

#### Example 8 — Sorting by key
```python
procs = [{"name": "nginx", "cpu": 5}, {"name": "java", "cpu": 70}]  # (1) list of dicts
top = sorted(procs, key=lambda p: p["cpu"], reverse=True)[0]        # (2) sort desc and pick first
print(top["name"])                                                  # (3) print top consumer
```
Expected output: `java`

#### Example 9 — Simple retry pattern (no library)
```python
import time                 # (1) delay support

def retry(fn, attempts=3):  # (2) wrapper
    for i in range(attempts):   # (3) attempt loop
        try:
            return fn()         # (4) success -> return result
        except Exception:
            if i == attempts - 1:   # (5) last attempt?
                raise               # (6) re-raise final error
            time.sleep(2 ** i)      # (7) exponential backoff
```
Expected output: depends on `fn()`

#### Example 10 — Simple class for structured data (light OOP)
```python
class Target:                      # (1) class defines structure
    def __init__(self, host, env): # (2) initializer
        self.host = host           # (3) store fields
        self.env = env

t = Target("10.0.0.1", "prod")     # (4) instance
print(t.host, t.env)               # (5) access fields
```
Expected output: `10.0.0.1 prod`

#### Example 11 — Basic set usage (dedupe)
```python
ips = ["1.1.1.1", "1.1.1.1", "2.2.2.2"]  # (1) duplicates
unique = set(ips)                        # (2) dedupe
print(sorted(unique))                    # (3) stable output
```
Expected output: `['1.1.1.1', '2.2.2.2']`

---

## 2) File Handling

### What it is
Reading/writing files: logs, reports, configs, artifacts. Includes JSON/YAML/CSV patterns.

### Why DevOps uses it
- Parse logs and create summaries
- Update configuration files programmatically
- Write reports for CI/CD pipelines

### Real-world use cases
- Count errors in logs
- Rotate old backups/logs
- Generate `.env` or ConfigMap YAML

### Common mistakes
- Reading huge files fully into memory
- Not using `with` (leaks file handles)
- Not handling encoding

### Best practices
- Stream large files line-by-line
- Use atomic writes for config files
- Validate input before overwriting

### 10+ Examples (line-by-line)

#### Example 1 — Write a report
```python
text = "OK: checks passed\n"                 # (1) content
with open("report.txt", "w", encoding="utf-8") as f:  # (2) open write
    f.write(text)                             # (3) write
print("written")                              # (4) confirm
```
Expected output: `written` (creates `report.txt`)

#### Example 2 — Append to a log
```python
from datetime import datetime                 # (1) timestamp
msg = f"{datetime.utcnow().isoformat()}Z done\n"  # (2) line
with open("job.log", "a", encoding="utf-8") as f:   # (3) append mode
    f.write(msg)                             # (4) write line
```
Expected: job.log grows by one line

#### Example 3 — Stream-read and count ERROR
```python
count = 0                                    # (1) counter
with open("app.log", "r", encoding="utf-8") as f:   # (2) open read
    for line in f:                           # (3) stream lines
        if "ERROR" in line:                  # (4) match
            count += 1                       # (5) increment
print(count)                                 # (6) print result
```
Expected: integer count

#### Example 4 — Read last N lines (small files)
```python
N = 10                                       # (1) choose tail lines
with open("app.log", "r", encoding="utf-8") as f:   # (2) open
    lines = f.readlines()                    # (3) read all
print("".join(lines[-N:]))                   # (4) print last N
```
Expected: last 10 lines printed

#### Example 5 — Safe parse `.env` format
```python
cfg = {}                                     # (1) output dict
with open(".env", "r", encoding="utf-8") as f:      # (2) open
    for line in f:                           # (3) iterate
        line = line.strip()                  # (4) remove spaces
        if not line or line.startswith("#"): # (5) skip blank/comments
            continue
        k, v = line.split("=", 1)            # (6) split once
        cfg[k] = v                           # (7) store
print(cfg)                                   # (8) show dict
```
Expected: dict of keys

#### Example 6 — Atomic write to avoid partial config
```python
import os, tempfile                           # (1) helpers
content = "port=8080\n"                      # (2) new file content
fd, tmp = tempfile.mkstemp(prefix="cfg_", text=True)  # (3) temp file
with os.fdopen(fd, "w", encoding="utf-8") as f:       # (4) open fd as file
    f.write(content)                           # (5) write content
os.replace(tmp, "config.txt")                  # (6) atomic replace
```
Expected: `config.txt` updated safely

#### Example 7 — Read JSON config
```python
import json                                   # (1) json module
with open("config.json", "r", encoding="utf-8") as f: # (2) open
    cfg = json.load(f)                        # (3) parse JSON
print(cfg.get("env"))                         # (4) read value
```
Expected: prints env or None

#### Example 8 — Write JSON config prettily
```python
import json
cfg = {"env": "prod", "timeout": 10}          # (1) dict
with open("out.json", "w", encoding="utf-8") as f:    # (2) open write
    json.dump(cfg, f, indent=2)               # (3) write pretty JSON
```
Expected: out.json created

#### Example 9 — Read YAML (K8s manifests)
```python
import yaml                                   # (1) pyyaml
with open("deploy.yaml", "r", encoding="utf-8") as f: # (2) open
    doc = yaml.safe_load(f)                   # (3) parse YAML safely
print(doc["kind"])                            # (4) read field
```
Expected: `Deployment` / `Service` etc.

#### Example 10 — Update YAML image tag (safe)
```python
import yaml
with open("deploy.yaml", "r", encoding="utf-8") as f:
    d = yaml.safe_load(f)                     # (1) load doc
d["spec"]["template"]["spec"]["containers"][0]["image"] = "repo/app:2.0"  # (2) update image
with open("deploy.yaml", "w", encoding="utf-8") as f:
    yaml.safe_dump(d, f, sort_keys=False)     # (3) write back
```
Expected: deploy.yaml updated

#### Example 11 — Discover *.log files recursively
```python
from pathlib import Path                       # (1) path helper
for p in Path(".").rglob("*.log"):             # (2) recursive match
    print(p)                                   # (3) print each file path
```
Expected: list of log files

---

## 3) OS & Linux Automation

### What it is
Work with filesystem and environment: directories, permissions, cleanup tasks (using `os`, `pathlib`, `shutil`).

### Why DevOps uses it
- Housekeeping scripts for builds/logs/backups
- Prepare directories before deployment
- Manage artifacts on servers

### Real-world use cases
- Cleanup old build artifacts
- Create release folders with timestamps
- Validate file permissions for configs

### Common mistakes
- Deleting files without safety checks
- Using raw string paths (bugs across OS)
- Not handling permission errors

### Best practices
- Prefer `pathlib.Path`
- Add `--dry-run` for destructive scripts
- Log every action

### 10+ Examples

#### Example 1 — Create nested directories safely
```python
from pathlib import Path                         # (1) import
Path("/tmp/devops/reports").mkdir(parents=True, exist_ok=True)  # (2) create tree
print("done")                                    # (3) confirm
```
Expected: directory created

#### Example 2 — Read environment variable with default
```python
import os                                        # (1) import
region = os.getenv("AWS_REGION", "ap-south-1")    # (2) get or default
print(region)                                     # (3) print
```
Expected: region string

#### Example 3 — Check if file exists before deleting
```python
from pathlib import Path
p = Path("/tmp/tmp.txt")                          # (1) target path
if p.exists() and p.is_file():                    # (2) safe check
    p.unlink()                                    # (3) delete
    print("deleted")                              # (4) confirm
```
Expected: deleted (if file existed)

#### Example 4 — Move files (artifact management)
```python
import shutil                                     # (1) import
from pathlib import Path
src = Path("dist/app.tar.gz")                     # (2) source artifact
dst = Path("/tmp/releases/app.tar.gz")            # (3) destination
dst.parent.mkdir(parents=True, exist_ok=True)     # (4) ensure folder exists
shutil.copy2(src, dst)                            # (5) copy with metadata
```
Expected: artifact copied

#### Example 5 — Remove files older than N days (preview)
```python
import time
from pathlib import Path
days = 7                                          # (1) retention
cutoff = time.time() - days * 86400               # (2) cutoff timestamp
for p in Path("/var/log").glob("*.log"):          # (3) iterate logs
    if p.stat().st_mtime < cutoff:                # (4) old?
        print("delete candidate:", p)             # (5) preview action
```
Expected: prints candidates

#### Example 6 — Compute directory size
```python
from pathlib import Path
total = 0                                         # (1) bytes
for p in Path(".").rglob("*"):                    # (2) iterate
    if p.is_file():                               # (3) only files
        total += p.stat().st_size                 # (4) add bytes
print(total)                                      # (5) print bytes
```
Expected: total bytes

#### Example 7 — Create timestamped backup folder
```python
from datetime import datetime
from pathlib import Path
stamp = datetime.utcnow().strftime("%Y%m%dT%H%M%SZ")   # (1) UTC stamp
Path(f"/tmp/backup-{stamp}").mkdir()                  # (2) folder
print(stamp)                                          # (3) show
```
Expected: new folder

#### Example 8 — Read Linux load average (Linux only)
```python
import os
print(os.getloadavg())                                # (1) prints (1m,5m,15m)
```
Expected: tuple like `(0.12, 0.15, 0.20)`

#### Example 9 — Expand user home safely
```python
from pathlib import Path
print(Path("~/.ssh").expanduser())                    # (1) resolve home path
```
Expected: `/home/user/.ssh`

#### Example 10 — Check PATH contains a command (simple)
```python
import shutil
print(shutil.which("kubectl"))                        # (1) prints path or None
```
Expected: `/usr/bin/kubectl` or `None`

#### Example 11 — Set permissions (careful)
```python
import os
os.chmod("config.txt", 0o600)                         # (1) owner read/write only
print("secured")                                      # (2) confirm
```
Expected: `secured`

---

## 4) subprocess (Running Linux commands safely)

### What it is
Execute commands (`kubectl`, `docker`, `systemctl`, `terraform`) and capture output/exit codes.

### Why DevOps uses it
Because many operations still happen via CLI; Python becomes the orchestrator.

### Real-world use cases
- `kubectl get pods` and parse output
- `docker ps` checks
- `systemctl status` checks in servers

### Common mistakes
- `shell=True` with untrusted inputs (security risk)
- Ignoring return codes
- Not capturing stderr for debugging

### Best practices
- Use list form: `["kubectl","get","pods"]`
- Use `check=True` where failure should stop pipeline
- Use timeouts for long commands

### 10+ Examples

#### Example 1 — Capture output
```python
import subprocess
res = subprocess.run(["ls", "-l"], capture_output=True, text=True)  # (1) run & capture
print(res.stdout)                                                   # (2) print stdout
```
Expected: directory listing

#### Example 2 — Fail fast
```python
import subprocess
subprocess.run(["false"], check=True)        # (1) raises CalledProcessError
print("never prints")                        # (2) skipped
```
Expected: script stops with error

#### Example 3 — Read return code + stderr
```python
import subprocess
res = subprocess.run(["cat", "missing.txt"], capture_output=True, text=True)  # (1) fail command
print(res.returncode)                                                         # (2) non-zero
print(res.stderr.strip())                                                     # (3) error text
```
Expected: returncode `1` and error message

#### Example 4 — kubectl get pods (requires cluster access)
```python
import subprocess
cmd = ["kubectl", "get", "pods", "-n", "default"]    # (1) build args
res = subprocess.run(cmd, capture_output=True, text=True)  # (2) run
print(res.stdout)                                    # (3) output table
```
Expected: pods list

#### Example 5 — docker ps (requires docker)
```python
import subprocess
res = subprocess.run(["docker", "ps"], capture_output=True, text=True)  # (1) docker ps
print(res.stdout)                                                       # (2) containers
```
Expected: running containers table

#### Example 6 — Timeout
```python
import subprocess
try:
    subprocess.run(["sleep", "10"], timeout=1, check=True)  # (1) timeout quickly
except subprocess.TimeoutExpired:
    print("timed out")                                      # (2) handle
```
Expected: `timed out`

#### Example 7 — Pipe without shell=True
```python
import subprocess
p1 = subprocess.Popen(["ps", "aux"], stdout=subprocess.PIPE, text=True)   # (1) process list
p2 = subprocess.Popen(["grep", "python"], stdin=p1.stdout, stdout=subprocess.PIPE, text=True)  # (2) filter
out, _ = p2.communicate()                                                 # (3) collect output
print(out.splitlines()[:3])                                               # (4) show first lines
```
Expected: some matching lines

#### Example 8 — Stream output live (CI logs)
```python
import subprocess
p = subprocess.Popen(["ping", "-c", "2", "8.8.8.8"], stdout=subprocess.PIPE, text=True)  # (1) start
for line in p.stdout:                               # (2) read stream
    print(line.strip())                             # (3) print live
```
Expected: ping output lines

#### Example 9 — Safer input into args
```python
import subprocess
namespace = "prod"                                  # (1) variable
res = subprocess.run(["kubectl", "get", "svc", "-n", namespace], capture_output=True, text=True)  # (2) safe args
print(res.returncode)                               # (3) status
```
Expected: 0 on success

#### Example 10 — Use check + capture in one
```python
import subprocess
res = subprocess.run(["python", "--version"], check=True, capture_output=True, text=True)  # (1) run python
print(res.stdout or res.stderr)                                                           # (2) version output
```
Expected: Python version

#### Example 11 — Use env variables for command
```python
import subprocess, os
env = os.environ.copy()                            # (1) inherit environment
env["MY_FLAG"] = "1"                               # (2) set env var
subprocess.run(["bash", "-lc", "echo $MY_FLAG"], env=env, check=True)  # (3) run with env
```
Expected: `1`

---

## 5) sys + argparse (Proper CLI scripts)

### What it is
- `sys`: raw args, exit codes
- `argparse`: structured CLI options like a real tool

### Why DevOps uses it
To create scripts runnable in Jenkins/GitHub Actions, cronjobs, and production.

### Real-world use cases
- `check_disk.py --threshold 80 --path /`
- `deploy.py --env prod --image repo/app:2.0`

### Common mistakes
- Not validating user inputs
- Not using non-zero exit codes on failures
- Not providing help text

### Best practices
- Always implement `--help`
- Provide defaults but allow overrides
- Exit code 0 = success, 1+ = failure

### 10+ Examples

#### Example 1 — sys.argv
```python
import sys
print(sys.argv)                     # (1) list: script + args
```
Expected: list printed

#### Example 2 — sys.exit codes
```python
import sys
ok = False                          # (1) result flag
sys.exit(0 if ok else 1)            # (2) exit status for CI
```
Expected: exit code 1

#### Example 3 — argparse required argument
```python
import argparse
p = argparse.ArgumentParser()       # (1) parser
p.add_argument("--env", required=True)  # (2) require env
a = p.parse_args()                  # (3) parse
print(a.env)                        # (4) use
```
Expected: prints env when provided

#### Example 4 — integer threshold
```python
import argparse
p = argparse.ArgumentParser()
p.add_argument("--threshold", type=int, default=80)  # (1) int default
a = p.parse_args()
print(a.threshold)                                   # (2) value
```
Expected: threshold printed

#### Example 5 — choices
```python
import argparse
p = argparse.ArgumentParser()
p.add_argument("--level", choices=["info", "warn", "error"], default="info")  # (1) restrict values
a = p.parse_args()
print(a.level)
```
Expected: chosen level

#### Example 6 — boolean flag
```python
import argparse
p = argparse.ArgumentParser()
p.add_argument("--dry-run", action="store_true")  # (1) true if flag present
a = p.parse_args()
print(a.dry_run)
```
Expected: True/False

#### Example 7 — multiple hosts
```python
import argparse
p = argparse.ArgumentParser()
p.add_argument("--hosts", nargs="+", required=True)  # (1) list of hosts
a = p.parse_args()
print(a.hosts)                                       # (2) list
```
Expected: list printed

#### Example 8 — subcommands
```python
import argparse
p = argparse.ArgumentParser()
sp = p.add_subparsers(dest="cmd", required=True)   # (1) subcommand system
sp.add_parser("status")                            # (2) add status
sp.add_parser("cleanup")                           # (3) add cleanup
a = p.parse_args()
print(a.cmd)                                       # (4) chosen subcommand
```
Expected: status/cleanup printed

#### Example 9 — output JSON for pipelines
```python
import json
data = {"status": "ok", "count": 3}  # (1) result
print(json.dumps(data))             # (2) machine-readable output
```
Expected: JSON string

#### Example 10 — read from stdin (CI pipelines)
```python
import sys
text = sys.stdin.read()             # (1) read piped input
print(len(text))                    # (2) print size
```
Expected: prints length

#### Example 11 — combine args into config dict
```python
import argparse
p = argparse.ArgumentParser()
p.add_argument("--env", required=True)
p.add_argument("--region", default="ap-south-1")
a = p.parse_args()
cfg = {"env": a.env, "region": a.region}     # (1) build config
print(cfg)
```
Expected: dict printed

---

## 6) logging (Production-style)

### What it is
Structured logs with levels (DEBUG/INFO/WARN/ERROR) and handlers (console/file/rotation).

### Why DevOps uses it
- CI/CD debugging
- Observability and incident investigation
- CloudWatch/ELK ingestion

### Common mistakes
- `print()` everywhere
- Logging tokens/secrets
- No timestamps / context

### Best practices
- Use a consistent format
- Use `logging.exception()` on errors
- Make log level configurable via env/args

### 10+ Examples

#### Example 1 — basic config
```python
import logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")  # (1) setup
logging.info("started")                                                                   # (2) info log
```
Expected: timestamped log line

#### Example 2 — logger object
```python
import logging
logger = logging.getLogger("devops")        # (1) named logger
logger.setLevel(logging.INFO)               # (2) level
logger.info("hello")                        # (3) log message
```
Expected: log printed

#### Example 3 — exception with stacktrace
```python
import logging
logging.basicConfig(level=logging.INFO)
try:
    1 / 0                                   # (1) crash
except Exception:
    logging.exception("failed")             # (2) prints stack trace
```
Expected: stack trace output

#### Example 4 — log to file
```python
import logging
logging.basicConfig(filename="script.log", level=logging.INFO)  # (1) file handler
logging.info("file log")                                        # (2) writes to file
```
Expected: script.log created

#### Example 5 — rotate file logs
```python
import logging
from logging.handlers import RotatingFileHandler
logger = logging.getLogger("rot")
logger.setLevel(logging.INFO)
h = RotatingFileHandler("rot.log", maxBytes=100_000, backupCount=3)  # (1) rotation
logger.addHandler(h)                                                  # (2) attach
logger.info("hello")                                                  # (3) write
```
Expected: rot.log updated

#### Example 6 — add context using extra
```python
import logging
logging.basicConfig(level=logging.INFO, format="%(levelname)s service=%(service)s msg=%(message)s")
logger = logging.getLogger("x")
logger.info("up", extra={"service": "billing"})  # (1) add service field
```
Expected: `service=billing` in log

#### Example 7 — level control via env
```python
import logging, os
level = os.getenv("LOG_LEVEL", "INFO")     # (1) read env
logging.basicConfig(level=level)           # (2) set level
logging.info("visible at INFO")            # (3) prints if level allows
```
Expected: depends on LOG_LEVEL

#### Example 8 — avoid logging secrets (mask)
```python
token = "abcd1234SECRET"                   # (1) secret
safe = token[:4] + "...(masked)..."        # (2) mask
print(safe)                                # (3) log safe only
```
Expected: masked string

#### Example 9 — timing operation
```python
import time
start = time.time()                        # (1) start
time.sleep(0.2)                            # (2) simulate
print(round(time.time() - start, 3))       # (3) duration
```
Expected: ~0.2

#### Example 10 — structured JSON log line
```python
import json, time
event = {"ts": int(time.time()), "event": "deploy", "status": "ok"}  # (1) dict
print(json.dumps(event))                                             # (2) JSON log
```
Expected: JSON

#### Example 11 — log to both console and file (simple handler)
```python
import logging
logger = logging.getLogger("multi")
logger.setLevel(logging.INFO)
fh = logging.FileHandler("multi.log")        # (1) file handler
sh = logging.StreamHandler()                 # (2) console handler
logger.addHandler(fh); logger.addHandler(sh) # (3) attach
logger.info("hello")                         # (4) log to both
```
Expected: printed and written

---

## 7) APIs with requests

### What it is
HTTP client library for REST APIs.

### Why DevOps uses it
- Trigger Jenkins builds
- Call GitHub/GitLab APIs
- Hit health endpoints
- Push alerts/incidents (PagerDuty/Slack etc.)

### Common mistakes
- No timeout (scripts hang)
- No retries/backoff
- Not checking status codes

### Best practices
- Always pass `timeout=`
- Use sessions for reuse
- Validate JSON response
- Avoid printing tokens

### 10+ Examples

#### Example 1 — GET with timeout
```python
import requests
r = requests.get("https://api.github.com", timeout=10)   # (1) GET
print(r.status_code)                                     # (2) status
```
Expected: 200

#### Example 2 — parse JSON
```python
import requests
r = requests.get("https://api.github.com", timeout=10)
data = r.json()                                          # (1) parse json
print(list(data.keys())[:5])                             # (2) show keys
```
Expected: list of keys

#### Example 3 — handle non-200
```python
import requests
r = requests.get("https://httpbin.org/status/503", timeout=10)  # (1) 503
if r.status_code != 200:                                        # (2) check
    print("failed", r.status_code)                              # (3) report
```
Expected: `failed 503`

#### Example 4 — POST JSON
```python
import requests
payload = {"name": "demo"}                              # (1) payload
r = requests.post("https://httpbin.org/post", json=payload, timeout=10)  # (2) POST
print(r.json()["json"])                                 # (3) server echoes back
```
Expected: `{'name': 'demo'}`

#### Example 5 — Authorization header pattern
```python
import requests
token = "REDACTED"                                     # (1) token
headers = {"Authorization": f"Bearer {token}"}         # (2) auth header
r = requests.get("https://httpbin.org/headers", headers=headers, timeout=10)  # (3) call
print(r.status_code)                                   # (4) status
```
Expected: 200

#### Example 6 — use Session
```python
import requests
s = requests.Session()                                 # (1) session
for _ in range(3):
    r = s.get("https://httpbin.org/get", timeout=10)   # (2) reuse
    print(r.status_code)                               # (3) print status
```
Expected: three 200s

#### Example 7 — simple retry with backoff
```python
import time, requests
url = "https://httpbin.org/status/500"                 # (1) failing endpoint
for i in range(3):                                     # (2) attempts
    r = requests.get(url, timeout=10)                  # (3) call
    if r.ok:                                           # (4) success?
        break
    time.sleep(2 ** i)                                 # (5) backoff
print("done")                                          # (6) end
```
Expected: `done`

#### Example 8 — download to file
```python
import requests
r = requests.get("https://httpbin.org/bytes/50", timeout=10)  # (1) download bytes
with open("bin.dat", "wb") as f:                               # (2) open binary
    f.write(r.content)                                         # (3) write
print("saved")                                                 # (4) confirm
```
Expected: `saved`

#### Example 9 — health check
```python
import requests
r = requests.get("https://httpbin.org/status/200", timeout=10)  # (1) health
print("healthy" if r.ok else "unhealthy")                        # (2) print status
```
Expected: `healthy`

#### Example 10 — Jenkins trigger pattern
```python
import requests
jenkins_url = "https://jenkins.example.com/job/myjob/build"  # (1) job URL
auth = ("user", "token")                                     # (2) basic auth (API token)
r = requests.post(jenkins_url, auth=auth, timeout=10)         # (3) trigger build
print(r.status_code)                                         # (4) status
```
Expected: 201/200/302 depending on Jenkins

#### Example 11 — GitHub API: list repos (pattern)
```python
import requests
user = "octocat"                                             # (1) user
r = requests.get(f"https://api.github.com/users/{user}/repos", timeout=10)  # (2) call
print(len(r.json()))                                         # (3) count repos
```
Expected: repo count

---

## 8) JSON/YAML (Configs + K8s)

### What it is
- JSON for APIs/config files
- YAML for Kubernetes/Ansible/Helm

### Why DevOps uses it
- Convert config files to data structures
- Update manifests safely
- Generate environment-specific configs

### Common mistakes
- String replace YAML (breaks structure)
- No validation
- Putting secrets in YAML

### Best practices
- Use `yaml.safe_load` / `safe_dump`
- Use templates (Jinja2) for larger setups (optional)
- Validate required keys

### 10+ Examples

#### Example 1 — JSON load
```python
import json
cfg = json.loads('{"env":"prod","timeout":10}')  # (1) parse json string
print(cfg["env"])                                # (2) access field
```
Expected: `prod`

#### Example 2 — JSON dump pretty
```python
import json
print(json.dumps({"a": 1, "b": {"c": 2}}, indent=2))  # (1) pretty json
```
Expected: formatted JSON

#### Example 3 — YAML load from string
```python
import yaml
doc = yaml.safe_load("a: 1\nb: 2\n")  # (1) parse YAML string
print(doc["a"])                         # (2) access key
```
Expected: `1`

#### Example 4 — YAML dump
```python
import yaml
print(yaml.safe_dump({"kind": "ConfigMap", "metadata": {"name": "app"}}, sort_keys=False))  # (1) dump yaml
```
Expected: YAML text

#### Example 5 — Update ConfigMap data
```python
import yaml
cm = {"apiVersion":"v1","kind":"ConfigMap","data":{"MODE":"dev"}}  # (1) sample
cm["data"]["MODE"] = "prod"                                       # (2) update value
print(yaml.safe_dump(cm, sort_keys=False))                         # (3) show output
```
Expected: MODE=prod in YAML

#### Example 6 — Validate required keys
```python
cfg = {"env": "prod"}                   # (1) config
required = ["env", "region"]            # (2) required list
missing = [k for k in required if k not in cfg]  # (3) missing keys
print(missing)                           # (4) report
```
Expected: `['region']`

#### Example 7 — Merge defaults + overrides
```python
defaults = {"timeout": 10, "retries": 3}    # (1) defaults
over = {"timeout": 30}                     # (2) overrides
cfg = {**defaults, **over}                 # (3) merge
print(cfg)                                 # (4) final
```
Expected: timeout 30, retries 3

#### Example 8 — Convert YAML -> JSON
```python
import yaml, json
doc = yaml.safe_load("a: 1\nb: 2\n")      # (1) parse YAML
print(json.dumps(doc))                      # (2) output JSON
```
Expected: `{"a": 1, "b": 2}`

#### Example 9 — Change Deployment replicas
```python
d = {"spec": {"replicas": 2}}   # (1) minimal deployment-like dict
d["spec"]["replicas"] = 5       # (2) update
print(d["spec"]["replicas"])    # (3) verify
```
Expected: `5`

#### Example 10 — Read/Write YAML file safely
```python
import yaml
with open("x.yaml","r",encoding="utf-8") as f:    # (1) open
    doc = yaml.safe_load(f)                        # (2) load
doc["version"] = 2                                 # (3) update
with open("x.yaml","w",encoding="utf-8") as f:     # (4) write
    yaml.safe_dump(doc, f, sort_keys=False)        # (5) dump
```
Expected: x.yaml updated

#### Example 11 — Extract container image from deployment dict
```python
deploy = {"spec":{"template":{"spec":{"containers":[{"image":"repo/app:1.0"}]}}}}  # (1) sample
img = deploy["spec"]["template"]["spec"]["containers"][0]["image"]                  # (2) path access
print(img)                                                                           # (3) print
```
Expected: `repo/app:1.0`

---

## 9) boto3 (AWS Automation)

### What it is
AWS SDK for Python to automate AWS services (EC2, S3, IAM, CloudWatch...).

### Why DevOps uses it
- Automation in CI/CD, Lambda, ops scripts
- Bulk operations (tags, reports, cleanup)
- Replace manual console actions

### Common mistakes
- Hardcoding credentials in code
- Forgetting pagination
- Over-permissioned IAM roles
- Not handling throttling

### Best practices
- Use IAM roles and least privilege
- Use pagination where needed
- Add retries/backoff for throttling
- Keep region configurable

### 10+ Examples (patterns)

> **Note:** These are patterns. To run them you need AWS credentials configured (AWS CLI, env vars, or instance role).

#### Example 1 — Create EC2 client
```python
import boto3
ec2 = boto3.client("ec2", region_name="ap-south-1")  # (1) create EC2 client
print("ready")                                       # (2) confirm
```
Expected: `ready`

#### Example 2 — Describe instances (basic)
```python
import boto3
ec2 = boto3.client("ec2", region_name="ap-south-1")
resp = ec2.describe_instances()                      # (1) call AWS API
print(len(resp["Reservations"]))                     # (2) show reservation count
```
Expected: integer

#### Example 3 — Extract instance IDs
```python
ids = []                                             # (1) list
for r in resp["Reservations"]:                       # (2) iterate reservations
    for i in r["Instances"]:                         # (3) iterate instances
        ids.append(i["InstanceId"])                  # (4) collect ID
print(ids)                                           # (5) print
```
Expected: list of instance IDs

#### Example 4 — Start instance
```python
import boto3
ec2 = boto3.client("ec2", region_name="ap-south-1")
ec2.start_instances(InstanceIds=["i-1234567890abcdef0"])  # (1) start
print("started")                                          # (2) confirm
```
Expected: `started`

#### Example 5 — Stop instance
```python
import boto3
ec2 = boto3.client("ec2", region_name="ap-south-1")
ec2.stop_instances(InstanceIds=["i-1234567890abcdef0"])   # (1) stop
print("stopped")                                          # (2) confirm
```
Expected: `stopped`

#### Example 6 — Waiter for instance running
```python
import boto3
ec2 = boto3.client("ec2", region_name="ap-south-1")
ec2.get_waiter("instance_running").wait(InstanceIds=["i-1234567890abcdef0"])  # (1) wait
print("running")                                                               # (2) done
```
Expected: `running`

#### Example 7 — List S3 buckets
```python
import boto3
s3 = boto3.client("s3")                       # (1) S3 is global-ish
resp = s3.list_buckets()                      # (2) list
print([b["Name"] for b in resp["Buckets"]])   # (3) names
```
Expected: list of bucket names

#### Example 8 — Upload file to S3
```python
import boto3
s3 = boto3.client("s3")
s3.upload_file("report.txt", "my-bucket", "reports/report.txt")  # (1) upload
print("uploaded")
```
Expected: `uploaded`

#### Example 9 — Download from S3
```python
import boto3
s3 = boto3.client("s3")
s3.download_file("my-bucket", "reports/report.txt", "downloaded.txt")  # (1) download
print("downloaded")
```
Expected: `downloaded`

#### Example 10 — CloudWatch metric data (pattern)
```python
import boto3
cw = boto3.client("cloudwatch", region_name="ap-south-1")
print("cloudwatch ready")                           # (1) you would call get_metric_data here
```
Expected: `cloudwatch ready`

#### Example 11 — Tag resources (pattern)
```python
import boto3
ec2 = boto3.client("ec2", region_name="ap-south-1")
ec2.create_tags(Resources=["i-1234567890abcdef0"], Tags=[{"Key":"env","Value":"prod"}])  # (1) tag
print("tagged")
```
Expected: `tagged`

---

## 10) paramiko (SSH Automation)

### What it is
Python SSH client for running remote commands and copying files.

### Why DevOps uses it
- Run checks across servers
- Patch/configure machines (when not using Ansible)
- Pull logs from servers

### Common mistakes
- Using password auth everywhere (prefer keys)
- No timeouts
- Not closing connections

### Best practices
- Use SSH keys
- Use timeouts
- Close client in finally block
- Avoid storing keys in repo

### 10+ Examples (patterns)

> Note: Requires access to an SSH server and credentials.

#### Example 1 — Basic SSH connect + command
```python
import paramiko
client = paramiko.SSHClient()                              # (1) client
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())  # (2) accept host key (demo)
client.connect("1.2.3.4", username="ubuntu", key_filename="~/.ssh/id_rsa", timeout=10)  # (3) connect
stdin, stdout, stderr = client.exec_command("uname -a")     # (4) run command
print(stdout.read().decode())                               # (5) output
client.close()                                              # (6) close
```
Expected: Linux kernel info

#### Example 2 — Check service status remotely
```python
import paramiko
c = paramiko.SSHClient(); c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
c.connect("1.2.3.4", username="ubuntu", key_filename="~/.ssh/id_rsa", timeout=10)
_, out, _ = c.exec_command("systemctl is-active nginx")     # (1) check service
print(out.read().decode().strip())                          # (2) active/inactive
c.close()
```
Expected: `active`

#### Example 3 — Run multiple commands
```python
import paramiko
c = paramiko.SSHClient(); c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
c.connect("1.2.3.4", username="ubuntu", key_filename="~/.ssh/id_rsa", timeout=10)
for cmd in ["uptime", "df -h", "free -m"]:                  # (1) commands list
    _, out, _ = c.exec_command(cmd)                         # (2) run
    print(cmd, "=>", out.read().decode().splitlines()[:1])  # (3) show first line
c.close()
```
Expected: first lines of outputs

#### Example 4 — SFTP download file
```python
import paramiko
c = paramiko.SSHClient(); c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
c.connect("1.2.3.4", username="ubuntu", key_filename="~/.ssh/id_rsa", timeout=10)
sftp = c.open_sftp()                                        # (1) open sftp
sftp.get("/var/log/syslog", "syslog")                        # (2) download
sftp.close(); c.close()                                      # (3) close
print("downloaded")
```
Expected: `downloaded`

#### Example 5 — SFTP upload file
```python
import paramiko
c = paramiko.SSHClient(); c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
c.connect("1.2.3.4", username="ubuntu", key_filename="~/.ssh/id_rsa", timeout=10)
sftp = c.open_sftp()
sftp.put("config.txt", "/tmp/config.txt")                    # (1) upload
sftp.close(); c.close()
print("uploaded")
```
Expected: `uploaded`

#### Example 6 — Capture stderr
```python
import paramiko
c = paramiko.SSHClient(); c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
c.connect("1.2.3.4", username="ubuntu", key_filename="~/.ssh/id_rsa", timeout=10)
_, out, err = c.exec_command("cat /nope")                    # (1) fail
print("stderr:", err.read().decode().strip())                # (2) error
c.close()
```
Expected: error message

#### Example 7 — Timeout idea (command-level)
```python
# Paramiko command timeout handling is usually done with channel timeouts; keep scripts simple and short.
print("Use SSH connect timeout + short commands.")
```
Expected: message

#### Example 8 — Host list loop pattern
```python
hosts = ["1.2.3.4", "5.6.7.8"]                               # (1) servers
print("loop over hosts and run checks")                       # (2) pattern
```
Expected: pattern note

#### Example 9 — Key auth best practice reminder
```python
print("Prefer SSH keys; avoid embedding passwords in scripts.")  # (1) best practice
```
Expected: message

#### Example 10 — Close in finally pattern
```python
import paramiko
c = paramiko.SSHClient(); c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
try:
    c.connect("1.2.3.4", username="ubuntu", key_filename="~/.ssh/id_rsa", timeout=10)  # (1) connect
    _, out, _ = c.exec_command("echo ok")                                              # (2) run
    print(out.read().decode().strip())                                                 # (3) output
finally:
    c.close()                                                                          # (4) always close
```
Expected: `ok`

#### Example 11 — Run kubectl on remote jump host (pattern)
```python
print("Pattern: SSH into jump host -> run kubectl commands -> capture output")
```
Expected: message

---

## 11) datetime + scheduling

### What it is
Work with time: timestamps, UTC vs local, scheduling patterns for periodic checks.

### Why DevOps uses it
- Time-based log filtering
- Naming backup folders
- Scheduled jobs (cron, systemd timers, pipelines)

### Common mistakes
- Using local time in logs (prefer UTC)
- Not handling timezones
- Not formatting timestamps consistently

### Best practices
- Use UTC (`datetime.utcnow()` or timezone-aware objects)
- Use ISO-8601 format
- Use cron/systemd for scheduling; Python for job logic

### 10+ Examples

#### Example 1 — UTC timestamp ISO format
```python
from datetime import datetime
print(datetime.utcnow().isoformat() + "Z")  # (1) UTC ISO timestamp
```
Expected: `2026-...Z`

#### Example 2 — Filename-safe timestamp
```python
from datetime import datetime
stamp = datetime.utcnow().strftime("%Y%m%dT%H%M%SZ")  # (1) safe format
print(stamp)                                          # (2) output
```
Expected: `20260223T...Z`

#### Example 3 — Measure duration
```python
import time
start = time.time()          # (1) start
time.sleep(0.1)              # (2) simulate work
print(time.time() - start)   # (3) seconds
```
Expected: ~0.1

#### Example 4 — Parse datetime
```python
from datetime import datetime
dt = datetime.fromisoformat("2026-02-23T10:00:00")  # (1) parse
print(dt.year)                                       # (2) year
```
Expected: `2026`

#### Example 5 — Compute "older than" check
```python
import time
file_mtime = time.time() - 900     # (1) pretend file modified 15 min ago
is_old = (time.time() - file_mtime) > 600  # (2) older than 10 min?
print(is_old)                       # (3) output
```
Expected: `True`

#### Example 6 — Simple scheduler loop (basic)
```python
import time
for _ in range(3):                  # (1) 3 iterations
    print("check...")               # (2) do job
    time.sleep(5)                   # (3) wait
```
Expected: prints 3 times with delay

#### Example 7 — Recommended: cron + script
```python
print("Use cron: */5 * * * * python check.py")  # (1) best practice note
```
Expected: message

#### Example 8 — Time window filtering pattern
```python
print("Filter logs between start_time and end_time using parsed timestamps.")  # (1) pattern
```
Expected: message

#### Example 9 — Daily backup folder name
```python
from datetime import datetime
folder = "backup-" + datetime.utcnow().strftime("%Y-%m-%d")   # (1) day-based folder
print(folder)                                                 # (2) show
```
Expected: `backup-2026-02-23`

#### Example 10 — Convert seconds to human readable
```python
seconds = 3661                      # (1) total seconds
h = seconds // 3600                 # (2) hours
m = (seconds % 3600) // 60          # (3) minutes
s = seconds % 60                    # (4) seconds
print(h, m, s)                      # (5) output
```
Expected: `1 1 1`

#### Example 11 — Backoff pattern for retries
```python
import time
for i in range(3):                  # (1) 3 attempts
    wait = 2 ** i                   # (2) 1,2,4
    print("wait", wait)             # (3) show
    time.sleep(0.01)                # (4) short sleep demo
```
Expected: wait 1,2,4

---

## 12) Packaging/Testing

### What it is
- Packaging: structure reusable scripts/modules
- Testing: validate automation logic safely before prod

### Why DevOps uses it
- Prevent regressions
- Reliable tooling across teams
- Safer refactors

### Common mistakes
- No tests, production breaks
- Putting everything in one huge script
- Not pinning dependencies

### Best practices
- Use `pytest`
- Use `requirements.txt` or `pyproject.toml`
- Separate “core logic” from “side effects” (API calls)

### 10+ Examples

#### Example 1 — Minimal project structure (pattern)
```python
print("repo/ src/app/ tests/ pyproject.toml")  # (1) recommended layout
```
Expected: message

#### Example 2 — requirements.txt pinning
```python
print("requests==2.32.3  pyyaml==6.0.2  boto3==1.xx")  # (1) pin versions
```
Expected: message

#### Example 3 — Basic unit test idea
```python
def add(a,b): return a+b            # (1) function
print(add(1,2) == 3)                # (2) test expectation
```
Expected: True

#### Example 4 — pytest style (pattern)
```python
print("pytest: def test_add(): assert add(1,2)==3")  # (1) example note
```
Expected: message

#### Example 5 — Separate logic from I/O
```python
def count_errors(lines):                      # (1) pure logic
    return sum(1 for l in lines if "ERROR" in l)  # (2) count
print(count_errors(["OK","ERROR x"]))         # (3) run
```
Expected: 1

#### Example 6 — Entry point script idea
```python
print("Create cli.py that calls functions from core.py")  # (1) pattern
```
Expected: message

#### Example 7 — Use argparse in entry point
```python
print("cli.py uses argparse, core.py has business logic")  # (1) pattern
```
Expected: message

#### Example 8 — Linting reminder
```python
print("Use ruff/flake8 + black formatting to keep scripts clean")  # (1) best practice note
```
Expected: message

#### Example 9 — Type hints
```python
def normalize(s: str) -> str:                # (1) hint input/output
    return s.strip().lower()                 # (2) normalization
print(normalize("  PROD "))                  # (3) run
```
Expected: `prod`

#### Example 10 — Mocking external calls (pattern)
```python
print("In tests, mock requests.get/boto3 client instead of real AWS calls")  # (1) note
```
Expected: message

#### Example 11 — CI test command
```python
print("CI: pip install -r requirements.txt && pytest -q")  # (1) command note
```
Expected: message

---

## 13) DevOps Mini-Projects (5–7) — Step-by-step, Production style

> Each project includes: problem, design steps, code, how to run, expected output, improvements.

### Project 1 — Disk Usage Monitor (Linux) + Exit Code
**Problem:** Check disk usage for a path; if above threshold, print alert and exit non-zero (for CI/cron alerts).

**Step-by-step approach**
1. Take `--path` and `--threshold` from CLI.
2. Use `shutil.disk_usage()` to compute usage %.
3. Print OK or ALERT.
4. Exit code 0 (OK) or 2 (ALERT).

**Code**
```python
import argparse                     # (1) parse CLI args
import shutil                       # (2) disk usage helper
import sys                          # (3) exit codes

p = argparse.ArgumentParser()       # (4) create parser
p.add_argument("--path", default="/")           # (5) path to check
p.add_argument("--threshold", type=int, default=80)  # (6) threshold %
a = p.parse_args()                  # (7) parse args

total, used, free = shutil.disk_usage(a.path)  # (8) get disk stats
pct = int((used / total) * 100)                # (9) compute percent

if pct >= a.threshold:                          # (10) compare
    print(f"ALERT disk={pct}% path={a.path}")   # (11) alert
    sys.exit(2)                                 # (12) fail
else:
    print(f"OK disk={pct}% path={a.path}")      # (13) ok
    sys.exit(0)                                 # (14) success
```

**How to run**
```bash
python disk_check.py --path / --threshold 80
echo $?
```

**Expected output**
- OK: `OK disk=35% path=/` exit code 0  
- Alert: `ALERT disk=92% path=/` exit code 2

**Improvements**
- Add Slack webhook alert
- Add email alert
- Support multiple mount points
- Add logging + JSON output

---

### Project 2 — Log Parser: Count ERROR + Top Error Messages
**Problem:** Parse a log file, count ERROR lines, and output top 5 repeated error messages.

**Step-by-step**
1. Read file line-by-line (memory safe).
2. Select lines containing `"ERROR"`.
3. Normalize error message (strip timestamp if needed).
4. Count occurrences using dict.
5. Print summary.

**Code**
```python
import argparse                                      # (1) CLI
from collections import Counter                      # (2) counting helper

p = argparse.ArgumentParser()                        # (3) parser
p.add_argument("--file", required=True)              # (4) log file
a = p.parse_args()                                   # (5) parse

errors = []                                          # (6) store error lines
with open(a.file, "r", encoding="utf-8") as f:       # (7) open file
    for line in f:                                   # (8) stream lines
        if "ERROR" in line:                          # (9) filter
            msg = line.strip()                       # (10) clean
            errors.append(msg)                       # (11) collect

c = Counter(errors)                                  # (12) count
print("total_errors:", sum(c.values()))              # (13) total
for msg, n in c.most_common(5):                      # (14) top 5
    print(n, msg)                                    # (15) print
```

**How to run**
```bash
python log_parser.py --file app.log
```

**Expected output**
- `total_errors: 12`
- then 5 lines: `3 ERROR timeout ...`

**Improvements**
- Parse JSON logs
- Remove timestamps via regex
- Output CSV report
- Add threshold exit code for alerting

---

### Project 3 — Kubernetes Helper: Restart Deployment (kubectl wrapper)
**Problem:** Restart a deployment (rolling restart) via Python in pipelines.

**Step-by-step**
1. Use argparse for `--namespace` and `--deploy`.
2. Run kubectl command with subprocess (safe list form).
3. Print output and exit appropriately.

**Code**
```python
import argparse
import subprocess
import sys

p = argparse.ArgumentParser()
p.add_argument("--namespace", default="default")         # (1) namespace
p.add_argument("--deploy", required=True)                # (2) deployment name
a = p.parse_args()                                       # (3) parse

cmd = ["kubectl", "rollout", "restart", f"deployment/{a.deploy}", "-n", a.namespace]  # (4) command
res = subprocess.run(cmd, capture_output=True, text=True) # (5) run

print(res.stdout.strip())                                 # (6) print stdout
if res.returncode != 0:                                   # (7) failure?
    print(res.stderr.strip())                             # (8) print stderr
    sys.exit(res.returncode)                              # (9) return same code
sys.exit(0)                                               # (10) success
```

**How to run**
```bash
python k8s_restart.py --namespace prod --deploy myapp
```

**Expected output**
- `deployment.apps/myapp restarted`

**Improvements**
- Add `kubectl rollout status` wait
- Add timeout
- Add structured logging

---

### Project 4 — Jenkins Trigger via REST API (requests)
**Problem:** Trigger a Jenkins job from Python (useful in automation tools).

**Step-by-step**
1. Get `--url`, `--user`, `--token`.
2. POST to `job/<name>/build`.
3. Validate HTTP status.

**Code**
```python
import argparse
import requests
import sys

p = argparse.ArgumentParser()
p.add_argument("--url", required=True)         # (1) job build URL
p.add_argument("--user", required=True)        # (2) username
p.add_argument("--token", required=True)       # (3) api token
a = p.parse_args()                              # (4) parse args

r = requests.post(a.url, auth=(a.user, a.token), timeout=15)  # (5) trigger build
print("status:", r.status_code)                               # (6) show status

if r.status_code not in (200, 201, 302):                      # (7) Jenkins may redirect
    print("failed")                                           # (8) error
    sys.exit(1)                                               # (9) fail
sys.exit(0)                                                   # (10) ok
```

**How to run**
```bash
python jenkins_trigger.py --url "https://jenkins/.../build" --user USER --token TOKEN
```

**Expected**
- `status: 201` (or 302)

**Improvements**
- Support build parameters
- Fetch crumb issuer if enabled
- Add retry/backoff

---

### Project 5 — AWS EC2: List Instances + Filter by Tag
**Problem:** List running instances filtered by tag (env=prod).

**Step-by-step**
1. Get region + tag from args.
2. Call describe_instances with filters.
3. Print instance id + state + name tag.

**Code**
```python
import argparse
import boto3

p = argparse.ArgumentParser()
p.add_argument("--region", default="ap-south-1")         # (1) region
p.add_argument("--tag-key", default="env")               # (2) tag key
p.add_argument("--tag-val", default="prod")              # (3) tag value
a = p.parse_args()                                       # (4) parse

ec2 = boto3.client("ec2", region_name=a.region)          # (5) client
filters = [                                              # (6) filters list
    {"Name": f"tag:{a.tag_key}", "Values": [a.tag_val]},
    {"Name": "instance-state-name", "Values": ["running"]},
]
resp = ec2.describe_instances(Filters=filters)           # (7) API call

for r in resp["Reservations"]:                           # (8) reservations
    for i in r["Instances"]:                             # (9) instances
        iid = i["InstanceId"]                            # (10) id
        state = i["State"]["Name"]                       # (11) state
        name = next((t["Value"] for t in i.get("Tags", []) if t["Key"] == "Name"), "")  # (12) name tag
        print(iid, state, name)                          # (13) print
```
**How to run**
```bash
python ec2_list.py --region ap-south-1 --tag-key env --tag-val prod
```

**Expected output**
- lines like: `i-0abcd running myserver-1`

**Improvements**
- Handle pagination
- Output JSON for dashboards
- Add start/stop options

---

### Project 6 — Config Updater: Update YAML image tag (Release automation)
**Problem:** Update a Kubernetes Deployment YAML image version automatically during release.

**Step-by-step**
1. Read YAML file
2. Update `containers[0].image`
3. Write YAML back safely
4. Print changed value

**Code**
```python
import argparse
import yaml

p = argparse.ArgumentParser()
p.add_argument("--file", required=True)                 # (1) YAML path
p.add_argument("--image", required=True)                # (2) new image
a = p.parse_args()                                      # (3) parse args

with open(a.file, "r", encoding="utf-8") as f:          # (4) open read
    d = yaml.safe_load(f)                               # (5) parse YAML

old = d["spec"]["template"]["spec"]["containers"][0]["image"]  # (6) old image
d["spec"]["template"]["spec"]["containers"][0]["image"] = a.image  # (7) update

with open(a.file, "w", encoding="utf-8") as f:          # (8) open write
    yaml.safe_dump(d, f, sort_keys=False)               # (9) write YAML

print("old:", old)                                      # (10) show old
print("new:", a.image)                                  # (11) show new
```
**How to run**
```bash
python update_image.py --file deploy.yaml --image repo/app:2.0
```

**Expected output**
- prints old and new image tags

**Improvements**
- Update all containers
- Validate YAML schema
- Create backup file before writing

---

### Project 7 — Service Health Check + JSON output (CI-ready)
**Problem:** Ping a health endpoint; output JSON and exit non-zero on failure.

**Step-by-step**
1. Take `--url`
2. GET with timeout
3. If not OK, exit 2
4. Print JSON result

**Code**
```python
import argparse
import json
import requests
import sys
import time

p = argparse.ArgumentParser()
p.add_argument("--url", required=True)                 # (1) health URL
a = p.parse_args()                                     # (2) parse args

ts = int(time.time())                                  # (3) timestamp
try:
    r = requests.get(a.url, timeout=10)                # (4) call
    ok = r.ok                                          # (5) True if 2xx/3xx
    code = r.status_code                               # (6) status code
except Exception as e:
    ok = False                                         # (7) failure
    code = None                                        # (8) unknown
    err = str(e)                                       # (9) error text
else:
    err = None                                         # (10) no error

out = {"ts": ts, "url": a.url, "ok": ok, "status": code, "error": err}  # (11) result dict
print(json.dumps(out))                                  # (12) JSON output
sys.exit(0 if ok else 2)                                # (13) exit code
```
**How to run**
```bash
python health_check.py --url https://httpbin.org/status/200
echo $?
```

**Expected output**
- JSON line and exit 0 on success; exit 2 on failure

**Improvements**
- Add retries/backoff
- Add latency measurement
- Send Slack alert if failure

---

## 14) Practice Exercises (30+)

1. Count number of lines in a file.
2. Count ERROR and WARN occurrences in a log file.
3. Extract unique IPs from access logs.
4. Build a CLI: `--env`, `--region`, print config.
5. Write a script to rotate logs (`app.log` -> `app.log.1`).
6. Implement `--dry-run` cleanup script that deletes files older than N days.
7. Build a “tail -f” style log watcher in Python.
8. Call a public API and print JSON keys.
9. Retry API call 5 times with exponential backoff.
10. Parse JSON file and validate required keys.
11. Load YAML and update replicas count.
12. Load YAML and update multiple container images.
13. Write a script that checks if a Linux service is active (subprocess + systemctl).
14. Write a script that checks docker container count.
15. Write a script that checks kubectl context and namespace.
16. Write a script that prints top 5 largest files in a directory.
17. Write a script to zip a folder (shutil.make_archive).
18. Write a script that uploads a file to S3.
19. Write a script that lists EC2 instances and prints Name tag.
20. Write a script that starts/stops EC2 by tag.
21. Write a script that creates S3 bucket if missing.
22. Write a script that sends Slack message via webhook (requests).
23. Write a script that checks CPU usage (use psutil if allowed).
24. Write a script that checks memory usage from `/proc/meminfo`.
25. Write a script that checks free disk and exits non-zero if low.
26. Write a script that runs a command and prints stderr on failure.
27. Write a script that writes JSON output for CI.
28. Write a script that reads stdin and processes it.
29. Write a script that copies files matching pattern to backup folder.
30. Build a script to validate Kubernetes YAML structure.
31. Build a script to generate ConfigMap YAML from `.env`.
32. Build a script to compare two config files and show differences.
33. Build a script to check HTTPS certificate expiry (advanced).

---

## 15) Interview Q&A (20)

1. Why use `subprocess.run([...])` instead of `shell=True`?
2. How do you ensure scripts fail correctly in CI/CD?
3. Difference between `print()` and `logging` in production scripts?
4. How do you parse large log files safely?
5. How do you handle retries for flaky APIs?
6. Why always set `timeout` in `requests`?
7. How do you securely handle AWS credentials in Python?
8. What is pagination in boto3 and why does it matter?
9. Explain `argparse` benefits in automation scripts.
10. What are exit codes and why do they matter in Jenkins?
11. How to update YAML safely without string replacement?
12. How do you prevent partial writes when writing config files?
13. How do you capture stdout/stderr of a command?
14. How to stream command output live in CI logs?
15. Difference between client and resource in boto3?
16. What are waiters in boto3?
17. How would you build a health check script for microservices?
18. How would you structure Python code for maintainability?
19. How do you avoid logging secrets?
20. How would you deploy this script via cron/systemd timers?

---

## 16) 30-Day Roadmap (DevOps Python)

### Week 1 — Core Python for scripting
Day 1-2: data types, loops, dict/list/set  
Day 3: functions, exceptions  
Day 4: file reading/writing (logs)  
Day 5: list comprehension, sorting, Counter  
Day 6: small scripts (log count, config parse)  
Day 7: review + mini exercise set

### Week 2 — OS automation + subprocess
Day 8: pathlib, shutil, permissions  
Day 9: cleanup scripts + dry-run mode  
Day 10: subprocess basics + return codes  
Day 11: kubectl/docker/systemctl wrappers  
Day 12: timeouts + streaming output  
Day 13: build Disk Monitor project  
Day 14: review + refactor with functions/logging

### Week 3 — APIs + JSON/YAML + logging
Day 15: requests GET/POST, timeouts  
Day 16: sessions + retries/backoff  
Day 17: logging best practices + file rotation  
Day 18: JSON + YAML parsing and validation  
Day 19: YAML updater project (image tag)  
Day 20: health check project output JSON  
Day 21: review + add argparse everywhere

### Week 4 — AWS + SSH + packaging/testing
Day 22: boto3 basics (clients, describe)  
Day 23: EC2 list/filter by tag project  
Day 24: S3 upload/download automation  
Day 25: waiters + tagging + error handling  
Day 26: paramiko basics + service checks  
Day 27: structure code into modules (core + cli)  
Day 28: write a few tests for core functions  
Day 29: integrate into CI (GitHub Actions/Jenkins)  
Day 30: polish + build a “DevOps Toolkit” repo

---

## Quick “Go-To Modules” Cheat Sheet
- **os/pathlib/shutil**: filesystem + env + copy/move
- **subprocess**: run CLI tools safely
- **sys/argparse**: CLI args + exit codes
- **logging**: production logs
- **requests**: REST APIs (Jenkins/GitHub/health)
- **json/yaml**: config + manifests
- **boto3**: AWS automation
- **paramiko**: SSH automation
- **datetime/time**: timestamps + schedules

---

### End of Notes
