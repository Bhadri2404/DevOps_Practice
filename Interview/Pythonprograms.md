Great, let’s take those same 10 beginner‑friendly programs and add **clear line‑by‑line explanations** for each.

***

## 1. Find duplicate elements in a list

```python
items = ["nginx", "redis", "nginx", "python", "redis", "redis"]

duplicates = []

for item in items:
    # count how many times this item appears in the list
    count = items.count(item)
    # if appears more than once and not already in duplicates list, add it
    if count > 1 and item not in duplicates:
        duplicates.append(item)

print("Duplicates:", duplicates)
```

**Explanation (line by line):**

- `items = ["nginx", "redis", "nginx", "python", "redis", "redis"]`  
  Create a list of strings; some values appear more than once.

- `duplicates = []`  
  Start with an empty list that will store only the duplicated values.

- `for item in items:`  
  Loop through each element in the `items` list.

- `count = items.count(item)`  
  For the current `item`, count how many times it appears in the list.

- `if count > 1 and item not in duplicates:`  
  If the item appears more than once and is not already in `duplicates`, we want to add it.

- `duplicates.append(item)`  
  Add this item to the `duplicates` list.

- `print("Duplicates:", duplicates)`  
  Print the list of duplicates collected.

***

## 2. Check if a string is a palindrome

```python
def is_palindrome(text):
    # make everything lowercase and remove spaces
    text = text.lower().replace(" ", "")
    # reverse the string using slicing
    reversed_text = text[::-1]
    # compare original and reversed
    return text == reversed_text

print(is_palindrome("Madam"))       # True
print(is_palindrome("nurses run"))  # True
print(is_palindrome("devops"))      # False
```

**Explanation:**

- `def is_palindrome(text):`  
  Define a function named `is_palindrome` that takes a string `text`.

- `text = text.lower().replace(" ", "")`  
  Convert the string to lowercase and remove spaces so that things like “Nurses Run” and “nursesrun” are treated the same.

- `reversed_text = text[::-1]`  
  Create a new string that is the reverse of `text` using slicing.

- `return text == reversed_text`  
  Return `True` if the cleaned text is the same forwards and backwards, otherwise `False`.

- `print(is_palindrome("Madam"))`  
  Call the function with `"Madam"` and print the result.

- `print(is_palindrome("nurses run"))`  
  Call the function with a phrase that has a space; still works because we removed spaces.

- `print(is_palindrome("devops"))`  
  Example of a string that is not a palindrome.

***

## 3. Factorial of a number (loop)

```python
def factorial(n):
    if n < 0:
        print("Factorial is not defined for negative numbers")
        return None

    result = 1

    # multiply result by each number from 1 to n
    for i in range(1, n + 1):
        result = result * i

    return result

print(factorial(5))  # 120
```

**Explanation:**

- `def factorial(n):`  
  Define a function `factorial` that takes an integer `n`.

- `if n < 0:`  
  Check if the input is negative.

- `print("Factorial is not defined for negative numbers")`  
  Inform the user that factorial is not defined for negative numbers.

- `return None`  
  Exit the function early if `n` is negative.

- `result = 1`  
  Start with `result` equal to 1; this will store the running product.

- `for i in range(1, n + 1):`  
  Loop from 1 up to and including `n`.

- `result = result * i`  
  Multiply the current `result` by `i` each time through the loop.

- `return result`  
  After the loop finishes, return the final factorial value.

- `print(factorial(5))`  
  Call `factorial` with 5, which should return 120, and print the result.

***

## 4. Fibonacci series (first N numbers)

```python
def fibonacci(n):
    # handle small values of n
    if n <= 0:
        return []
    if n == 1:
        return [0]

    # start with first two numbers
    series = [0, 1]

    # keep adding next numbers until we have n numbers
    while len(series) < n:
        # sum of last two numbers
        next_value = series[-1] + series[-2]
        series.append(next_value)

    return series

print(fibonacci(7))  # [0, 1, 1, 2, 3, 5, 8]
```

**Explanation:**

- `def fibonacci(n):`  
  Define `fibonacci` that returns a list of the first `n` Fibonacci numbers.

- `if n <= 0:` / `return []`  
  If `n` is zero or negative, return an empty list (no terms).

- `if n == 1:` / `return [0]`  
  If only one term is requested, return `[0]`.

- `series = [0, 1]`  
  Start the list with the first two Fibonacci numbers.

- `while len(series) < n:`  
  Keep looping until the list has `n` elements.

- `next_value = series[-1] + series[-2]`  
  The next Fibonacci number is the sum of the last two numbers in the series.

- `series.append(next_value)`  
  Add this new value to the end of the list.

- `return series`  
  After generating enough numbers, return the whole list.

- `print(fibonacci(7))`  
  Call the function asking for 7 numbers and print the list.

***

## 5. Check if a number is an Armstrong number

```python
def is_armstrong(number):
    # convert number to string so we can loop over digits
    s = str(number)
    # number of digits
    digits = len(s)

    total = 0

    for ch in s:
        # convert character back to integer
        digit = int(ch)
        # raise digit to power = number of digits
        total = total + (digit ** digits)

    # check if sum equals original number
    return total == number

print(is_armstrong(153))  # True
print(is_armstrong(370))  # True
print(is_armstrong(10))   # False
```

**Explanation:**

- `def is_armstrong(number):`  
  Define a function that checks if `number` is an Armstrong number.

- `s = str(number)`  
  Convert the number to a string to easily access each digit.

