# Table of Contents

- [Senior DevOps Engineer – Python Scripting Interview Preparation](#senior-devops-engineer--python-scripting-interview-preparation)
  - [What you should prepare first](#what-you-should-prepare-first)
- [Part 1: Python Fundamentals for DevOps](#part-1-python-fundamentals-for-devops)
    - [Q1. Why do DevOps engineers use Python?](#q1-why-do-devops-engineers-use-python)
    - [Q2. What are the main Python data types?](#q2-what-are-the-main-python-data-types)
    - [Q3. What is the difference between a list, tuple, set, and dictionary?](#q3-what-is-the-difference-between-a-list-tuple-set-and-dictionary)
    - [Q4. How do you use a for loop in Python?](#q4-how-do-you-use-a-for-loop-in-python)
    - [Q5. What is a function in Python, and why do we use it?](#q5-what-is-a-function-in-python-and-why-do-we-use-it)
    - [Q6. What is exception handling in Python?](#q6-what-is-exception-handling-in-python)
    - [Q7. How do you read environment variables in Python?](#q7-how-do-you-read-environment-variables-in-python)
    - [Q8. How do you execute Linux commands using Python?](#q8-how-do-you-execute-linux-commands-using-python)
    - [Q9. How do you read and write files in Python?](#q9-how-do-you-read-and-write-files-in-python)
    - [Q10. How do you handle JSON and YAML files in Python?](#q10-how-do-you-handle-json-and-yaml-files-in-python)
- [Part 2: Real-Time Python Automation Scripts for DevOps](#part-2-real-time-python-automation-scripts-for-devops)
    - [Q11. Write a Python script to check Linux disk usage and alert if it exceeds 80%.](#q11-write-a-python-script-to-check-linux-disk-usage-and-alert-if-it-exceeds-80)
    - [Q12. Write a Python script to monitor CPU and memory usage.](#q12-write-a-python-script-to-monitor-cpu-and-memory-usage)
    - [Q13. Write a Python script to monitor application health.](#q13-write-a-python-script-to-monitor-application-health)
    - [Q14. Write a Python script to check ERROR messages in an application log.](#q14-write-a-python-script-to-check-error-messages-in-an-application-log)
    - [Q15. Write a Python script to check whether a Linux service is running.](#q15-write-a-python-script-to-check-whether-a-linux-service-is-running)
    - [Q16. Write a Python script to list EC2 instances and their running status.](#q16-write-a-python-script-to-list-ec2-instances-and-their-running-status)
    - [Q17. Write a Python script to stop an EC2 instance.](#q17-write-a-python-script-to-stop-an-ec2-instance)
    - [Q18. Write a Python script to upload application logs to S3.](#q18-write-a-python-script-to-upload-application-logs-to-s3)
    - [Q19. Write a Python script to find unattached EBS volumes.](#q19-write-a-python-script-to-find-unattached-ebs-volumes)
    - [Q20. Write a Python script to create an RDS database snapshot.](#q20-write-a-python-script-to-create-an-rds-database-snapshot)
- [Part 3: Python for EKS, Docker, Terraform and Azure DevOps](#part-3-python-for-eks-docker-terraform-and-azure-devops)
    - [Q21. Write a Python script to check Kubernetes pod status.](#q21-write-a-python-script-to-check-kubernetes-pod-status)
    - [Q22. Write a Python script to identify Kubernetes pods that are not Running.](#q22-write-a-python-script-to-identify-kubernetes-pods-that-are-not-running)
    - [Q23. Write a Python script to check Docker containers.](#q23-write-a-python-script-to-check-docker-containers)
    - [Q24. How do you use Python to detect Terraform infrastructure changes?](#q24-how-do-you-use-python-to-detect-terraform-infrastructure-changes)
    - [Q25. How do you call REST APIs using Python?](#q25-how-do-you-call-rest-apis-using-python)
    - [Q26. How do you execute Python scripts inside an Azure DevOps pipeline?](#q26-how-do-you-execute-python-scripts-inside-an-azure-devops-pipeline)
    - [Q27. How do you schedule Python automation scripts?](#q27-how-do-you-schedule-python-automation-scripts)
    - [Q28. How do you make a Python automation script production-ready?](#q28-how-do-you-make-a-python-automation-script-production-ready)
- [Part 4: Common Python Coding Questions](#part-4-common-python-coding-questions)
    - [Coding 1. Reverse a string.](#coding-1-reverse-a-string)
    - [Coding 2. Check whether a string is a palindrome.](#coding-2-check-whether-a-string-is-a-palindrome)
    - [Coding 3. Find duplicate values in a list.](#coding-3-find-duplicate-values-in-a-list)
    - [Coding 4. Remove duplicates from a list.](#coding-4-remove-duplicates-from-a-list)
    - [Coding 5. Find the second-largest number in a list.](#coding-5-find-the-second-largest-number-in-a-list)
    - [Coding 6. Count how many times each word appears.](#coding-6-count-how-many-times-each-word-appears)
    - [Coding 7. Print even numbers from a list.](#coding-7-print-even-numbers-from-a-list)
    - [Coding 8. Check whether a number is prime.](#coding-8-check-whether-a-number-is-prime)
    - [Coding 9. Print a Fibonacci series.](#coding-9-print-a-fibonacci-series)
    - [Coding 10. Find the largest number without using `max()`.](#coding-10-find-the-largest-number-without-using-max)
    - [Coding 11. Sort a dictionary by value.](#coding-11-sort-a-dictionary-by-value)
    - [Coding 12. Compare a configuration value against an expected value.](#coding-12-compare-a-configuration-value-against-an-expected-value)
- [Part 5: Additional Python Interview Questions](#part-5-additional-python-interview-questions)
- [Python Coding Interview Preparation – Senior DevOps Engineer](#python-coding-interview-preparation--senior-devops-engineer)
- [Part 1: The Original 12 Python Coding Questions](#part-1-the-original-12-python-coding-questions)
    - [Q1. Write a Python program to reverse a string.](#q1-write-a-python-program-to-reverse-a-string)
    - [Q2. Write a Python program to check whether a string is a palindrome.](#q2-write-a-python-program-to-check-whether-a-string-is-a-palindrome)
    - [Q3. Write a Python program to find duplicates in a list.](#q3-write-a-python-program-to-find-duplicates-in-a-list)
    - [Q4. Write a Python program to remove duplicates from a list.](#q4-write-a-python-program-to-remove-duplicates-from-a-list)
    - [Q5. Write a Python program to find the second-largest number.](#q5-write-a-python-program-to-find-the-second-largest-number)
    - [Q6. Write a Python program to count the frequency of words.](#q6-write-a-python-program-to-count-the-frequency-of-words)
    - [Q7. Write a Python program to print even numbers.](#q7-write-a-python-program-to-print-even-numbers)
    - [Q8. Write a Python program to check a prime number.](#q8-write-a-python-program-to-check-a-prime-number)
    - [Q9. Write a Python program to print the Fibonacci series.](#q9-write-a-python-program-to-print-the-fibonacci-series)
    - [Q10. Write a Python program to find the largest number without using `max()`.](#q10-write-a-python-program-to-find-the-largest-number-without-using-max)
    - [Q11. Write a Python program to sort a dictionary by its values.](#q11-write-a-python-program-to-sort-a-dictionary-by-its-values)
    - [Q12. Write a Python program to validate Kubernetes replica count.](#q12-write-a-python-program-to-validate-kubernetes-replica-count)
- [Part 2: 20 Additional Commonly Asked Python Coding Questions](#part-2-20-additional-commonly-asked-python-coding-questions)
    - [Q13. Swap two numbers without using a third variable.](#q13-swap-two-numbers-without-using-a-third-variable)
    - [Q14. Find the factorial of a number.](#q14-find-the-factorial-of-a-number)
    - [Q15. Count vowels in a string.](#q15-count-vowels-in-a-string)
    - [Q16. Count the frequency of each character in a string.](#q16-count-the-frequency-of-each-character-in-a-string)
    - [Q17. Check whether two strings are anagrams.](#q17-check-whether-two-strings-are-anagrams)
    - [Q18. Find the first non-repeating character.](#q18-find-the-first-non-repeating-character)
    - [Q19. Reverse an integer.](#q19-reverse-an-integer)
    - [Q20. Find the sum of digits of a number.](#q20-find-the-sum-of-digits-of-a-number)
    - [Q21. Count even and odd numbers in a list.](#q21-count-even-and-odd-numbers-in-a-list)
    - [Q22. Find the missing number in a list from 1 to N.](#q22-find-the-missing-number-in-a-list-from-1-to-n)
    - [Q23. Find common elements between two lists.](#q23-find-common-elements-between-two-lists)
    - [Q24. Merge two dictionaries.](#q24-merge-two-dictionaries)
    - [Q25. Sort a list without using `sort()` or `sorted()`.](#q25-sort-a-list-without-using-sort-or-sorted)
    - [Q26. Write the FizzBuzz program.](#q26-write-the-fizzbuzz-program)
    - [Q27. Find the value of a key in a dictionary safely.](#q27-find-the-value-of-a-key-in-a-dictionary-safely)
    - [Q28. Flatten a nested list.](#q28-flatten-a-nested-list)
    - [Q29. Read a log file and count ERROR messages.](#q29-read-a-log-file-and-count-error-messages)
    - [Q30. Write a Python program to check disk usage above 80%.](#q30-write-a-python-program-to-check-disk-usage-above-80)
    - [Q31. Write a Python program to check whether an application is UP.](#q31-write-a-python-program-to-check-whether-an-application-is-up)
    - [Q32. Write a Python program to read JSON and display application details.](#q32-write-a-python-program-to-read-json-and-display-application-details)
- [Part 3: Additional Commonly Asked Python Interview Questions](#part-3-additional-commonly-asked-python-interview-questions)
  - [Python Basics](#python-basics)
  - [Functions, OOP and Error Handling](#functions-oop-and-error-handling)
  - [Python for DevOps and Automation](#python-for-devops-and-automation)
- [Part 4: Five Additional DevOps Coding Questions That Are Worth Practising](#part-4-five-additional-devops-coding-questions-that-are-worth-practising)
    - [Q33. Write a Python script to list only running EC2 instances.](#q33-write-a-python-script-to-list-only-running-ec2-instances)
    - [Q34. Write a Python script to identify failed Kubernetes pods.](#q34-write-a-python-script-to-identify-failed-kubernetes-pods)
    - [Q35. Write a Python script to check multiple application URLs.](#q35-write-a-python-script-to-check-multiple-application-urls)
    - [Q36. Write a Python script to execute a Linux command and handle failure.](#q36-write-a-python-script-to-execute-a-linux-command-and-handle-failure)
    - [Q37. Write a Python script to identify the server with the highest CPU usage.](#q37-write-a-python-script-to-identify-the-server-with-the-highest-cpu-usage)
  - [Final Revision: What to Prioritize](#final-revision-what-to-prioritize)

---

# Senior DevOps Engineer – Python Scripting Interview Preparation

Interview: Netenvy Analytics, Bengaluru Focus: Python for DevOps, AWS, EKS, Linux, CI/CD and automation Level: Senior DevOps Engineer (approximately 5 years' experience)

I'll follow the same format as your previous preparation notes: simple interview answers, small Python scripts, explanations, real-time scenarios and follow-up questions.

The goal is to help you explain the logic confidently and write the code during the interview without memorizing complicated programs.

## What you should prepare first

For a Senior DevOps interview, these are the Python topics I would prioritize:

| Priority  | Topic              | What to practise                               |
| --------- | ------------------ | ---------------------------------------------- |
| Very high | Python basics      | Lists, dictionaries, loops, functions          |
| Very high | Linux automation   | CPU, memory, disk, logs, processes             |
| Very high | AWS Boto3          | EC2, S3, EBS, backups                          |
| Very high | API automation     | GET/POST, JSON, error handling                 |
| Very high | File handling      | Read logs, search errors, manage files         |
| High      | EKS automation     | Check pods, deployments, logs                  |
| High      | CI/CD              | Execute Python in Azure DevOps                 |
| High      | JSON and YAML      | Read and update configurations                 |
| High      | Exception handling | Handle failed API calls and commands           |
| High      | Coding exercises   | Strings, lists, dictionaries, basic algorithms |

# Part 1: Python Fundamentals for DevOps

### Q1. Why do DevOps engineers use Python?

Interview Answer:

Python helps us automate repetitive DevOps tasks.

We use it for AWS resource management, Linux monitoring, log analysis, API integration, backup automation, and CI/CD tasks.

Instead of manually running multiple commands, we write scripts to automate them.

Example:

Real-Time Scenario: Instead of manually checking disk usage on a Linux server every day, we schedule a Python script to monitor disk utilization and generate alerts.

Follow-Up: Why Python instead of Bash?

Answer: Bash is useful for simple Linux commands. Python is better suited for more complex automation, API calls, JSON handling, and AWS SDK integration.

### Q2. What are the main Python data types?

Interview Answer:

The main Python data types are string, integer, float, boolean, list, tuple, set, and dictionary.

In DevOps automation, I commonly use lists and dictionaries to work with API responses and cloud resource details.

Example:

Real-Time Scenario: When Boto3 returns EC2 information, we use dictionaries and lists to extract instance IDs, names, and states.

### Q3. What is the difference between a list, tuple, set, and dictionary?

Interview Answer:

- List: Ordered collection that can be modified.
- Tuple: Ordered collection that cannot be modified.
- Set: Collection of unique values.
- Dictionary: Stores key-value pairs.

Example:

Real-Time Scenario: I use a list for EC2 instance IDs and a dictionary for detailed instance information.

### Q4. How do you use a for loop in Python?

Interview Answer:

A for loop is used to execute the same operation for multiple items.

For example, we can use it to check several servers or process multiple EC2 instances.

Python Code:

Output:

Real-Time Scenario: We receive a list of EC2 instances from AWS. We use a for loop to check the status of each instance.

### Q5. What is a function in Python, and why do we use it?

Interview Answer:

A function is a reusable block of code that performs a specific task.

We use functions to avoid repeating code and make automation scripts easier to maintain.

Python Code:

Output:

Real-Time Scenario: Instead of writing the same health-check logic for multiple applications, we create a function and reuse it.

Follow-Up: Difference between `print` and `return`?

Answer: `print` displays output. `return` sends a value back to the calling code.

### Q6. What is exception handling in Python?

Interview Answer:

Exception handling prevents our script from stopping unexpectedly when an error occurs.

We use `try` and `except` to handle failures such as API timeouts, missing files, and AWS permission errors.

Python Code:

Real-Time Scenario: A Python script calls an AWS API, but the request fails. We catch the expected error, log the failure, and decide whether to retry or stop.

Follow-Up: What is `finally`?

Answer: `finally` runs whether an exception occurs or not. We use it for cleanup activities.

### Q7. How do you read environment variables in Python?

Interview Answer:

We use the `os` module to read environment variables.

This helps us avoid hardcoding environment-specific values or secrets in scripts.

Python Code:

Linux Command:

Real-Time Scenario: Our Python automation runs in Dev and Production. Instead of changing the script, we pass the appropriate region using environment variables.

Important: We should not print passwords, access tokens, or secret environment variables in pipeline logs.

### Q8. How do you execute Linux commands using Python?

Interview Answer:

We use the `subprocess` module to execute Linux commands from Python.

We can capture command output, check exit codes, and handle failures.

Python Code:

Real-Time Scenario: A Python monitoring script executes Linux commands to collect disk usage and system information.

Follow-Up: Difference between `os.system()` and `subprocess.run()`?

Answer: `os.system()` is a simple way to execute a command. `subprocess.run()` gives better control over arguments, output, errors, and exit codes.

Important: Prefer passing commands as lists rather than using `shell=True` with user-provided values.

### Q9. How do you read and write files in Python?

Interview Answer:

We use the `open()` function to read and write files.

For DevOps, we commonly read log files, configuration files, and command output.

Read a file:

Write to a file:

Real-Time Scenario: After checking application health, a Python script writes the result to a report file.

Follow-Up: Why use `with open()`?

Answer: It automatically closes the file when the block finishes, including when an error occurs.

### Q10. How do you handle JSON and YAML files in Python?

Interview Answer:

We use the `json` module to read JSON files and PyYAML to read YAML files.

In DevOps, we work with JSON API responses, Kubernetes manifests, and application configurations.

JSON Example:

`config.json`

Python Code:

YAML Example:

`config.yaml`

Python Code:

Real-Time Scenario: We use Python to read Kubernetes YAML configuration and validate the configured replica count.

Important: Use `yaml.safe_load()` for configuration data rather than unsafe deserialization.

# Part 2: Real-Time Python Automation Scripts for DevOps

These are the most important scripts to practise. Each is small enough to explain or write during an interview.

### Q11. Write a Python script to check Linux disk usage and alert if it exceeds 80%.

Interview Answer:

We use Python's `shutil` module to check disk usage.

If disk usage exceeds the threshold, the script prints an alert and returns a failure exit code.

Python Script – `disk_check.py`:

Run:

Real-Time Scenario: We schedule this script to monitor the root filesystem. If usage crosses 80%, the script reports an unhealthy status so our monitoring system can generate an alert.

How to Explain:

> First, I get total and used disk space using `shutil.disk_usage`.
>
> Then I calculate the percentage.
>
> If it crosses 80%, I print an alert and return a non-zero exit code.

### Q12. Write a Python script to monitor CPU and memory usage.

Interview Answer:

We use the `psutil` library to monitor CPU and memory utilization.

If utilization crosses the defined threshold, we generate an alert.

Install:

Python Script – `resource_check.py`:

Real-Time Scenario: An EC2 application server suddenly uses 95% CPU. The monitoring script identifies high usage and generates an alert.

Follow-Up: How can you identify the process consuming high CPU?

Answer: We can use `psutil.process_iter()` or Linux commands like `top` and `ps`.

### Q13. Write a Python script to monitor application health.

Interview Answer:

We use the `requests` library to send an HTTP request to the application health endpoint.

If the application returns a successful response, we report it as healthy.

Otherwise, we generate an alert.

Python Script – `health_check.py`:

Real-Time Scenario: After deploying an application to EKS, we execute this script to confirm that the application is accessible.

Follow-Up: Why do we use `timeout=5`?

Answer: To prevent the script from hanging indefinitely if the application does not respond.

### Q14. Write a Python script to check ERROR messages in an application log.

Interview Answer:

We open the application log file and search for lines containing `ERROR`.

This helps identify application failures during production troubleshooting.

Python Script – `log_check.py`:

Example Log:

Output:

Real-Time Scenario: During an incident, I use Python to filter error messages from application logs instead of reading the entire file manually.

Follow-Up: How do you count the number of errors?

### Q15. Write a Python script to check whether a Linux service is running.

Interview Answer:

We use `subprocess` to execute `systemctl is-active` and check the service status.

If the service is stopped, we report it.

Python Script – `service_check.py`:

Real-Time Scenario: A production Nginx service stops unexpectedly. Our script detects that the service is inactive.

Follow-Up: Can Python restart the service automatically?

Answer: Yes. With approved permissions, we can execute a restart command using subprocess.

In production, automatic restarts should follow a defined recovery policy. Repeatedly restarting a failing service can hide the root cause.

### Q16. Write a Python script to list EC2 instances and their running status.

Interview Answer:

We use Boto3, the AWS SDK for Python.

It allows us to communicate with AWS services without manually using AWS Console.

We use `describe_instances()` to retrieve EC2 details.

Python Script – `ec2_list.py`:

Example Output:

Real-Time Scenario: Instead of checking EC2 instances manually in AWS Console, we use a Python script to generate a list of running and stopped instances.

Follow-Up: What if your AWS account has hundreds of instances?

Answer: We use pagination to retrieve all results.

AWS recommends pagination for large EC2 queries.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.aws.amazon.com\&sz=32)

Boto3 1.43.110 documentation



### Q17. Write a Python script to stop an EC2 instance.

Interview Answer:

We use Boto3's `stop_instances()` API to stop a specified EC2 instance.

In production, we verify the instance ID, environment, permissions, and approval before stopping it.

Python Script – `stop_ec2.py`:

Real-Time Scenario: An approved cost-optimization task requires stopping a non-production EC2 instance after working hours.

Important: Stopping an instance is not the same as terminating it. The script above sends a stop request and does not wait for the instance to reach Stopped state. Use approved tags, instance allowlists, and scheduled automation for real environments.

### Q18. Write a Python script to upload application logs to S3.

Interview Answer:

We use Boto3's S3 client and `upload_file()` method.

This helps us automate transferring log files, reports, and backup artifacts to S3.

Python Script – `s3_upload.py`:

Real-Time Scenario: We collect an application log file and upload it to an approved S3 bucket for troubleshooting or retention.

Follow-Up: How does Python authenticate with AWS?

Answer: Boto3 uses the AWS credential provider chain. On EC2 or EKS, we prefer IAM roles and temporary credentials instead of hardcoding access keys.

### Q19. Write a Python script to find unattached EBS volumes.

Interview Answer:

We use Boto3 to identify EBS volumes with the state `available`.

These volumes are not currently attached to EC2 instances.

We can review them to identify possible unnecessary infrastructure costs.

Python Script – `ebs_check.py`:

Real-Time Scenario: During a cost review, we identify unattached EBS volumes and share the report with the infrastructure team.

Follow-Up: Can we automatically delete them?

Answer: Technically yes, but we should verify ownership, backup status, tags, and retention requirements before deleting any volume. An unattached volume may still contain important data.

### Q20. Write a Python script to create an RDS database snapshot.

Interview Answer:

We use the Boto3 RDS client to create a database snapshot.

This can help automate recovery-point creation before maintenance or certain infrastructure changes.

Python Script – `rds_snapshot.py`:

Real-Time Scenario: Before an approved database maintenance activity, we create a manual RDS snapshot as an additional recovery measure.

Important: This applies to standard RDS DB instances, not Aurora clusters. The request starts snapshot creation asynchronously; we must confirm snapshot completion before relying on it.

# Part 3: Python for EKS, Docker, Terraform and Azure DevOps

### Q21. Write a Python script to check Kubernetes pod status.

Interview Answer:

We can use Python with `subprocess` to execute kubectl commands.

We retrieve pod information as JSON, process the result, and print pod status.

Python Script – `eks_pod_check.py`:

Example Output:

Real-Time Scenario: We run this script after deployment to check whether all application pods are running.

Follow-Up: Does Running mean the pod is Ready?

Answer: No. We must also check container readiness conditions. A Running pod can still be NotReady.

### Q22. Write a Python script to identify Kubernetes pods that are not Running.

Interview Answer:

We retrieve Kubernetes pod data and filter pods whose phase is not Running.

For production readiness, we also check readiness conditions and waiting reasons such as CrashLoopBackOff.

Python Code:

Real-Time Scenario: After a cluster upgrade, this script helps us identify pods in Pending or Failed states.

Follow-Up: How do you check CrashLoopBackOff?

Answer: We inspect `containerStatuses` and their `state.waiting.reason`, or use `kubectl describe pod`.

Production Command:

### Q23. Write a Python script to check Docker containers.

Interview Answer:

We can execute Docker commands using Python subprocess.

For example, we can list running containers and identify stopped containers.

Python Code:

Real-Time Scenario: A standalone Docker container crashes. We use a Python script to collect its current status and identify containers that exited.

Follow-Up: How do you check the container's exit code?

Follow-Up: How do you check historical CPU or memory usage?

Answer: Use previously collected monitoring data from Prometheus or Grafana. `docker stats` provides live measurements for running containers, not the full historical resource usage of a stopped container.

### Q24. How do you use Python to detect Terraform infrastructure changes?

Interview Answer:

We use Python subprocess to execute `terraform plan -detailed-exitcode`.

Terraform returns an exit code indicating whether changes exist.

The script can use that status to decide whether a CI/CD pipeline needs approval.

Python Script – `terraform_check.py`:

Real-Time Scenario: Azure DevOps executes this script to detect Terraform changes before allowing the Production infrastructure deployment.

Follow-Up: What do the Terraform exit codes mean?

| Exit Code | Meaning          |
| --------- | ---------------- |
| 0         | No changes       |
| 1         | Error            |
| 2         | Changes detected |

### Q25. How do you call REST APIs using Python?

Interview Answer:

We use the `requests` library to make REST API calls.

We commonly use GET to retrieve data and POST to submit data.

API automation is useful for CI/CD systems, monitoring, incident tools, and internal platforms.

GET Example:

POST Example:

Real-Time Scenario: A Python script checks a deployment status API and reports the results to an internal monitoring or release-management system.

Follow-Up: How do you handle HTTP 401, 403, and 500?

Answer:

- 401: Authentication is missing or invalid.
- 403: The request is not authorized.
- 500: The server encountered an internal error.

In production, we handle timeouts, unexpected status codes, and retries where safe.

### Q26. How do you execute Python scripts inside an Azure DevOps pipeline?

Interview Answer:

We store Python scripts in our Git repository.

The Azure DevOps pipeline checks out the code, installs the required Python packages, and executes the scripts.

If a script returns a non-zero exit code, the pipeline task fails.

Example Repository:

Example `requirements.txt`:

Azure DevOps Pipeline:

Real-Time Scenario: After deploying Payment Service to EKS, Azure DevOps executes a Python health-check script. If the service is unavailable, the validation stage fails.

The `PythonScript@0` task supports executing a Python file or inline code.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://learn.microsoft.com\&sz=32)

Microsoft Learn



### Q27. How do you schedule Python automation scripts?

Interview Answer:

For Linux servers, we can schedule Python scripts using cron.

For cloud environments, we can use EventBridge Scheduler, Lambda, or approved pipeline schedules.

Example Cron:

Run a disk check every five minutes:

Real-Time Scenario: We schedule a Python script to monitor disk usage every five minutes and report unhealthy results to our monitoring system.

Follow-Up: Can Python scripts run without an EC2 server?

Answer: Yes. We can run suitable scripts using AWS Lambda without maintaining a dedicated server.

### Q28. How do you make a Python automation script production-ready?

Interview Answer:

I add exception handling, logging, timeouts, and input validation.

I avoid hardcoded secrets and use IAM roles for AWS access.

For critical operations, I add approvals, dry-run support where possible, and checks to prevent duplicate actions.

Simple Logging Example:

Real-Time Scenario: A backup automation fails. Instead of silently stopping, the script logs the error and reports a failure to the pipeline or alerting system.

Follow-Up: Why is logging better than print?

Answer: Logging supports severity levels, timestamps, structured formatting, and forwarding to centralized log systems.

# Part 4: Common Python Coding Questions

These are the short programs I recommend practising without looking at the answers. They are common ways interviewers check whether you can write basic Python independently.

### Coding 1. Reverse a string.

Output: `spOveD`

Explanation: `[::-1]` reverses the string.

### Coding 2. Check whether a string is a palindrome.

Explanation: A palindrome reads the same forward and backward.

### Coding 3. Find duplicate values in a list.

Output: `[2, 3]`

Explanation: Check which numbers appear more than once. This is simple for an interview, although larger lists benefit from using sets or counters.

### Coding 4. Remove duplicates from a list.

Output: `[1, 2, 3, 4]`

Explanation: Dictionary keys are unique, and their insertion order is preserved.

### Coding 5. Find the second-largest number in a list.

Output: `40`

Explanation: Remove duplicates, sort the values, and select the second-last element.

Follow-Up: Check that at least two distinct values exist before using this in a production script.

### Coding 6. Count how many times each word appears.

Output:

DevOps Scenario: Counting repeated error messages or status values in logs.

### Coding 7. Print even numbers from a list.

Output: `2`, `4`, `6`

### Coding 8. Check whether a number is prime.

Explanation: A prime number is divisible only by 1 and itself.

### Coding 9. Print a Fibonacci series.

Output:

### Coding 10. Find the largest number without using `max()`.

Output: `80`

### Coding 11. Sort a dictionary by value.

DevOps Scenario: Sorting servers by CPU usage to identify which server is consuming the most resources.

### Coding 12. Compare a configuration value against an expected value.

DevOps Scenario: Validating Kubernetes application configuration before deployment.

# Part 5: Additional Python Interview Questions

| Question                           | Simple Interview Answer                                                                             |
| ---------------------------------- | --------------------------------------------------------------------------------------------------- |
| What is PIP?                       | Python package installer.                                                                           |
| What is a virtual environment?     | An isolated environment for project-specific Python dependencies.                                   |
| What is Boto3?                     | AWS SDK for Python used to automate AWS services.                                                   |
| Difference between list and tuple? | List is mutable; tuple is immutable.                                                                |
| Difference between `==` and `is`?  | `==` compares values; `is` compares object identity.                                                |
| What is list comprehension?        | A shorter way to create a list using a loop and optional condition.                                 |
| What is a lambda function?         | A small anonymous function.                                                                         |
| What is a decorator?               | A function or callable that wraps or modifies another function's behavior.                          |
| What is a generator?               | Produces values one at a time, commonly using `yield`.                                              |
| What is `*args`?                   | Accepts multiple positional arguments.                                                              |
| What is `**kwargs`?                | Accepts multiple keyword arguments.                                                                 |
| What is a class?                   | A blueprint for creating objects containing data and methods.                                       |
| What is `__init__`?                | An initializer called when creating a class instance.                                               |
| What is OOP?                       | Organizing code using classes and objects.                                                          |
| What is multithreading?            | Running multiple threads, useful for overlapping I/O operations.                                    |
| What is multiprocessing?           | Running work in separate processes, useful for CPU-intensive tasks.                                 |
| What is the GIL?                   | In standard CPython builds, a mechanism limiting simultaneous Python bytecode execution by threads. |
| What is a Python module?           | A Python file containing reusable code.                                                             |
| What is exception handling?        | Handling errors using `try`, `except`, and related statements.                                      |
| What is `requirements.txt`?        | A file listing Python dependencies.                                                                 |
| What is `__name__ == "__main__"`?  | A condition used to run code only when a file is executed directly.                                 |
| What is `pytest`?                  | A Python testing framework.                                                                         |
| What is idempotency?               | Repeating an operation safely without creating unintended additional changes.                       |
| What is a paginator in Boto3?      | A tool for fetching multiple pages of AWS API results.                                              |
| What is a waiter in Boto3?         | A helper that waits for an AWS resource to reach a specified state.                                 |
| How do you secure Python scripts?  | Use IAM roles, secrets managers, validation, timeouts,                                              |

# Python Coding Interview Preparation – Senior DevOps Engineer

Target: Netenvy Analytics – Senior DevOps Engineer Level: Basic to Intermediate Python + DevOps Automation Format: Interview question → Simple Python code → Short explanation

Bro, I've included the original 12 coding questions, 20 additional commonly asked Python coding questions, and extra Python interview questions with short answers.

The programs are deliberately simple so you can write and explain them during the interview.

# Part 1: The Original 12 Python Coding Questions

### Q1. Write a Python program to reverse a string.

```
text = "DevOps"reverse = text[::-1]print(reverse)
```

Output:

```
spOveD
```

Explanation: `[::-1]` reverses the characters in the string.

Follow-Up: Reverse without slicing.

```
text = "DevOps"reverse = ""for char in text:    reverse = char + reverseprint(reverse)
```

### Q2. Write a Python program to check whether a string is a palindrome.

```
text = "madam"if text == text[::-1]:    print("Palindrome")else:    print("Not Palindrome")
```

Output:

```
Palindrome
```

Explanation: A palindrome reads the same forward and backward.

### Q3. Write a Python program to find duplicates in a list.

```
numbers = [1, 2, 3, 2, 4, 3]duplicates = []for num in numbers:    if numbers.count(num) > 1 and num not in duplicates:        duplicates.append(num)print(duplicates)
```

Output:

```
[2, 3]
```

Explanation: We check which numbers appear more than once.

Follow-Up: Find duplicates using a set.

```
numbers = [1, 2, 3, 2, 4, 3]seen = set()duplicates = set()for num in numbers:    if num in seen:        duplicates.add(num)    else:        seen.add(num)print(sorted(duplicates))
```

### Q4. Write a Python program to remove duplicates from a list.

```
numbers = [1, 2, 2, 3, 4, 4]unique = []for num in numbers:    if num not in unique:        unique.append(num)print(unique)
```

Output:

```
[1, 2, 3, 4]
```

Shorter Method:

```
numbers = [1, 2, 2, 3, 4, 4]print(list(dict.fromkeys(numbers)))
```

Explanation: We store only the first occurrence of each number.

### Q5. Write a Python program to find the second-largest number.

```
numbers = [10, 30, 20, 50, 40]unique = sorted(set(numbers))if len(unique) >= 2:    print(unique[-2])else:    print("Second largest not available")
```

Output:

```
40
```

Explanation: Remove duplicates, sort the numbers, and take the second-last number.

### Q6. Write a Python program to count the frequency of words.

```
text = "aws eks aws terraform eks aws"words = text.split()count = {}for word in words:    count[word] = count.get(word, 0) + 1print(count)
```

Output:

```
{'aws': 3, 'eks': 2, 'terraform': 1}
```

Explanation: We use a dictionary to count how many times each word appears.

DevOps Use Case: Counting repeated errors or status messages in application logs.

### Q7. Write a Python program to print even numbers.

```
numbers = [1, 2, 3, 4, 5, 6]for num in numbers:    if num % 2 == 0:        print(num)
```

Output:

```
2
4
6
```

Explanation: A number is even if the remainder after dividing by 2 is zero.

### Q8. Write a Python program to check a prime number.

```
num = 7if num < 2:    print("Not Prime")else:    for i in range(2, num):        if num % i == 0:            print("Not Prime")            break    else:        print("Prime")
```

Output:

```
Prime
```

Explanation: A prime number is divisible only by 1 and itself.

### Q9. Write a Python program to print the Fibonacci series.

```
a = 0b = 1for i in range(7):    print(a)    a, b = b, a + b
```

Output:

```
0
1
1
2
3
5
8
```

Explanation: Every new number is the sum of the previous two numbers.

### Q10. Write a Python program to find the largest number without using `max()`.

```
numbers = [10, 50, 20, 80, 30]largest = numbers[0]for num in numbers:    if num > largest:        largest = numprint(largest)
```

Output:

```
80
```

Explanation: We compare each element and update the largest value.

### Q11. Write a Python program to sort a dictionary by its values.

```
servers = {    "server1": 80,    "server2": 40,    "server3": 95}result = sorted(    servers.items(),    key=lambda x: x[1])print(result)
```

Output:

```
[('server2', 40), ('server1', 80), ('server3', 95)]
```

Explanation: `lambda x: x[1]` selects the dictionary value for sorting.

DevOps Use Case: Sorting servers based on CPU or memory usage.

### Q12. Write a Python program to validate Kubernetes replica count.

```
config = {    "application": "payment-service",    "replicas": 2}if config["replicas"] < 3:    print("Alert: Insufficient replicas")else:    print("Replica count is sufficient")
```

Output:

```
Alert: Insufficient replicas
```

Explanation: We compare the current replica configuration against the required minimum.

DevOps Use Case: Validating deployment configurations before promotion to Production.

# Part 2: 20 Additional Commonly Asked Python Coding Questions

### Q13. Swap two numbers without using a third variable.

```
a = 10b = 20a, b = b, aprint("a =", a)print("b =", b)
```

Output:

```
a = 20
b = 10
```

Explanation: Python allows us to swap values using multiple assignment.

### Q14. Find the factorial of a number.

```
num = 5factorial = 1for i in range(1, num + 1):    factorial = factorial * iprint(factorial)
```

Output: `120`

Explanation: Factorial of 5 is 5 × 4 × 3 × 2 × 1.

### Q15. Count vowels in a string.

```
text = "DevOps Engineer"count = 0for char in text.lower():    if char in "aeiou":        count += 1print("Vowels:", count)
```

Output: `Vowels: 6`

Explanation: We loop through each character and check whether it is a vowel.

### Q16. Count the frequency of each character in a string.

```
text = "banana"count = {}for char in text:    count[char] = count.get(char, 0) + 1print(count)
```

Output:

```
{'b': 1, 'a': 3, 'n': 2}
```

Explanation: A dictionary stores each character and its occurrence count.

### Q17. Check whether two strings are anagrams.

Interview Question: Are `"listen"` and `"silent"` anagrams?

```
a = "listen"b = "silent"if sorted(a) == sorted(b):    print("Anagram")else:    print("Not Anagram")
```

Output: `Anagram`

Explanation: Anagrams contain the same characters with the same frequency, but their order may differ.

### Q18. Find the first non-repeating character.

```
text = "aabbcde"for char in text:    if text.count(char) == 1:        print(char)        break
```

Output: `c`

Explanation: We return the first character that appears only once.

### Q19. Reverse an integer.

```
num = 12345reverse = int(str(num)[::-1])print(reverse)
```

Output: `54321`

Explanation: Convert the integer to a string, reverse it, and convert it back to an integer. This example assumes a non-negative integer.

### Q20. Find the sum of digits of a number.

```
num = 12345total = 0for digit in str(num):    total += int(digit)print(total)
```

Output: `15`

Explanation: We add each digit individually.

### Q21. Count even and odd numbers in a list.

```
numbers = [1, 2, 3, 4, 5, 6]even = 0odd = 0for num in numbers:    if num % 2 == 0:        even += 1    else:        odd += 1print("Even:", even)print("Odd:", odd)
```

Output:

```
Even: 3
Odd: 3
```

### Q22. Find the missing number in a list from 1 to N.

Example: `[1, 2, 3, 5]` — missing number is 4.

```
numbers = [1, 2, 3, 5]n = 5expected = n * (n + 1) // 2actual = sum(numbers)print("Missing number:", expected - actual)
```

Output: `Missing number: 4`

Explanation: Calculate the expected sum and subtract the actual sum.

Important: This works when the numbers should contain 1 through N with exactly one missing value and no duplicates.

### Q23. Find common elements between two lists.

```
list1 = [1, 2, 3, 4]list2 = [3, 4, 5, 6]common = []for num in list1:    if num in list2:        common.append(num)print(common)
```

Output: `[3, 4]`

Shorter Method:

```
print(list(set(list1) & set(list2)))
```

Sets do not guarantee a particular display order.

### Q24. Merge two dictionaries.

```
dict1 = {    "name": "payment-service"}dict2 = {    "replicas": 3}merged = {**dict1, **dict2}print(merged)
```

Output:

```
{'name': 'payment-service', 'replicas': 3}
```

DevOps Use Case: Combining application configuration values with environment-specific settings. If both dictionaries have the same key, the second value wins.

### Q25. Sort a list without using `sort()` or `sorted()`.

Simple Bubble Sort:

```
numbers = [5, 2, 8, 1, 3]for i in range(len(numbers)):    for j in range(len(numbers) - 1):        if numbers[j] > numbers[j + 1]:            numbers[j], numbers[j + 1] = (                numbers[j + 1], numbers[j]            )print(numbers)
```

Output: `[1, 2, 3, 5, 8]`

Explanation: We repeatedly compare neighboring numbers and swap them when they are in the wrong order.

### Q26. Write the FizzBuzz program.

Question: Print numbers from 1 to 20. Print Fizz for multiples of 3, Buzz for multiples of 5, and FizzBuzz for multiples of both.

```
for num in range(1, 21):    if num % 3 == 0 and num % 5 == 0:        print("FizzBuzz")    elif num % 3 == 0:        print("Fizz")    elif num % 5 == 0:        print("Buzz")    else:        print(num)
```

Explanation: Check divisibility by both 3 and 5 first.

### Q27. Find the value of a key in a dictionary safely.

```
server = {    "name": "prod-ec2",    "status": "running"}status = server.get("status", "unknown")region = server.get("region", "not configured")print(status)print(region)
```

Output:

```
running
not configured
```

Explanation: `.get()` avoids a `KeyError` when a key is missing.

DevOps Use Case: AWS API responses may contain optional fields. We use `.get()` when a field is not guaranteed to exist.

### Q28. Flatten a nested list.

```
numbers = [[1, 2], [3, 4], [5, 6]]result = []for group in numbers:    for num in group:        result.append(num)print(result)
```

Output: `[1, 2, 3, 4, 5, 6]`

Explanation: We use one loop for the outer list and another loop for each inner list.

### Q29. Read a log file and count ERROR messages.

```
count = 0with open("app.log", "r") as file:    for line in file:        if "ERROR" in line:            count += 1print("Total Errors:", count)
```

Sample `app.log`:

```
INFO Server started
ERROR Database unavailable
INFO Retrying
ERROR Connection timeout
```

Output: `Total Errors: 2`

DevOps Scenario: During a production incident, I use this script to count error messages in application logs.

### Q30. Write a Python program to check disk usage above 80%.

```
import shutiltotal, used, free = shutil.disk_usage("/")usage = (used / total) * 100print(f"Disk Usage: {usage:.2f}%")if usage > 80:    print("ALERT: High Disk Usage")else:    print("Disk Usage Normal")
```

DevOps Scenario: We automate disk monitoring on EC2 Linux servers.

Follow-Up: How would you schedule this script?

Answer: Use cron, a systemd timer, or an appropriate cloud scheduler and alerting service.

### Q31. Write a Python program to check whether an application is UP.

```
import requestsurl = "https://example.com/health"try:    response = requests.get(url, timeout=5)    if response.status_code == 200:        print("Application is UP")    else:        print("Application is DOWN")except requests.RequestException:    print("Application is unreachable")
```

Explanation: We send an HTTP GET request and check the response.

DevOps Scenario: We execute this script after deploying a Python application into EKS.

### Q32. Write a Python program to read JSON and display application details.

Example `config.json`:

```
{
  "application": "payment-service",
  "environment": "production",
  "replicas": 3
}
```

Python Code:

```
import jsonwith open("config.json") as file:    data = json.load(file)print("Application:", data["application"])print("Environment:", data["environment"])print("Replicas:", data["replicas"])
```

Output:

```
Application: payment-service
Environment: production
Replicas: 3
```

DevOps Scenario: We use Python to validate application configuration before executing an Azure DevOps deployment pipeline.

# Part 3: Additional Commonly Asked Python Interview Questions

These are theory questions an interviewer may ask immediately after you finish a coding exercise.

## Python Basics

| Question                                         | Simple Interview Answer                                                                                               |
| ------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------- |
| 1. What is Python?                               | Python is a high-level programming language widely used for scripting, automation, APIs, and application development. |
| 2. Is Python compiled or interpreted?            | Python code is generally compiled to bytecode and then executed by the Python interpreter.                            |
| 3. What is a variable?                           | A name used to reference a value or object.                                                                           |
| 4. What are mutable and immutable objects?       | Mutable objects can be changed. Immutable objects cannot be modified after creation.                                  |
| 5. Is a list mutable?                            | Yes, we can add, update, or remove elements.                                                                          |
| 6. Is a tuple mutable?                           | No, tuples are immutable, although they can contain mutable objects.                                                  |
| 7. Difference between list and set?              | A list preserves order and allows duplicates. A set stores unique hashable values.                                    |
| 8. Difference between `==` and `is`?             | `==` compares values, whereas `is` checks whether two references point to the same object.                            |
| 9. Difference between `append()` and `extend()`? | `append()` adds one object; `extend()` adds elements from an iterable.                                                |
| 10. Difference between `remove()` and `pop()`?   | `remove()` deletes a matching value; `pop()` removes and returns an element.                                          |
| 11. What is slicing?                             | Extracting part of a sequence using indexes.                                                                          |
| 12. What is a lambda function?                   | A small anonymous function, usually written as a single expression.                                                   |

## Functions, OOP and Error Handling

| Question                                     | Simple Interview Answer                                                                        |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| 13. What is `*args`?                         | It accepts multiple positional arguments.                                                      |
| 14. What is `**kwargs`?                      | It accepts multiple keyword arguments.                                                         |
| 15. Difference between `return` and `print`? | `return` sends a value back; `print` displays it.                                              |
| 16. What is a decorator?                     | A callable used to wrap or modify another function's behavior.                                 |
| 17. What is a generator?                     | A function that produces values one at a time using `yield`.                                   |
| 18. What is `__init__`?                      | The initializer method used when creating an object.                                           |
| 19. What is inheritance?                     | A class reuses or extends the behavior of another class.                                       |
| 20. What is exception handling?              | Handling expected errors using `try` and `except`.                                             |
| 21. What is `finally`?                       | A block that normally runs whether an exception occurs or not.                                 |
| 22. What is `raise`?                         | It explicitly raises an exception.                                                             |
| 23. What is a context manager?               | A mechanism for managing setup and cleanup, commonly using `with`.                             |
| 24. What is shallow copy vs deep copy?       | Shallow copy reuses references to nested objects; deep copy recursively copies nested objects. |

## Python for DevOps and Automation

| Question                                                               | Simple Interview Answer                                                                |
| ---------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| 25. What is Boto3?                                                     | The AWS SDK for Python, used to automate services such as EC2, S3, and RDS.            |
| 26. What is `subprocess`?                                              | A module used to run external programs and collect their results.                      |
| 27. What is `requests`?                                                | A Python library used to communicate with HTTP APIs.                                   |
| 28. What is a virtual environment?                                     | An isolated Python environment for installing project dependencies.                    |
| 29. What is `requirements.txt`?                                        | A file containing Python package requirements.                                         |
| 30. What is `logging`?                                                 | A module for recording application events and errors.                                  |
| 31. What is idempotency?                                               | Repeating an operation without causing additional unintended changes.                  |
| 32. What is a Boto3 paginator?                                         | A helper for retrieving multiple pages of AWS API results.                             |
| 33. What is a Boto3 waiter?                                            | A helper that polls an AWS resource until it reaches a specified state.                |
| 34. How do you handle API timeouts?                                    | Configure timeouts, catch expected errors, and retry safely when appropriate.          |
| 35. How do you secure Python automation?                               | Use IAM roles, least privilege, input validation, secure secrets, and proper logging.  |
| 36. How do you schedule Python scripts?                                | Use cron, systemd timers, EventBridge Scheduler, Lambda, or CI/CD schedules.           |
| 37. How do you test Python scripts?                                    | Use unit tests with `pytest` or `unittest`.                                            |
| 38. What is `__name__ == "__main__"`?                                  | It lets us execute specific code only when the Python file runs directly.              |
| 39. What is the difference between multithreading and multiprocessing? | Threads share process memory; multiprocessing uses separate processes.                 |
| 40. What is Python's GIL?                                              | In standard CPython builds, it limits how threads execute Python bytecode in parallel. |

# Part 4: Five Additional DevOps Coding Questions That Are Worth Practising

### Q33. Write a Python script to list only running EC2 instances.

```
import boto3ec2 = boto3.client("ec2", region_name="ap-south-1")response = ec2.describe_instances(    Filters=[        {            "Name": "instance-state-name",            "Values": ["running"]        }    ])for reservation in response["Reservations"]:    for instance in reservation["Instances"]:        print(instance["InstanceId"])
```

Interview Explanation:

> I use Boto3 to connect to EC2, filter running instances, and print their instance IDs.

For large accounts, use an EC2 paginator.

### Q34. Write a Python script to identify failed Kubernetes pods.

```
import subprocessimport jsonresult = subprocess.check_output(    ["kubectl", "get", "pods", "-A", "-o", "json"],    text=True)pods = json.loads(result)for pod in pods["items"]:    name = pod["metadata"]["name"]    status = pod["status"]["phase"]    if status in ["Pending", "Failed"]:        print(name, status)
```

Interview Explanation:

> I execute kubectl using Python, convert its JSON output into a dictionary, and identify pods in Pending or Failed states.

Follow-Up: CrashLoopBackOff is normally a container waiting reason, not a pod phase, so I would inspect `containerStatuses` for that condition.

### Q35. Write a Python script to check multiple application URLs.

```
import requestsurls = [    "https://example.com",    "https://www.python.org"]for url in urls:    try:        response = requests.get(url, timeout=5)        if response.status_code == 200:            print(url, "UP")        else:            print(url, "Status:", response.status_code)    except requests.RequestException:        print(url, "DOWN")
```

Interview Explanation:

> I store application URLs in a list and use a for loop to check each endpoint.

DevOps Scenario: Monitoring multiple application endpoints after a deployment.

### Q36. Write a Python script to execute a Linux command and handle failure.

```
import subprocessresult = subprocess.run(    ["systemctl", "is-active", "nginx"],    capture_output=True,    text=True)if result.returncode == 0:    print("Nginx is running")else:    print("Nginx is not running")
```

Interview Explanation:

> I use `subprocess.run()` to execute a Linux command. Then I check the return code to decide whether the operation succeeded.

### Q37. Write a Python script to identify the server with the highest CPU usage.

```
servers = {    "server1": 45,    "server2": 92,    "server3": 70}highest = max(servers, key=servers.get)print("Server:", highest)print("CPU Usage:", servers[highest], "%")
```

Output:

```
Server: server2
CPU Usage: 92 %
```

Interview Explanation:

> I use a dictionary to store server names and CPU usage, then use `max()` to find the server consuming the highest CPU.

## Final Revision: What to Prioritize

For your Senior DevOps Engineer interview, I recommend practising these first:

- Python basics: Reverse string, palindrome, duplicates, second largest, dictionary frequency, list operations, loops, and functions.
- Linux automation: Disk usage, CPU/memory monitoring, log-error counting, and subprocess.
- AWS automation: List EC2 instances, find unattached EBS volumes, upload files to S3, and create RDS snapshots.
- Kubernetes automation: Check unhealthy pods, parse JSON, and verify deployment status.
- API automation: GET requests, health checks, timeout handling, and JSON parsing.

One important interview tip: When the interviewer asks you to write Python code, first explain the logic in two sentences. Then write a simple working solution. After that, mention how you would add error handling, logging, and IAM security for production.

You now have 37 Python coding exercises and 40 additional short interview questions to revise.
