Regular Expressions (**Regex**) are patterns used to search, match, and extract text.

Let's understand each pattern with simple examples.

---

## 1. `.` (Dot)

**Matches any single character except a newline.**

### Pattern

```python
a.c
```

### Matches

```text
abc
a1c
a-c
a@c
```

### Doesn't Match

```text
ac
abbc
```

Explanation:

* `a` → must be present
* `.` → any one character
* `c` → must be present

So:

```text
a b c  ✅
a 1 c  ✅
a @ c  ✅
```

---

## 2. `\d` (Digit)

**Matches any digit from 0 to 9.**

### Pattern

```python
\d
```

### Matches

```text
1
5
9
```

### Example

```python
\d+
```

### Matches

```text
123
4567
2026
```

Explanation:

* `\d` = one digit
* `+` = one or more

So:

```text
123
^^^^
all digits matched
```

---

## 3. `\w` (Word Character)

Matches:

```text
A-Z
a-z
0-9
_
```

### Pattern

```python
\w+
```

### Matches

```text
server01
server_01
hello
user123
```

### Doesn't Match Fully

```text
server-01
```

because `-` is not a word character.

---

## 4. `\s` (Whitespace)

Matches:

```text
Space
Tab
Newline
```

### Pattern

```python
\s
```

### Example

```text
Hello World
     ^
   space matched
```

### Pattern

```python
\s+
```

Matches:

```text
"   "
"\t"
"\n"
```

One or more whitespace characters.

---

## 5. `^` (Start of String)

Checks if text starts with something.

### Pattern

```python
^ERROR
```

### Matches

```text
ERROR: Connection failed
```

### Doesn't Match

```text
INFO ERROR: Connection failed
```

Because ERROR is not at the beginning.

Think:

```text
^ = beginning
```

---

## 6. `$` (End of String)

Checks if text ends with something.

### Pattern

```python
\.py$
```

### Matches

```text
app.py
main.py
```

### Doesn't Match

```text
app.py.txt
```

Explanation:

```text
$ = end
```

So `.py` must be at the end.

---

## 7. `*` (Zero or More)

Matches the preceding character zero or more times.

### Pattern

```python
ab*c
```

### Matches

```text
ac
abc
abbc
abbbc
```

Explanation:

```text
b*
```

means:

```text
0 b's
1 b
2 b's
3 b's
...
```

Examples:

```text
a c       ✅
a b c     ✅
a bb c    ✅
a bbb c   ✅
```

---

## 8. `+` (One or More)

Matches the preceding character at least once.

### Pattern

```python
ab+c
```

### Matches

```text
abc
abbc
abbbc
```

### Doesn't Match

```text
ac
```

Because at least one `b` is required.

Think:

```text
* = 0 or more
+ = 1 or more
```

---

## 9. `?` (Zero or One)

Makes the previous character optional.

### Pattern

```python
colou?r
```

### Matches

```text
color
colour
```

Explanation:

```text
u?
```

means:

```text
u can be present
or absent
```

So both work:

```text
color
colour
```

---

## 10. `[]` (Character Class)

Matches one character from a set.

### Pattern

```python
[0-9]
```

Matches:

```text
0
1
5
9
```

### Pattern

```python
[a-z]
```

Matches:

```text
a
b
z
```

### Pattern

```python
[A-Z]
```

Matches:

```text
A
B
Z
```

### Pattern

```python
[abc]
```

Matches:

```text
a
b
c
```

only these three characters.

---

## 11. `()` (Capture Group)

Used to capture parts of a match.

### Pattern

```python
(\d+)\.(\d+)
```

### Text

```text
10.25
```

### Captures

Group 1:

```text
10
```

Group 2:

```text
25
```

Explanation:

```python
(\d+)
```

captures digits before dot

```python
\.
```

matches literal dot

```python
(\d+)
```

captures digits after dot

---

## Real DevOps Examples

### Extract IP Address

```python
\d+\.\d+\.\d+\.\d+
```

Matches:

```text
192.168.1.10
10.0.0.5
```

---

### Find ERROR Logs

```python
^ERROR
```

Matches:

```text
ERROR Connection failed
```

---

### Extract Kubernetes Pod Name

```python
pod-\d+
```

Matches:

```text
pod-1
pod-22
pod-999
```

---

## Quick Cheat Sheet

| Regex | Meaning           | Example Match |
| ----- | ----------------- | ------------- |
| `.`   | Any character     | `a.c` → `abc` |
| `\d`  | Digit             | `5`           |
| `\w`  | Letter/Digit/_    | `server_01`   |
| `\s`  | Space/Tab/Newline | `" "`         |
| `^`   | Start of string   | `^ERROR`      |
| `$`   | End of string     | `\.py$`       |
| `*`   | 0 or more         | `ab*c`        |
| `+`   | 1 or more         | `ab+c`        |
| `?`   | 0 or 1            | `colou?r`     |
| `[]`  | Character set     | `[0-9]`       |
| `()`  | Capture group     | `(\d+)`       |

### Easy way to remember

```text
*  → Optional and many times (0,1,2,3...)
+  → At least once (1,2,3...)
?  → Optional only (0 or 1)
^  → Start
$  → End
[] → Choose one character
() → Capture something
\d → Digit
\w → Word
\s → Space
.  → Any character
```
