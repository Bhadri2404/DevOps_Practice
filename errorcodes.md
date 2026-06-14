````md
# DevOps Interview Handbook - Part 1
# Deep Dive into HTTP Error Codes

This guide is focused on the most commonly asked HTTP status codes in DevOps, SRE, Production Support, Kubernetes, AWS EKS, and Cloud environments.

For every code we will cover:

1. Meaning
2. Where it occurs
3. Application causes
4. Kubernetes causes
5. AWS causes
6. Linux causes
7. Troubleshooting commands
8. Resolution
9. Prevention
10. Interview Answer

---

# 400 BAD REQUEST

## Meaning

The server cannot process the request because the request itself is invalid.

The problem is usually from the client side.

---

## Where Does It Occur?

- REST APIs
- Microservices
- API Gateway
- Nginx
- Load Balancers
- Backend Applications

---

## Application Causes

### Invalid JSON

Expected:

```json
{
  "name":"Veera",
  "age":26
}
```

Received:

```json
{
  "name":"Veera"
}
```

Mandatory field missing.

---

### Wrong Datatype

Expected:

```json
{
  "age":26
}
```

Received:

```json
{
  "age":"twenty six"
}
```

---

### Invalid Query Parameters

```http
GET /employee?id=
```

---

### Missing Request Headers

```http
Content-Type: application/json
```

header missing.

---

## Kubernetes Causes

Usually application generated.

Check:

```bash
kubectl logs pod-name
```

---

## AWS Causes

### API Gateway Validation Failure

Request schema validation fails.

Returns:

```text
400 Bad Request
```

---

## Troubleshooting

### Application Logs

```bash
kubectl logs pod-name
```

or

```bash
tail -100f application.log
```

---

### Verify Request

```bash
curl -v
```

---

## Resolution

- Fix request payload
- Add missing parameters
- Validate frontend request

---

## Prevention

- API validation
- Swagger/OpenAPI
- Frontend validations

---

## Interview Answer

400 indicates invalid request format.
I would first verify payload structure, mandatory parameters, headers, and application validation logs.

====================================================================

# 401 UNAUTHORIZED

## Meaning

Authentication failed.

Server cannot verify who the user is.

---

## Common Causes

### Expired JWT Token

```text
JWT Expired
```

---

### Missing Token

```http
Authorization Header Missing
```

---

### Invalid Credentials

Wrong username/password.

---

### OAuth Failure

Token generation failed.

---

## Kubernetes Causes

### Secret Not Mounted

```bash
kubectl get secrets
```

Application unable to authenticate.

---

## AWS Causes

### Invalid IAM Credentials

```bash
aws sts get-caller-identity
```

fails.

---

### Expired Session Token

STS token expired.

---

## Troubleshooting

### Verify Token

```bash
jwt.io
```

Decode token.

---

### Application Logs

```bash
kubectl logs pod-name
```

---

### Verify Secrets

```bash
kubectl get secret
```

---

## Resolution

- Refresh token
- Fix secret
- Regenerate credentials

---

## Prevention

- Token refresh mechanisms
- Proper secret rotation

---

## Interview Answer

401 means authentication failure.
I would verify JWT token, secrets, OAuth provider, and credential configuration.

====================================================================

# 403 FORBIDDEN

## Meaning

Authentication successful.

Authorization failed.

---

## Difference Between 401 and 403

401:

```text
You are not authenticated.
```

403:

```text
You are authenticated but not allowed.
```

---

## Application Causes

### Missing Role

User role:

```text
Employee
```

Trying to access:

```text
Admin Dashboard
```

---

## Kubernetes Causes

### RBAC Issue

```bash
kubectl auth can-i get pods
```

returns:

```text
no
```

---

## AWS Causes

### IAM Permission Missing

Pod trying to access S3.

Policy denies.

---

### EKS Pod Identity Issue

Pod IAM role missing permissions.

---

## Troubleshooting

### Verify IAM Policy

```bash
aws iam get-role
```

---

### Kubernetes RBAC

```bash
kubectl auth can-i
```

---

## Resolution

Grant permissions.

---

## Prevention

Principle of least privilege with proper role assignment.

---

## Interview Answer

403 indicates authorization issue.
I would verify RBAC roles, IAM policies, and application roles.

====================================================================

# 404 NOT FOUND

## Meaning

Requested resource not found.

---

## Application Causes

Wrong API endpoint.

Example:

```text
/api/user
```

Actual:

```text
/api/v1/user
```

---

## Kubernetes Causes

### Wrong Ingress Path

Ingress:

```yaml
path: /api
```

Request:

```text
/api/v1
```

---

### Service Missing

```bash
kubectl get svc
```

---

### Endpoint Missing

```bash
kubectl get endpoints
```

---

## AWS Causes

### Wrong ALB Rule

Traffic forwarded incorrectly.

---

### Route53 DNS Issue

DNS pointing to wrong target.

---

## Troubleshooting

```bash
kubectl get ingress
kubectl describe ingress
```

```bash
kubectl get svc
```

---

## Resolution

Correct route configuration.

---

## Interview Answer

404 means resource unavailable.
I would verify URL path, ingress rules, service mapping, and endpoints.