- `digits = len(s)`  
  Count how many digits the number has.

- `total = 0`  
  Initialize a sum that will hold the sum of digit^digits.

- `for ch in s:`  
  Loop through each character (digit) in the string.

- `digit = int(ch)`  
  Convert the character back to an integer.

- `total = total + (digit ** digits)`  
  Raise the digit to the power of the number of digits and add to `total`.

- `return total == number`  
  If the total equals the original number, it is an Armstrong number.

- The three `print` lines test the function with different numbers.

***

## 6. Reverse a string (two methods)

### Method 1 – using slicing

```python
def reverse_string(text):
    return text[::-1]

print(reverse_string("DevOps"))  # spOveD
```

**Explanation:**

- `def reverse_string(text):`  
  Define a function that takes a string.

- `return text[::-1]`  
  Return the reversed string using slice syntax: `start:end:step` with step `-1` means go backwards.

- `print(reverse_string("DevOps"))`  
  Call the function and print the reversed result.

***

### Method 2 – using a loop

```python
def reverse_string_loop(text):
    result = ""
    for ch in text:
        # put each character at the front
        result = ch + result
    return result

print(reverse_string_loop("DevOps"))  # spOveD
```

**Explanation:**

- `def reverse_string_loop(text):`  
  Define another version that uses a loop.

- `result = ""`  
  Start with an empty result string.

- `for ch in text:`  
  Loop over each character in the input string.

- `result = ch + result`  
  Prepend the current character to the result string (builds in reverse order).

- `return result`  
  After the loop, return the reversed string.

- `print(reverse_string_loop("DevOps"))`  
  Test and print the reversed result.

***

## 7. Check if a number is prime (simple version)

```python
def is_prime(n):
    # numbers less than 2 are not prime
    if n < 2:
        return False

    # try dividing n by all numbers from 2 to n-1
    for i in range(2, n):
        if n % i == 0:
            # found a divisor, so not prime
            return False

    # no divisors found, so it is prime
    return True

print(is_prime(7))   # True
print(is_prime(12))  # False
```

**Explanation:**

- `def is_prime(n):`  
  Define a function to check if `n` is prime.

- `if n < 2:` / `return False`  
  0 and 1 (and negative numbers) are not prime.

- `for i in range(2, n):`  
  Loop over potential factors from 2 up to `n-1`.

- `if n % i == 0:`  
  If `n` divided by `i` has no remainder, `i` is a factor.

- `return False`  
  If any factor is found, return `False`.

- After the loop, if no factor is found, return `True`.

- The `print` calls are simple tests.

***

## 8. boto3 – Upload a file to S3 (simple)

```python
import boto3
from botocore.exceptions import ClientError

def upload_to_s3(bucket_name, object_key, filename):
    # create an S3 client with default AWS config
    s3 = boto3.client("s3")

    try:
        # upload local file "filename" to "bucket_name" with key "object_key"
        s3.upload_file(filename, bucket_name, object_key)
        print("Uploaded", filename, "to", f"s3://{bucket_name}/{object_key}")
    except ClientError as e:
        print("Error uploading file:", e)

# Example usage (make sure your AWS credentials and bucket exist):
# upload_to_s3("my-bucket", "path/in/bucket/config.json", "config.json")
```

**Explanation:**

- `import boto3`  
  Import the AWS SDK for Python.

- `from botocore.exceptions import ClientError`  
  Import an exception class used for AWS client errors.

- `def upload_to_s3(bucket_name, object_key, filename):`  
  Define a function to upload a local file to S3.

- `s3 = boto3.client("s3")`  
  Create an S3 client using your AWS configuration (credentials, region).

- `try:` / `s3.upload_file(...)`  
  Try to upload the local file `filename` to the specified bucket and key.

- `print("Uploaded", ...)`  
  If successful, print a confirmation message.

- `except ClientError as e:` / `print("Error uploading file:", e)`  
  If there is an error (e.g., permission, missing bucket), catch it and print the error.

- The commented example shows how to call this function.

***

## 9. boto3 – Download a file from S3 (simple)

```python
import boto3
from botocore.exceptions import ClientError

def download_from_s3(bucket_name, object_key, filename):
    s3 = boto3.client("s3")

    try:
        # download object "object_key" from "bucket_name" to local file "filename"
        s3.download_file(bucket_name, object_key, filename)
        print("Downloaded", f"s3://{bucket_name}/{object_key}", "to", filename)
    except ClientError as e:
        print("Error downloading file:", e)

# Example:
# download_from_s3("my-bucket", "path/in/bucket/config.json", "config_downloaded.json")
```

**Explanation:**

- Imports are the same as in the upload example.

- `def download_from_s3(bucket_name, object_key, filename):`  
  Define a function to download from S3 to a local file.

- `s3 = boto3.client("s3")`  
  Create an S3 client.

- `s3.download_file(bucket_name, object_key, filename)`  
  Download the object from the bucket/key into a local file.

- `print("Downloaded", ...)`  
  Print success information.

- `except ClientError as e:`  
  Catch and print errors if something goes wrong.

- The commented example shows how to use it.

***

## 10. boto3 – List running EC2 instances (simple)

