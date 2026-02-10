`bash_scripting_complete_guide.md`

---

````md
# Bash Scripting Complete Guide (Beginner Friendly + DevOps Ready)

This document explains **basic to advanced Bash scripts**.
Each script includes:
- What this script is
- How it works (step by step)
- Simple and clear explanation

---

# BASIC BASH SCRIPTS

---

## 1. Reverse a String

### What is this script?
This script reverses a given string using a Linux command.

### Script
```bash
#!/bin/bash
str="devops"
echo "$str" | rev
````

### How it works

1. `echo "$str"` prints the string
2. `|` sends output to another command
3. `rev` reverses the characters

---

## 2. Reverse a String Without `rev`

### What is this script?

Reverses a string manually using a loop.

### Script

```bash
#!/bin/bash
str="devops"
len=${#str}

for (( i=len-1; i>=0; i-- ))
do
  reverse="$reverse${str:$i:1}"
done

echo "$reverse"
```

### How it works

1. `${#str}` gets string length
2. Loop starts from last index
3. `${str:$i:1}` extracts one character
4. Characters are appended in reverse order

---

## 3. Palindrome Check

### What is this script?

Checks whether a string reads the same forward and backward.

### Script

```bash
#!/bin/bash
read -p "Enter string: " s
rev=$(echo "$s" | rev)

if [ "$s" == "$rev" ]; then
  echo "Palindrome"
else
  echo "Not a Palindrome"
fi
```

### How it works

1. User enters a string
2. String is reversed
3. Original and reversed strings are compared

---

## 4. Factorial of a Number

### What is this script?

Calculates factorial of a number.

### Script

```bash
#!/bin/bash
read -p "Enter number: " n
fact=1

for (( i=1; i<=n; i++ ))
do
  fact=$((fact * i))
done

echo "Factorial: $fact"
```

### How it works

1. Loop multiplies numbers from 1 to n
2. Result stored in `fact`

---

## 5. Fibonacci Series

### What is this script?

Prints Fibonacci series.

### Script

```bash
#!/bin/bash
a=0
b=1

for i in {1..10}
do
  echo -n "$a "
  sum=$((a + b))
  a=$b
  b=$sum
done
```

### How it works

* Each number is sum of previous two numbers

---

## 6. Prime Number Check

### What is this script?

Checks whether a number is prime.

### Script

```bash
#!/bin/bash
read -p "Enter number: " n
flag=0

for (( i=2; i<=n/2; i++ ))
do
  if [ $((n % i)) -eq 0 ]; then
    flag=1
    break
  fi
done

if [ $flag -eq 0 ]; then
  echo "Prime"
else
  echo "Not Prime"
fi
```

---

## 7. Count Vowels

### What is this script?

Counts vowels in a string.

### Script

```bash
#!/bin/bash
read -p "Enter string: " s
count=$(echo "$s" | grep -o -i "[aeiou]" | wc -l)
echo "Vowel count: $count"
```

---

## 8. Sum of Digits

### What is this script?

Calculates sum of digits in a number.

### Script

```bash
#!/bin/bash
read -p "Enter number: " n
sum=0

while [ $n -gt 0 ]
do
  rem=$((n % 10))
  sum=$((sum + rem))
  n=$((n / 10))
done

echo "Sum: $sum"
```

---

## 9. Check File Exists

### What is this script?

Checks whether a file exists.

### Script

```bash
#!/bin/bash
file="/etc/passwd"

if [ -f "$file" ]; then
  echo "File exists"
else
  echo "File not found"
fi
```

---

# DEVOPS BASH SCRIPTS

---

## 10. Disk Usage Check

### What is this script?

Checks disk usage of root partition.

### Script

```bash
#!/bin/bash
df -h /
```

---

## 11. Memory Usage Check

### Script

```bash
#!/bin/bash
free -m
```

---

## 12. Service Health Check

### Script

```bash
#!/bin/bash
if systemctl is-active --quiet nginx; then
  echo "Nginx running"
else
  echo "Nginx stopped"
fi
```

---

## 13. Backup Script

### What is this script?

Creates compressed backup.

### Script

```bash
#!/bin/bash
tar -czf backup_$(date +%F).tar.gz /home/user/data
```

---

## 14. Cron Job Example

### Script

```bash
0 2 * * * /home/user/backup.sh
```

### How it works

* Runs backup daily at 2 AM

---

# ADVANCED BASH SCRIPTING

---

## 15. Bash Function

### What is this?

Reusable block of code.

### Script

```bash
#!/bin/bash

greet() {
  echo "Hello DevOps"
}

greet
```

---

## 16. If-Else Condition

### Script

```bash
#!/bin/bash
read -p "Enter number: " n

if [ $n -gt 10 ]; then
  echo "Greater than 10"
else
  echo "Less than or equal to 10"
fi
```

---

## 17. Case Statement

### What is this?

Used instead of multiple if-else.

### Script

```bash
#!/bin/bash
read -p "Enter option: " opt

case $opt in
  start) echo "Service started" ;;
  stop) echo "Service stopped" ;;
  restart) echo "Service restarted" ;;
  *) echo "Invalid option" ;;
esac
```

---

## 18. Trap Signal Handling

### What is this?

Executes commands when script is interrupted.

### Script

```bash
#!/bin/bash

trap 'echo "Script interrupted"; exit' SIGINT

while true
do
  echo "Running..."
  sleep 2
done
```

### How it works

* `SIGINT` = Ctrl+C
* Trap catches signal and runs cleanup

---

## 19. Script with Functions + Case

### Script

```bash
#!/bin/bash

start() {
  echo "Starting app"
}

stop() {
  echo "Stopping app"
}

case $1 in
  start) start ;;
  stop) stop ;;
  *) echo "Usage: $0 start|stop" ;;
esac
```

---

## 20. Error Handling Using Exit Codes

### Script

```bash
#!/bin/bash
cp file1 file2

if [ $? -ne 0 ]; then
  echo "Copy failed"
  exit 1
fi

echo "Copy successful"
```

---

