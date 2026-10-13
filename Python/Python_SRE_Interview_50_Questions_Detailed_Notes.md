# Python Interview Preparation — 50 Questions with Detailed Answers

**Role:** Microsoft Azure Site Reliability Engineer / DevOps Engineer | **Experience:** 5+ years | **Client interview:** State Street

**Learning style:** Simple English, working code, sample output, line-by-line logic, loop/execution dry runs, method explanations, practical production examples, troubleshooting, and a short answer you can say in an interview.

This handbook contains **all 50 Python questions from your shortlist, including Questions 1 and 2**. Example output from local code is shown directly; output from live Azure, Azure DevOps, Event Hubs, Storage, and Terraform Enterprise is clearly labeled *illustrative* because actual values depend on your environment, RBAC, and configuration.

> **Study tip:** For coding questions, practise typing the code without looking. Explain how each line works and how the values change on each loop. For cloud-connected scripts, explain identity, permissions, endpoints, retry behavior, failure handling, and what you would test before production.

## Clickable Table of Contents

- [1. Python Coding and Problem-Solving](#coding) — Questions 1–12
- [2. DevOps Automation and Log Processing](#devops) — Questions 13–21
- [3. REST APIs, JSON, YAML and Resilience](#apis) — Questions 22–31
- [4. Azure SDK and Cloud Automation](#azure-sdk) — Questions 32–39
- [5. Advanced Python and Testing](#advanced) — Questions 40–46
- [6. Terraform Integration and Agentic AI](#terraform-ai) — Questions 47–50

### Jump directly to a question

**1. Python Coding and Problem-Solving**

- [Q01. Count the frequency of each word in a string without external libraries](#q01)
- [Q02. Raise each element of a list to a given power](#q02)
- [Q03. Find the largest and second-largest distinct numbers without `sort()` or `max()`](#q03)
- [Q04. Remove duplicates from a list while preserving order](#q04)
- [Q05. Check whether a number is prime](#q05)
- [Q06. Reverse a string without slicing or `reversed()`](#q06)
- [Q07. Check whether a string is a palindrome](#q07)
- [Q08. Find common elements between two lists without duplicates](#q08)
- [Q09. Merge two dictionaries, prioritizing values from the second](#q09)
- [Q10. Sort a list of dictionaries by a chosen key](#q10)
- [Q11. Find the missing number in a sequence](#q11)
- [Q12. Flatten a nested list](#q12)

**2. DevOps Automation and Log Processing**

- [Q13. Read logs and count ERROR and WARNING messages](#q13)
- [Q14. Process a 10 GB log file without loading it into memory](#q14)
- [Q15. Check CPU, memory, and disk usage and raise a threshold alert](#q15)
- [Q16. Check multiple application URLs for HTTP 200 and report failures](#q16)
- [Q17. Find the top five most frequent errors in application logs](#q17)
- [Q18. Find log entries generated in the last 30 minutes](#q18)
- [Q19. Run Linux, Azure CLI, or kubectl commands using `subprocess`](#q19)
- [Q20. Archive or delete old log files safely](#q20)
- [Q21. Design a scheduled Python automation with logging, failure handling, and no overlapping runs](#q21)

**3. REST APIs, JSON, YAML and Resilience**

- [Q22. Call a REST API with Python, bearer authentication, JSON, and HTTP error handling](#q22)
- [Q23. Read a JSON file, update its values, and write it back](#q23)
- [Q24. Read Azure environment settings from a YAML file](#q24)
- [Q25. Handle REST API failures — 429, 401/403, timeouts, and 500 errors](#q25)
- [Q26. Implement retry logic with exponential backoff](#q26)
- [Q27. Convert JSON to YAML and YAML to JSON](#q27)
- [Q28. Parse nested JSON and filter Azure-like resource records](#q28)
- [Q29. Fetch all pages of a paginated REST API](#q29)
- [Q30. Secure API tokens, credentials, and secrets in Python](#q30)
- [Q31. Trigger an Azure DevOps pipeline through REST API and monitor its result](#q31)

**4. Azure SDK and Cloud Automation**

- [Q32. List Azure VMs across subscriptions with sizes and power states](#q32)
- [Q33. Authenticate to Azure using DefaultAzureCredential, managed identity, or service principal](#q33)
- [Q34. Identify Azure VM network interfaces with public IP references](#q34)
- [Q35. Stop nonproduction Azure VMs outside business hours to save costs](#q35)
- [Q36. Upload, download, and list Azure Blob Storage files using managed identity](#q36)
- [Q37. Send and receive Azure Event Hubs messages using Python](#q37)
- [Q38. Send and receive Azure Storage Queue messages and handle retries](#q38)
- [Q39. Build a combined infrastructure and application health report](#q39)

**5. Advanced Python and Testing**

- [Q40. Compare multithreading, multiprocessing, and asyncio for 100 API requests](#q40)
- [Q41. Design a production-ready Python automation script](#q41)
- [Q42. Explain list, tuple, set, and dictionary with DevOps examples](#q42)
- [Q43. Explain functions, `*args`, `**kwargs`, lambda, generators, and decorators](#q43)
- [Q44. Unit-test Python Azure/API automation using pytest and mocking](#q44)
- [Q45. Make a Python infrastructure automation script idempotent](#q45)
- [Q46. Troubleshoot Python working locally but failing in Azure DevOps](#q46)

**6. Terraform Integration and Agentic AI**

- [Q47. Parse Terraform plan JSON and flag deletes or replacements](#q47)
- [Q48. Trigger and monitor a Terraform Enterprise run using Python](#q48)
- [Q49. Explain agentic AI and build a simple Python-based Azure troubleshooting assistant](#q49)
- [Q50. Securely integrate an LLM with Azure infrastructure APIs using Python](#q50)

---

## Answer structure used in every chapter

1. **Concept** — What the program or service does, in simple English.
2. **Implementation** — Full Python example and sample output.
3. **Line-by-line explanation** — Why each statement is present.
4. **Loop execution or data flow** — How variables and logic change step by step.
5. **Functions and methods** — What the built-ins, SDK methods, and libraries do.
6. **Production example** — How an Azure SRE/DevOps engineer would use the approach.
7. **Troubleshooting** — Errors, edge cases, reliability, and safe operation.
8. **Short interview explanation** — A concise explanation to say aloud.

---

<a id="coding"></a>
# 1. Python Coding and Problem-Solving

<a id="q01"></a>
## Question 1: Count the frequency of each word in a string without external libraries

### 1. Concept
We want to know how many times each word occurs. A **dictionary** stores a word as the *key* and its occurrence count as the *value*. A `for` loop visits the words one by one. This is a useful pattern for counting error codes, HTTP response codes, or log levels.

### 2. Implementation — complete code and sample output
```python
def count_words(text):
    frequency = {}
    for word in text.split():
        frequency[word] = frequency.get(word, 0) + 1
    return frequency

text = "aws azure aws terraform azure aws"
result = count_words(text)
print(result)
```
**Sample output**
```text
{'aws': 3, 'azure': 2, 'terraform': 1}
```

### 3. Line-by-line explanation
1. `def count_words(text):` creates a reusable function; `text` receives the supplied string.
2. `frequency = {}` creates an empty dictionary before counting starts.
3. `text.split()` turns the input into `['aws', 'azure', 'aws', 'terraform', 'azure', 'aws']`.
4. `for word in ...` picks one word for each iteration.
5. `frequency.get(word, 0)` returns the previous count, or `0` if the word is new; `+ 1` adds this occurrence.
6. `return frequency` sends the dictionary back **after** the loop ends.
7. `result = count_words(text)` calls the function; `print(result)` displays its return value.

### 4. Loop execution — dry run
| Loop | Current word | Previous count | Dictionary after updating |
|---|---|---:|---|
| 1 | aws | 0 | `{'aws': 1}` |
| 2 | azure | 0 | `{'aws': 1, 'azure': 1}` |
| 3 | aws | 1 | `{'aws': 2, 'azure': 1}` |
| 4 | terraform | 0 | `{'aws': 2, 'azure': 1, 'terraform': 1}` |
| 5 | azure | 1 | `{'aws': 2, 'azure': 2, 'terraform': 1}` |
| 6 | aws | 2 | `{'aws': 3, 'azure': 2, 'terraform': 1}` |

### 5. Why these functions and methods?
- `def`: use the counting logic again with other strings.
- `split()`: separate a sentence into words without a third-party package.
- `get(key, 0)`: handle the first occurrence without `KeyError`.
- `return`: make the result available to the caller; unlike `print`, it can be used by another function.

### 6. Production example — DevOps / SRE
For a small log-level sample, `count_words("ERROR INFO ERROR WARNING ERROR")` returns `{'ERROR': 3, 'INFO': 1, 'WARNING': 1}`. An operations script can count parsed log severities and send the counts to a dashboard. Real structured logs should be parsed by their severity field, not by counting every word.

### 7. Troubleshooting and follow-ups
An empty string gives `{}` because there is nothing to iterate. `AWS` and `aws` count separately; use `text.lower().split()` when case should be ignored. Punctuation, such as `aws,`, remains attached; strip punctuation if the requirement asks for normalized words. This approach uses approximately one dictionary entry per unique word.

### 8. Short interview explanation
> I split the string into words, loop through each word, and keep its count in a dictionary. `get()` returns zero for a new word, so I can increase the count safely and return the result.

---
<a id="q02"></a>
## Question 2: Raise each element of a list to a given power

### 1. Concept
The function receives two inputs: a list such as `[1, 2, 3]` and a power such as `2`. It visits every number, calculates the exponent using `**`, and adds the result to a **new list**. The original list remains unchanged.

### 2. Implementation — complete code and sample output
```python
def calculate_power(numbers, power):
    result = []
    for num in numbers:
        value = num ** power
        result.append(value)
    return result

numbers = [1, 2, 3]
power = 2
output = calculate_power(numbers, power)
print(output)
```
**Sample output**
```text
[1, 4, 9]
```

### 3. Line-by-line explanation
1. `def calculate_power(numbers, power):` defines a reusable function with **two parameters**.
2. `result = []` starts an empty list to collect calculated values.
3. `for num in numbers:` reads a number at a time; it runs three times for this input.
4. `value = num ** power` raises the current number to the power; `2 ** 2` becomes `4`.
5. `result.append(value)` places this calculated value at the end of the list.
6. `return result` runs after the loop and returns all three values.
7. We assign inputs, call the function, and print the returned list.

### 4. Loop execution — dry run
| Iteration | `num` | `num ** 2` | `result` after `append()` |
|---|---:|---:|---|
| 1 | 1 | 1 | `[1]` |
| 2 | 2 | 4 | `[1, 4]` |
| 3 | 3 | 9 | `[1, 4, 9]` |

### 5. Why these functions and methods?
- `**` is Python's power operator; `*` performs multiplication, not exponentiation.
- `append()` adds one item to a list; no need to know the final list length beforehand.
- `for` handles lists of different lengths.
- `return` makes the new list available for the next processing step.
- Shorter alternative: `return [num ** power for num in numbers]`; the normal loop is easier to explain first.

### 6. Production example — DevOps / SRE
A simple data-transform function can process numerical values collected from an API. For example, `calculate_power([2, 4, 6], 2)` returns `[4, 16, 36]`. This demonstrates list transformation; squaring CPU percentage is **not** itself a standard monitoring calculation.

### 7. Troubleshooting and follow-ups
An empty list returns `[]`. A zero power returns `1` for each number (Python also evaluates `0 ** 0` as `1`). A negative power produces fractional values for nonzero inputs. Non-numeric items such as `'aws'` raise `TypeError`; a zero base with a negative exponent raises `ZeroDivisionError`. Validate numeric inputs if this becomes production code.

### 8. Short interview explanation
> I create a function that takes a list and a power. I loop through the list, calculate each element using `**`, append the result to a new list, and return the completed list.

---
<a id="q03"></a>
## Question 3: Find the largest and second-largest distinct numbers without `sort()` or `max()`

### 1. Concept
We can find the top two **different** numbers in one pass. We keep `largest` and `second` and update them while looping. This is more efficient than sorting the full list just to find two values.

### 2. Implementation — code and sample output
```python
def top_two(numbers):
    largest = second = None
    for num in numbers:
        if largest is None or num > largest:
            if num != largest:
                second = largest
                largest = num
        elif num != largest and (second is None or num > second):
            second = num
    return largest, second

print(top_two([10, 50, 20, 80, 30, 80]))
```
**Sample output:** `(80, 50)`

### 3. Line-by-line explanation
1. Initialize both values as `None` because we have not seen any numbers.
2. For every `num`, first check whether it exceeds the current largest.
3. If yes, the old `largest` becomes `second`, and `num` becomes the new `largest`.
4. Otherwise, a distinct number can update `second` if it is greater than the existing second largest.
5. `return largest, second` returns a tuple containing both results.

### 4. Loop execution — dry run
| Number seen | Largest | Second largest |
|---:|---:|---:|
| 10 | 10 | None |
| 50 | 50 | 10 |
| 20 | 50 | 20 |
| 80 | 80 | 50 |
| 30 | 80 | 50 |
| 80 | 80 | 50 |

### 5. Why these functions and methods?
`None` marks a missing value; `is None` checks for it. `if/elif` makes the two updates mutually exclusive. A tuple is an easy way to return two values. Time complexity is **O(n)** and extra space is **O(1)**.

### 6. Production example — DevOps / SRE
Find the two highest **distinct** CPU-usage readings in a list, or the largest two response-time measurements, to spot outliers.

### 7. Troubleshooting and follow-ups
An empty list returns `(None, None)`; a list with one distinct number gives a missing second value. State clearly whether the interviewer wants *distinct* numbers: if duplicates should count, the logic changes. This assumes all elements are mutually comparable numbers.

### 8. Short interview explanation
> I use two variables and scan the list only once. When I find a new maximum, the previous maximum becomes the second largest. Otherwise I update the second-largest value if the current number is distinct and larger.

---
<a id="q04"></a>
## Question 4: Remove duplicates from a list while preserving order

### 1. Concept
A `set` remembers which values have already appeared. We append each new value to another list. This avoids duplicates **without changing the order of first appearance**.

### 2. Implementation — code and output
```python
def unique_in_order(values):
    seen = set()
    result = []
    for item in values:
        if item not in seen:
            seen.add(item)
            result.append(item)
    return result

print(unique_in_order(['aks', 'vm', 'aks', 'sql', 'vm']))
```
**Sample output:** `['aks', 'vm', 'sql']`

### 3. Line-by-line explanation
`seen = set()` creates a fast membership-check collection. `result = []` stores output in order. The loop visits every `item`. `if item not in seen` allows only unseen items through. `seen.add(item)` records it; `result.append(item)` preserves its position in the output. `return` sends the unique list back.

### 4. Loop execution — dry run
| Item | Already seen? | Result |
|---|---|---|
| aks | No | `['aks']` |
| vm | No | `['aks', 'vm']` |
| aks | Yes | unchanged |
| sql | No | `['aks', 'vm', 'sql']` |
| vm | Yes | unchanged |

### 5. Why these functions and methods?
`set()` creates a set, `add()` inserts a new value, `not in` performs membership testing, and `append()` maintains output order. Typical time is **O(n)** for hashable values. `list(set(values))` does **not** guarantee input order.

### 6. Production example — DevOps / SRE
Deduplicate a stream of Azure resource-group names or alert IDs before producing a report. Keeping first-seen order helps maintain the original priority.

### 7. Troubleshooting and follow-ups
Dictionaries and lists are unhashable, so they cannot go into a set directly. For a list of dictionaries, choose a unique field such as resource `id` as the key in `seen`. An empty input returns `[]`.

### 8. Short interview explanation
> I use a set to track previously seen values and a separate list to keep their original order. I append a value only the first time it appears.

---
<a id="q05"></a>
## Question 5: Check whether a number is prime

### 1. Concept
A prime number is an integer greater than one with no divisors except `1` and itself. We only need to test divisors up to the square root of the number, which avoids unnecessary iterations.

### 2. Implementation — code and output
```python
def is_prime(number):
    if number < 2:
        return False
    for divisor in range(2, int(number ** 0.5) + 1):
        if number % divisor == 0:
            return False
    return True

print(is_prime(7))
print(is_prime(9))
```
**Sample output**
```text
True
False
```

### 3. Line-by-line explanation
The first `if` rules out negatives, zero, and one. `number ** 0.5` gives the square root; `int(...) + 1` makes the `range` cover candidate divisors up to that root. `%` calculates the remainder. If it equals zero, we found a divisor and immediately `return False`. Reaching the last line means there was no divisor, so the number is prime.

### 4. Loop execution — dry run
For `9`, potential divisors are `2` and `3`. `9 % 2 = 1`, so keep checking; `9 % 3 = 0`, so return `False`. For `7`, divisors tested are `2`, and no zero remainder is found, so return `True`.

### 5. Why these functions and methods?
`range(start, stop)` produces candidate integers but **excludes** `stop`. `%` checks divisibility. Early `return` stops work immediately. For extremely large integers, `math.isqrt(number)` avoids floating-point precision issues.

### 6. Production example — DevOps / SRE
This is mainly a coding-screen question testing loops, conditions, and efficient checks. Similar early-exit logic is useful when validating resource IDs or inputs before running automation.

### 7. Troubleshooting and follow-ups
`1` is not prime; `2` is prime. `range(2, 2)` is empty for `2`, so the function returns `True`. Negative values are not prime. Reject non-integer inputs if needed.

### 8. Short interview explanation
> I reject numbers below two, then test divisors from two through the square root. If any divisor divides the number exactly, it is not prime. Otherwise, it is prime.

---
<a id="q06"></a>
## Question 6: Reverse a string without slicing or `reversed()`

### 1. Concept
The exercise checks whether you can work with loops and strings. Create an empty string, visit every character, and put it **before** the characters already collected.

### 2. Implementation — code and output
```python
def reverse_text(text):
    result = ""
    for char in text:
        result = char + result
    return result

print(reverse_text("azure"))
```
**Sample output:** `eruza`

### 3. Line-by-line explanation
`result` starts empty. The loop reads characters from left to right. `char + result` puts the new character at the beginning. For `a`, result is `a`; after `z`, result is `za`. `return` gives the reversed text after the loop.

### 4. Loop execution — dry run
| Character | Result |
|---|---|
| a | `a` |
| z | `za` |
| u | `uza` |
| r | `ruza` |
| e | `eruza` |

### 5. Why these functions and methods?
`for` reads each character. `+` joins two strings. Unlike lists, strings are immutable, so each concatenation creates a new string; on large inputs, a list of characters and `''.join()` is often more efficient.

### 6. Production example — DevOps / SRE
String processing and parsing are common when working with log labels, filenames, and resource names, even though reversing text itself is mostly an interview exercise.

### 7. Troubleshooting and follow-ups
An empty string returns an empty string. This reverses Unicode code points and may not keep complex emoji or combined characters visually intact. Time can approach O(n²) due to repeated concatenation.

### 8. Short interview explanation
> I start with an empty string and loop through the characters. I put each new character in front of the result, which reverses the original order.

---
<a id="q07"></a>
## Question 7: Check whether a string is a palindrome

### 1. Concept
A palindrome reads the same forwards and backwards, such as `madam`. We can compare the characters at the beginning and end, then move toward the center.

### 2. Implementation — code and output
```python
def is_palindrome(text):
    text = text.lower().replace(" ", "")
    left, right = 0, len(text) - 1
    while left < right:
        if text[left] != text[right]:
            return False
        left += 1
        right -= 1
    return True

print(is_palindrome("Madam"))
print(is_palindrome("Azure"))
```
**Sample output**
```text
True
False
```

### 3. Line-by-line explanation
`lower()` makes letters lowercase. `replace(" ", "")` removes ordinary spaces. `left` points to the first character, while `right` points to the last. The `while` loop continues until the pointers meet. Unequal characters return `False`; matching characters allow both pointers to move inward. The final `True` means all pairs matched.

### 4. Loop execution — dry run
For `madam`: compare `m` to `m` (match), then `a` to `a` (match); the pointers meet at `d`, and the function returns `True`. For `azure`, the first pair `a` and `e` differs, so it returns `False` immediately.

### 5. Why these functions and methods?
`len()` finds the last valid index, `while` repeats until a condition becomes false, and indexing `text[left]` reads individual characters. Two pointers avoid building a reversed copy of the entire string.

### 6. Production example — DevOps / SRE
Mostly a coding test for validation and indexing. The two-pointer idea also appears in comparing structured sequences and scanning data from both ends.

### 7. Troubleshooting and follow-ups
This code ignores spaces and case but **not** punctuation. An empty string returns `True` by the standard definition. For punctuation-insensitive comparison, normalize with `''.join(ch.lower() for ch in text if ch.isalnum())`.

### 8. Short interview explanation
> I normalize the string, compare its first and last characters, and move inward. If any pair differs, it is not a palindrome.

---
<a id="q08"></a>
## Question 8: Find common elements between two lists without duplicates

### 1. Concept
We want values that appear in **both** lists, without repeating them. Convert the second list to a set for quick lookup, then follow the order of the first list.

### 2. Implementation — code and output
```python
def common_unique(first, second):
    second_values = set(second)
    seen = set()
    result = []
    for item in first:
        if item in second_values and item not in seen:
            result.append(item)
            seen.add(item)
    return result

print(common_unique(['aks', 'vm', 'aks', 'sql'], ['sql', 'aks']))
```
**Sample output:** `['aks', 'sql']`

### 3. Line-by-line explanation
`set(second)` contains the possible matches. `seen` tracks matches already added. The `for` loop walks through `first` in order. An item is included only when it is in both collections and has not been recorded yet. `return result` gives the matches.

### 4. Loop execution — dry run
`aks`: in both → append. `vm`: not in second → skip. Second `aks`: already seen → skip. `sql`: in both and new → append. Final output is `['aks', 'sql']`.

### 5. Why these functions and methods?
`set()` provides efficient membership checks. `and` requires both conditions to be true. `append()` builds an ordered answer. Expected runtime is O(n + m) for hashable elements.

### 6. Production example — DevOps / SRE
Identify which Azure resource IDs appear in both a CMDB export and a monitoring inventory, avoiding duplicate IDs.

### 7. Troubleshooting and follow-ups
Elements must be hashable for sets. Case is significant. If order doesn't matter, `list(set(first) & set(second))` is shorter, but may reorder results.

### 8. Short interview explanation
> I convert one list to a set and loop over the other. I append items that appear in both, tracking those already included to avoid duplicates.

---
<a id="q09"></a>
## Question 9: Merge two dictionaries, prioritizing values from the second

### 1. Concept
A dictionary keeps one value per key. During a merge, a later value replaces an earlier value when the key is repeated. This is useful for applying environment-specific configuration over defaults.

### 2. Implementation — code and output
```python
def merge_settings(defaults, overrides):
    result = defaults.copy()
    result.update(overrides)
    return result

base = {'region': 'eastus', 'replicas': 2}
prod = {'region': 'centralindia', 'replicas': 4}
print(merge_settings(base, prod))
```
**Sample output:** `{'region': 'centralindia', 'replicas': 4}`

### 3. Line-by-line explanation
`defaults.copy()` makes a new dictionary, so the original is not modified. `result.update(overrides)` adds keys absent from the original and replaces values for keys that already exist. `return` sends the combined settings back.

### 4. Execution trace
Start: `{'region': 'eastus', 'replicas': 2}`. Apply `region='centralindia'` → replace. Apply `replicas=4` → replace. Nothing changes in `base` because `copy()` made a new object.

### 5. Why these functions and methods?
`copy()` is a shallow copy. `update()` performs a **one-level merge**. In Python 3.9+, `defaults | overrides` also works. Nested dictionaries are not automatically deep-merged.

### 6. Production example — DevOps / SRE
Combine general deployment settings (`replicas=2`) with production overrides (`replicas=4`) before generating configuration files.

### 7. Troubleshooting and follow-ups
If nested values need merging, build a dedicated recursive merge and carefully decide whether lists should be replaced or combined. Avoid mutating shared default dictionaries unexpectedly.

### 8. Short interview explanation
> I copy the first dictionary, then call `update()` with the second. Duplicate keys take their values from the second dictionary.

---
<a id="q10"></a>
## Question 10: Sort a list of dictionaries by a chosen key

### 1. Concept
APIs commonly return lists of dictionaries. Sorting by a numeric field helps rank machines by CPU usage or errors by frequency.

### 2. Implementation — code and output
```python
servers = [
    {'name': 'vm1', 'cpu': 40},
    {'name': 'vm2', 'cpu': 85},
    {'name': 'vm3', 'cpu': 20},
]
ranked = sorted(servers, key=lambda server: server['cpu'], reverse=True)
for server in ranked:
    print(server['name'], server['cpu'])
```
**Sample output**
```text
vm2 85
vm1 40
vm3 20
```

### 3. Line-by-line explanation
`servers` is a list with three dictionaries. `sorted(...)` creates a new sorted list. The `key=` function tells Python which value to compare. `lambda server: server['cpu']` extracts CPU from each dictionary. `reverse=True` sorts highest first. The loop prints each ranked server.

### 4. Loop execution — dry run
The sorting algorithm compares CPU keys `40`, `85`, and `20`, producing the order `vm2`, `vm1`, `vm3`. The display loop then prints these three records in that order.

### 5. Why these functions and methods?
`sorted()` does not modify the original list; `list.sort()` would. A `lambda` is a small anonymous function. `reverse=True` switches to descending order. Sorting typically takes O(n log n) time.

### 6. Production example — DevOps / SRE
Rank Azure VM performance data and report the ten servers with the highest CPU usage first.

### 7. Troubleshooting and follow-ups
`server['cpu']` raises `KeyError` when a field is missing. Use `server.get('cpu', 0)` if missing values should default to zero. Avoid mixing strings and numbers in the same sort key.

### 8. Short interview explanation
> I use `sorted()` with a `lambda` to select the dictionary field. `reverse=True` puts the highest values first, which is useful for ranking infrastructure metrics.

---
<a id="q11"></a>
## Question 11: Find the missing number in a sequence

### 1. Concept
For a list containing every integer from `1` to `n` except one, calculate the total expected sum and subtract the actual sum.

### 2. Implementation — code and output
```python
def missing_number(values, n):
    expected = n * (n + 1) // 2
    actual = sum(values)
    return expected - actual

print(missing_number([1, 2, 3, 5, 6], 6))
```
**Sample output:** `4`

### 3. Line-by-line explanation
`n * (n + 1) // 2` uses the formula for `1 + 2 + ... + n`. `sum(values)` adds present numbers. Their difference is the missing number. Here expected sum is `21`, actual sum is `17`, so the result is `4`.

### 4. Execution trace
`n=6` → `6*7//2=21`; loop inside `sum()` adds `1+2+3+5+6=17`; `21-17=4`.

### 5. Why these functions and methods?
`sum()` adds numbers from a sequence. `//` performs integer division. The formula avoids constructing an extra list and uses O(1) space.

### 6. Production example — DevOps / SRE
Find a missing integer in a small sequence of batch IDs or scheduled job numbers when IDs follow the exact consecutive-number rules.

### 7. Troubleshooting and follow-ups
This assumes **exactly one** missing value, no duplicates, and a range from `1` through `n`. Validate those assumptions for real data. For arbitrary sets of IDs, compare two sets instead.

### 8. Short interview explanation
> I calculate the expected sum from one to `n`, subtract the sum of values we have, and the remaining difference is the missing number.

---
<a id="q12"></a>
## Question 12: Flatten a nested list

### 1. Concept
Flattening changes `[[1, 2], [3, 4], [5]]` into a single list `[1, 2, 3, 4, 5]`. The simple version uses two `for` loops: one to visit each inner list, and another to visit each item.

### 2. Implementation — code and output
```python
def flatten(groups):
    result = []
    for group in groups:
        for item in group:
            result.append(item)
    return result

print(flatten([[1, 2], [3, 4], [5]]))
```
**Sample output:** `[1, 2, 3, 4, 5]`

### 3. Line-by-line explanation
Start with an empty `result`. The outer loop reads each list, such as `[1, 2]`. The inner loop reads each number within that list and appends it. After all groups have been visited, `return` produces the flat list.

### 4. Loop execution — dry run
Outer group `[1, 2]` → append `1`, `2`: result `[1, 2]`. Next group `[3, 4]` → append `3`, `4`: result `[1, 2, 3, 4]`. Final group `[5]` → append `5`.

### 5. Why these functions and methods?
Nested `for` loops fit a two-level nested structure. `append()` adds each inner value. List-comprehension alternative: `[item for group in groups for item in group]`.

### 6. Production example — DevOps / SRE
Flatten lists of VM names returned per Azure resource group into one inventory list for reporting.

### 7. Troubleshooting and follow-ups
This handles **one** nesting level only. Strings inside the outer list would be iterated character by character. For arbitrary-depth nesting, use a carefully designed recursive function with explicit handling for strings and dictionaries.

### 8. Short interview explanation
> I create an empty result list, loop through the inner lists, and append each element to produce one flat list.

---

<a id="devops"></a>
# 2. DevOps Automation and Log Processing

<a id="q13"></a>
## Question 13: Read logs and count ERROR and WARNING messages

### 1. Concept
Operations teams need to know how many errors and warnings an application produces. Read the file **line by line**, extract a severity such as `ERROR`, and count it. This is safer than loading a large log file into memory.

### 2. Implementation — code and sample output
Assume `app.log` contains:
```text
2026-10-13 INFO Started
2026-10-13 ERROR Database timeout
2026-10-13 WARNING Slow request
2026-10-13 ERROR Database timeout
```
```python
from collections import Counter

def count_levels(path):
    counts = Counter()
    with open(path, encoding="utf-8") as file:
        for line in file:
            fields = line.split(maxsplit=2)
            if len(fields) >= 2 and fields[1] in ("ERROR", "WARNING"):
                counts[fields[1]] += 1
    return dict(counts)

print(count_levels("app.log"))
```
**Sample output:** `{'ERROR': 2, 'WARNING': 1}`

### 3. Line-by-line explanation
`Counter()` is a dictionary-like object that starts missing counts at zero. `with open(...)` opens and closes the file safely. The `for` loop reads one line at a time. `split(maxsplit=2)` extracts date, level, and remaining message. The `if` checks that a severity exists and is either ERROR or WARNING. We increase the corresponding counter and return normal dictionary output.

### 4. Loop execution — dry run
Line 1 has INFO → skip. Line 2 has ERROR → `ERROR=1`. Line 3 has WARNING → `WARNING=1`. Line 4 has ERROR → `ERROR=2`. No line has to be retained after processing.

### 5. Why these functions and methods?
`Counter` simplifies counting; `with` safely closes the file; `split(maxsplit=2)` prevents unnecessary splitting of the free-text message; `len` protects against blank or malformed lines.

### 6. Production example — DevOps / SRE
Run a scheduled log analyzer against application files, identify a sudden rise in errors, and send summarized counts to a monitoring platform. Prefer structured JSON logs if available because severity fields are unambiguous.

### 7. Troubleshooting and follow-ups
A missing file raises `FileNotFoundError`; verify the path and permissions. Other log formats may put the severity in a different position; update the parser. Avoid counting `ERROR` inside message text if that is not the actual severity.

### 8. Short interview explanation
> I read the log file one line at a time, extract the severity field, and use `Counter` to count ERROR and WARNING messages. This is memory efficient and easy to automate.

---
<a id="q14"></a>
## Question 14: Process a 10 GB log file without loading it into memory

### 1. Concept
A 10 GB file is too large to read as a single string on many machines. Instead, **stream** the file line by line and keep only small summary variables. The memory requirement stays almost constant.

### 2. Implementation — code and sample output
```python
def summarize_large_log(path):
    total = errors = 0
    with open(path, encoding="utf-8", errors="replace") as file:
        for line in file:
            total += 1
            if " ERROR " in f" {line} ":
                errors += 1
    return {"lines": total, "errors": errors}

print(summarize_large_log("app.log"))
```
**Illustrative output for a four-line file:** `{'lines': 4, 'errors': 2}`

### 3. Line-by-line explanation
`total = errors = 0` initializes counters. `open(..., errors="replace")` avoids crashing on a bad UTF-8 byte, but you should still investigate unexpected encodings. Each `for line in file` yields one log line. We increment `total` each time and increase `errors` for matching records. The result contains only counts, not millions of log lines.

### 4. Loop execution — dry run
For `INFO`, `ERROR`, `WARNING`, `ERROR`: totals become `1,2,3,4`; error counts become `0,1,1,2`. Memory does not grow with the number of rows because only two integers change.

### 5. Why these functions and methods?
`with open` controls file lifetime; streaming iteration avoids `.read()` or `.readlines()`; counters store aggregated results. `f" {line} "` makes a simple space-delimited match, but a real parser should extract a severity field rather than rely on substring matching.

### 6. Production example — DevOps / SRE
Process rotated application logs from a VM and summarize errors before uploading compact metrics. For distributed logs, use a centralized service such as Log Analytics rather than copying 10 GB files between servers.

### 7. Troubleshooting and follow-ups
The code assumes a simple log structure and text encoding. For JSON logs, parse each line with `json.loads()`. For compressed `.gz` files use `gzip.open(path, 'rt')`. Use checkpoints if a long-running batch must resume after interruption.

### 8. Short interview explanation
> I never load the full file with `read()`. I open it and process lines one by one, keeping only counters or selected results. That keeps memory usage small even for very large files.

---
<a id="q15"></a>
## Question 15: Check CPU, memory, and disk usage and raise a threshold alert

### 1. Concept
Monitoring scripts measure resource utilization and compare it to configured thresholds. Python can collect operating-system metrics using the `psutil` package and print alerts or forward them to a monitoring service.

### 2. Implementation — code and sample output
Install: `pip install psutil`
```python
import psutil

def check_health(threshold=85):
    values = {
        "CPU": psutil.cpu_percent(interval=1),
        "Memory": psutil.virtual_memory().percent,
        "Disk": psutil.disk_usage("/").percent,
    }
    for name, percent in values.items():
        if percent >= threshold:
            print(f"ALERT {name}: {percent}%")
        else:
            print(f"OK {name}: {percent}%")

check_health()
```
**Illustrative output (depends on machine):**
```text
OK CPU: 25.4%
OK Memory: 64.0%
ALERT Disk: 91.2%
```

### 3. Line-by-line explanation
`import psutil` loads the monitoring library. `cpu_percent(interval=1)` samples CPU for one second. `virtual_memory().percent` reads RAM usage. `disk_usage("/").percent` reads usage for the filesystem mounted at `/`. `.items()` returns name/value pairs. Each percentage is compared to the configured threshold, then reported as OK or ALERT.

### 4. Loop execution — dry run
With simulated values `CPU=25.4`, `Memory=64`, `Disk=91.2` and threshold `85`: the first two `if` checks are false; the disk check is true, so only the disk triggers an alert.

### 5. Why these functions and methods?
`psutil` offers portable process/system APIs; a dictionary labels each metric; `.items()` avoids repeating three separate `if` blocks; f-strings format the messages. On Windows, check the appropriate disk path, such as `C:\\`.

### 6. Production example — DevOps / SRE
Run a health check on a diagnostic VM and publish utilization to Azure Monitor or Prometheus. Production alerts should consider duration and multiple samples, not one brief CPU spike.

### 7. Troubleshooting and follow-ups
Metrics vary from run to run. Filesystem `"/"` may not be the desired data volume. Containers may have limits different from host-wide values. In AKS, prefer Prometheus/Container Insights for cluster metrics.

### 8. Short interview explanation
> I use `psutil` to read CPU, memory, and disk percentages. I loop over the metrics and compare each value with a threshold to report OK or ALERT.

---
<a id="q16"></a>
## Question 16: Check multiple application URLs for HTTP 200 and report failures

### 1. Concept
An availability checker sends HTTP requests to a set of endpoints. A successful HTTP status means the endpoint responded; it does not necessarily prove the entire application is healthy, so use meaningful `/health` paths when possible.

### 2. Implementation — code and sample output
Install: `pip install requests`
```python
import requests

def check_urls(urls):
    for url in urls:
        try:
            response = requests.get(url, timeout=5)
            if response.status_code == 200:
                print(url, "UP")
            else:
                print(url, "HTTP", response.status_code)
        except requests.RequestException as error:
            print(url, "UNREACHABLE", type(error).__name__)

check_urls(["https://example.com/", "https://example.invalid/"])
```
**Illustrative output:**
```text
https://example.com/ UP
https://example.invalid/ UNREACHABLE ConnectionError
```

### 3. Line-by-line explanation
`requests.get` sends an HTTP GET and `timeout=5` avoids waiting forever. The first `if` detects exactly HTTP 200. Other statuses are printed to distinguish 503 from 404. `except requests.RequestException` handles connection, TLS and timeout-related request errors so a failed endpoint does not stop the whole loop.

### 4. Loop execution — dry run
First URL: request succeeds with `200` → print UP. Second URL: DNS/connection error → enter `except`, print UNREACHABLE, and finish the loop.

### 5. Why these functions and methods?
`try/except` isolates failures; `.status_code` exposes HTTP result; `type(error).__name__` prints the exception type without leaking the full request; `timeout` prevents hung health checks.

### 6. Production example — DevOps / SRE
Check regional application health endpoints after an Azure DevOps release and block a traffic cutover if the new deployment is not healthy.

### 7. Troubleshooting and follow-ups
An HTTP 302 redirect may be followed automatically; use `allow_redirects=False` if you want to inspect it. Private endpoints need correct DNS and network access from the machine running the test. Check TLS validity and authentication for private services.

### 8. Short interview explanation
> I loop over URLs, make requests with a timeout, and check each HTTP status. I catch request exceptions so one bad endpoint does not stop monitoring other endpoints.

---
<a id="q17"></a>
## Question 17: Find the top five most frequent errors in application logs

### 1. Concept
Counting all errors is useful; finding **which errors repeat most** gives a better starting point for RCA. Normalize error messages before counting so variable request IDs do not make every message unique.

### 2. Implementation — code and output
Assume each error record uses `ERROR: message`.
```python
from collections import Counter

def top_errors(lines):
    counts = Counter()
    for line in lines:
        if line.startswith("ERROR:"):
            message = line.split(":", 1)[1].strip()
            counts[message] += 1
    return counts.most_common(5)

logs = ["ERROR: timeout", "INFO: healthy", "ERROR: auth", "ERROR: timeout"]
print(top_errors(logs))
```
**Sample output:** `[('timeout', 2), ('auth', 1)]`

### 3. Line-by-line explanation
`Counter()` stores the counts. The loop sees each log line. `startswith("ERROR:")` filters error records. `split(":", 1)` cuts only at the first colon, so later colons in the message remain intact. `strip()` removes surrounding spaces. `most_common(5)` returns at most five highest-frequency messages.

### 4. Loop execution — dry run
First timeout → 1; INFO skipped; auth → 1; next timeout → 2. `most_common` sorts by counts so timeout appears first.

### 5. Why these functions and methods?
`startswith` checks a prefix, `split(...,1)` avoids splitting unrelated colons, `strip` normalizes whitespace, and `most_common` ranks the results.

### 6. Production example — DevOps / SRE
From an AKS application's exported logs, identify repeated `database timeout` or `connection refused` errors to target investigations.

### 7. Troubleshooting and follow-ups
If messages contain unique request IDs, group by error code or exception class rather than full string. Stream very large files; avoid converting all logs to a list. For structured JSON logs, parse `severity` and `error_code` fields.

### 8. Short interview explanation
> I filter ERROR records, count messages in a `Counter`, then use `most_common(5)` to find the five errors occurring most often.

---
<a id="q18"></a>
## Question 18: Find log entries generated in the last 30 minutes

### 1. Concept
Time-window filtering is common during incident investigation. Parse each log timestamp as a timezone-aware `datetime`, calculate a cutoff, and keep records newer than it.

### 2. Implementation — code and output
Assume timestamps start each line in UTC ISO format.
```python
from datetime import datetime, timedelta, timezone

def recent_lines(lines, now):
    cutoff = now - timedelta(minutes=30)
    result = []
    for line in lines:
        timestamp = line.split(" ", 1)[0]
        occurred = datetime.fromisoformat(timestamp.replace("Z", "+00:00"))
        if cutoff <= occurred <= now:
            result.append(line)
    return result

now = datetime(2026, 10, 13, 12, 0, tzinfo=timezone.utc)
logs = ["2026-10-13T11:20:00Z old", "2026-10-13T11:45:00Z new"]
print(recent_lines(logs, now))
```
**Sample output:** `['2026-10-13T11:45:00Z new']`

### 3. Line-by-line explanation
`timedelta(minutes=30)` represents 30 minutes. `cutoff` is `11:30 UTC` in the example. The loop extracts the timestamp before the first space. `replace("Z", "+00:00")` makes UTC explicit. `datetime.fromisoformat` parses it. The `if` includes events between cutoff and now.

### 4. Loop execution — dry run
`11:20` is older than `11:30` → skip; `11:45` falls within `11:30–12:00` → append. Final list contains one record.

### 5. Why these functions and methods?
`datetime` represents an instant, `timedelta` calculates offsets, `timezone.utc` keeps time comparisons consistent, and `fromisoformat` converts text to a datetime object.

### 6. Production example — DevOps / SRE
During an alert, collect only the last 30 minutes of errors around the incident instead of examining all historical logs.

### 7. Troubleshooting and follow-ups
Malformed timestamps raise `ValueError`; catch and quarantine those lines in a robust parser. Do not compare naive local times with UTC-aware timestamps. Streaming is better for enormous files if only a count is needed.

### 8. Short interview explanation
> I calculate the time cutoff, parse timestamps from each log record, and include only records between the cutoff and current UTC time.

---
<a id="q19"></a>
## Question 19: Run Linux, Azure CLI, or kubectl commands using `subprocess`

### 1. Concept
Python can execute a command-line tool and capture its output. We must check exit codes, set timeouts, and avoid constructing shell commands from untrusted input.

### 2. Implementation — code and output
```python
import subprocess

def get_python_version():
    result = subprocess.run(
        ["python", "--version"],
        capture_output=True,
        text=True,
        timeout=10,
        check=False,
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip())
    return result.stdout.strip() or result.stderr.strip()

print(get_python_version())
```
**Illustrative output:** `Python 3.12.8` (depends on installation).

### 3. Line-by-line explanation
`subprocess.run` launches the command. The list separates the executable and arguments. `capture_output=True` captures standard output and errors; `text=True` returns strings. `timeout=10` stops a stuck process. `returncode` tells whether it succeeded. We raise a clear error for failure and return the version string on success.

### 4. Execution trace
Python launches `python --version` → subprocess finishes → `returncode=0` → returns captured version. For a failure, `returncode` is nonzero, so the function raises an exception.

### 5. Why these functions and methods?
`run` is the preferred simple subprocess API; `capture_output` captures logs; `timeout` limits execution; `check=True` is an alternative that automatically raises `CalledProcessError` on nonzero exit.

### 6. Production example — DevOps / SRE
Execute `kubectl get pods -o json` from a controlled automation environment and parse JSON output to build a pod health report. Prefer an SDK where possible for structured access.

### 7. Troubleshooting and follow-ups
`FileNotFoundError` means the executable isn't available on PATH. Avoid `shell=True` with untrusted strings, because shell injection is possible. Check executable permissions and the Azure login context on pipeline agents.

### 8. Short interview explanation
> I use `subprocess.run` with a list of arguments, timeout, and output capture. I check the return code and handle failures instead of assuming the command succeeded.

---
<a id="q20"></a>
## Question 20: Archive or delete old log files safely

### 1. Concept
A maintenance script can find files older than a retention threshold. Production cleanup should start in **dry-run mode** so engineers can review exactly which files would be changed.

### 2. Implementation — code and output
```python
from pathlib import Path
from datetime import datetime, timedelta, timezone

def old_log_files(folder, days=30):
    cutoff = datetime.now(timezone.utc) - timedelta(days=days)
    for path in Path(folder).glob("*.log"):
        if not path.is_file() or path.is_symlink():
            continue
        modified = datetime.fromtimestamp(path.stat().st_mtime, timezone.utc)
        if modified < cutoff:
            print("DRY RUN - would archive:", path)

old_log_files("./logs")
```
**Illustrative output:** `DRY RUN - would archive: logs/application-older.log`

### 3. Line-by-line explanation
`Path(folder)` selects the directory. `glob('*.log')` returns only matching files within that folder. The loop ignores non-files and symbolic links. `stat().st_mtime` reads last-modified time, and `fromtimestamp` turns it into UTC datetime. The `if` identifies old files; the script **prints only**, so nothing is actually deleted.

### 4. Loop execution — dry run
`app-today.log`: newer than cutoff → skip. `application-older.log`: older than cutoff → print candidate. Other extensions don't match `*.log`.

### 5. Why these functions and methods?
`pathlib.Path` is clearer than manually joining path strings; `glob` filters filenames; `stat()` retrieves metadata; `timedelta` calculates retention age.

### 6. Production example — DevOps / SRE
Generate a daily dry-run report of aged VM logs, then archive selected logs to approved storage after retention-policy review. Only enable deletion behind an explicit approval and test restoreability first.

### 7. Troubleshooting and follow-ups
File modification time isn't always creation time. Concurrent log rotation can change files during scanning. Production code needs access checks, symlink protection, audit logs, exception handling, and retention/legal-hold safeguards.

### 8. Short interview explanation
> I use `pathlib` to find candidate log files, compare modification time to a retention cutoff, and first report the matches in dry-run mode before any approved cleanup.

---
<a id="q21"></a>
## Question 21: Design a scheduled Python automation with logging, failure handling, and no overlapping runs

### 1. Concept
Scheduled jobs may overlap when one run takes longer than expected. An **atomic lock file** can allow only one instance to execute; structured logging records success and failure. For distributed systems, use a proper shared lock or managed job scheduler.

### 2. Implementation — code and output
```python
import logging
import os
from pathlib import Path

logging.basicConfig(level=logging.INFO)
LOCK = Path("job.lock")

def run_job():
    fd = None
    try:
        fd = os.open(LOCK, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
        logging.info("Starting scheduled job")
        # Put idempotent API or inventory work here.
        logging.info("Job finished")
    except FileExistsError:
        logging.warning("Job already running; skipping")
    except Exception:
        logging.exception("Job failed")
        raise
    finally:
        if fd is not None:
            os.close(fd)
            LOCK.unlink(missing_ok=True)

run_job()
```
**Sample output, first run:** `INFO:root:Starting scheduled job` followed by `INFO:root:Job finished`.

### 3. Line-by-line explanation
`basicConfig` configures logging. `LOCK` is the lock-file path. `os.open(...O_EXCL...)` atomically fails when the file already exists. If lock acquisition succeeds, work runs. `except FileExistsError` skips another overlapping run. `logging.exception` retains a traceback. `finally` closes and removes the lock if this run created it.

### 4. Execution trace
Run A creates `job.lock` and enters the work. Run B attempts the same creation → receives `FileExistsError` → skips. When A ends, its `finally` removes its own lock file.

### 5. Why these functions and methods?
`os.O_EXCL` guarantees atomic create-if-absent on a suitable local filesystem; `try/except/finally` ensures cleanup; `logging` is better than uncontrolled `print` statements for operations jobs.

### 6. Production example — DevOps / SRE
Execute a nightly Azure resource inventory via cron, Task Scheduler, or an Azure-managed scheduling service. For production, use a lock backed by shared coordination if multiple agents could run the job.

### 7. Troubleshooting and follow-ups
A hard process crash can leave a stale local lock file; require safe operator cleanup or use OS-managed/shared locking. The local lock doesn't coordinate machines in different hosts, containers, or ephemeral agents. Limit runtime and make the job idempotent.

### 8. Short interview explanation
> I schedule the job, record progress with logging, wrap execution in exception handling, and use a lock so overlapping instances cannot run the same changes simultaneously.

---
<a id="apis"></a>
# 3. REST APIs, JSON, YAML and Resilience

<a id="q22"></a>
## Question 22: Call a REST API with Python, bearer authentication, JSON, and HTTP error handling

### 1. Concept
Python can integrate with REST APIs to collect data and trigger operations. A typical sequence is: read a token securely, send an HTTPS request, check the response, then parse JSON.

### 2. Implementation — code and output
Install: `pip install requests`. Set `API_URL` and `API_TOKEN` in your environment.
```python
import os
import requests

def fetch_resources():
    url = os.environ["API_URL"]
    token = os.environ["API_TOKEN"]
    response = requests.get(
        url,
        headers={"Authorization": f"Bearer {token}"},
        timeout=10,
    )
    response.raise_for_status()
    return response.json()

print(fetch_resources())
```
**Illustrative output for a JSON endpoint:** `{'resources': [{'name': 'vm1'}]}`.

### 3. Line-by-line explanation
`os.environ[...]` reads required environment variables and fails if missing. `requests.get` sends a GET with an Authorization header. `timeout` limits the wait. `raise_for_status()` raises for unsuccessful 4xx/5xx responses. `.json()` parses the response body into Python dictionaries/lists.

### 4. Execution trace
Read credentials → send request → receive, for example, HTTP 200 → validate status → parse JSON → print dictionary. For HTTP 403, `raise_for_status()` raises and does not reach JSON parsing.

### 5. Why these functions and methods?
`requests` handles HTTP; environment variables prevent putting tokens in source code (though a managed secret store is better); `raise_for_status` separates transport/API errors from valid JSON processing.

### 6. Production example — DevOps / SRE
Query an internal inventory API and compare the results with Azure resources. Prefer Entra-issued short-lived OAuth tokens rather than manually maintained long-lived bearer tokens.

### 7. Troubleshooting and follow-ups
Handle `requests.Timeout`, `HTTPError`, and malformed JSON (`ValueError`) at the call site. Never print token values or sensitive bodies to logs. Add pagination, retries for safe operations, and schema validation for production.

### 8. Short interview explanation
> I send an authenticated request using `requests`, set a timeout, check the HTTP status, and parse the JSON response. I keep credentials out of source code and handle failed requests.

---
<a id="q23"></a>
## Question 23: Read a JSON file, update its values, and write it back

### 1. Concept
JSON configuration is common in pipelines. Python's built-in `json` module converts JSON text to a dictionary, allowing us to modify fields and then serialize it back.

### 2. Implementation — code and output
Assume `config.json` contains `{"app":"payments","replicas":2}`.
```python
import json
from pathlib import Path

def update_replicas(path, replicas):
    file = Path(path)
    with file.open(encoding="utf-8") as handle:
        settings = json.load(handle)
    settings["replicas"] = replicas
    with file.open("w", encoding="utf-8") as handle:
        json.dump(settings, handle, indent=2)
    return settings

print(update_replicas("config.json", 4))
```
**Sample output:** `{'app': 'payments', 'replicas': 4}`

### 3. Line-by-line explanation
`Path` identifies the file. The first `with` opens it for reading and `json.load` parses the contents. `settings['replicas'] = replicas` changes the dictionary value in memory. The second `with` opens the file for writing and `json.dump` writes formatted JSON. We return the updated dictionary.

### 4. Execution trace
Input `replicas=2` → parse dictionary → assign `replicas=4` → write updated JSON → print the new dictionary. The old file contents are replaced.

### 5. Why these functions and methods?
`json.load` reads JSON from a **file object**; `json.loads` parses a **string**. `json.dump` writes to a file; `json.dumps` returns a JSON string. `indent=2` makes output easier to review.

### 6. Production example — DevOps / SRE
Update a generated deployment configuration for a staging environment after validating the requested replica count and committing the change through a reviewed pipeline.

### 7. Troubleshooting and follow-ups
`JSONDecodeError` means invalid JSON; `KeyError` may indicate expected fields are missing. Writing directly can truncate the file if interrupted; production tools should write to a temporary file and atomically replace the original after validation and backup.

### 8. Short interview explanation
> I read the JSON using `json.load`, update the required dictionary key, and save it with `json.dump`. I validate inputs before updating production configuration.

---
<a id="q24"></a>
## Question 24: Read Azure environment settings from a YAML file

### 1. Concept
YAML is frequently used for deployment configuration. Python can read YAML and select settings for one environment, such as the subscription, resource group, and region for QA or production.

### 2. Implementation — code and sample output
Install: `pip install pyyaml`. Save this as `env.yaml`:
```yaml
environments:
  dev:
    subscription: dev-subscription
    resource_group: rg-dev
    location: eastus
  prod:
    subscription: prod-subscription
    resource_group: rg-prod
    location: centralindia
```
```python
import yaml

def read_environment(path, name):
    with open(path, encoding="utf-8") as handle:
        data = yaml.safe_load(handle)
    return data["environments"][name]

settings = read_environment("env.yaml", "prod")
print(settings["resource_group"], settings["location"])
```
**Sample output:** `rg-prod centralindia`

### 3. Line-by-line explanation
`yaml.safe_load` converts the YAML document into Python nested dictionaries. `data['environments']` selects the top-level environment mapping; `[name]` chooses `prod`. The final `print` extracts two fields.

### 4. Execution trace
Read YAML → create nested dictionary → look up `environments` → look up `prod` → read `resource_group='rg-prod'` and `location='centralindia'`.

### 5. Why these functions and methods?
`yaml.safe_load` avoids constructing arbitrary Python objects from YAML tags; `[]` accesses known fields; `with open` closes the file automatically. Prefer validation of required keys and expected data types.

### 6. Production example — DevOps / SRE
A single Azure automation tool can read environment-specific configuration and deploy to the selected subscription only after validating an allowlist and receiving the appropriate approval.

### 7. Troubleshooting and follow-ups
A missing environment causes `KeyError`; malformed YAML raises a parsing error; `safe_load` can return `None` for an empty file. Never store production passwords or tokens as plain YAML in Git.

### 8. Short interview explanation
> I load YAML using `yaml.safe_load`, which gives a Python dictionary. I select the requested environment and read its subscription, resource group, and location values.

---

<a id="q25"></a>
## Question 25: Handle REST API failures — 429, 401/403, timeouts, and 500 errors

### 1. Concept
Not every API failure should be treated the same. HTTP `401` usually means authentication is missing or invalid; `403` usually means authenticated but not authorized; `429` means rate limiting; `500/503` can be temporary server problems. Network timeouts need separate handling.

### 2. Implementation — code and sample output
Install: `pip install requests`.
```python
import requests

def get_health(url):
    try:
        response = requests.get(url, timeout=5)
        if response.status_code == 429:
            return "RATE LIMITED: wait and retry"
        if response.status_code in (401, 403):
            return "AUTH ERROR: check token and roles"
        if response.status_code >= 500:
            return "SERVER ERROR: investigate or retry safely"
        response.raise_for_status()
        return "SUCCESS"
    except requests.Timeout:
        return "TIMEOUT: check dependency latency"
    except requests.RequestException:
        return "NETWORK OR HTTP ERROR"

print(get_health("https://example.com/"))
```
**Illustrative output:** `SUCCESS`

### 3. Line-by-line explanation
`try` wraps the request. `timeout=5` prevents an indefinite wait. The sequence of `if` statements distinguishes rate limits, permission problems, and server errors. `raise_for_status()` catches other HTTP errors (such as 404). Separate `except` blocks provide useful diagnosis for timeouts versus other request failures.

### 4. Execution trace
If the API responds with `429`, the function returns the rate-limit message immediately. With `403`, it recommends access checks. With HTTP 200, no condition matches and it returns `SUCCESS`. A timeout skips response checks and goes to the exception handler.

### 5. Why these functions and methods?
`.status_code` identifies server responses, `raise_for_status()` converts unsuccessful responses into exceptions, and `requests.Timeout` is a specialized exception. Separate classifications lead to different operational actions.

### 6. Production example — DevOps / SRE
An Azure inventory API may return 429 during a large subscription sweep. Instead of treating it as a permanent failure, use bounded retries with backoff and record the failed subscription if retries are exhausted.

### 7. Troubleshooting and follow-ups
Do **not** automatically retry all requests, especially non-idempotent POST operations. Check `Retry-After` for 429/503 when provided. A 403 is usually not fixed by waiting; verify scopes and RBAC. Avoid logging access tokens.

### 8. Short interview explanation
> I classify failures by status code. I investigate 401/403 as permissions issues, handle 429 with controlled retries, and use timeouts and logs for network or server errors.

---
<a id="q26"></a>
## Question 26: Implement retry logic with exponential backoff

### 1. Concept
Temporary failures such as HTTP 429 or 503 may clear after waiting. **Exponential backoff** increases the delay between attempts, reducing pressure on an overloaded service. Retries must be limited and should only be used for operations that are safe to repeat.

### 2. Implementation — code and sample output
```python
import time
import requests

def get_with_retry(url, attempts=4):
    for attempt in range(attempts):
        try:
            response = requests.get(url, timeout=5)
            if response.status_code not in (429, 500, 502, 503, 504):
                response.raise_for_status()
                return response.json()
        except (requests.Timeout, requests.ConnectionError):
            pass
        if attempt < attempts - 1:
            delay = min(2 ** attempt, 8)
            print("Retry in", delay, "seconds")
            time.sleep(delay)
    raise RuntimeError("API unavailable after retries")
```
**Illustrative retry output when requests keep failing:**
```text
Retry in 1 seconds
Retry in 2 seconds
Retry in 4 seconds
```
Then `RuntimeError` is raised.

### 3. Line-by-line explanation
`range(attempts)` controls the maximum number of tries. `requests.get` sends each request. Non-retryable HTTP statuses call `raise_for_status`; a successful one parses JSON. Timeouts and connection errors fall through to retry logic. `2 ** attempt` creates delays of 1, 2, 4, ... seconds. The last failure raises an explicit error instead of looping forever.

### 4. Loop execution — dry run
Attempt 1 returns 503 → wait 1s. Attempt 2 times out → wait 2s. Attempt 3 returns 200 → parse JSON and return immediately. Attempt 4 is never executed.

### 5. Why these functions and methods?
`range` limits attempts; `2 ** attempt` creates exponential delays; `min` caps the wait; `sleep` delays the next try. Production systems normally add random **jitter**, respect `Retry-After`, and use an overall time budget.

### 6. Production example — DevOps / SRE
A Python resource-inventory script queries Azure management APIs and receives occasional 429 responses. A bounded retry policy avoids a complete report failure while respecting service limits.

### 7. Troubleshooting and follow-ups
Do not blindly retry 401/403 or malformed responses. Retries for POST need idempotency keys or API-specific guarantees. This teaching example assumes a JSON response on success; validate `Content-Type` in a mature client.

### 8. Short interview explanation
> I retry only temporary failures, increase the delay after each failed attempt, cap the attempts, and stop immediately on success. I also check rate-limit guidance and avoid repeating unsafe operations.

---
<a id="q27"></a>
## Question 27: Convert JSON to YAML and YAML to JSON

### 1. Concept
JSON and YAML both represent structured data. JSON is common for REST API responses, while YAML is common for Kubernetes manifests and CI/CD files. Python can parse one format and serialize the result into the other.

### 2. Implementation — code and output
Install: `pip install pyyaml`.
```python
import json
import yaml

json_text = '{"app": "payments", "replicas": 2}'
data = json.loads(json_text)
yaml_text = yaml.safe_dump(data, sort_keys=False)
print(yaml_text)
restored = yaml.safe_load(yaml_text)
print(json.dumps(restored, sort_keys=True))
```
**Sample output**
```text
app: payments
replicas: 2

{"app": "payments", "replicas": 2}
```

### 3. Line-by-line explanation
`json.loads` parses a JSON **string** into a dictionary. `yaml.safe_dump` converts the dictionary to YAML text. `sort_keys=False` keeps existing key order for readability. `yaml.safe_load` parses YAML back into Python objects. `json.dumps` produces JSON text again.

### 4. Execution trace
JSON text → `{'app': 'payments', 'replicas': 2}` → YAML lines → the same dictionary → JSON string. No file access is required because this example operates on strings.

### 5. Why these functions and methods?
`loads/dumps` work with strings; `load/dump` work with file objects for JSON. Use `yaml.safe_load` rather than unsafe YAML object loading. `sort_keys=True` creates deterministic JSON key order for the displayed example.

### 6. Production example — DevOps / SRE
Convert an API-provided JSON configuration into a human-readable YAML file for a generated deployment manifest, after verifying the expected schema.

### 7. Troubleshooting and follow-ups
YAML supports some types and constructs not directly representable in JSON; anchors/comments may not survive conversion. Validate data types and avoid embedding secrets in generated files.

### 8. Short interview explanation
> I parse JSON using `json.loads`, write YAML using `yaml.safe_dump`, and reverse it with `yaml.safe_load` and `json.dumps`.

---
<a id="q28"></a>
## Question 28: Parse nested JSON and filter Azure-like resource records

### 1. Concept
Cloud APIs often return an object containing nested arrays and dictionaries. You can navigate those structures and filter items by fields such as region, type, or provisioning status.

### 2. Implementation — code and output
```python
response = {
    "value": [
        {"name": "vm1", "location": "eastus", "properties": {"state": "running"}},
        {"name": "vm2", "location": "centralindia", "properties": {"state": "stopped"}},
        {"name": "vm3", "location": "eastus", "properties": {"state": "running"}},
    ]
}

def running_in_region(payload, region):
    matches = []
    for resource in payload.get("value", []):
        if resource.get("location") == region and \
           resource.get("properties", {}).get("state") == "running":
            matches.append(resource["name"])
    return matches

print(running_in_region(response, "eastus"))
```
**Sample output:** `['vm1', 'vm3']`

### 3. Line-by-line explanation
`payload.get('value', [])` supplies an empty list if the field is absent. The loop processes each resource. The first `.get` checks region. The nested `.get('properties', {})` safely accesses the properties object when missing. Both conditions must match before appending the name.

### 4. Loop execution — dry run
`vm1`: eastus + running → include. `vm2`: different region → skip. `vm3`: eastus + running → include. Final list contains two names.

### 5. Why these functions and methods?
Nested dictionaries model JSON objects; lists model JSON arrays; `.get` lets us supply defaults. `and` combines conditions and short-circuits when the first is false.

### 6. Production example — DevOps / SRE
Filter a large Azure resource inventory response to show only resources in a particular region or in a target operational state.

### 7. Troubleshooting and follow-ups
Real Azure response schemas vary by API; VM power state is not always present as `properties.state`. Validate fields, support pagination, and use documented SDK operations where possible.

### 8. Short interview explanation
> I iterate over the JSON array, access nested dictionaries with `.get()`, apply conditions, and collect matching records in a list.

---
<a id="q29"></a>
## Question 29: Fetch all pages of a paginated REST API

### 1. Concept
APIs may return only one page at a time, along with a URL for the next page. A client must continue until the API provides no next link, otherwise the report misses resources.

### 2. Implementation — code and sample output
```python
import requests

def fetch_all(first_url, token):
    results = []
    url = first_url
    while url:
        response = requests.get(
            url, headers={"Authorization": f"Bearer {token}"}, timeout=10
        )
        response.raise_for_status()
        data = response.json()
        results.extend(data.get("value", []))
        url = data.get("nextLink")
    return results
```
**Illustrative page sequence:** page 1 returns `vm1, vm2` and a next link; page 2 returns `vm3` with no next link. **Result:** three records.

### 3. Line-by-line explanation
`results` collects records across pages. `url = first_url` starts with page 1. `while url` continues while there is a next-page URL. Each request returns JSON and `.extend` adds all items from that page. `data.get('nextLink')` becomes the next URL or `None`; the loop stops when it is missing.

### 4. Loop execution — dry run
Iteration 1: store `[vm1, vm2]`, update URL to page 2. Iteration 2: add `[vm3]`, next URL becomes `None`. Condition becomes false, and the result contains all three records.

### 5. Why these functions and methods?
`while` handles an unknown number of pages; `extend` adds multiple records, unlike `append`, which would add the whole page as one nested list; `.get` tolerates a missing next link.

### 6. Production example — DevOps / SRE
Collect resources across a large Azure subscription using an API that returns continuation links. Azure SDK paged iterators can abstract this logic for many Azure services.

### 7. Troubleshooting and follow-ups
Only follow continuation URLs trusted from the intended API and permitted hosts; a malicious nextLink could leak tokens. Add bounded retries, rate-limit handling, cycle detection, and maximum pages for safety. Different APIs use `@odata.nextLink`, `nextLink`, or continuation tokens.

### 8. Short interview explanation
> I start with the first API URL, collect its records, read the next-page link, and repeat until there are no more pages.

---
<a id="q30"></a>
## Question 30: Secure API tokens, credentials, and secrets in Python

### 1. Concept
Credentials should not appear in Python source code or Git. Use managed identities for Azure workloads and a secret manager such as Azure Key Vault when an external API requires a secret.

### 2. Implementation — code and sample output
Install: `pip install azure-identity azure-keyvault-secrets`.
```python
import os
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

def get_api_token():
    vault_url = os.environ["KEY_VAULT_URL"]
    client = SecretClient(vault_url=vault_url,
                          credential=DefaultAzureCredential())
    return client.get_secret("external-api-token").value

token = get_api_token()
print("Token retrieved:", bool(token))  # Do not print token itself
```
**Illustrative output:** `Token retrieved: True`.

### 3. Line-by-line explanation
`os.environ` supplies the vault URL, not the secret. `DefaultAzureCredential` obtains an identity token from a configured development or Azure identity. `SecretClient` connects to Key Vault. `get_secret` retrieves an authorized secret's value. `bool(token)` confirms it is present without exposing the credential.

### 4. Execution trace
Application starts → identity library finds a credential → requests access to Key Vault → Key Vault checks RBAC and network rules → returns the named secret if allowed.

### 5. Why these functions and methods?
`DefaultAzureCredential` is convenient across environments; `SecretClient` is the secret-management API. On a hosted production service, using an explicit `ManagedIdentityCredential` is often easier to reason about and avoids unintended credential-chain choices.

### 6. Production example — DevOps / SRE
A production Azure Function calls an external incident platform. Give its managed identity permission to read one Key Vault secret, and rotate that secret without rebuilding the function package.

### 7. Troubleshooting and follow-ups
`403` may indicate missing `Key Vault Secrets User` data-plane permission, secret policy configuration, or network restrictions. Confirm private endpoint DNS when Key Vault public access is disabled. Never print secrets or pass them on subprocess command lines.

### 8. Short interview explanation
> I use managed identity wherever possible and retrieve unavoidable secrets from Key Vault at runtime. I never hardcode or log access tokens.

---
<a id="q31"></a>
## Question 31: Trigger an Azure DevOps pipeline through REST API and monitor its result

### 1. Concept
Python can start a pipeline run and poll its status. The pipeline API accepts a POST to start a run and a GET to check it. Use a securely supplied Azure DevOps token with the necessary scopes.

### 2. Implementation — code and sample output
Install: `pip install requests`. Configure `AZDO_ORG`, `AZDO_PROJECT`, `PIPELINE_ID`, and `AZDO_PAT` in the environment for this example.
```python
import os
import time
import requests

base = (f"https://dev.azure.com/{os.environ['AZDO_ORG']}/"
        f"{os.environ['AZDO_PROJECT']}/_apis/pipelines/"
        f"{os.environ['PIPELINE_ID']}/runs")
auth = ("", os.environ["AZDO_PAT"])

started = requests.post(base, params={"api-version": "7.1"},
                        auth=auth, json={}, timeout=15)
started.raise_for_status()
run_id = started.json()["id"]

for attempt in range(30):
    response = requests.get(f"{base}/{run_id}",
                            params={"api-version": "7.1"},
                            auth=auth, timeout=15)
    response.raise_for_status()
    run = response.json()
    if run.get("state") == "completed":
        print("Pipeline result:", run.get("result"))
        break
    time.sleep(10)
else:
    raise TimeoutError("Pipeline still running after polling window")
```
**Illustrative output:** `Pipeline result: succeeded`.

### 3. Line-by-line explanation
`base` constructs the pipeline Runs endpoint. `auth=("", PAT)` uses HTTP Basic authentication without embedding the token in the URL. `requests.post` triggers a new run; its response contains the run ID. The loop polls that particular run up to 30 times. When the run state is completed, it prints the result and exits. The loop's `else` runs only if no `break` happened.

### 4. Loop execution — dry run
POST creates run 123. Poll 1: `inProgress` → sleep 10s. Poll 2: `inProgress` → sleep. Poll 3: `completed, succeeded` → print and break. Only three polls were needed.

### 5. Why these functions and methods?
`post` creates a pipeline run; `get` reads status; `.json()` parses the response; `range(30)` caps polling; `time.sleep` avoids hammering the API; `break` stops when finished.

### 6. Production example — DevOps / SRE
After verifying an infrastructure change request, a controlled internal tool triggers an approved deployment pipeline and records its run ID in a change ticket. Prefer a short-lived Azure DevOps access token or service connection where the execution context supports it.

### 7. Troubleshooting and follow-ups
A 401/403 may mean the token is invalid or has insufficient pipeline permissions. Confirm organization/project/pipeline IDs and HTTP status. Do not print the PAT. Production code should handle retryable 429/503 responses and verify that the finished result is `succeeded` before marking the operation successful.

### 8. Short interview explanation
> I call the Azure DevOps Run Pipeline API, get a run ID, then poll that run until it completes. I check whether the result succeeded or failed and report it to the caller.

---
<a id="azure-sdk"></a>
# 4. Azure SDK and Cloud Automation

<a id="q32"></a>
## Question 32: List Azure VMs across subscriptions with sizes and power states

### 1. Concept
Azure's Python SDK can enumerate subscriptions and VMs. The VM model contains the size, while actual **power state** comes from instance-view information, not simply the resource's provisioning status.

### 2. Implementation — code and sample output
Install: `pip install azure-identity azure-mgmt-resource azure-mgmt-compute` and authenticate using `az login` for local development.
```python
from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import SubscriptionClient
from azure.mgmt.compute import ComputeManagementClient

credential = DefaultAzureCredential()
subs = SubscriptionClient(credential)

for subscription in subs.subscriptions.list():
    sid = subscription.subscription_id
    compute = ComputeManagementClient(credential, sid)
    for vm in compute.virtual_machines.list_all():
        rg = vm.id.split("/resourceGroups/")[1].split("/")[0]
        view = compute.virtual_machines.instance_view(rg, vm.name)
        power = next((s.display_status for s in view.statuses
                      if s.code.startswith("PowerState/")), "Unknown")
        print(sid, rg, vm.name, vm.hardware_profile.vm_size, power)
```
**Illustrative output:** `subscription-id rg-prod vm-payments Standard_D2s_v5 VM running`.

### 3. Line-by-line explanation
`DefaultAzureCredential()` obtains an Azure credential. `SubscriptionClient` lists visible subscriptions. The outer `for` selects one subscription; `ComputeManagementClient` is created for that subscription. The inner loop gets each VM. We extract its resource-group name from its Azure resource ID, request `instance_view`, search statuses for `PowerState/`, and print the record.

### 4. Loop execution — dry run
Subscription A contains VM1 and VM2 → print two rows. Subscription B contains VM3 → print one row. The outer loop ensures we don't stop after the first subscription.

### 5. Why these functions and methods?
The SDK hides raw REST pagination for many list operations. `next(..., 'Unknown')` selects the first matching power-state status or a safe fallback. Instance view retrieves runtime state that a basic VM list may not include.

### 6. Production example — DevOps / SRE
Build a daily inventory report identifying VM location, SKU, and running/deallocated state across authorized enterprise subscriptions.

### 7. Troubleshooting and follow-ups
Permissions may differ per subscription, and instance-view calls can be throttled. Handle individual VM errors so one inaccessible VM doesn't abort the whole report. Avoid brittle resource-group parsing by using a resource ID helper or consistent case-insensitive parsing in production.

### 8. Short interview explanation
> I use `SubscriptionClient` to iterate subscriptions, `ComputeManagementClient` to list VMs, and VM instance view to retrieve accurate power states.

---
<a id="q33"></a>
## Question 33: Authenticate to Azure using DefaultAzureCredential, managed identity, or service principal

### 1. Concept
The Azure SDK uses **token credentials** instead of requiring a password in every API call. `DefaultAzureCredential` tries supported credential sources; `ManagedIdentityCredential` is a clearer production choice when code runs on a managed-identity-enabled Azure resource.

### 2. Implementation — code and sample output
Install: `pip install azure-identity`.
```python
import os
from azure.identity import DefaultAzureCredential, ManagedIdentityCredential

if os.getenv("RUNNING_IN_AZURE") == "true":
    credential = ManagedIdentityCredential()
else:
    credential = DefaultAzureCredential()

token = credential.get_token("https://management.azure.com/.default")
print("Azure token acquired:", bool(token.token))
```
**Illustrative output:** `Azure token acquired: True`.

### 3. Line-by-line explanation
`os.getenv` selects which credential mode we intend to use. On managed-identity-enabled compute, `ManagedIdentityCredential` requests a token for its assigned identity. Locally, `DefaultAzureCredential` can use the Azure CLI or supported developer credentials. `get_token` requests a token for the Azure management scope. We print only a Boolean, never the token.

### 4. Execution trace
Local development: mode false → DefaultAzureCredential → Azure CLI login found → token returned. Azure hosted: mode true → managed identity endpoint → token returned when identity is enabled.

### 5. Why these functions and methods?
`DefaultAzureCredential` reduces boilerplate when moving between local tools and Azure. `ManagedIdentityCredential` makes the production identity explicit and easier to audit. A service principal is useful in some automation systems, but prefer federation or certificates over long-lived client secrets.

### 6. Production example — DevOps / SRE
A Python tool running on an Azure VM uses its system-assigned managed identity to inventory resources with read-only RBAC, instead of keeping a service principal password in a config file.

### 7. Troubleshooting and follow-ups
Getting a token does **not** prove access to every Azure resource; RBAC is checked by the called service. Identity must be enabled, authorized, and able to reach the token service. Check tenant selection and credential-chain logs without exposing secrets.

### 8. Short interview explanation
> Locally I can use `DefaultAzureCredential`. For a production Azure workload, I prefer managed identity and least-privilege RBAC so no static cloud password needs to be stored.

---
<a id="q34"></a>
## Question 34: Identify Azure VM network interfaces with public IP references

### 1. Concept
Many organizations want to detect unintended public access. A VM's network interfaces can have IP configurations that reference Azure Public IP resources. We can inventory these references with the Network SDK.

### 2. Implementation — code and sample output
Install: `pip install azure-identity azure-mgmt-network`. Set `AZURE_SUBSCRIPTION_ID`.
```python
import os
from azure.identity import DefaultAzureCredential
from azure.mgmt.network import NetworkManagementClient

credential = DefaultAzureCredential()
network = NetworkManagementClient(
    credential, os.environ["AZURE_SUBSCRIPTION_ID"]
)
for nic in network.network_interfaces.list_all():
    public_ips = [config.public_ip_address.id
                  for config in nic.ip_configurations or []
                  if config.public_ip_address is not None]
    if public_ips:
        print(nic.name, public_ips)
```
**Illustrative output:** `nic-vm1 ['/subscriptions/.../publicIPAddresses/pip-vm1']`.

### 3. Line-by-line explanation
The client connects to one subscription. The outer loop reads each NIC. List comprehension checks each IP configuration and keeps only entries with a linked public IP reference. The `if public_ips` condition prints NICs with at least one such reference.

### 4. Loop execution — dry run
NIC-A has zero public IP references → skip. NIC-B has one → print. NIC-C has two configurations but no Public IP → skip.

### 5. Why these functions and methods?
`list_all()` enumerates NICs; list comprehension builds a filtered list; `or []` avoids iterating over `None`. NIC ownership can be determined from `nic.virtual_machine.id` if present.

### 6. Production example — DevOps / SRE
Generate a security review listing public-IP-attached NICs and the owning VM, then create remediation tickets rather than automatically disconnecting addresses during business hours.

### 7. Troubleshooting and follow-ups
This does not detect all public exposure routes (such as public load balancers or application gateways). A Public IP association alone doesn't guarantee an open inbound port; check NSGs, routes, and service exposure too. Iterate all authorized subscriptions for enterprise-wide reports.

### 8. Short interview explanation
> I use the Azure Network SDK to list NICs, inspect each IP configuration, and report any linked public IP resources for security review.

---
<a id="q35"></a>
## Question 35: Stop nonproduction Azure VMs outside business hours to save costs

### 1. Concept
A scheduled script can deallocate VMs with approved `Environment=nonprod` tags. **Deallocate**, not merely shut down inside the OS, if you want to stop compute billing in the standard VM case. Start with dry-run mode.

### 2. Implementation — code and sample output
Install: `pip install azure-identity azure-mgmt-compute`. Set `AZURE_SUBSCRIPTION_ID`. This example is dry-run by default.
```python
import os
from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient

compute = ComputeManagementClient(
    DefaultAzureCredential(), os.environ["AZURE_SUBSCRIPTION_ID"]
)
DRY_RUN = True

for vm in compute.virtual_machines.list_all():
    tags = {k.lower(): v.lower() for k, v in (vm.tags or {}).items()}
    if tags.get("environment") != "nonprod":
        continue
    rg = vm.id.split("/resourceGroups/")[1].split("/")[0]
    print("Candidate:", rg, vm.name)
    if not DRY_RUN:
        compute.virtual_machines.begin_deallocate(rg, vm.name).result()
```
**Illustrative output:** `Candidate: rg-qa vm-qa-01`.

### 3. Line-by-line explanation
`ComputeManagementClient` provides VM management APIs. The loop examines every VM and normalizes tags to lowercase. `continue` skips machines without a matching nonprod tag. The resource group is extracted from the VM ID. The script prints a candidate; `begin_deallocate` executes only if an operator explicitly changes `DRY_RUN` to `False`.

### 4. Loop execution — dry run
VM1 has `Environment=prod` → skip. VM2 has `Environment=nonprod` → print candidate, do not stop because dry run is true.

### 5. Why these functions and methods?
`.items()` iterates tag key/value pairs; `continue` skips non-matching VMs; `.result()` waits for the long-running deallocation operation to finish. Tags help declare ownership and cost policy.

### 6. Production example — DevOps / SRE
Deallocate approved QA VMs after business hours, then restart them on a weekday morning through a separate reviewed automation. Exclude critical schedulers, backup hosts, and exceptions.

### 7. Troubleshooting and follow-ups
Some VM sizes or dependencies have special billing and availability implications. Incorrect tags can cause unintended downtime. Use allowlists, approvals, change windows, and managed identities with minimum permissions. The simple resource ID parsing should be hardened for real inventory systems.

### 8. Short interview explanation
> I select VMs by approved nonproduction tags, test using dry run, and then use the Azure SDK deallocation operation through a controlled scheduled job.

---
<a id="q36"></a>
## Question 36: Upload, download, and list Azure Blob Storage files using managed identity

### 1. Concept
Blob Storage stores objects such as reports or backups. The Python SDK can upload, list, and download blobs over HTTPS. Managed identity lets a hosted application access Storage without putting account keys into code.

### 2. Implementation — code and sample output
Install: `pip install azure-storage-blob azure-identity`. Provide `STORAGE_ACCOUNT`, `BLOB_CONTAINER`, and `LOCAL_FILE`. Assign a suitable Storage Blob Data role.
```python
import os
from pathlib import Path
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient

account = os.environ["STORAGE_ACCOUNT"]
container = os.environ["BLOB_CONTAINER"]
client = BlobServiceClient(
    f"https://{account}.blob.core.windows.net",
    credential=DefaultAzureCredential(),
)
blob = client.get_blob_client(container=container, blob="report.txt")
with Path(os.environ["LOCAL_FILE"]).open("rb") as source:
    blob.upload_blob(source, overwrite=True)
for item in client.get_container_client(container).list_blobs():
    print("Blob:", item.name)
with Path("downloaded-report.txt").open("wb") as destination:
    destination.write(blob.download_blob().readall())
```
**Illustrative output:** `Blob: report.txt`.

### 3. Line-by-line explanation
`BlobServiceClient` connects to the storage account using a credential. `get_blob_client` points to one blob name. `open('rb')` reads a local file as bytes, and `upload_blob` uploads it. `list_blobs()` returns items through an iterator. `download_blob().readall()` downloads the blob data; the final `with` writes it to a local file.

### 4. Execution trace
Authenticate → upload local bytes as `report.txt` → list container objects and print names → download `report.txt` and save to `downloaded-report.txt`.

### 5. Why these functions and methods?
`with` closes files safely; `upload_blob` writes an object; `list_blobs` enumerates content; `download_blob` fetches an object. `readall` is easy for small files; stream in chunks for large files to avoid high memory use.

### 6. Production example — DevOps / SRE
An Azure automation job uploads daily inventory reports to a private Storage Account using managed identity and Storage Blob Data Contributor permission. Private endpoint DNS and network access must also be configured when public access is disabled.

### 7. Troubleshooting and follow-ups
403 can mean missing **data-plane** RBAC or storage networking restrictions. 404 may mean incorrect container/blob names. `overwrite=True` replaces content; for important production backups, use versioning, conditional writes, or immutable retention according to policy.

### 8. Short interview explanation
> I authenticate with Azure identity, create a Blob client, upload from a file, list blobs using the container client, and download content. I use RBAC and private networking in production.

---

<a id="q37"></a>
## Question 37: Send and receive Azure Event Hubs messages using Python

### 1. Concept
Azure Event Hubs ingests large volumes of streaming events. A **producer** publishes events; a **consumer** reads them from partitions. Consumer groups separate independent applications that need to read the same stream. Checkpoints help consumers resume from the correct position.

### 2. Implementation — code and sample output
Install: `pip install azure-eventhub azure-identity`. Set `EVENTHUB_NAMESPACE` (for example `myns.servicebus.windows.net`) and `EVENTHUB_NAME`. Use an identity with the appropriate Event Hubs Data Sender/Receiver roles.

**Producer (`send.py`):**
```python
import os
from azure.identity import DefaultAzureCredential
from azure.eventhub import EventHubProducerClient, EventData

producer = EventHubProducerClient(
    fully_qualified_namespace=os.environ["EVENTHUB_NAMESPACE"],
    eventhub_name=os.environ["EVENTHUB_NAME"],
    credential=DefaultAzureCredential(),
)
with producer:
    batch = producer.create_batch()
    batch.add(EventData('{"event":"payment_received"}'))
    producer.send_batch(batch)
print("Event sent")
```
**Consumer (`receive.py`; keep running until interrupted):**
```python
import os
from azure.identity import DefaultAzureCredential
from azure.eventhub import EventHubConsumerClient

def handle_event(partition_context, event):
    if event is not None:
        print("Partition", partition_context.partition_id,
              "Event", event.body_as_str())

consumer = EventHubConsumerClient(
    fully_qualified_namespace=os.environ["EVENTHUB_NAMESPACE"],
    eventhub_name=os.environ["EVENTHUB_NAME"],
    consumer_group="$Default",
    credential=DefaultAzureCredential(),
)
with consumer:
    consumer.receive(on_event=handle_event, starting_position="-1")
```
**Illustrative producer output:** `Event sent`. **Illustrative consumer output:** `Partition 0 Event {"event":"payment_received"}`.

### 3. Line-by-line explanation
The producer creates a client, opens it with `with`, creates a batch, adds one `EventData` object, and sends the batch. The consumer defines a callback that receives one event at a time. `EventHubConsumerClient` binds to a consumer group; `.receive()` invokes the callback as messages arrive. `starting_position='-1'` requests the earliest available events when no checkpoint controls the starting point.

### 4. Execution trace
Producer → batch created → JSON event added → send. Consumer → partition receiver starts → event arrives → `handle_event` prints partition and body. Receiving normally continues until the process is stopped.

### 5. Why these functions and methods?
`create_batch` respects Event Hubs batch limits; `EventData` wraps payloads; `send_batch` publishes them; `receive` subscribes; a callback processes each event. In production, add a Blob-backed checkpoint store rather than always replaying from the earliest position.

### 6. Production example — DevOps / SRE
Forward application audit events to Event Hubs for downstream analytics. Scale consumers by partition distribution; ensure event handlers can tolerate duplicate delivery and checkpoint only after successful processing.

### 7. Troubleshooting and follow-ups
403 often means missing Data Sender/Receiver RBAC or network restrictions. Check namespace DNS and private endpoint access. Large batches may exceed service limits; partitions influence parallelism and ordering. Production receivers need checkpointing, error callbacks, and a shutdown strategy. <https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-python-get-started-send>

### 8. Short interview explanation
> I create a producer client to send EventData batches and a consumer client to receive events by consumer group. In production I use managed identity, checkpointing, and idempotent processing.

---
<a id="q38"></a>
## Question 38: Send and receive Azure Storage Queue messages and handle retries

### 1. Concept
Azure Storage Queues separate message producers from workers. A worker retrieves a message, processes it, and deletes it only after success. Messages can appear again if not deleted before the visibility timeout, so handlers must be **idempotent**.

### 2. Implementation — code and sample output
Install: `pip install azure-storage-queue azure-identity`; set `STORAGE_ACCOUNT` and `QUEUE_NAME`; use the Storage Queue Data Contributor role.
```python
import os
from azure.identity import DefaultAzureCredential
from azure.storage.queue import QueueClient

queue = QueueClient(
    account_url=f"https://{os.environ['STORAGE_ACCOUNT']}.queue.core.windows.net",
    queue_name=os.environ["QUEUE_NAME"],
    credential=DefaultAzureCredential(),
)
queue.send_message("process-report-123")
print("Message submitted")

for message in queue.receive_messages(visibility_timeout=30):
    print("Processing:", message.content)
    # Delete only after real work has succeeded.
    queue.delete_message(message.id, message.pop_receipt)
    break
```
**Illustrative output**
```text
Message submitted
Processing: process-report-123
```

### 3. Line-by-line explanation
`QueueClient` connects to one queue. `send_message` adds a work item. `receive_messages` returns available messages and temporarily hides them using the visibility timeout. The loop processes one message. `delete_message(id, pop_receipt)` acknowledges completion. `break` makes this example stop after one message.

### 4. Execution trace
Producer sends → queue stores message → worker receives and it becomes invisible for 30 seconds → worker completes → worker deletes it. If processing fails before deletion, the message becomes eligible for another attempt after the visibility period.

### 5. Why these functions and methods?
`send_message` enqueues, `receive_messages` pulls work, `visibility_timeout` reduces duplicate simultaneous processing, `pop_receipt` confirms the worker's current claim, and `delete_message` completes the job.

### 6. Production example — DevOps / SRE
An Azure Function consumes report-generation requests from a queue. Each request includes a unique job ID so re-delivery does not generate duplicate invoices or reports.

### 7. Troubleshooting and follow-ups
Handle poison messages by inspecting dequeue count and redirecting repeatedly failing work to a designated poison queue or other failure store. The simple demo deletes immediately after printing; real code must delete only after successful business processing. Very long jobs need visibility renewal.

### 8. Short interview explanation
> I send work to a queue, receive it in a worker, and delete it only when processing succeeds. I expect possible re-delivery and make processing idempotent.

---
<a id="q39"></a>
## Question 39: Build a combined infrastructure and application health report

### 1. Concept
A health report merges signals from multiple places—HTTP health endpoints, VM or pod metrics, and recent alerts. It should identify **which check failed**, not merely show one generic green/red status.

### 2. Implementation — code and sample output
Install: `pip install requests psutil`.
```python
import json
import requests
import psutil

def create_health_report(url):
    report = {"cpu_percent": psutil.cpu_percent(interval=1)}
    try:
        response = requests.get(url, timeout=5)
        report["http_status"] = response.status_code
        report["application_healthy"] = response.status_code == 200
    except requests.RequestException:
        report["http_status"] = None
        report["application_healthy"] = False
    return report

print(json.dumps(create_health_report("https://example.com/health"), indent=2))
```
**Illustrative output:** `{"cpu_percent": 27.5, "http_status": 200, "application_healthy": true}` (formatted across lines).

### 3. Line-by-line explanation
We start a dictionary with one host metric. `requests.get` checks the application health URL. `status_code` records the HTTP result and a Boolean indicates success. A request exception makes the application unhealthy without crashing the report. `json.dumps(..., indent=2)` serializes the dictionary for readable output.

### 4. Execution trace
Collect CPU → send health request → receive 200 → set healthy true → serialize. If request times out, the `except` branch records `None` and false.

### 5. Why these functions and methods?
`psutil` collects operating-system data, `requests` checks the app, and `json.dumps` produces machine-readable output that a pipeline or dashboard can consume.

### 6. Production example — DevOps / SRE
Extend the report with Azure SDK resource status, Application Insights errors, AKS pod readiness, and active Azure Monitor alerts. Include UTC timestamps, source identifiers, and the correlation ID used for incident investigation.

### 7. Troubleshooting and follow-ups
A CPU measurement from a CI agent is **not** the CPU of the target Azure VM. Get remote metrics from Azure Monitor or the relevant SDK. Use a stable health endpoint, avoid storing sensitive response bodies, and distinguish failures from unavailable telemetry.

### 8. Short interview explanation
> I gather infrastructure and application checks into a single dictionary, handle each failure independently, and export the result as JSON for dashboards or incident automation.

---
<a id="advanced"></a>
# 5. Advanced Python and Testing

<a id="q40"></a>
## Question 40: Compare multithreading, multiprocessing, and asyncio for 100 API requests

### 1. Concept
For **I/O-bound tasks** such as HTTP calls, threads or `asyncio` can wait for many requests concurrently. For **CPU-bound Python calculations**, multiprocessing can use multiple CPU cores. Choose based on the workload and the libraries available.

### 2. Implementation — code and output
This runnable example **simulates I/O waits**, so it does not need network access:
```python
import time
from concurrent.futures import ThreadPoolExecutor

def call_api(resource_id):
    time.sleep(0.1)  # Simulated network latency
    return f"{resource_id}: OK"

resources = ["vm1", "vm2", "vm3", "vm4"]
with ThreadPoolExecutor(max_workers=4) as pool:
    results = list(pool.map(call_api, resources))
print(results)
```
**Sample output:** `['vm1: OK', 'vm2: OK', 'vm3: OK', 'vm4: OK']`.

### 3. Line-by-line explanation
`call_api` represents a slow network request. `ThreadPoolExecutor(max_workers=4)` creates up to four worker threads. `pool.map` submits one task per resource and returns results in **input order**, even when tasks finish out of order. `list(...)` collects results. `with` shuts down the pool when finished.

### 4. Execution trace
Four tasks begin close together. Each waits approximately 0.1 seconds. Results become available, and `map` returns them in the same order as `resources`.

### 5. Why these functions and methods?
Threads work well when requests release the interpreter to wait on I/O. `asyncio` scales many async-capable requests with `await`, while processes isolate CPU-heavy work. Bound concurrency to avoid API throttling.

### 6. Production example — DevOps / SRE
Collect Azure resource details in parallel across a limited number of subscriptions using a thread pool and an API-rate-limit policy. For CPU-intensive log compression, consider process-based parallelism instead.

### 7. Troubleshooting and follow-ups
High concurrency can cause HTTP 429, socket exhaustion, or high memory use. Use timeouts, bounded worker counts, connection pooling, and retries. Python's GIL historically limits some CPU-bound threaded execution; interpreter/runtime behavior depends on the Python build and version.

### 8. Short interview explanation
> For 100 Azure API calls, I would use bounded threads or asynchronous HTTP because they are I/O-bound. For CPU-heavy computation, I would consider multiprocessing.

---
<a id="q41"></a>
## Question 41: Design a production-ready Python automation script

### 1. Concept
A production script needs more than a successful API call: configuration validation, logging, safe authentication, retries, timeouts, meaningful exit codes, and predictable behavior during failures.

### 2. Implementation — code and output
Install: `pip install requests`.
```python
import logging
import os
import sys
import requests

logging.basicConfig(level=logging.INFO)

def main():
    url = os.environ.get("HEALTH_URL")
    if not url:
        raise ValueError("HEALTH_URL is required")
    response = requests.get(url, timeout=5)
    response.raise_for_status()
    logging.info("Health check succeeded: status=%s", response.status_code)

if __name__ == "__main__":
    try:
        main()
    except Exception:
        logging.exception("Health check failed")
        sys.exit(1)
```
**Illustrative successful output:** `INFO:root:Health check succeeded: status=200`.

### 3. Line-by-line explanation
`logging` records structured operational messages. `os.environ.get` reads configuration. `if not url` prevents execution without required settings. The request has a timeout and raises for bad HTTP responses. `if __name__ == '__main__'` runs the program only when executed directly. Any unhandled failure is logged with a traceback and exits with code 1.

### 4. Execution trace
Configuration exists → send GET → 200 → log success → exit 0. Missing URL → raise `ValueError` → log traceback → exit 1, which CI/CD can detect.

### 5. Why these functions and methods?
`sys.exit(1)` tells the scheduler/pipeline a failure occurred; `logging.exception` captures traceback; `raise_for_status` validates the response. Production versions should add retries with jitter only for retryable failures.

### 6. Production example — DevOps / SRE
Use this as a post-deployment smoke test in Azure DevOps. Combine it with a read-only check of Application Insights error rates before promoting traffic.

### 7. Troubleshooting and follow-ups
Avoid broad `except` within the core logic that hides the failure. Never log secrets. Add request correlation IDs, unit tests, metrics, and idempotency for scripts that modify cloud resources.

### 8. Short interview explanation
> I keep production scripts configurable, add logging and timeouts, fail with nonzero exit codes, handle exceptions, use safe credentials, and test before putting them in a pipeline.

---
<a id="q42"></a>
## Question 42: Explain list, tuple, set, and dictionary with DevOps examples

### 1. Concept
These are Python's most common built-in collections. Choose them based on whether you need order, uniqueness, key/value lookup, or an immutable group of values.

### 2. Implementation — code and output
```python
names = ["vm1", "vm2", "vm1"]
region = ("centralindia", "zone1")
unique_names = set(names)
vm_status = {"vm1": "Running", "vm2": "Stopped"}

print(names)
print(region)
print(sorted(unique_names))
print(vm_status["vm2"])
```
**Sample output**
```text
['vm1', 'vm2', 'vm1']
('centralindia', 'zone1')
['vm1', 'vm2']
Stopped
```

### 3. Line-by-line explanation
`names` is an ordered list that permits duplicates. `region` is a tuple, commonly used for a fixed group of values. `set(names)` removes duplicates. `vm_status` maps VM names to statuses. `sorted(unique_names)` gives a predictable order for display; dictionary indexing retrieves the specific status.

### 4. Execution trace
The list contains three entries. The set holds only two unique entries. The dictionary lookup finds the value stored under `vm2`, which is `Stopped`.

### 5. Why these functions and methods?
Lists support ordered iteration and mutation; tuples are immutable; sets optimize membership and uniqueness; dictionaries support fast key-based lookup. Set display order should not be relied upon.

### 6. Production example — DevOps / SRE
Use a list for VM inventory, a tuple for an immutable `(region, zone)` pair, a set to deduplicate resource IDs, and a dictionary to map each resource ID to its health state.

### 7. Troubleshooting and follow-ups
`set()` needs hashable elements. Dictionary keys must be hashable. Lists are mutable and may be modified unintentionally if shared between functions.

### 8. Short interview explanation
> A list stores ordered items, a tuple stores a fixed group, a set removes duplicates, and a dictionary stores values by key. I choose based on how the data is accessed.

---
<a id="q43"></a>
## Question 43: Explain functions, `*args`, `**kwargs`, lambda, generators, and decorators

### 1. Concept
These Python features help make automation reusable. `*args` accepts multiple positional values; `**kwargs` accepts named options; lambdas express small functions; generators produce one item at a time; decorators wrap a function with extra behavior.

### 2. Implementation — code and output
```python
def log_call(func):
    def wrapper(*args, **kwargs):
        print("Calling", func.__name__)
        return func(*args, **kwargs)
    return wrapper

@log_call
def total(*values, scale=1):
    return sum(values) * scale

def squared(numbers):
    for number in numbers:
        yield number ** 2

print(total(2, 3, 5, scale=2))
print(list(squared([1, 2, 3])))
print(sorted([3, 1, 2], key=lambda x: -x))
```
**Sample output**
```text
Calling total
20
[1, 4, 9]
[3, 2, 1]
```

### 3. Line-by-line explanation
`log_call` receives a function and returns a new `wrapper`. `*args` and `**kwargs` pass its original arguments through. The `@log_call` decorator wraps `total` so a message prints before calculating. Inside `total`, `*values` collects positional numbers and `scale` is a named option. The generator `squared` uses `yield` to produce one square at a time. The final `lambda` tells `sorted` to rank larger numbers first via negative keys.

### 4. Execution trace
Call `total(2,3,5,scale=2)` → wrapper logs → original function sums 10 and multiplies by 2 → returns 20. `list(squared(...))` drives the generator through three `yield` points, producing 1, 4, and 9.

### 5. Why these functions and methods?
`yield` supports lazy streaming; decorators centralize logging, retries, or timing; `*args/**kwargs` support reusable wrappers; lambdas are concise for one-expression functions.

### 6. Production example — DevOps / SRE
Add a decorator around approved automation functions to log start/end and execution time, or use a generator to stream inventory records without loading all records at once.

### 7. Troubleshooting and follow-ups
A decorator can hide the original function metadata; use `functools.wraps` for production wrappers. Do not hide exceptions or turn a failed API operation into a false success. `yield` creates a generator object until iterated.

### 8. Short interview explanation
> I use functions for reuse, `*args/**kwargs` for flexible inputs, lambda for small functions, generators for memory-efficient iteration, and decorators to add common behavior such as logging.

---
<a id="q44"></a>
## Question 44: Unit-test Python Azure/API automation using pytest and mocking

### 1. Concept
Unit tests should validate your script without requiring real Azure resources or live internet access. **Mocking** replaces external API calls with predictable test responses, so tests are fast and safe.

### 2. Implementation — code and sample output
Install: `pip install pytest requests`. File `health.py`:
```python
import requests

def is_healthy(url):
    response = requests.get(url, timeout=5)
    return response.status_code == 200
```
File `test_health.py`:
```python
import health

def test_healthy_endpoint(monkeypatch):
    class FakeResponse:
        status_code = 200
    def fake_get(url, timeout):
        assert timeout == 5
        return FakeResponse()
    monkeypatch.setattr(health.requests, "get", fake_get)
    assert health.is_healthy("https://example.com/health") is True
```
Run:
```bash
pytest -q
```
**Illustrative output:** `1 passed in 0.03s`.

### 3. Line-by-line explanation
`is_healthy` performs an HTTP GET and checks status 200. In the test, `FakeResponse` imitates the small part of a response we need. `fake_get` replaces the network call and checks the timeout. `monkeypatch.setattr` swaps the real function with the fake during this test. The final `assert` verifies the expected behavior.

### 4. Execution trace
Pytest discovers `test_healthy_endpoint` → patches the HTTP call → calls `is_healthy` → fake returns 200 → function returns `True` → assertion passes.

### 5. Why these functions and methods?
`pytest` discovers tests; `assert` verifies behavior; `monkeypatch` safely changes dependencies for one test. Mocking avoids depending on external outages, credentials, or cost-incurring infrastructure during unit tests.

### 6. Production example — DevOps / SRE
Add tests to Azure DevOps before deploying a Python health-check tool. Test success, HTTP 500, timeout, missing configuration, and invalid JSON cases.

### 7. Troubleshooting and follow-ups
Patch the symbol **where the code uses it**, not necessarily where the dependency was originally defined. Unit tests don't replace integration tests; verify real managed identity/RBAC paths in a controlled QA environment.

### 8. Short interview explanation
> I use pytest with mocks to simulate Azure or REST API responses, test success and failure behavior, and run the tests automatically before deployment.

---
<a id="q45"></a>
## Question 45: Make a Python infrastructure automation script idempotent

### 1. Concept
**Idempotency** means running the same operation repeatedly produces the same desired final state. For example, a script should not create a second storage container just because it runs again.

### 2. Implementation — code and output
This local example simulates a remote resource store:
```python
resources = {}

def ensure_resource(name, location):
    if name not in resources:
        resources[name] = {"location": location}
        return "created"
    if resources[name]["location"] != location:
        resources[name]["location"] = location
        return "updated"
    return "unchanged"

print(ensure_resource("storage-qa", "eastus"))
print(ensure_resource("storage-qa", "eastus"))
```
**Sample output**
```text
created
unchanged
```

### 3. Line-by-line explanation
`resources` simulates the current infrastructure. The function checks whether a name already exists. If not, it creates an entry. If an existing value differs, it updates that value. If desired and current values match, it returns `unchanged` without taking action.

### 4. Execution trace
First call: missing name → create. Second call: same name and location → do nothing. The final resource store still has one entry.

### 5. Why these functions and methods?
Dictionary membership checks whether an object exists; comparison determines whether an update is needed; early returns make the three outcomes clear.

### 6. Production example — DevOps / SRE
For Azure APIs, use resource IDs and supported create-or-update operations where possible. Read the existing configuration first, compare the desired properties, and make changes only when necessary.

### 7. Troubleshooting and follow-ups
This is a demonstration; a local dictionary is not authoritative cloud state. Parallel jobs can race between read and create: use conditional requests, ETags, state locking, or a controlled queue. Some cloud updates are asynchronous and require polling.

### 8. Short interview explanation
> I first check the actual resource state, create it only if missing, update it only if different, and otherwise do nothing. That allows safe repeated automation runs.

---
<a id="q46"></a>
## Question 46: Troubleshoot Python working locally but failing in Azure DevOps

### 1. Concept
Local and pipeline environments may have different Python versions, packages, working directories, network routes, credentials, and permissions. The fastest approach is to identify **which environment assumption changed**.

### 2. Implementation — diagnostic code and sample output
Add this safe diagnostic step to the pipeline script:
```python
import os
import sys
from pathlib import Path
import importlib.util

print("Python:", sys.version.split()[0])
print("Working directory:", Path.cwd())
print("Config exists:", Path("config.yaml").exists())
print("requests installed:", importlib.util.find_spec("requests") is not None)
print("Azure subscription configured:", bool(os.getenv("AZURE_SUBSCRIPTION_ID")))
```
**Illustrative output**
```text
Python: 3.12.8
Working directory: /agent/work/1/s
Config exists: False
requests installed: True
Azure subscription configured: True
```

### 3. Line-by-line explanation
`sys.version` prints the interpreter version. `Path.cwd()` shows the working directory from which relative paths resolve. `Path(...).exists()` checks whether the expected file is there. `importlib.util.find_spec` tests whether a package can be found. `bool(os.getenv(...))` checks the presence of an environment variable without showing its value.

### 4. Execution trace
The pipeline starts the Python process → prints five environment checks → identifies, for example, `Config exists: False` → engineer corrects checkout path or working directory before rerunning.

### 5. Why these functions and methods?
`sys` shows runtime information; `pathlib` tests file paths; `find_spec` diagnoses missing installations; environment checks avoid printing sensitive secret values.

### 6. Production example — DevOps / SRE
A deployment health-check script fails only on a self-hosted agent. Diagnostics reveal an unreachable private endpoint and a different DNS resolver than the developer laptop.

### 7. Troubleshooting and follow-ups
Also inspect `requirements.txt` lockfiles, proxy settings, service connections, managed identity, Azure Firewall rules, agent egress, certificate stores, and exception stack traces. Fix root cause rather than adding broad privileges to the pipeline identity.

### 8. Short interview explanation
> I compare the Python environment, packages, files, credentials, and network access in the pipeline with local execution. I use logs and safe diagnostics to isolate the difference.

---
<a id="terraform-ai"></a>
# 6. Terraform Integration and Agentic AI

<a id="q47"></a>
## Question 47: Parse Terraform plan JSON and flag deletes or replacements

### 1. Concept
A Terraform plan includes a structured `resource_changes` array. Each change has an `actions` list such as `['create']`, `['update']`, or both `delete` and `create` for replacement. Python can inspect it before manual approval.

### 2. Implementation — code and sample output
Generate a plan JSON from a local reviewed plan:
```bash
terraform plan -out=tfplan
terraform show -json tfplan > plan.json
```
Then run:
```python
import json

def dangerous_changes(path):
    with open(path, encoding="utf-8") as file:
        plan = json.load(file)
    risks = []
    for item in plan.get("resource_changes", []):
        actions = item.get("change", {}).get("actions", [])
        if "delete" in actions:
            kind = "REPLACE" if "create" in actions else "DELETE"
            risks.append((item["address"], kind))
    return risks

for address, kind in dangerous_changes("plan.json"):
    print(kind, address)
```
**Illustrative output:** `REPLACE azurerm_linux_virtual_machine.api`.

### 3. Line-by-line explanation
`json.load` parses the saved plan. `resource_changes` lists planned changes. The loop inspects each item's nested `change.actions`. Any sequence containing `delete` is potentially destructive. When both `delete` and `create` appear, Terraform plans a replacement. We append a resource address and classification to a risk list and print it.

### 4. Loop execution — dry run
A resource with `['no-op']` is ignored. `['update']` is ignored by this destructive-change filter. `['delete']` is classified DELETE. `['delete','create']` is classified REPLACE.

### 5. Why these functions and methods?
`json.load` reads the plan; `.get` handles absent optional fields; membership test `in` is appropriate because replacement order can vary; tuples store resource address plus classification.

### 6. Production example — DevOps / SRE
Run this check during an Azure DevOps PR pipeline, publish a destruction-risk report, and require explicit production approval before applying the exact reviewed plan artifact.

### 7. Troubleshooting and follow-ups
A plan JSON file may contain **sensitive values**; store it with restricted access and short retention. Do not assume every `update` is safe. For a production policy, inspect resource types, attributes, planned values, and exceptions too. <https://developer.hashicorp.com/terraform/internals/json-format>

### 8. Short interview explanation
> I export the Terraform plan to JSON, loop through `resource_changes`, and flag actions containing `delete`. If `create` is also present, I mark it as a replacement.

---
<a id="q48"></a>
## Question 48: Trigger and monitor a Terraform Enterprise run using Python

### 1. Concept
Terraform Enterprise offers an API to create runs and read their status. A Python internal tool can request a plan, collect its run ID, and monitor progress while preserving manual apply approvals and policy checks.

### 2. Implementation — code and sample output
Install: `pip install requests`. Set `TFE_URL`, `TFE_TOKEN`, and `TFE_WORKSPACE_ID`. This example creates a run and reads its status; it **does not approve an apply**.
```python
import os
import requests

base = os.environ["TFE_URL"].rstrip("/")
headers = {
    "Authorization": f"Bearer {os.environ['TFE_TOKEN']}",
    "Content-Type": "application/vnd.api+json",
}
payload = {"data": {
    "type": "runs",
    "attributes": {"message": "Requested by SRE automation"},
    "relationships": {"workspace": {"data": {
        "type": "workspaces", "id": os.environ["TFE_WORKSPACE_ID"]
    }}}
}}
response = requests.post(f"{base}/api/v2/runs", headers=headers,
                         json=payload, timeout=20)
response.raise_for_status()
run_id = response.json()["data"]["id"]
status = requests.get(f"{base}/api/v2/runs/{run_id}",
                      headers=headers, timeout=20)
status.raise_for_status()
print("Run", run_id, "status:", status.json()["data"]["attributes"]["status"])
```
**Illustrative output:** `Run run-ABC123 status: planning`.

### 3. Line-by-line explanation
`base` selects the Terraform Enterprise server URL. The bearer header authenticates the API call. `payload` identifies the workspace and provides a run message. POST creates a run. The JSON response includes a run ID. GET retrieves that run's current state. We print its ID and state without exposing the bearer token.

### 4. Execution trace
Build request → POST run → receive run ID → GET run status → print `planning`. A monitoring extension would poll periodically until an appropriate terminal state, failed state, or manual-approval stage.

### 5. Why these functions and methods?
`requests.post` creates a run; `requests.get` reads it; `raise_for_status` handles HTTP errors; nested JSON access extracts the run ID/status.

### 6. Production example — DevOps / SRE
An internal change portal requests a Terraform Enterprise run, links the run ID to a change record, and waits for reviewers to examine the plan and policy results in Terraform Enterprise before anyone approves apply.

### 7. Troubleshooting and follow-ups
403 indicates missing workspace/API permissions. A run may be queued, require confirmation, fail policy checks, or be errored; do not report successful deployment just because the run was created. Validate run state transitions and honor organizational approval requirements. See <https://developer.hashicorp.com/terraform/enterprise/api-docs/run>.

### 8. Short interview explanation
> I call the Terraform Enterprise Runs API using a scoped token, record the run ID, poll its state, and report whether planning, policies, and apply succeeded or need manual approval.

---
<a id="q49"></a>
## Question 49: Explain agentic AI and build a simple Python-based Azure troubleshooting assistant

### 1. Concept
An **AI agent** goes beyond one chat response: it can decide which tools to call, use their results, and propose a next step. In production SRE, tools should first be **read-only**; any change to infrastructure requires human approval. Azure AI Foundry / Microsoft Foundry can host models, while LangChain or LangGraph can help organize tools and workflows.

### 2. Implementation — simple executable teaching example and output
This example shows the **agent workflow** using a deterministic decision function; it is **not a live LLM**. Replace `choose_tool` with an approved model's structured tool-calling response when integrating with Foundry.
```python
def check_runbook(service):
    return {"aks": "Check pod logs and events", "vm": "Check VM health"}.get(
        service, "Escalate to platform team"
    )

def choose_tool(alert):
    return "runbook" if alert["service"] in ("aks", "vm") else "escalate"

def diagnose(alert):
    choice = choose_tool(alert)
    if choice == "runbook":
        return {"alert": alert["message"],
                "recommendation": check_runbook(alert["service"])}
    return {"alert": alert["message"], "recommendation": "Human review"}

print(diagnose({"service": "aks", "message": "CrashLoopBackOff"}))
```
**Sample output:** `{'alert': 'CrashLoopBackOff', 'recommendation': 'Check pod logs and events'}`.

### 3. Line-by-line explanation
`check_runbook` maps supported services to approved diagnostics. `choose_tool` selects a safe action based on the alert type. `diagnose` calls the selector and either looks up a runbook or requests human review. The final call passes an AKS alert and prints the proposed next step.

### 4. Execution trace
Receive AKS alert → tool selector returns `runbook` → runbook lookup returns `Check pod logs and events` → recommendation returned. No cluster changes occur.

### 5. Why these functions and methods?
Functions isolate decision logic from diagnostic tools. `dict.get` provides a safe fallback. In an LLM integration, a structured tool schema and strict allowlist should replace free-form instructions to execute commands.

### 6. Production example — DevOps / SRE
A Foundry-hosted model analyzes an Azure Monitor alert, calls read-only tools for pod status and log summaries, then recommends a documented troubleshooting runbook. A human validates findings before any restart or scaling operation.

### 7. Troubleshooting and follow-ups
LLMs can hallucinate causes and produce unsafe tool requests. Validate tool arguments, redact private logs, enforce least-privilege identities, retain audit records, and test against prompt-injection attempts embedded in logs. LangGraph can represent multi-step approval and diagnostic states.

### 8. Short interview explanation
> Agentic AI uses a model with tools to investigate a problem in steps. For Azure SRE, I would start with read-only alerts and log tools, then require human approval before executing remediation.

---
<a id="q50"></a>
## Question 50: Securely integrate an LLM with Azure infrastructure APIs using Python

### 1. Concept
An LLM should never get unlimited cloud permissions or be allowed to execute arbitrary commands. Use an **allowlisted tool layer**, managed identity, input validation, redacted logs, rate limits, and human approval for high-risk actions.

### 2. Implementation — safe Python tool gateway and sample output
This runnable example simulates a gateway after an LLM suggests a tool call. It intentionally allows read-only actions and blocks changes unless separately approved.
```python
ALLOWED_READ_TOOLS = {"get_vm_status", "get_pod_events"}

def get_vm_status(resource_id):
    return {"resource_id": resource_id, "status": "Unknown (demo)"}

def execute_tool(name, resource_id, approved=False):
    if not resource_id.startswith("/subscriptions/"):
        raise ValueError("Invalid Azure resource ID")
    if name in ALLOWED_READ_TOOLS:
        if name == "get_vm_status":
            return get_vm_status(resource_id)
        return {"events": []}  # Demo only
    if not approved:
        raise PermissionError("Change requires human approval")
    raise NotImplementedError("No change tools enabled")

rid = "/subscriptions/example/resourceGroups/rg/providers/Microsoft.Compute/virtualMachines/vm1"
print(execute_tool("get_vm_status", rid))
```
**Sample output:** `{'resource_id': '/subscriptions/example/resourceGroups/rg/providers/Microsoft.Compute/virtualMachines/vm1', 'status': 'Unknown (demo)'}`.

### 3. Line-by-line explanation
`ALLOWED_READ_TOOLS` defines permitted read-only operations. `get_vm_status` is a local demonstration stub, not an Azure SDK call. `execute_tool` validates the resource ID format, checks the tool name against the allowlist, and dispatches permitted requests. Change requests without approval raise `PermissionError`; even with an approval flag, this example does not implement destructive operations.

### 4. Execution trace
Model suggests `get_vm_status` → gateway validates resource ID → finds tool in allowlist → executes read-only stub → returns status object. If it suggests `delete_vm`, the gateway rejects it unless separately approved, and no delete capability is implemented.

### 5. Why these functions and methods?
A `set` makes allowlist membership simple; `startswith` performs a basic format check; `raise` enforces guardrails. In production, validate resource IDs using a strict schema, authorize exact scopes and operations server-side, and require a trusted approval signal—not an LLM-generated Boolean.

### 6. Production example — DevOps / SRE
A Microsoft Foundry-hosted assistant uses Azure Monitor and approved read-only SDK tools to summarize incidents. A separate service with tightly scoped RBAC handles any approved remediation and logs the human approver, change ticket, tool parameters, and outcome.

### 7. Troubleshooting and follow-ups
Treat prompts, retrieved logs, and tool outputs as untrusted content. Prevent credential leakage and cross-subscription access through server-side authorization. Rate-limit model/tool calls and test prompt injection, data exfiltration, and false-positive recommendations. This demo is a control pattern, not a fully integrated LLM application.

### 8. Short interview explanation
> I connect the LLM to a controlled tool gateway with managed identity and least-privilege access. The model can request read-only checks, but privileged infrastructure changes need separate human approval and full auditing.

---

## Official documentation and further practice

- [Python tutorial and standard library](https://docs.python.org/3/tutorial/) — loops, functions, exceptions, files, JSON, and collections.
- [Azure Identity guidance for Python](https://learn.microsoft.com/en-us/azure/developer/python/sdk/authentication/credential-chains) — credential selection and managed identity.
- [Azure Event Hubs with Python](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-python-get-started-send) — sending, receiving, and checkpoints.
- [Azure DevOps Run Pipeline REST API](https://learn.microsoft.com/en-us/rest/api/azure/devops/pipelines/runs/run-pipeline?view=azure-devops-rest-7.1) — trigger a pipeline programmatically.
- [Terraform JSON plan format](https://developer.hashicorp.com/terraform/internals/json-format) — `resource_changes` and `actions`.
- [Terraform Enterprise Runs API](https://developer.hashicorp.com/terraform/enterprise/api-docs/run) — run creation, states, and review workflow.

**Production reminder:** Commands that update cloud resources can cause cost or downtime. Use a test environment, short-lived credentials, least-privilege permissions, dry runs, and change approval before enabling production changes.