```python
import boto3

def list_running_instances(region_name="ap-south-1"):
    # create EC2 client
    ec2 = boto3.client("ec2", region_name=region_name)

    # ask AWS for all running instances
    response = ec2.describe_instances(
        Filters=[
            {"Name": "instance-state-name", "Values": ["running"]}
        ]
    )

    # response contains "Reservations" -> each "Reservation" has "Instances"
    for reservation in response["Reservations"]:
        for instance in reservation["Instances"]:
            instance_id = instance["InstanceId"]
            # try to get Name tag
            name = None
            if "Tags" in instance:
                for tag in instance["Tags"]:
                    if tag["Key"] == "Name":
                        name = tag["Value"]
            print("Instance:", instance_id, "Name:", name)

# Example:
# list_running_instances()
```

**Explanation:**

- `import boto3`  
  Import AWS SDK for Python.

- `def list_running_instances(region_name="ap-south-1"):`  
  Define a function to list running EC2 instances in a given region (default is `ap-south-1`).

- `ec2 = boto3.client("ec2", region_name=region_name)`  
  Create an EC2 client for that region.

- `response = ec2.describe_instances(...)`  
  Call AWS to get details of EC2 instances filtered to state “running”.

- The response is nested:  
  - `response["Reservations"]` is a list.  
  - Each reservation has an `"Instances"` list.

- `for reservation in response["Reservations"]:`  
  Loop through each reservation.

- `for instance in reservation["Instances"]:`  
  Loop through each instance inside the reservation.

- `instance_id = instance["InstanceId"]`  
  Get the instance ID string.

- `name = None` / `if "Tags" in instance:` / loop tags  
  Try to find the `Name` tag among the instance tags; if not found, name stays `None`.

- `print("Instance:", instance_id, "Name:", name)`  
  Print the instance ID and name (if any).

- The commented example shows how to call the function.

***

Let’s continue with the **next 10 beginner‑friendly programs (11–20)**, each with line‑by‑line explanations, in the same style.

Programs in this batch:
11. Count vowels and consonants in a string  
12. Check if two strings are anagrams  
13. Find the second largest number in a list  
14. Sum of digits of a number  
15. Find the largest element in a list (without `max`)  
16. Remove duplicates from a list while keeping order  
17. Simple calculator using functions  
18. Count words in a sentence  
19. Check if a number is even or odd  
20. Generate a multiplication table for a number  

***

## 11. Count vowels and consonants in a string

```python
def count_vowels_consonants(text):
    text = text.lower()          # 1
    vowels = "aeiou"             # 2
    vowel_count = 0              # 3
    consonant_count = 0          # 4

    for ch in text:              # 5
        if ch.isalpha():         # 6
            if ch in vowels:     # 7
                vowel_count += 1 # 8
            else:
                consonant_count += 1  # 9

    return vowel_count, consonant_count  # 10

v, c = count_vowels_consonants("DevOps Engineer")  # 11
print("Vowels:", v, "Consonants:", c)             # 12
```

**Explanation:**

1. Convert the string to lowercase so we don’t have to treat `A` and `a` differently.
2. Define a string with all vowel characters.
3. Initialize a counter for vowels.
4. Initialize a counter for consonants.
5. Loop through each character in the text.
6. Check if the character is a letter (ignore spaces, numbers, etc.).
7. If the character is in the `vowels` string, it’s a vowel.
8. Increase the vowel counter by 1.
9. Otherwise, it’s a consonant; increase consonant counter.
10. Return both counts as a tuple.
11. Call the function with `"DevOps Engineer"` and store the two counts.
12. Print the vowel and consonant counts.

***

## 12. Check if two strings are anagrams

```python
def are_anagrams(s1, s2):
    s1 = s1.replace(" ", "").lower()  # 1
    s2 = s2.replace(" ", "").lower()  # 2

    # if lengths differ, cannot be anagrams
    if len(s1) != len(s2):            # 3
        return False                  # 4

    # sort both strings and compare
    return sorted(s1) == sorted(s2)   # 5

print(are_anagrams("listen", "silent"))        # True   # 6
print(are_anagrams("devops", "podevs"))        # True   # 7
print(are_anagrams("hello", "world"))          # False  # 8
```

**Explanation:**

1. Remove spaces from first string and convert to lowercase.
2. Do the same for second string.
3. If they have different lengths, they can’t be anagrams.
4. Immediately return False in that case.
5. Sort both strings (convert to lists of characters) and compare; if equal, they are anagrams.
6–8. Test the function with different string pairs and print results.

***

## 13. Find the second largest number in a list

```python
def second_largest(numbers):
    if len(numbers) < 2:     # 1
        return None          # 2

    # assume first two numbers as candidates
    largest = max(numbers[0], numbers[1])      # 3
    second = min(numbers[0], numbers[1])       # 4

    for n in numbers[2:]:    # 5
        if n > largest:      # 6
            second = largest # 7
            largest = n      # 8
        elif n > second and n != largest:  # 9
            second = n       # 10

    return second            # 11

print(second_largest([10, 5, 8, 20, 15]))  # 15  # 12
```

**Explanation:**

1. If the list has fewer than 2 elements, there is no “second largest”.
2. Return `None` to indicate that.
3. Set `largest` to the bigger of the first two numbers.
4. Set `second` to the smaller of the first two.
5. Loop over the rest of the list starting from index 2.
6. If `n` is greater than the current largest, it becomes the new largest.
7. The old largest becomes the second largest.
8. Update `largest` with the new value.
9. Otherwise, if `n` is between `second` and `largest` (and not equal to largest), it should be the new second largest.
10. Update `second` accordingly.
11. After the loop, return `second`.
12. Example: second largest in that list is 15.

***

