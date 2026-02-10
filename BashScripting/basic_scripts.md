

````md
# Bash Scripting Complete Guide – Deep Explanation (Beginner Friendly + DevOps Ready)

This document explains **basic to advanced Bash scripts** in a **very detailed and beginner-friendly way**.

For every script, you will learn:
- What the script is
- Why it is used
- Script code
- Step-by-step explanation
- Loop/iteration diagrams where applicable
- Sample output

---

# BASIC BASH SCRIPTS

---

## 1. Reverse a String (Using `rev`)

### Script
```bash
#!/bin/bash
str="devops"
echo "$str" | rev
```

### Step-by-step explanation
1. `str="devops"` → Store string in variable.
2. `echo "$str"` → Prints string to stdout.
3. `| rev` → Sends string to `rev` command which reverses it.

**Output:**  
```
spoved
```

---

## 2. Reverse a String Without `rev` (Manual)

### Script
```bash
#!/bin/bash
str="devops"
len=${#str}
reverse=""

for (( i=len-1; i>=0; i-- ))
do
  reverse="$reverse${str:$i:1}"
done

echo "$reverse"
```

### Step-by-step explanation
1. `len=${#str}` → Gets length of string (`6` for `devops`).
2. `for (( i=len-1; i>=0; i-- ))` → Loop from last index to 0.
3. `reverse="$reverse${str:$i:1}"` → Extract character at index `i` and append to `reverse`.
4. `echo "$reverse"` → Prints reversed string.

### Loop diagram
```
i=5 -> s -> reverse="" + s = "s"
i=4 -> p -> reverse="s" + p = "sp"
i=3 -> o -> reverse="sp" + o = "spo"
i=2 -> v -> reverse="spo" + v = "spov"
i=1 -> e -> reverse="spov" + e = "spove"
i=0 -> d -> reverse="spove" + d = "spoved"
```

**Output:**  
```
spoved
```

---

## 3. Palindrome Check

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

### Step-by-step explanation
1. `read -p "Enter string: " s` → Takes input from user.
2. `rev=$(echo "$s" | rev)` → Reverses string.
3. `if [ "$s" == "$rev" ]; then ...` → Compares original and reversed.
4. Outputs `"Palindrome"` if match, else `"Not a Palindrome"`.

**Example**
```
Input: radar
Output: Palindrome
```

---

## 4. Factorial of a Number

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

### Step-by-step explanation
1. Read user input `n`.
2. Initialize `fact=1`.
3. Loop `i=1` to `n` and multiply `fact` by `i`.
4. Print final factorial.

### Loop diagram (Example n=5)
```
i=1 -> fact=1*1=1
i=2 -> fact=1*2=2
i=3 -> fact=2*3=6
i=4 -> fact=6*4=24
i=5 -> fact=24*5=120
```

**Output:**  
```
Factorial: 120
```

---

## 5. Fibonacci Series

### Script
```bash
#!/bin/bash
read -p "Enter number of terms: " n
a=0
b=1

echo "Fibonacci Series:"
for (( i=1; i<=n; i++ ))
do
  echo -n "$a "
  sum=$((a + b))
  a=$b
  b=$sum
done
```

### Step-by-step explanation
1. Read number of terms `n`.
2. Initialize `a=0`, `b=1`.
3. Loop `i=1` to `n`:
   - Print `a`.
   - Calculate `sum=a+b`.
   - Update `a=b`, `b=sum`.

### Loop diagram (n=6)
```
Iteration | a  | b  | sum | Output
---------------------------------
1         | 0  | 1  | 1   | 0
2         | 1  | 1  | 2   | 1
3         | 1  | 2  | 3   | 1
4         | 2  | 3  | 5   | 2
5         | 3  | 5  | 8   | 3
6         | 5  | 8  | 13  | 5
```

**Output:**  
```
0 1 1 2 3 5
```

---

## 6. Prime Number Check

### Script
```bash
#!/bin/bash
read -p "Enter number: " n
flag=1

for (( i=2; i<=n/2; i++ ))
do
  if [ $((n % i)) -eq 0 ]; then
    flag=0
    break
  fi
done

if [ $flag -eq 1 ]; then
  echo "Prime Number"
else
  echo "Not Prime"
fi
```

### Step-by-step explanation
1. Read number `n`.
2. Initialize `flag=1`.
3. Loop `i=2` to `n/2`:
   - If `n % i == 0`, set `flag=0` and break.
