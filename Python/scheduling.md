# 1. Scheduling Gmail Alert Program Using Cron Job

Suppose your Gmail CPU monitoring script file is:

```text id="jlwm228"
/home/user/cpu_gmail_alert.py
```

---

# Step 1: Open Crontab

```bash id="’wini229"
crontab -e
```

This opens Linux scheduler configuration.

---

# What is Cron?

Cron is Linux job scheduler.

Used to run tasks automatically like:

* Monitoring
* Backups
* Cleanup
* Health checks

---

# Step 2: Add Cron Job

Run every 5 minutes:

```bash id="’wini230"
*/5 * * * * /usr/bin/python3 /home/user/cpu_gmail_alert.py
```

---

# Cron Breakdown

```text id="’wini231"
*/5 * * * *
│   │ │ │ │
│   │ │ │ └── Day of week
│   │ │ └──── Month
│   │ └────── Day
│   └──────── Hour
└──────────── Minute
```

---

# Meaning

```bash id="’wini232"
*/5
```

means:

> Run every 5 minutes

---

# What Happens Internally

Every 5 minutes Linux runs:

```bash id="’wini233"
/usr/bin/python3 /home/user/cpu_gmail_alert.py
```

which:

1. Checks CPU
2. Detects high usage
3. Sends Gmail alert

---

# Better Production Version

```bash id="’wini234"
*/5 * * * * /usr/bin/python3 /home/user/cpu_gmail_alert.py >> /var/log/cpu_alert.log 2>&1
```

---

# Understanding `>>`

```bash id="’wini235"
>>
```

Appends output to log file.

---

# Understanding `2>&1`

| Part   | Meaning                      |
| ------ | ---------------------------- |
| `2`    | stderr (errors)              |
| `1`    | stdout (normal output)       |
| `2>&1` | Send errors also to same log |

---

# View Logs

```bash id="’wini236"
cat /var/log/cpu_alert.log
```

---

# View Existing Cron Jobs

```bash id="’wini237"
crontab -l
```

---

# Remove Cron Jobs

```bash id="’wini238"
crontab -r
```

---

# Interview Explanation

```text id="’wini239"
I use Linux cron scheduler to execute Python monitoring script automatically every 5 minutes.
The script checks CPU usage and sends Gmail alert if threshold exceeds.
```

---

# 2. Scheduling Slack Alert Program Using Python `schedule` Module

Suppose Slack alert script is:

```text id="’wini240"
cpu_slack_alert.py
```

---

# Install Schedule Module

```bash id="’wini241"
pip install schedule
```

---

# Example Scheduling Program

```python id="’wini242"
import schedule
import time

from cpu_slack_alert import check_cpu_usage


# Run every 5 minutes
schedule.every(5).minutes.do(
    check_cpu_usage,
    "web-server-01"
)


print("CPU monitoring started...")


while True:

    # Run scheduled jobs
    schedule.run_pending()

    # Wait 1 second
    time.sleep(1)
```

---

# Step-by-Step Explanation

---

# 1. Import `schedule`

```python id="’wini243"
import schedule
```

Used to schedule tasks in Python.

---

# 2. Import `time`

```python id="’wini244"
import time
```

Used for delays/sleep.

---

# 3. Import Monitoring Function

```python id="’wini245"
from cpu_slack_alert import check_cpu_usage
```

Imports CPU monitoring function from existing script.

---

# 4. Schedule Every 5 Minutes

```python id="’wini246"
schedule.every(5).minutes.do(
    check_cpu_usage,
    "web-server-01"
)
```

Means:

> Run `check_cpu_usage()` every 5 minutes.

---

# 5. Infinite Loop

```python id="’wini247"
while True:
```

Keeps scheduler running continuously.

---

# 6. Run Pending Jobs

```python id="’wini248"
schedule.run_pending()
```

Checks whether scheduled task time has arrived.

---

# 7. Sleep

```python id="’wini249"
time.sleep(1)
```

Waits 1 second before checking again.

Avoids excessive CPU usage.

---

# Internal Flow

```text id="’wini250"
Start scheduler
      ↓
Wait for 5 minutes
      ↓
Run CPU check
      ↓
Send Slack alert if needed
      ↓
Repeat forever
```

---

# Run Program

```bash id="’wini251"
python3 scheduler.py
```

---

# Interview Explanation

```text id="’wini252"
I used Python schedule module to run monitoring task every 5 minutes.
The scheduler continuously checks pending jobs and executes CPU monitoring function automatically.
```

---

# 3. Scheduling Outlook Alert Program Using `while` Loop + `time.sleep()`

This is simplest beginner approach.

---

# Example

```python id="’wini253"
import time

from cpu_outlook_alert import check_cpu_usage


print("CPU monitoring started...")


while True:

    # Check CPU usage
    check_cpu_usage("web-server-01")

    # Wait 300 seconds (5 minutes)
    time.sleep(300)
```

---

# Step-by-Step Explanation

---

# 1. Import `time`

```python id="’wini254"
import time
```

Used for delay/sleep.

---

# 2. Import Monitoring Function

```python id="’wini255"
from cpu_outlook_alert import check_cpu_usage
```

Imports monitoring function.

---

# 3. Infinite Loop

```python id="’wini256"
while True:
```

Runs forever continuously.

---

# 4. Run CPU Check

```python id="’wini257"
check_cpu_usage("web-server-01")
```

Checks CPU usage.

If high:

* Sends Outlook alert

---

# 5. Wait 5 Minutes

```python id="’wini258"
time.sleep(300)
```

Program sleeps for:

```text id="’wini259"
300 seconds = 5 minutes
```

---

# Internal Flow

```text id="’wini260"
Check CPU
    ↓
Send alert if needed
    ↓
Sleep 5 minutes
    ↓
Repeat forever
```

---

# Run Program

```bash id="’wini261"
python3 monitor.py
```

---

# Difference Between All 3 Scheduling Methods

| Method          | Best For                 |
| --------------- | ------------------------ |
| Cron Job        | Production Linux servers |
| schedule module | Python applications      |
| while + sleep   | Simple beginner scripts  |

---

# Production Recommendation

In real DevOps environments:

Most commonly used:

```text id="’wini262"
Cron Job
```

because:

* Reliable
* Lightweight
* Native Linux scheduler
* Survives reboot
* Widely used in production

---

# Final Interview Summary

| Scheduling Type | Explanation                                       |
| --------------- | ------------------------------------------------- |
| Cron            | Linux scheduler used to run scripts automatically |
| schedule module | Python-based scheduler for recurring jobs         |
| while + sleep   | Simple looping scheduler inside Python            |

---

# Best Interview One-Line Answer

```text id="’wini263"
I can schedule monitoring scripts using Linux cron jobs or Python schedule module to run CPU health checks automatically at regular intervals.
```
