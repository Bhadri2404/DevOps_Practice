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

# Python Script to List Files and Subfolders with Size

---

# 1. Using `os.system()` + `du -sh` (Best for Folder Sizes)

```python
import os

def file_path(path):

    # Walk through all folders and files recursively
    for root, dirs, files in os.walk(path):

        # Loop through subfolders
        for d in dirs:

            # Create full folder path
            folder_path = os.path.join(root, d)

            # Print folder name
            print(f"\n📁 Folder: {folder_path}")

            # Run Linux command to get folder size
            os.system(f'du -sh "{folder_path}"')

        # Loop through files
        for f in files:

            # Create full file path
            file_path = os.path.join(root, f)

            # Print file name
            print(f"📄 File: {file_path}")

            # Run Linux command to get file size
            os.system(f'du -sh "{file_path}"')


# Call function
file_path("/home/user")
```

---

# Example Output

```bash
📁 Folder: /home/user/docs
120M    /home/user/docs

📁 Folder: /home/user/images
2.1G    /home/user/images

📄 File: /home/user/test.txt
4.0K    /home/user/test.txt

📄 File: /home/user/app.log
12M     /home/user/app.log
```

---

# Explanation

| Code | Meaning |
|---|---|
| `os.walk(path)` | Recursively walks through all folders |
| `root` | Current directory path |
| `dirs` | List of subfolders |
| `files` | List of files |
| `os.path.join()` | Safely joins paths |
| `du -sh` | Shows human-readable disk usage |

---

# Why This is Better

This method gives:

- Actual folder size
- Human-readable output
- Recursive folder calculation
- Real Linux disk usage

---

# 2. Pure Python Method (`os.path.getsize()`)

```python
import os

def file_path(path):

    # Walk through all directories
    for root, dirs, files in os.walk(path):

        # Loop through folders
        for d in dirs:

            # Create full folder path
            folder = os.path.join(root, d)

            # Get folder metadata size
            size = os.path.getsize(folder)

            # Print folder size
            print(f"📁 {folder} -> {size} bytes")

        # Loop through files
        for f in files:

            # Create full file path
            file = os.path.join(root, f)

            # Get file size
            size = os.path.getsize(file)

            # Print file size
            print(f"📄 {file} -> {size} bytes")


# Call function
file_path("/home/user")
```

---

# Example Output

```bash
📁 /home/user/docs -> 4096 bytes
📁 /home/user/images -> 4096 bytes

📄 /home/user/test.txt -> 2048 bytes
📄 /home/user/app.log -> 12582912 bytes
```

---

# Important Difference

| Method | Folder Size Accurate? | Human Readable? | Recommended? |
|---|---|---|---|
| `du -sh` | ✅ Yes | ✅ Yes | ✅ Best |
| `os.path.getsize()` | ❌ No | ❌ No | ⚠️ Only for files |

---

# Production Recommendation

In real DevOps/Linux environments:

```python
os.system('du -sh')
```

or

```python
subprocess.run()
```

is preferred because Linux already calculates directory sizes efficiently.

`os.path.getsize()` only checks metadata size of folders, not actual contents.

