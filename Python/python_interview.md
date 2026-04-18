# 🖥️ System Monitoring Scripts (Python)

These scripts use the `psutil` library to monitor **CPU, Disk, and Memory usage** in real time.

> Install dependency:

```bash
pip install psutil
```

---

# 🧠 CPU Usage Monitoring

```python
import psutil

def check_cpu_usage(server_name):
    """Check real CPU usage of the system"""
    
    usage = psutil.cpu_percent(interval=1)
    
    print(f"🖥️ {server_name} — CPU Usage: {usage}%")
    
    if usage > 85:
        print(f"  🚨 ALERT: High CPU usage on {server_name}! Investigate processes.")
    else:
        print(f"  ✅ CPU usage is normal.")

# Call for multiple servers
check_cpu_usage("web-server-01")
check_cpu_usage("db-server-01")
check_cpu_usage("app-server-01")
```

---

# 💾 Disk Usage Monitoring

```python
import psutil

def check_disk_usage(server_name):
    """Check real disk usage of the system"""
    
    disk = psutil.disk_usage('/')
    usage = disk.percent
    
    print(f"📀 {server_name} — Disk Usage: {usage}%")
    
    if usage > 85:
        print(f"  🚨 ALERT: High disk usage on {server_name}! Cleanup required.")
    else:
        print(f"  ✅ Disk usage is normal.")

# Call for multiple servers
check_disk_usage("web-server-01")
check_disk_usage("db-server-01")
check_disk_usage("app-server-01")
```

---

# 🧠 Memory Usage Monitoring

```python
import psutil

def check_memory_usage(server_name):
    """Check real memory (RAM) usage of the system"""
    
    memory = psutil.virtual_memory()
    usage = memory.percent
    
    print(f"🧠 {server_name} — Memory Usage: {usage}%")
    
    if usage > 85:
        print(f"  🚨 ALERT: High memory usage on {server_name}! Investigate applications.")
    else:
        print(f"  ✅ Memory usage is normal.")

# Call for multiple servers
check_memory_usage("web-server-01")
check_memory_usage("db-server-01")
check_memory_usage("app-server-01")
```

---