## 14. Sum of digits of a number

```python
def sum_of_digits(n):
    n = abs(n)           # 1
    total = 0            # 2

    while n > 0:         # 3
        digit = n % 10   # 4
        total = total + digit  # 5
        n = n // 10      # 6

    return total         # 7

print(sum_of_digits(1234))   # 10  # 8
print(sum_of_digits(-567))   # 18  # 9
```

**Explanation:**

1. Use `abs` to handle negative numbers by converting them to positive.
2. Initialize sum `total` to 0.
3. Loop while `n` is greater than 0.
4. Get the last digit using modulo 10.
5. Add the digit to the total.
6. Remove the last digit from `n` using integer division by 10.
7. After the loop, return the total sum of digits.
8–9. Example calls.

***

## 15. Find the largest element in a list (without `max`)

```python
def find_largest(numbers):
    if not numbers:       # 1
        return None       # 2

    largest = numbers[0]  # 3

    for n in numbers:     # 4
        if n > largest:   # 5
            largest = n   # 6

    return largest        # 7

print(find_largest([5, 10, 3, 20, 15]))  # 20  # 8
```

**Explanation:**

1. If the list is empty, there is no largest value.
2. Return `None` for an empty list.
3. Assume first element is the largest initially.
4. Loop through every number in the list.
5. If current `n` is greater than `largest`, update `largest`.
6. Store `n` as new largest.
7. After the loop, return the final largest value.
8. Example usage.

***

## 16. Remove duplicates from a list while keeping the order

```python
def remove_duplicates_keep_order(items):
    seen = []              # 1
    result = []            # 2

    for item in items:     # 3
        if item not in seen:  # 4
            seen.append(item)  # 5
            result.append(item)  # 6

    return result          # 7

print(remove_duplicates_keep_order(["nginx", "redis", "nginx", "python", "redis"]))
# ['nginx', 'redis', 'python']  # 8
```

**Explanation:**

1. Create an empty list `seen` to remember what we’ve seen.
2. Create an empty list `result` to store the unique items in order.
3. Loop through each element in `items`.
4. If we have not seen this item before:
5. Add it to the `seen` list.
6. Also add it to the `result` list.
7. After the loop, return `result`.
8. Example output shows duplicates removed, order kept.

***

## 17. Simple calculator using functions

```python
def add(a, b):
    return a + b  # 1

def subtract(a, b):
    return a - b  # 2

def multiply(a, b):
    return a * b  # 3

def divide(a, b):
    if b == 0:               # 4
        print("Cannot divide by zero")
        return None
    return a / b             # 5

print(add(10, 5))        # 15    # 6
print(subtract(10, 5))   # 5     # 7
print(multiply(10, 5))   # 50    # 8
print(divide(10, 0))     # error # 9
```

**Explanation:**

1–3. Four simple functions performing basic arithmetic.
4. In `divide`, check if `b` is zero to avoid division by zero.
5. If safe, perform division and return the result.
6–9. Example calls demonstrating the functions, including the divide-by-zero case.

***

## 18. Count words in a sentence

```python
def count_words(sentence):
    # split on whitespace into a list of words
    words = sentence.split()   # 1
    return len(words)          # 2

print(count_words("Python for DevOps scripting is powerful"))  # 6  # 3
```

**Explanation:**

1. Use `split()` with no argument to split by any whitespace (spaces, tabs, etc.).
2. Count how many elements are in the `words` list using `len`.
3. Print the word count for the example sentence.

***

## 19. Check if a number is even or odd

```python
def is_even(n):
    return n % 2 == 0  # 1

print(is_even(10))  # True   # 2
print(is_even(3))   # False  # 3
```

**Explanation:**

1. Return `True` if `n` modulo 2 equals 0; otherwise `False`.
2–3. Example usage showing even and odd numbers.

If you want a version that prints directly:

```python
def check_even_odd(n):
    if n % 2 == 0:
        print(n, "is even")
    else:
        print(n, "is odd")

check_even_odd(10)
check_even_odd(3)
```

***

## 20. Generate multiplication table for a number

```python
def multiplication_table(n, upto=10):
    for i in range(1, upto + 1):   # 1
        result = n * i             # 2
        print(n, "x", i, "=", result)  # 3

multiplication_table(5)  # 4
```

**Explanation:**

1. Loop `i` from 1 up to `upto` (inclusive).
2. Compute `n * i` for each step.
3. Print the multiplication in a readable format: for example `5 x 3 = 15`.
4. Call the function with `n = 5` to print the table for 5.

***

Continuing in the same beginner‑friendly style, here are **next 10 programs (21–30)** with line‑by‑line explanations.

Programs in this batch:
21. Print all prime numbers in a range  
22. Find the smallest number in a list  
23. Check if a year is a leap year  
24. Count character frequency in a string  
25. Merge two lists element‑wise (same index)  
26. Simple pattern: right‑angled triangle of `*`  
27. Sum of even and odd numbers in a list  
28. Find common elements of two lists  
29. Check if a string contains only digits  
30. Reverse the words in a sentence  

***

## 21. Print all prime numbers in a range

```python
def is_prime(n):
    if n < 2:                 # 1
        return False
    for i in range(2, n):     # 2
        if n % i == 0:        # 3
            return False
    return True               # 4

def primes_in_range(start, end):
    result = []               # 5
    for n in range(start, end + 1):  # 6
        if is_prime(n):       # 7
            result.append(n)  # 8
    return result             # 9

print(primes_in_range(10, 30))      # 10
```

