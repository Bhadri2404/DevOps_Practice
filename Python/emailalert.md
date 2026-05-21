```python id="yyd5n6"
import os
import psutil
import smtplib

from email.mime.text import MIMEText


# Read Gmail app password from environment variable
EMAIL_PASSWORD = os.getenv("EMAIL_PASSWORD")

# Email details
SENDER_EMAIL = "yourgmail@gmail.com"

RECEIVER_EMAIL = "admin@example.com"


def send_email_alert(server_name, usage):
    """
    Send Gmail alert when CPU usage is high
    """

    # Create email body
    body = (
        f"🚨 High CPU Usage Alert\n\n"
        f"Server: {server_name}\n"
        f"CPU Usage: {usage}%"
    )

    # Create email message object
    message = MIMEText(body)

    # Email subject
    message["Subject"] = "HIGH CPU ALERT"

    # Sender email
    message["From"] = SENDER_EMAIL

    # Receiver email
    message["To"] = RECEIVER_EMAIL

    # Connect to Gmail SMTP server
    server = smtplib.SMTP("smtp.gmail.com", 587)

    # Start secure TLS connection
    server.starttls()

    # Login to Gmail account
    server.login(
        SENDER_EMAIL,
        EMAIL_PASSWORD
    )

    # Send email
    server.send_message(message)

    # Close SMTP connection
    server.quit()

    print("📧 Gmail alert sent successfully")


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

        # Send Gmail alert
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

```python id="jlwm110"
import os
```

Used to access:

* environment variables
* operating system values

Here we use:

```python id="’wini111"
os.getenv()
```

to read password securely.

---

# 2. Import `psutil`

```python id="’wini112"
import psutil
```

Used for:

* CPU monitoring
* Memory monitoring
* Disk monitoring

Here:

```python id="’wini113"
psutil.cpu_percent()
```

checks CPU usage.

---

# 3. Import `smtplib`

```python id="’wini114"
import smtplib
```

Used to send emails using SMTP protocol.

---

# 4. Import `MIMEText`

```python id="’wini115"
from email.mime.text import MIMEText
```

Used to create email body/message.

---

# 5. Read Password Securely

```python id="’wini116"
EMAIL_PASSWORD = os.getenv("EMAIL_PASSWORD")
```

Reads password from Linux environment variable.

---

# Why This is Better?

Instead of:

```python id="’wini117"
EMAIL_PASSWORD = "mypassword"
```

we use:

```python id="’wini118"
os.getenv()
```

because production code should not store passwords directly.

---

# Set Environment Variable

Linux command:

```bash id="’wini119"
export EMAIL_PASSWORD="your_gmail_app_password"
```

---

# 6. Sender Email

```python id="’wini120"
SENDER_EMAIL = "yourgmail@gmail.com"
```

Email account used to send alerts.

---

# 7. Receiver Email

```python id="’wini121"
RECEIVER_EMAIL = "admin@example.com"
```

Admin/team receiving alerts.

---

# 8. Create Email Function

```python id="’wini122"
def send_email_alert(server_name, usage):
```

Function used to send Gmail alert.

---

# 9. Create Email Body

```python id="’wini123"
body = (
    f"🚨 High CPU Usage Alert\n\n"
    f"Server: {server_name}\n"
    f"CPU Usage: {usage}%"
)
```

Creates email content dynamically.

---

# Example Body

```text id="’wini124"
🚨 High CPU Usage Alert

Server: web-server-01
CPU Usage: 92%
```

---

# 10. Create MIME Message

```python id="’wini125"
message = MIMEText(body)
```

Creates email object.

---

# 11. Set Subject

```python id="’wini126"
message["Subject"] = "HIGH CPU ALERT"
```

Email subject line.

---

# 12. Set Sender

```python id="’wini127"
message["From"] = SENDER_EMAIL
```

Shows who sent email.

---

# 13. Set Receiver

```python id="’wini128"
message["To"] = RECEIVER_EMAIL
```

Shows who receives email.

---

# 14. Connect Gmail SMTP Server

```python id="’wini129"
server = smtplib.SMTP("smtp.gmail.com", 587)
```

Connects Python to Gmail mail server.

---

# Understanding `587`

Port used for secure SMTP communication.

---

# 15. Start TLS Encryption

```python id="’wini130"
server.starttls()
```

Encrypts communication securely.

TLS means:

> Transport Layer Security

---

# 16. Login to Gmail

```python id="’wini131"
server.login(
    SENDER_EMAIL,
    EMAIL_PASSWORD
)
```

Authenticates Gmail account.

---

# 17. Send Email

```python id="’wini132"
server.send_message(message)
```

Actually sends email.

---

# 18. Close Connection

```python id="’wini133"
server.quit()
```

Closes SMTP connection properly.

---

# 19. Success Message

```python id="’wini134"
print("📧 Gmail alert sent successfully")
```

Shows email sent successfully.

---

# 20. Create CPU Monitoring Function

```python id="’wini135"
def check_cpu_usage(server_name):
```

Function used to check CPU usage.

---

# 21. Get CPU Usage

```python id="’wini136"
usage = psutil.cpu_percent(interval=1)
```

Measures CPU usage over 1 second.

---

# Example

```python id="’wini137"
usage = 92
```

means:

```text id="’wini138"
CPU is 92% busy
```

---

# 22. Print CPU Usage

```python id="’wini139"
print(f"🖥️ {server_name} — CPU Usage: {usage}%")
```

Example output:

```text id="’wini140"
🖥️ web-server-01 — CPU Usage: 92%
```

---

# 23. Check High CPU

```python id="’wini141"
if usage > 85:
```

If CPU usage crosses 85%,
send alert.

---

# 24. Print Alert

```python id="’wini142"
print(
    f"🚨 ALERT: High CPU usage on {server_name}"
)
```

---

# 25. Send Gmail Alert

```python id="’wini143"
send_email_alert(server_name, usage)
```

Calls Gmail function.

---

# 26. Else Block

```python id="’wini144"
else:
```

Runs when CPU usage is normal.

---

# 27. Normal Status Message

```python id="’wini145"
print("✅ CPU usage is normal")
```

---

# 28. Function Calls

```python id="’wini146"
check_cpu_usage("web-server-01")
```

Checks CPU usage for server label.

---

# Example Output (Normal)

```text id="’wini147"
🖥️ web-server-01 — CPU Usage: 32%
✅ CPU usage is normal
```

---

# Example Output (High CPU)

```text id="’wini148"
🖥️ web-server-01 — CPU Usage: 92%

🚨 ALERT: High CPU usage on web-server-01

📧 Gmail alert sent successfully
```

---

# Example Email Received

## Subject

```text id="’wini149"
HIGH CPU ALERT
```

## Body

```text id="’wini150"
🚨 High CPU Usage Alert

Server: web-server-01
CPU Usage: 92%
```

---

# Interview-Friendly Explanation

You can explain like this:

```text id="’wini151"
This script monitors CPU usage using psutil.
If CPU exceeds threshold, it sends Gmail alert using SMTP.
Password is stored securely using environment variables instead of hardcoding in code.
```
