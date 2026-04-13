
---

# 🔹 SECTION 1: FILE OPERATIONS (DevOps Style – No User Input)

---

## 1️⃣ Read a File

```python
with open("app.log", "r") as f:
    content = f.read()
    print(content)
```

---

## 2️⃣ Write to a File

```python
with open("output.txt", "w") as f:
    f.write("Deployment completed successfully")
```

---

## 3️⃣ Append to Log File

```python
with open("app.log", "a") as f:
    f.write("\nNew log entry added")
```

---

## 4️⃣ Check If File Exists

```python
import os

if os.path.exists("app.log"):
    print("File exists")
else:
    print("File not found")
```

---

## 5️⃣ Delete a File

```python
import os

if os.path.exists("old.log"):
    os.remove("old.log")
    print("File deleted")
```

---

## 6️⃣ Delete Files Older Than 7 Days

```python
import os, time

path = "/var/log/myapp"
now = time.time()

for file in os.listdir(path):
    full_path = os.path.join(path, file)
    if os.path.isfile(full_path):
        if os.stat(full_path).st_mtime < now - 7*86400:
            os.remove(full_path)
            print("Deleted:", file)
```

---

## 7️⃣ Find Files Larger Than 100MB

```python
import os

for root, dirs, files in os.walk("/var/log"):
    for file in files:
        full_path = os.path.join(root, file)
        if os.path.getsize(full_path) > 100*1024*1024:
            print("Large file:", full_path)
```

---

## 8️⃣ Rename File

```python
import os

os.rename("old_config.conf", "new_config.conf")
```

---

## 9️⃣ Copy File

```python
import shutil

shutil.copy("config.conf", "/backup/config.conf")
```

---

## 🔟 Count Lines in Log File

```python
with open("app.log", "r") as f:
    lines = f.readlines()

print("Total lines:", len(lines))
```

---

# 🔹 SECTION 2: BOTO3 (AWS DevOps Programs)

---

## 1️⃣1️⃣ List EC2 Instances

```python
import boto3

ec2 = boto3.client('ec2')
response = ec2.describe_instances()

for r in response['Reservations']:
    for i in r['Instances']:
        print(i['InstanceId'])
```

---

## 1️⃣2️⃣ Start EC2 Instance

```python
ec2.start_instances(InstanceIds=['i-1234567890abcdef0'])
```

---

## 1️⃣3️⃣ Stop EC2 Instance

```python
ec2.stop_instances(InstanceIds=['i-1234567890abcdef0'])
```

---

## 1️⃣4️⃣ Reboot EC2 Instance

```python
ec2.reboot_instances(InstanceIds=['i-1234567890abcdef0'])
```

---

## 1️⃣5️⃣ List S3 Buckets

```python
s3 = boto3.client('s3')
response = s3.list_buckets()

for bucket in response['Buckets']:
    print(bucket['Name'])
```

---

## 1️⃣6️⃣ Upload File to S3

```python
s3.upload_file("backup.zip", "my-bucket", "backup.zip")
```

---

## 1️⃣7️⃣ Download File from S3

```python
s3.download_file("my-bucket", "backup.zip", "downloaded_backup.zip")
```

---

## 1️⃣8️⃣ List Unused EBS Volumes

```python
volumes = ec2.describe_volumes(
    Filters=[{'Name': 'status', 'Values': ['available']}]
)

for v in volumes['Volumes']:
    print("Unused Volume:", v['VolumeId'])
```

---

## 1️⃣9️⃣ Delete Unused EBS Volume

```python
ec2.delete_volume(VolumeId='vol-1234567890abcdef0')
```

---

## 2️⃣0️⃣ Create Snapshot Before Deleting Volume

```python
ec2.create_snapshot(
    VolumeId='vol-1234567890abcdef0',
    Description='Backup before deletion'
)
```

---

# 🔹 SECTION 3: SERVICE MANAGEMENT (Linux DevOps)

---

## 2️⃣1️⃣ Start Service

```python
import os
os.system("systemctl start nginx")
```

---

## 2️⃣2️⃣ Stop Service

```python
os.system("systemctl stop nginx")
```

---

## 2️⃣3️⃣ Restart Service

```python
os.system("systemctl restart nginx")
```

---

## 2️⃣4️⃣ Check Service Status

```python
os.system("systemctl status nginx")
```

---

## 2️⃣5️⃣ Restart If Service Is Not Running

```python
status = os.system("systemctl is-active --quiet nginx")

if status != 0:
    os.system("systemctl restart nginx")
```

---

# 🔹 SECTION 4: BASIC PYTHON INTERVIEW PROGRAMS (With Input)

---

## 2️⃣6️⃣ Palindrome

```python
word = input("Enter a word: ")

if word == word[::-1]:
    print("Palindrome")
else:
    print("Not Palindrome")
```

---

## 2️⃣7️⃣ Factorial

```python
num = int(input("Enter a number: "))

fact = 1
for i in range(1, num+1):
    fact *= i

print("Factorial:", fact)
```

---

## 2️⃣8️⃣ Fibonacci Series

```python
n = int(input("Enter number of terms: "))

a, b = 0, 1

for i in range(n):
    print(a)
    a, b = b, a+b
```

---

## 2️⃣9️⃣ Prime Number

```python
num = int(input("Enter a number: "))

if num > 1:
    for i in range(2, num):
        if num % i == 0:
            print("Not Prime")
            break
    else:
        print("Prime")
else:
    print("Not Prime")
```

---

## 3️⃣0️⃣ Reverse a String

```python
text = input("Enter a string: ")

print("Reversed:", text[::-1])
```

---


