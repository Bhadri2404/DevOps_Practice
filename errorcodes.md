# DevOps Interview Handbook
## HTTP Errors, Kubernetes, AWS EKS, Linux, Networking, Databases, CI/CD

# Introduction

This handbook is designed for DevOps Engineers with 4–6 years of experience preparing for interviews involving:
- Linux
- Kubernetes
- AWS EKS
- Docker
- Nginx
- Load Balancers
- Databases
- Networking
- CI/CD
- Production Support

---

# HTTP STATUS CODES

## 1xx Informational

### 100 Continue
Meaning: Server received headers and is ready for the body.

Why:
- Large uploads
- Chunked requests

Troubleshooting:
- Verify client request headers
- Check reverse proxy configuration

Resolution:
- Fix request formatting
- Verify proxy settings

---

## 101 Switching Protocols

Meaning:
Protocol upgrade.

Example:
HTTP → WebSocket

Troubleshooting:
- Check upgrade headers
- Verify WebSocket support

Resolution:
- Correct proxy configuration
- Enable protocol support

---

# 2xx Success

## 200 OK

Meaning:
Request successful.

Checks:
- Application logs
- API response
- Database connectivity

Resolution:
No action required.

---

## 201 Created

Meaning:
Resource successfully created.

Why:
- Insert successful
- Object stored

Resolution:
Verify persistence layer.

---

## 202 Accepted

Meaning:
Request queued for later processing.

Examples:
- Kafka
- RabbitMQ
- SQS

Checks:
- Consumer health
- Queue depth

Resolution:
Scale workers.

---

## 204 No Content

Meaning:
Request successful but no body returned.

Common:
DELETE operations.

---

# 3xx Redirects

## 301 Moved Permanently

Why:
- HTTP → HTTPS migration
- URL changes

Checks:
- Nginx
- ALB listener rules

Resolution:
Update redirect configuration.

---

## 302 Found

Temporary redirect.

Checks:
- Application routing
- Maintenance pages

---

## 304 Not Modified

Browser cache still valid.

Benefit:
- Saves bandwidth
- Improves performance

---

# 4xx Client Errors

## 400 Bad Request

Meaning:
Malformed request.

Root Causes:
- Invalid JSON
- Missing field
- Wrong datatype

Linux:
tail -f application.log

Kubernetes:
kubectl logs POD

Resolution:
Fix request payload.

---

## 401 Unauthorized

Meaning:
Authentication failed.

Root Causes:
- Expired token
- Invalid password
- Missing Authorization header

Checks:
- OAuth
- JWT
- Secrets

Resolution:
Refresh token.

---

## 403 Forbidden

Meaning:
Authenticated but not authorized.

Root Causes:
- RBAC issue
- IAM issue

Checks:
kubectl auth can-i

Resolution:
Grant permissions.

---

## 404 Not Found

Meaning:
Resource unavailable.

Root Causes:
- Wrong URL
- Wrong ingress path
- Missing service

Checks:
kubectl get ingress
kubectl get svc

Resolution:
Fix routing.

---

## 405 Method Not Allowed

Meaning:
Wrong HTTP method.

Example:
GET instead of POST

Resolution:
Use correct method.

---

## 408 Request Timeout

Meaning:
Request took too long.

Checks:
- Network latency
- Backend response time

Resolution:
Optimize backend.

---

## 409 Conflict

Meaning:
Data conflict.

Example:
Duplicate email.

Resolution:
Handle duplicates.

---

## 413 Payload Too Large

Meaning:
File exceeds limit.

Checks:
Nginx client_max_body_size

Resolution:
Increase limit.

---

## 415 Unsupported Media Type

Meaning:
Wrong content-type.

Resolution:
Use correct content-type.

---

## 429 Too Many Requests

Meaning:
Rate limit exceeded.

Checks:
- API Gateway
- Nginx limits

Resolution:
Retry, caching, scaling.

---

# 5xx Server Errors

## 500 Internal Server Error

Meaning:
Application failure.

Root Causes:
- Null pointer
- DB failure
- Config issue
- Dependency failure

Linux:
systemctl status app

Kubernetes:
kubectl logs POD

Resolution:
Fix root cause.

---

## 501 Not Implemented

Meaning:
Feature unavailable.