**Explanation:**

1. Numbers less than 2 are not prime.
2. Try dividing `n` by every integer from 2 up to `n-1`.
3. If any divides exactly (`n % i == 0`), `n` is not prime.
4. If no divisor is found, return `True`.
5. In `primes_in_range`, start with an empty list to collect primes.
6. Loop from `start` to `end` (inclusive).
7. For each number, check if it’s prime using `is_prime`.
8. If it is, add it to the result list.
9. Return the list of prime numbers.
10. Print all primes between 10 and 30.

***

## 22. Find the smallest number in a list (without `min`)

```python
def find_smallest(numbers):
    if not numbers:          # 1
        return None
    smallest = numbers[0]    # 2
    for n in numbers:        # 3
        if n < smallest:     # 4
            smallest = n     # 5
    return smallest          # 6

print(find_smallest([5, 10, 3, 20, 1]))  # 1  # 7
```

**Explanation:**

1. If the list is empty, return `None` (no smallest value).
2. Assume the first element is the smallest to start.
3. Loop through each number in the list.
4. If current number `n` is less than `smallest`, update it.
5. Store `n` as the new smallest.
6. After the loop, return the smallest number found.
7. Example: smallest is 1.

***

## 23. Check if a year is a leap year

```python
def is_leap_year(year):
    # divisible by 4 and not by 100, OR divisible by 400
    if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):  # 1
        return True                                               # 2
    else:
        return False                                              # 3

print(is_leap_year(2024))  # True   # 4
print(is_leap_year(2100))  # False  # 5
print(is_leap_year(2000))  # True   # 6
```

**Explanation:**

1. Leap year rule: divisible by 4 and not by 100, unless divisible by 400.
2. If condition is true, return `True`.
3. Otherwise, return `False`.
4–6. Test with different years.

***

## 24. Count character frequency in a string

```python
def char_frequency(text):
    freq = {}                   # 1
    for ch in text:             # 2
        if ch in freq:          # 3
            freq[ch] += 1       # 4
        else:
            freq[ch] = 1        # 5
    return freq                 # 6

print(char_frequency("banana"))  # 7
```

**Explanation:**

1. Create an empty dictionary to store character counts.
2. Loop through each character in the string.
3. If the character is already in the dictionary…
4. Increase its count by 1.
5. Otherwise, add it with initial count 1.
6. Return the dictionary mapping chars to counts.
7. Example: `{'b': 1, 'a': 3, 'n': 2}`.

***

## 25. Merge two lists element‑wise (same index)

```python
def merge_lists(a, b):
    length = min(len(a), len(b))   # 1
    result = []                    # 2

    for i in range(length):        # 3
        pair = (a[i], b[i])        # 4
        result.append(pair)        # 5

    return result                  # 6

print(merge_lists([1, 2, 3], ["a", "b", "c"]))  # [(1, 'a'), (2,'b'), (3,'c')]  # 7
```

**Explanation:**

1. Take the smaller length to avoid index errors if lists differ.
2. Create an empty list `result`.
3. Loop from index 0 up to `length-1`.
4. Take the element from each list at index `i` and make a tuple.
5. Append this tuple to `result`.
6. Return the merged list.
7. Example output.

***

## 26. Simple pattern: right‑angled triangle with `*`

```python
def print_triangle(rows):
    for i in range(1, rows + 1):   # 1
        line = "*" * i             # 2
        print(line)                # 3

print_triangle(5)                  # 4
```

**Explanation:**

1. Loop from 1 to `rows` inclusive.
2. Create a string containing `i` stars by multiplying `"*"` by `i`.
3. Print that line.
4. Example prints 5 lines:
   - `*`  
   - `**`  
   - `***`  
   - `****`  
   - `*****`

***

## 27. Sum of even and odd numbers in a list

```python
def sum_even_odd(numbers):
    even_sum = 0               # 1
    odd_sum = 0                # 2

    for n in numbers:          # 3
        if n % 2 == 0:         # 4
            even_sum += n      # 5
        else:
            odd_sum += n       # 6

    return even_sum, odd_sum   # 7

even, odd = sum_even_odd([1, 2, 3, 4, 5, 6])  # 8
print("Even sum:", even, "Odd sum:", odd)     # 9
```

**Explanation:**

1. Initialize sum of even numbers.
2. Initialize sum of odd numbers.
3. Loop through each number in the list.
4. Check if the number is even using modulo 2.
5. Add it to `even_sum` if even.
6. Otherwise add it to `odd_sum`.
7. Return both sums as a tuple.
8. Call the function with a sample list.
9. Print the even and odd sums.

***

## 28. Find common elements of two lists

```python
def common_elements(list1, list2):
    result = []                      # 1
    for item in list1:               # 2
        if item in list2 and item not in result:  # 3
            result.append(item)      # 4
    return result                    # 5

print(common_elements([1, 2, 3, 4], [3, 4, 5, 6]))   # [3, 4]  # 6
```

**Explanation:**

1. Create an empty list `result`.
2. Loop through each item in the first list.
3. If the item is also in the second list and not already in `result`, it is common and unique.
4. Add it to `result`.
5. Return the list of common elements.
6. Example: common elements are 3 and 4.

***

## 29. Check if a string contains only digits

```python
def is_all_digits(text):
    if not text:              # 1
        return False
    for ch in text:           # 2
        if not ch.isdigit():  # 3
            return False      # 4
    return True               # 5

print(is_all_digits("12345"))   # True   # 6
print(is_all_digits("12a45"))   # False  # 7
print(is_all_digits(""))        # False  # 8
```

