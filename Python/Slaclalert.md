```python id="dq04v6"
import os
import psutil
import requests


# Read Slack webhook URL from environment variable
SLACK_WEBHOOK_URL = os.getenv("SLACK_WEBHOOK_URL")


def send_slack_alert(server_name, usage):
    """
    Send Slack alert when CPU usage is high
    """

    # Create Slack message
    message = {
        "text": (
            f"🚨 HIGH CPU ALERT\n"
            f"Server: {server_name}\n"
            f"CPU Usage: {usage}%"
        )
    }

    # Send message to Slack webhook
    response = requests.post(
        SLACK_WEBHOOK_URL,
        json=message
    )

    # Check response status
    if response.status_code == 200:

        print("📩 Slack alert sent successfully")

    else:

        print("❌ Failed to send Slack alert")


def check_cpu_usage(server_name):
    """
    Check CPU usage of the system
    """

    # Get CPU usage percentage
    usage = psutil.cpu_percent(interval=1)

    print(f"🖥️ {server_name} — CPU Usage: {usage}%")

    # Check if CPU usage is high
    if usage > 85:

        print(
            f"🚨 ALERT: High CPU usage on {server_name}"
        )

        # Send Slack alert
        send_slack_alert(server_name, usage)

    else:

        print("✅ CPU usage is normal")


# Check CPU usage for servers
check_cpu_usage("web-server-01")

check_cpu_usage("db-server-01")

check_cpu_usage("app-server-01")
```

---

# Step-by-Step Explanation

---

# 1. Import `os`

```python id="jlwm152"
import os
```

Used to access:

* environment variables
* operating system values

Here we use:

```python id="’wini153"
os.getenv()
```

to securely read Slack webhook URL.

---

# 2. Import `psutil`

```python id="’wini154"
import psutil
```

Used for system monitoring.

Can monitor:

* CPU
* Memory
* Disk
* Processes
* Network

Here we use:

```python id="’wini155"
psutil.cpu_percent()
```

to check CPU usage.

---

# 3. Import `requests`

```python id="’wini156"
import requests
```

Used to send HTTP requests.

Here we use it to send message to Slack webhook URL.

---

# 4. Read Slack Webhook URL

```python id="’wini157"
SLACK_WEBHOOK_URL = os.getenv("SLACK_WEBHOOK_URL")
```

Reads Slack webhook URL from environment variable.

---

# Why Use Environment Variable?

Instead of:

```python id="’wini158"
SLACK_WEBHOOK_URL = "https://hooks.slack.com/..."
```

we use:

```python id="’wini159"
os.getenv()
```

because production code should not store secrets directly.

---

# Set Environment Variable

Linux command:

```bash id="’wini160"
export SLACK_WEBHOOK_URL="https://hooks.slack.com/services/XXXXX/XXXXX/XXXXX"
```

---

# 5. Create Slack Alert Function

```python id="’wini161"
def send_slack_alert(server_name, usage):
```

Function used to send Slack notification.

---

# 6. Create Slack Message

```python id="’wini162"
message = {
    "text": (
        f"🚨 HIGH CPU ALERT\n"
        f"Server: {server_name}\n"
        f"CPU Usage: {usage}%"
    )
}
```

Creates Slack message payload.

---

# Example Slack Message

```text id="’wini163"
🚨 HIGH CPU ALERT
Server: web-server-01
CPU Usage: 92%
```

---

# Understanding JSON Payload

Slack webhook expects data in JSON format.

Example:

```python id="’wini164"
{
   "text": "message"
}
```

---

# 7. Send HTTP POST Request

```python id="’wini165"
response = requests.post(
    SLACK_WEBHOOK_URL,
    json=message
)
```

Sends message to Slack channel.

---

# Understanding POST Request

POST request means:

> Send data to server.

Flow:

```text id="’wini166"
Python Script
      ↓
Slack Webhook URL
      ↓
Slack Channel
```

---

# 8. Check Response Status

```python id="’wini167"
if response.status_code == 200:
```

Checks if Slack accepted request successfully.

---

# What is Status Code 200?

| Status Code | Meaning      |
| ----------- | ------------ |
| 200         | Success      |
| 404         | Not found    |
| 500         | Server error |

---

# 9. Success Message

```python id="’wini168"
print("📩 Slack alert sent successfully")
```

---

# 10. Failure Message

```python id="’wini169"
print("❌ Failed to send Slack alert")
```

---

# 11. Create CPU Monitoring Function

```python id="’wini170"
def check_cpu_usage(server_name):
```

Function used to monitor CPU usage.

---

# 12. Get CPU Usage

```python id="’wini171"
usage = psutil.cpu_percent(interval=1)
```

Measures CPU usage over 1 second.

---

# Example

```python id="’wini172"
usage = 92
```

means:

```text id="’wini173"
CPU is 92% busy
```

---

# 13. Print CPU Usage

```python id="’wini174"
print(f"🖥️ {server_name} — CPU Usage: {usage}%")
```

Example output:

```text id="’wini175"
🖥️ web-server-01 — CPU Usage: 92%
```

---

# 14. Check High CPU

```python id="’wini176"
if usage > 85:
```

If CPU crosses 85%,
send Slack alert.

---

# 15. Print Alert Message

```python id="’wini177"
print(
    f"🚨 ALERT: High CPU usage on {server_name}"
)
```

---

# 16. Send Slack Alert

```python id="’wini178"
send_slack_alert(server_name, usage)
```

Calls Slack alert function.

---

# 17. Else Block

```python id="’wini179"
else:
```

Runs if CPU usage is normal.

---

# 18. Normal Message

```python id="’wini180"
print("✅ CPU usage is normal")
```

---

# 19. Function Calls

```python id="’wini181"
check_cpu_usage("web-server-01")
```

Checks CPU usage for given server label.

---

# Example Output (Normal)

```text id="’wini182"
🖥️ web-server-01 — CPU Usage: 30%
✅ CPU usage is normal
```

---

# Example Output (High CPU)

```text id="’wini183"
🖥️ web-server-01 — CPU Usage: 92%

🚨 ALERT: High CPU usage on web-server-01

📩 Slack alert sent successfully
```

---

# Example Slack Notification

```text id="’wini184"
🚨 HIGH CPU ALERT
Server: web-server-01
CPU Usage: 92%
```

---

# How to Create Slack Webhook

Go to:

[Slack Incoming Webhooks Documentation](https://api.slack.com/messaging/webhooks?utm_source=chatgpt.com)

Steps:

1. Create Slack App
2. Enable Incoming Webhooks
3. Select Slack channel
4. Copy webhook URL

---

# Install Required Packages

```bash id="’wini185"
pip install psutil requests
```

---

# Interview-Friendly Explanation

You can explain like this:

```text id="’wini186"
This script monitors CPU usage using psutil.
If CPU usage exceeds threshold, it sends Slack alert using webhook URL.
Webhook URL is stored securely using environment variables instead of hardcoding in code.
```
