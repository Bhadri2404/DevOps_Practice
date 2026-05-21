# Container Image Vulnerability Scanning — Explained

## 1. Trivy (Basic Scan)

```bash
trivy image myapp:latest
```

- Scans your Docker image for **known vulnerabilities** (CVEs) in OS packages and application dependencies.
- Outputs a table of all vulnerabilities found (LOW, MEDIUM, HIGH, CRITICAL).
- Just informational — doesn't block anything.

---

## 2. Trivy in CI/CD Pipeline

```bash
trivy image --severity HIGH,CRITICAL --exit-code 1 myapp:latest
```

| Flag | Purpose |
|------|---------|
| `--severity HIGH,CRITICAL` | Only report HIGH and CRITICAL vulnerabilities (ignore LOW, MEDIUM) |
| `--exit-code 1` | Return exit code `1` if vulnerabilities are found |

**Why `--exit-code 1`?**

In CI/CD (GitHub Actions, Jenkins, GitLab CI), any command that exits with a non-zero code **fails the pipeline**. This means:

```
Vulnerabilities found → exit code 1 → pipeline fails → deployment blocked ❌
No vulnerabilities     → exit code 0 → pipeline passes → deployment proceeds ✅
```

---

## 3. Docker Scout

```bash
docker scout cves myapp:latest
```

- Built into Docker Desktop (no extra install needed).
- Similar to Trivy — scans for CVEs in your image.
- Provides fix recommendations and base image upgrade suggestions.

---

## Comparison

| Tool | Install | Speed | CI/CD Friendly |
|------|---------|-------|----------------|
| **Trivy** | Separate install | Fast | ✅ Very (exit codes, JSON output) |
| **Docker Scout** | Built into Docker | Fast | ✅ Yes |

---

## Example CI/CD Usage (GitHub Actions)

```yaml name=.github/workflows/scan.yml
- name: Scan image for vulnerabilities
  run: |
    trivy image --severity HIGH,CRITICAL --exit-code 1 myapp:latest
```

If any HIGH/CRITICAL CVE exists in your image, the workflow fails and the code won't be deployed to production.