**Explanation:**

1. If the string is empty, return False (no digits).
2. Loop through each character.
3. Check if character is not a digit.
4. If any character is not a digit, immediately return False.
5. If all characters are digits, return True.
6–8. Example uses.

***

## 30. Reverse the words in a sentence

```python
def reverse_words(sentence):
    words = sentence.split()      # 1
    reversed_list = words[::-1]   # 2
    result = " ".join(reversed_list)  # 3
    return result                 # 4

print(reverse_words("Python for DevOps engineers"))  # 5
```

**Explanation:**

1. Split the sentence into a list of words based on spaces.
2. Reverse the list of words using slicing.
3. Join the reversed list back into a string with spaces between words.
4. Return the reversed sentence.
5. Example: `"engineers DevOps for Python"`.

***

Continuing in the same beginner‑friendly style, here are **next 10 programs (31–40)** with line‑by‑line explanations.

Programs in this batch:  
31. Sort a list without using `sort()` (simple bubble sort)  
32. Find the length of a list without using `len()`  
33. Check if a substring exists in a string  
34. Count how many times a word appears in a sentence  
35. Convert a list of strings to integers (ignoring invalid ones)  
36. Find the index of an element in a list (manual search)  
37. Join list elements into a comma‑separated string  
38. Remove all occurrences of an element from a list  
39. Check if two lists are equal (same elements in same order)  
40. Basic menu‑driven program (loop + input)  

***

## 31. Sort a list without using `sort()` (simple bubble sort)

```python
def bubble_sort(numbers):
    n = len(numbers)                      # 1
    for i in range(n):                    # 2
        for j in range(0, n - 1):         # 3
            if numbers[j] > numbers[j+1]: # 4
                # swap the elements
                temp = numbers[j]         # 5
                numbers[j] = numbers[j+1] # 6
                numbers[j+1] = temp       # 7
    return numbers                        # 8

print(bubble_sort([5, 1, 4, 2, 8]))       # 9
```

**Explanation:**

1. Get the length of the list.
2. Outer loop runs `n` times to ensure the list is fully sorted.
3. Inner loop compares each pair of neighbors.
4. If the current element is bigger than the next, they are out of order.
5–7. Swap the two elements.
8. After all passes, return the sorted list.
9. Example: sorts `[5, 1, 4, 2, 8]` into `[1, 2, 4, 5, 8]`.

***

## 32. Find the length of a list without using `len()`

```python
def list_length(items):
    count = 0             # 1
    for _ in items:       # 2
        count = count + 1 # 3
    return count          # 4

print(list_length([1, 2, 3, 4]))  # 5
```

**Explanation:**

1. Start a counter at 0.
2. Loop through each element; we don’t care about the value, so use `_`.
3. Increase the counter for every element.
4. Return the final count.
5. Example: length is 4.

***

## 33. Check if a substring exists in a string

```python
def contains_substring(text, sub):
    if sub in text:             # 1
        return True             # 2
    else:
        return False            # 3

print(contains_substring("DevOps Engineer", "Ops"))   # True  # 4
print(contains_substring("DevOps Engineer", "Cloud")) # False # 5
```

**Explanation:**

1. Use the `in` operator to check if `sub` appears inside `text`.
2. If yes, return `True`.
3. Otherwise, return `False`.
4–5. Example calls.

***

## 34. Count how many times a word appears in a sentence

```python
def count_word(sentence, word):
    words = sentence.split()    # 1
    count = 0                   # 2
    for w in words:             # 3
        if w == word:           # 4
            count = count + 1   # 5
    return count                # 6

print(count_word("devops is great and devops is in demand", "devops"))  # 7
```

**Explanation:**

1. Split the sentence into a list of words.
2. Start a counter at 0.
3. Loop through each word.
4. If the current word matches the target word…
5. Increase the counter by 1.
6. Return the final count.
7. Example: `"devops"` appears 2 times.

***

## 35. Convert a list of strings to integers (ignore invalid)

```python
def to_int_list(strings):
    result = []                    # 1
    for s in strings:              # 2
        try:
            num = int(s)           # 3
            result.append(num)     # 4
        except ValueError:
            # ignore items that cannot be converted
            print("Skipping:", s)  # 5
    return result                  # 6

print(to_int_list(["10", "20", "abc", "30"]))         # 7
```

**Explanation:**

1. Create an empty list to store converted integers.
2. Loop through each string in the input.
3. Try to convert the string to an integer.
4. If conversion works, append the number to `result`.
5. If conversion fails (`ValueError`), print a message and skip it.
6. Return the list of valid integers.
7. Example: `["10","20","abc","30"]` becomes `[10, 20, 30]`.

***

## 36. Find the index of an element in a list (manual search)

```python
def find_index(items, value):
    index = 0                    # 1
    for item in items:           # 2
        if item == value:        # 3
            return index         # 4
        index = index + 1        # 5
    return -1                    # 6

print(find_index(["a", "b", "c"], "b"))  # 1  # 7
print(find_index(["a", "b", "c"], "x"))  # -1 # 8
```

**Explanation:**

1. Start index counter at 0.
2. Loop through each `item` in the list.
3. If the item equals the value we are searching for…
4. Return the current index.
5. Otherwise, increment index and continue.
6. If value not found after the loop, return -1 as “not found”.
7–8. Example calls.

