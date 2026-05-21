# CPU Monitoring with Outlook Email Alert

```python id="upg4w9"
import os
import psutil
import smtplib

from email.mime.text import MIMEText


# Read Outlook password from environment variable
EMAIL_PASSWORD = os.getenv("EMAIL_PASSWORD")

# Outlook email details
SENDER_EMAIL = "yourname@outlook.com"

RECEIVER_EMAIL = "admin@example.com"


def send_email_alert(server_name, usage):
    """
    Send Outlook email alert when CPU usage is high
    """

    # Create email body
    body = (
        f"🚨 HIGH CPU ALERT\n\n"
        f"Server: {server_name}\n"
        f"CPU Usage: {usage}%"
    )

    # Create email message
    message = MIMEText(body)

    # Email subject
    message["Subject"] = "HIGH CPU ALERT"

    # Sender email
    message["From"] = SENDER_EMAIL

    # Receiver email
    message["To"] = RECEIVER_EMAIL

    # Connect to Outlook SMTP server
    server = smtplib.SMTP(
        "smtp.office365.com",
        587
    )

    # Start secure TLS connection
    server.starttls()

    # Login to Outlook account
    server.login(
        SENDER_EMAIL,
        EMAIL_PASSWORD
    )

    # Send email
    server.send_message(message)

    # Close SMTP connection
    server.quit()

    print("📧 Outlook email alert sent successfully")


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

        # Send Outlook email alert
        send_email_alert(server_name, usage)

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

```python id="jlwm187"
import os
```

Used to read environment variables securely.

Here we use:

```python id="’wini188"
os.getenv()
```

to read Outlook password.

---

# 2. Import `psutil`

```python id="’wini189"
import psutil
```

Used for system monitoring.

Here it checks CPU usage.

---

# 3. Import `smtplib`

```python id="’wini190"
import smtplib
```

Used to send emails using SMTP protocol.

---

# 4. Import `MIMEText`

```python id="’wini191"
from email.mime.text import MIMEText
```

Used to create email message body.

---

# 5. Read Password Securely

```python id="’wini192"
EMAIL_PASSWORD = os.getenv("EMAIL_PASSWORD")
```

Reads password from environment variable.

---

# Why Use Environment Variable?

Instead of:

```python id="’wini193"
EMAIL_PASSWORD = "mypassword"
```

we use:

```python id="’wini194"
os.getenv()
```

because passwords should not be stored directly in code.

---

# Set Environment Variable

Linux command:

```bash id="’wini195"
export EMAIL_PASSWORD="your_outlook_password"
```

---

# 6. Sender Email

```python id="’wini196"
SENDER_EMAIL = "yourname@outlook.com"
```

Outlook account used to send alerts.

---

# 7. Receiver Email

```python id="’wini197"
RECEIVER_EMAIL = "admin@example.com"
```

Admin/team receiving alerts.

---

# 8. Create Email Alert Function

```python id="’wini198"
def send_email_alert(server_name, usage):
```

Function used to send Outlook email alert.

---

# 9. Create Email Body

```python id="’wini199"
body = (
    f"🚨 HIGH CPU ALERT\n\n"
    f"Server: {server_name}\n"
    f"CPU Usage: {usage}%"
)
```

Creates dynamic email content.

---

# Example Email Body

```text id="’wini200"
🚨 HIGH CPU ALERT

Server: web-server-01
CPU Usage: 92%
```

---

# 10. Create MIME Message

```python id="’wini201"
message = MIMEText(body)
```

Creates email object.

---

# 11. Set Email Subject

```python id="’wini202"
message["Subject"] = "HIGH CPU ALERT"
```

Sets subject line.

---

# 12. Set Sender

```python id="’wini203"
message["From"] = SENDER_EMAIL
```

Shows sender email.

---

# 13. Set Receiver

```python id="’wini204"
message["To"] = RECEIVER_EMAIL
```

Shows receiver email.

---

# 14. Connect Outlook SMTP Server

```python id="’wini205"
server = smtplib.SMTP(
    "smtp.office365.com",
    587
)
```

Connects Python to Outlook SMTP server.

---

# Understanding `"smtp.office365.com"`

This is Microsoft's SMTP mail server.

---

# Understanding Port `587`

Used for secure SMTP communication.

| Port | Purpose     |
| ---- | ----------- |
| 25   | Old SMTP    |
| 587  | Secure SMTP |
| 465  | SSL SMTP    |

---

# 15. Start TLS Encryption

```python id="’wini206"
server.starttls()
```

Encrypts communication securely.

TLS means:

> Transport Layer Security

---

# 16. Login to Outlook

```python id="’wini207"
server.login(
    SENDER_EMAIL,
    EMAIL_PASSWORD
)
```

Authenticates Outlook account.

---

# 17. Send Email

```python id="’wini208"
server.send_message(message)
```

Actually sends email.

---

# 18. Close Connection

```python id="’wini209"
server.quit()
```

Properly closes SMTP connection.

---

# 19. Success Message

```python id="’wini210"
print("📧 Outlook email alert sent successfully")
```

---

# 20. Create CPU Monitoring Function

```python id="’wini211"
def check_cpu_usage(server_name):
```

Function used to monitor CPU usage.

---

# 21. Get CPU Usage

```python id="’wini212"
usage = psutil.cpu_percent(interval=1)
```

Measures CPU usage over 1 second.

---

# Example

```python id="’wini213"
usage = 92
```

means:

```text id="’wini214"
CPU is 92% busy
```

---

# 22. Print CPU Usage

```python id="’wini215"
print(f"🖥️ {server_name} — CPU Usage: {usage}%")
```

Example:

```text id="’wini216"
🖥️ web-server-01 — CPU Usage: 92%
```

---

# 23. Check High CPU

```python id="’wini217"
if usage > 85:
```

If CPU usage crosses threshold,
send alert.

---

# 24. Print Alert

```python id="’wini218"
print(
    f"🚨 ALERT: High CPU usage on {server_name}"
)
```

---

# 25. Send Outlook Email Alert

```python id="’wini219"
send_email_alert(server_name, usage)
```

Calls Outlook alert function.

---

# 26. Else Block

```python id="’wini220"
else:
```

Runs if CPU usage normal.

---

# 27. Normal Message

```python id="’wini221"
print("✅ CPU usage is normal")
```

---

# Example Output (Normal)

```text id="’wini222"
🖥️ web-server-01 — CPU Usage: 35%
✅ CPU usage is normal
```

---

# Example Output (High CPU)

```text id="’wini223"
🖥️ web-server-01 — CPU Usage: 92%

🚨 ALERT: High CPU usage on web-server-01

📧 Outlook email alert sent successfully
```

---

# Example Email Received

## Subject

```text id="’wini224"
HIGH CPU ALERT
```

## Body

```text id="’wini225"
🚨 HIGH CPU ALERT

Server: web-server-01
CPU Usage: 92%
```

---

# Install Required Package

```bash id="’wini226"
pip install psutil
```

---

# Interview-Friendly Explanation

You can explain like this:

```text id="’wini227"
This script monitors CPU usage using psutil.
If CPU usage exceeds threshold, it sends Outlook email alert using SMTP.
Password is stored securely using environment variables instead of hardcoding inside code.
```