Resolution:
Deploy updated code.

---

## 502 Bad Gateway

Meaning:
Proxy cannot communicate with backend.

Root Causes:
- Wrong port
- No endpoints
- Backend down

Checks:
kubectl get endpoints

Resolution:
Fix service mapping.

---

## 503 Service Unavailable

Meaning:
No healthy backend.

Root Causes:
- CrashLoopBackOff
- Readiness failure
- Node failure

Resolution:
Restore healthy pods.

---

## 504 Gateway Timeout

Meaning:
Backend too slow.

Root Causes:
- Slow query
- External API latency
- CPU bottleneck

Checks:
kubectl top pods

Resolution:
Scale and optimize.

---

# KUBERNETES TROUBLESHOOTING

## CrashLoopBackOff

Meaning:
Container repeatedly crashes.

Root Causes:
- Missing env vars
- Missing secrets
- DB unavailable
- App bug

Commands:
kubectl logs POD --previous
kubectl describe pod POD

Resolution:
Fix startup issue.

---

## ImagePullBackOff

Meaning:
Image cannot be pulled.

Root Causes:
- Wrong tag
- Wrong image
- ECR permission issue

Resolution:
Correct image reference.

---

## ErrImagePull

Meaning:
Image unavailable.

Resolution:
Push image and verify registry.

---

## OOMKilled

Meaning:
Memory exhausted.

Checks:
kubectl describe pod

Resolution:
Increase memory limits.

---

## Pending Pod

Meaning:
Pod unschedulable.

Root Causes:
- No CPU
- No memory
- Taints
- Affinity rules

Resolution:
Add capacity.

---

# AWS EKS TROUBLESHOOTING

## ALB Returns 502

Checks:
- Ingress
- Service
- Endpoints
- Target groups

Resolution:
Fix routing.

---

## ALB Returns 503

Checks:
- Healthy targets
- Pod readiness

Resolution:
Restore healthy pods.

---

## ECR Access Denied

Checks:
- Node role
- IAM permissions

Resolution:
Grant ECR access.

---

# DNS TROUBLESHOOTING

## Unknown Host

Root Causes:
- DNS record missing
- CoreDNS failure

Commands:
nslookup
dig

Resolution:
Fix DNS.

---

# DATABASE TROUBLESHOOTING

## Connection Refused

Meaning:
Host reachable but service unavailable.

Checks:
telnet host port

Resolution:
Start DB service.

---

## Connection Timeout

Meaning:
Host unreachable.

Checks:
- SG
- NACL
- Firewall

Resolution:
Fix network path.

---

# LINUX TROUBLESHOOTING

## Disk Full

Error:
No space left on device

Commands:
df -h
du -sh /*

Resolution:
Cleanup logs.

---

## High CPU

Commands:
top
htop

Root Causes:
- Traffic spike
- Infinite loop

Resolution:
Optimize workload.

---

## High Memory

Commands:
free -m
top

Resolution:
Identify leaks.

---

# NGINX TROUBLESHOOTING

## Nginx Down

Checks:
systemctl status nginx

Resolution:
Restart service.

---

## 502 From Nginx

Checks:
Backend health
Proxy config

Resolution:
Fix upstream.

---

# CI/CD TROUBLESHOOTING

## Jenkins Build Failure

Checks:
- Console logs
- Credentials
- SCM access

Resolution:
Fix build step.

---

## Git Clone Failure

Checks:
- SSH keys
- Tokens
- Network

Resolution:
Update credentials.

---

# TERRAFORM

## State Lock Error

Meaning:
State locked.

Resolution:
Unlock after verification.

---

## Drift

Meaning:
Infrastructure differs from code.

Resolution:
terraform plan
terraform apply

---

# GOLDEN PRODUCTION TROUBLESHOOTING FLOW

1. Verify issue.
2. Check DNS.
3. Check Load Balancer.
4. Check Ingress.
5. Check Service.
6. Check Endpoints.
7. Check Pods.
8. Check Logs.
9. Check Nodes.
10. Check CPU.
11. Check Memory.
12. Check Disk.
13. Check Database.
14. Check External APIs.
15. Check Recent Deployments.
16. Identify Root Cause.
17. Fix Issue.
18. Validate Recovery.
19. Monitor Stability.

End of handbook.