***

## 37. Join list elements into a comma‑separated string

```python
def join_with_comma(items):
    # convert all items to string type
    string_items = []                # 1
    for item in items:               # 2
        string_items.append(str(item))  # 3
    result = ", ".join(string_items) # 4
    return result                    # 5

print(join_with_comma([1, 2, 3, "devops"]))          # 6
```

**Explanation:**

1. Create an empty list to hold string versions of items.
2. Loop through each element in the input list.
3. Convert each item to a string and append to `string_items`.
4. Use `", ".join(...)` to combine them with comma + space.
5. Return the final string.
6. Example: `"1, 2, 3, devops"`.

***

## 38. Remove all occurrences of an element from a list

```python
def remove_all(items, value):
    result = []               # 1
    for item in items:        # 2
        if item != value:     # 3
            result.append(item)  # 4
    return result             # 5

print(remove_all([1, 2, 3, 2, 4, 2], 2))  # [1, 3, 4]  # 6
```

**Explanation:**

1. Create an empty list to store items we keep.
2. Loop through each element of the input list.
3. If the element is not equal to `value`, we want to keep it.
4. Append it to `result`.
5. Return the filtered list.
6. Example removes all `2`s.

***

## 39. Check if two lists are equal (same elements, same order)

```python
def lists_equal(a, b):
    if len(a) != len(b):       # 1
        return False
    for i in range(len(a)):    # 2
        if a[i] != b[i]:       # 3
            return False       # 4
    return True                # 5

print(lists_equal([1, 2, 3], [1, 2, 3]))  # True   # 6
print(lists_equal([1, 2, 3], [3, 2, 1]))  # False  # 7
```

**Explanation:**

1. If lengths differ, lists cannot be equal.
2. Loop through each index.
3. Compare elements at the same index in both lists.
4. If any pair is different, return `False`.
5. If all pairs are equal, return `True`.
6–7. Example comparisons.

***

## 40. Basic menu‑driven program (loop + input)

```python
def menu():
    while True:                                # 1
        print("1. Say Hello")                  # 2
        print("2. Add two numbers")            # 3
        print("3. Exit")                       # 4

        choice = input("Enter choice (1-3): ") # 5

        if choice == "1":                      # 6
            print("Hello!")                    # 7

        elif choice == "2":                    # 8
            a = int(input("Enter first number: "))  # 9
            b = int(input("Enter second number: ")) # 10
            print("Sum is:", a + b)                 # 11

        elif choice == "3":                    # 12
            print("Goodbye!")                  # 13
            break                              # 14

        else:
            print("Invalid choice, try again") # 15

menu()                                         # 16
```

**Explanation:**

1. Start an infinite loop; we’ll break when user chooses Exit.
2–4. Print a simple menu with options.
5. Read user input as a string.
6. If user chose `"1"`, option is “Say Hello”.
7. Print “Hello!”.
8. If user chose `"2"`, option is “Add two numbers”.
9–10. Ask for two integers from the user.
11. Print their sum.
12. If user chose `"3"`, option is “Exit”.
13. Print a goodbye message.
14. `break` exits the loop and ends the function.
15. If input is not 1, 2, or 3, show an error and continue loop.
16. Call the `menu()` function to start the menu program.

***
Here are the **next 10 beginner‑friendly programs (41–50)** with line‑by‑line explanations in the same style.

Programs in this batch:  
41. Check if a list is sorted (ascending)  
42. Binary search (on a sorted list)  
43. Count how many elements are greater than a given value  
44. Find all indexes of a value in a list  
45. Replace all spaces in a string with `-`  
46. Convert Celsius to Fahrenheit and vice versa  
47. Generate a list of squares for numbers 1..N  
48. Check if a string is a pangram (contains all letters a–z)  
49. Simple timer using `time.sleep`  
50. Basic file copy (read and write)  

***

## 41. Check if a list is sorted (ascending)

```python
def is_sorted_ascending(numbers):
    if len(numbers) < 2:              # 1
        return True                   # 2

    for i in range(len(numbers) - 1): # 3
        if numbers[i] > numbers[i + 1]:  # 4
            return False              # 5
    return True                       # 6

print(is_sorted_ascending([1, 2, 3, 4]))   # True  # 7
print(is_sorted_ascending([1, 3, 2, 4]))   # False # 8
```

**Explanation:**

1. If the list has fewer than 2 elements…
2. It is trivially sorted.
3. Loop over indexes from 0 to `len(numbers) - 2`.
4. Compare each element to the next one.
5. If any element is greater than the next, list is not sorted → return `False`.
6. If the loop finishes without finding any issues, return `True`.
7–8. Example calls.

***

## 42. Binary search (on a sorted list)

```python
def binary_search(sorted_list, target):
    left = 0                            # 1
    right = len(sorted_list) - 1        # 2

    while left <= right:                # 3
        mid = (left + right) // 2       # 4
        value = sorted_list[mid]        # 5

        if value == target:             # 6
            return mid                  # 7
        elif value < target:            # 8
            left = mid + 1              # 9
        else:
            right = mid - 1             # 10

    return -1                           # 11

print(binary_search([1, 3, 5, 7, 9], 7))   # 3   # 12
print(binary_search([1, 3, 5, 7, 9], 4))   # -1  # 13
```

**Explanation:**