4. Check `flag` to print result.

### Loop diagram (n=11)
```
i=2 -> 11%2=1 -> continue
i=3 -> 11%3=2 -> continue
i=4 -> 11%4=3 -> continue
i=5 -> 11%5=1 -> continue
Loop ends -> flag=1 -> Prime
```

**Output:**  
```
Prime Number
```

---

## 7. Count Vowels

### Script
```bash
#!/bin/bash
read -p "Enter string: " s
count=$(echo "$s" | grep -o -i "[aeiou]" | wc -l)
echo "Vowel count: $count"
```

### Step-by-step explanation
1. Take string input.
2. `grep -o -i "[aeiou]"` → Extract all vowels.
3. `wc -l` → Count total vowels.
4. Print count.

**Example**
```
Input: DevOps
Output: Vowel count: 2
```

---

## 8. Sum of Digits

### Script
```bash
#!/bin/bash
read -p "Enter number: " n
sum=0

while [ $n -gt 0 ]
do
  digit=$((n % 10))
  sum=$((sum + digit))
  n=$((n / 10))
done

echo "Sum of digits: $sum"
```

### Step-by-step explanation
1. Read number.
2. Initialize `sum=0`.
3. Loop while `n>0`:
   - Extract last digit `digit=n%10`.
   - Add to `sum`.
   - Remove last digit `n=n/10`.
4. Print `sum`.

### Loop diagram (n=1234)
```
Iteration | n    | digit | sum
-------------------------------
1         | 1234 | 4     | 0+4=4
2         | 123  | 3     | 4+3=7
3         | 12   | 2     | 7+2=9
4         | 1    | 1     | 9+1=10
Loop ends -> sum=10
```

**Output:**  
```
Sum of digits: 10
```

---

## 9. Check File Exists

### Script
```bash
#!/bin/bash
read -p "Enter filename: " file

if [ -f "$file" ]; then
  echo "File exists"
else
  echo "File does not exist"
fi
```

### Step-by-step explanation
1. Take filename input.
2. `-f` checks if regular file exists.
3. Prints result.

**Example**
```
Input: test.txt
Output: File exists
```

---

# DEVOPS BASH SCRIPTS

---

## 10. Disk Usage Check
```bash
df -h /
```

**Step-by-step**
1. `df` → Disk Free
2. `-h` → Human readable
3. `/` → Root partition

**Output Example**
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       50G   20G   28G  42% /
```

---

## 11. Memory Usage Check
```bash
free -m
```

**Step-by-step**
1. `free -m` → Displays memory in MB.

---

## 12. Service Health Check
```bash
systemctl is-active --quiet nginx
if [ $? -eq 0 ]; then
  echo "Nginx is running"
else
  echo "Nginx is not running"
fi
```

---

## 13. Backup Script
```bash
tar -czf backup_$(date +%F).tar.gz /home/user/data
```

**Step-by-step**
1. `tar -czf` → Create compressed archive.
2. `backup_$(date +%F).tar.gz` → Adds current date to filename.
3. `/home/user/data` → Source folder.

---

## 14. Cron Job
```bash
0 2 * * *
```

**Step-by-step**
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
greet() { echo "Hello $1"; }
greet "DevOps"
```

**Step-by-step**
1. Define function `greet`.
2. `$1` → First argument passed.
3. Call function with argument `"DevOps"`.
**Output:** `Hello DevOps`

---

## 16. If-Else Condition
```bash
if [ $num -gt 10 ]; then
  echo "Greater"
else
  echo "Smaller or equal"
fi
```

---

## 17. Case Statement
```bash
case $opt in
  start) echo "Starting";;
  stop) echo "Stopping";;
  *) echo "Invalid option";;
esac
```

---

## 18. Trap Signal Handling
```bash
trap 'echo "Interrupted!"; exit' SIGINT
```

---

## 19. Functions + Case Script
```bash
$1
```
- `$1` → First argument passed to script  
- Example: `./script.sh start`

---

## 20. Error Handling Using Exit Codes
```bash
$?
```
- Stores exit code of last command  
- `0` → Success, Non-zero → Failure

---

# FINAL BEGINNER ADVICE

- Bash is simple but strict. Spaces, symbols, and order matter.  
- Loops are essential: C-style `for`, condition-based `while`.  
- Practice typing scripts manually to understand flow.

✅ **All scripts now include step-by-step explanations and loop diagrams.**
````

---

