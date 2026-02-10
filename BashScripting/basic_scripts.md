

---

````md
# Bash Scripting Complete Guide – Deep Explanation (Beginner Friendly + DevOps Ready)

This document explains **basic to advanced Bash scripts** in a **very detailed and beginner-friendly way**.

For every script, you will learn:
- What the script is
- Why it is used
- Line-by-line explanation
- How Bash syntax works internally

---

# BASIC BASH SCRIPTS

---

## 1. Reverse a String (Using `rev`)

### What is this script?
This script reverses a string using a built-in Linux command.

### Script
```bash
#!/bin/bash
str="devops"
echo "$str" | rev
````

### How it works (line by line)

```bash
#!/bin/bash
```

* Called **shebang**
* Tells Linux to use **bash shell** to run this script

```bash
str="devops"
```

* Creates a variable named `str`
* Stores text `devops`
* No spaces allowed around `=`

```bash
echo "$str"
```

* Prints the value of `str`
* `$str` means “get value of variable”

```bash
|
```

* Pipe operator
* Sends output of left command to right command

```bash
rev
```

* Linux utility
* Reverses characters of input

---

## 2. Reverse a String Without `rev` (IMPORTANT)

### What is this script?

This script reverses a string **manually using a loop**.
This is one of the **most important scripts for understanding Bash loops**.

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

---

### Deep Explanation

```bash
str="devops"
```

* Variable `str` holds the string

```bash
len=${#str}
```

* `${#str}` means **length of string**
* `devops` → length = 6
* So `len=6`

---

### Understanding the `for` loop (VERY IMPORTANT)

```bash
for (( i=len-1; i>=0; i-- ))
```

This is a **C-style for loop**.

#### General syntax

```bash
for (( initialization; condition; increment/decrement ))
```

---

#### Part 1: Initialization

```bash
i=len-1
```

Why `len-1`?

* String index starts from **0**
* For `devops`:

| Character | d | e | v | o | p | s |
| --------- | - | - | - | - | - | - |
| Index     | 0 | 1 | 2 | 3 | 4 | 5 |

* Last index = `length - 1 = 5`

So loop starts from last character.

---

#### Part 2: Condition

```bash
i>=0
```

* Loop runs **as long as `i` is greater than or equal to 0**
* When `i` becomes `-1`, loop stops

---

#### Part 3: Decrement

```bash
i--
```

* Decreases `i` by 1 each iteration
* Makes loop move **backwards**

---

### Loop execution example

| Iteration | i | Character |
| --------- | - | --------- |
| 1         | 5 | s         |
| 2         | 4 | p         |
| 3         | 3 | o         |
| 4         | 2 | v         |
| 5         | 1 | e         |
| 6         | 0 | d         |

---

```bash
reverse="$reverse${str:$i:1}"
```

* `${str:$i:1}` → extract **1 character** from index `i`
* `$reverse` keeps appending characters
* Builds reversed string step-by-step

---

## 3. Palindrome Check

### What is this script?

Checks if a string is same forward and backward.

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

### Explanation

```bash
read -p "Enter string: " s
```

* `read` takes input from user
* `-p` shows prompt
* Stores input in variable `s`

```bash
rev=$(...)
```

* Command substitution
* Output of command is stored in `rev`

```bash
if [ "$s" == "$rev" ]; then
```

* Compares original and reversed string
* `[ ]` is a test command
* Spaces are mandatory

---

## 4. Factorial of a Number

### What is this script?

Calculates factorial of a number.

### Script

```bash
#!/bin/bash
read -p "Enter number: " n
fact=1
```

```bash
for (( i=1; i<=n; i++ ))
```

* Loop starts from 1
* Runs until `i <= n`
* Multiplies each number

```bash
fact=$((fact * i))
```

* `$(( ))` → arithmetic expansion
* Bash cannot do math without it

---

## 5. Fibonacci Series

### Script

```bash
a=0
b=1
```

* First two Fibonacci numbers

```bash
sum=$((a + b))
```

* Next number is sum of previous two

---

## 6. Prime Number Check

### Important line

```bash
if [ $((n % i)) -eq 0 ]; then
```

* `%` → modulus operator
* Checks if number is divisible
* If divisible → not prime

---

## 7. Count Vowels

```bash
grep -o -i "[aeiou]"
```

* `-o` → prints only matched characters
* `-i` → case-insensitive
* `[aeiou]` → vowel pattern

---

## 8. Sum of Digits

```bash
while [ $n -gt 0 ]
```

* Loop runs until number becomes 0

```bash
n=$((n / 10))
```

* Removes last digit

---

## 9. Check File Exists

```bash
if [ -f "$file" ]
```

* `-f` → checks if file exists and is regular file

---

# DEVOPS BASH SCRIPTS

---

## 10. Disk Usage Check

```bash
df -h /
```

* `df` → disk free
* `-h` → human readable
* `/` → root partition

---

## 11. Memory Usage Check

```bash
free -m
```

* Shows memory usage in MB

---

## 12. Service Health Check

```bash
systemctl is-active --quiet nginx
```

* Checks service status silently
* Exit code used by `if`

---

## 13. Backup Script

```bash
tar -czf backup_$(date +%F).tar.gz /home/user/data
```

* `-c` → create
* `-z` → gzip
* `-f` → filename
* `$(date +%F)` → adds date

---

## 14. Cron Job

```bash
0 2 * * *
```

| Field | Meaning |
| ----- | ------- |
| 0     | minute  |
| 2     | hour    |
| *     | day     |
| *     | month   |
| *     | week    |

---

# ADVANCED BASH SCRIPTING

---

## 15. Bash Function

```bash
greet() { ... }
```

* Defines function
* Avoids code repetition

---

## 16. If-Else Condition

```bash
-gt
```

* Numeric comparison operator

---

## 17. Case Statement

```bash
case $opt in
```

* Cleaner alternative to multiple if-else
* Common in service scripts

---

## 18. Trap Signal Handling

```bash
trap '...' SIGINT
```

* Catches Ctrl+C
* Executes cleanup code

---

## 19. Functions + Case Script

```bash
$1
```

* First argument passed to script
* Example: `./script.sh start`

---

## 20. Error Handling Using Exit Codes

```bash
$?
```

* Stores exit code of last command
* `0` → success
* Non-zero → failure

---

# FINAL BEGINNER ADVICE

* Bash is simple but strict
* Spaces, symbols, and order matter
* Practice typing scripts manually

---



Just tell me what you want next 👌
```