1. Start `left` at the beginning of the list.
2. Start `right` at the last index.
3. Continue as long as `left` is not past `right`.
4. Compute middle index.
5. Get the value at the middle.
6. If this value equals the target, we found the position.
7. Return the index `mid`.
8. If middle value is less than target…
9. Move `left` to `mid + 1` (search in right half).
10. Else move `right` to `mid - 1` (search in left half).
11. If the loop ends, target was not found → return -1.
12–13. Example calls.

***

## 43. Count how many elements are greater than a given value

```python
def count_greater_than(numbers, threshold):
    count = 0                       # 1
    for n in numbers:               # 2
        if n > threshold:           # 3
            count = count + 1       # 4
    return count                    # 5

print(count_greater_than([1, 5, 10, 3, 8], 4))  # 3  # 6
```

**Explanation:**

1. Start a counter at 0.
2. Loop through each number in the list.
3. Check if the number is greater than the threshold.
4. If yes, increase the counter by 1.
5. After looping, return the count.
6. Example: there are 3 numbers greater than 4 (5, 10, 8).

***

## 44. Find all indexes of a value in a list

```python
def all_indexes(items, value):
    result = []                      # 1
    index = 0                        # 2
    for item in items:               # 3
        if item == value:            # 4
            result.append(index)     # 5
        index = index + 1            # 6
    return result                    # 7

print(all_indexes([1, 2, 3, 2, 2, 5], 2))  # [1, 3, 4]  # 8
```

**Explanation:**

1. Create an empty list to store indexes.
2. Start index counter at 0.
3. Loop through each item in the list.
4. If the item equals the value we are looking for…
5. Append the current index to `result`.
6. Increase the index for the next iteration.
7. Return the list of all indexes where the value appears.
8. Example: value 2 appears at indexes 1, 3, and 4.

***

## 45. Replace all spaces in a string with `-`

```python
def replace_spaces(text):
    result = ""                     # 1
    for ch in text:                 # 2
        if ch == " ":               # 3
            result = result + "-"   # 4
        else:
            result = result + ch    # 5
    return result                   # 6

print(replace_spaces("DevOps Engineer Role"))  # DevOps-Engineer-Role  # 7
```

**Explanation:**

1. Start with an empty result string.
2. Loop over each character in the input string.
3. If the character is a space…
4. Add `"-"` to the result.
5. Otherwise, add the original character.
6. After the loop, return the new string.
7. Example output.

***

## 46. Convert Celsius to Fahrenheit and vice versa

```python
def c_to_f(celsius):
    fahrenheit = (celsius * 9/5) + 32  # 1
    return fahrenheit                  # 2

def f_to_c(fahrenheit):
    celsius = (fahrenheit - 32) * 5/9  # 3
    return celsius                     # 4

print(c_to_f(0))    # 32.0     # 5
print(f_to_c(32))   # 0.0      # 6
```

**Explanation:**

1. Formula to convert Celsius to Fahrenheit.
2. Return the Fahrenheit value.
3. Formula to convert Fahrenheit to Celsius.
4. Return the Celsius value.
5–6. Example conversions.

***

## 47. Generate a list of squares for numbers 1..N

```python
def generate_squares(n):
    squares = []                  # 1
    for i in range(1, n + 1):     # 2
        squares.append(i * i)     # 3
    return squares                # 4

print(generate_squares(5))        # [1, 4, 9, 16, 25]  # 5
```

**Explanation:**

1. Create an empty list.
2. Loop from 1 to `n` inclusive.
3. Compute `i * i` and append to the list.
4. Return the final list of squares.
5. Example for `n=5`.

***

## 48. Check if a string is a pangram (contains all letters a–z)

```python
def is_pangram(text):
    text = text.lower()              # 1
    letters = set()                  # 2

    for ch in text:                  # 3
        if ch.isalpha():             # 4
            letters.add(ch)          # 5

    return len(letters) == 26        # 6

print(is_pangram("The quick brown fox jumps over the lazy dog"))  # True  # 7
print(is_pangram("DevOps Engineer"))                               # False # 8
```

**Explanation:**

1. Convert the text to lowercase.
2. Create an empty set to store unique letters.
3. Loop over each character in the text.
4. Check if the character is a letter.
5. Add the letter to the set (duplicates are ignored automatically).
6. If there are 26 different letters, it’s a pangram; return True or False accordingly.
7–8. Example calls.

***

## 49. Simple timer using `time.sleep`

```python
import time                      # 1

def simple_timer(seconds):
    print("Timer started for", seconds, "seconds")  # 2
    time.sleep(seconds)         # 3
    print("Time's up!")         # 4

simple_timer(3)                 # 5
```

**Explanation:**

1. Import the `time` module.
2. Print a message showing how long the timer will run.
3. Pause the program for the given number of seconds.
4. After sleeping, print “Time’s up!”.
5. Example: run a 3‑second timer.

***

## 50. Basic file copy (read and write)

```python
def copy_file(source_path, dest_path):
    # open source file for reading
    with open(source_path, "r") as src:   # 1
        content = src.read()              # 2

    # open destination file for writing
    with open(dest_path, "w") as dst:     # 3
        dst.write(content)                # 4

    print("Copied from", source_path, "to", dest_path)  # 5

# Example (make sure 'input.txt' exists):
# copy_file("input.txt", "output.txt")
```

**Explanation:**

1. Use `with open(..., "r")` to open the source file in read mode (and ensure it closes automatically).
2. Read the entire file content into a string.
3. Open the destination file in write mode.
4. Write the content into the destination file.
5. Print a message confirming the copy.

***