====================================================================

# 429 TOO MANY REQUESTS

## Meaning

Rate limit exceeded.

---

## Causes

### Traffic Spike

100 requests/min allowed.

5000 requests/min received.

---

### Bot Traffic

Malicious requests.

---

### Infinite Retry Loop

Application bug.

---

## Kubernetes Causes

Application throttling.

---

## AWS Causes

### API Gateway Throttling

Burst limit exceeded.

---

### WAF Rules

Rate limiting triggered.

---

## Troubleshooting

CloudWatch Metrics.

Check request count.

---

## Resolution

- Increase limits
- Add caching
- Fix retry logic

---

## Prevention

Rate limiting strategy.

---

## Interview Answer

429 indicates request throttling.
I would investigate traffic pattern, retries, and API Gateway limits.

====================================================================

# 500 INTERNAL SERVER ERROR

MOST IMPORTANT FOR INTERVIEWS

---

## Meaning

Application failed internally.

---

## Application Causes

### Null Pointer Exception

Java:

```java
NullPointerException
```

---

### Database Failure

```text
Connection Refused
```

---

### Missing Environment Variable

```text
DB_HOST missing
```

---

### External API Failure

Dependency unavailable.

---

## Kubernetes Causes

### CrashLoopBackOff

Application crashes.

---

### Secret Missing

Environment variable unavailable.

---

### ConfigMap Missing

Application startup failure.

---

## AWS Causes

### RDS Down

Database unavailable.

---

### Secret Manager Failure

Secrets unavailable.

---

## Linux Causes

### Disk Full

```text
No space left on device
```

---

### Memory Exhaustion

OOM.

---

## Troubleshooting

```bash
kubectl logs pod-name
```

```bash
kubectl describe pod
```

```bash
df -h
```

```bash
free -m
```

---

## Resolution

Fix root cause.

---

## Prevention

Monitoring and alerting.

---

## Interview Answer

500 indicates application-side failure.
I would review logs, dependencies, environment variables, and infrastructure health.

====================================================================

# 502 BAD GATEWAY

VERY COMMON IN EKS

---

## Meaning

Proxy received invalid response from backend.

---

## Architecture

User
↓
ALB
↓
Ingress
↓
Service
↓
Pod

---

## Application Causes

Application crashed.

---

### Wrong Listening Port

Application:

```text
9090
```

Service:

```text
8080
```

Mismatch.

---

## Kubernetes Causes

### No Endpoints

```bash
kubectl get endpoints
```

returns:

```text
none
```

---

### Wrong Selector

Service cannot find pod.

---

### Pod Not Ready

Readiness failure.

---

## AWS Causes

### Target Group Unhealthy

ALB cannot reach targets.

---

### Security Group Issue

Port blocked.

---

## Troubleshooting

```bash
kubectl get svc
```

```bash
kubectl get endpoints
```

```bash
kubectl describe ingress
```

---

## Resolution

Fix service mapping.

Restore backend.

---

## Prevention

Readiness probes and monitoring.

---

## Interview Answer

502 means proxy cannot communicate with backend.
I would validate ingress, service, endpoints, target groups, and pod health.

====================================================================

# 503 SERVICE UNAVAILABLE

MOST COMMON KUBERNETES ERROR

---

## Meaning

No healthy backend available.

---

## Causes

### All Pods Down

CrashLoopBackOff.

---

### Readiness Probe Failed

Pod removed from load balancing.

---

### Node Failure

Worker node unavailable.

---

### Database Dependency Failure

Application startup failure.

---

## Troubleshooting

```bash
kubectl get pods
```

```bash
kubectl describe pod
```

```bash
kubectl logs pod
```

---

## Resolution

Restore healthy pods.

---

## Prevention

Multiple replicas.

HPA.

Pod Disruption Budgets.

---

## Interview Answer

503 indicates no healthy backend.
I would check pod health, readiness probes, deployments, and node health.

====================================================================

# 504 GATEWAY TIMEOUT

VERY IMPORTANT

---

## Meaning

Backend took too long to respond.

---

## Causes

### Slow Database Query

Query takes:

90 seconds

ALB timeout:

60 seconds

Returns:

504.

---

### External API Delay

Third-party service latency.

---

### CPU Saturation

Application overloaded.

---

### Memory Pressure

Garbage collection delays.

---

## Kubernetes Causes

### Resource Starvation

CPU limits reached.

---

### Node Pressure

High utilization.

---

## AWS Causes

### ALB Timeout

Default timeout exceeded.

---

### RDS Performance Issues

Slow database.

---

## Troubleshooting

```bash
kubectl top pods
```

```bash
kubectl top nodes
```

```sql
show processlist;
```

---

## Resolution

Optimize queries.

Scale application.

Increase timeout.

---

## Prevention

Performance testing.

Autoscaling.

Monitoring.

---

## Interview Answer

504 indicates backend latency.
I would investigate application performance, database queries, external dependencies, and infrastructure resource usage.
````

For tomorrow's interview, focus especially on **500, 502, 503, and 504**—these are the ones most frequently used in real EKS production troubleshooting discussions.
