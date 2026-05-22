# Using Terraform in CI/CD Pipelines

Terraform in CI/CD automates infrastructure provisioning by running `terraform plan` on pull requests (for review) and `terraform apply` on merge (to deploy).

---

## Core Workflow

1. **`terraform init`** – Initialize providers/backend
2. **`terraform plan`** – Preview changes (run on PRs)
3. **`terraform apply -auto-approve`** – Apply changes (run on merge to main)

---

## GitHub Actions Example

```yaml name=.github/workflows/terraform.yml
name: Terraform CI/CD

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  terraform:
    runs-on: ubuntu-latest
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

    steps:
      - uses: actions/checkout@v4

      - uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.7.0

      - name: Terraform Init
        run: terraform init

      - name: Terraform Format Check
        run: terraform fmt -check

      - name: Terraform Plan
        run: terraform plan -out=tfplan

      # Apply only on push to main (not on PRs)
      - name: Terraform Apply
        if: github.ref == 'refs/heads/main' && github.event_name == 'push'
        run: terraform apply -auto-approve tfplan
```

---

## Jenkins Pipeline Example

```groovy name=Jenkinsfile
pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Approval') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Apply Terraform changes?', ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        always {
            sh 'rm -f tfplan'
        }
    }
}
```

---

## Simple Terraform Config (for reference)

```hcl name=main.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-cicd-demo-bucket"
}
```

---

## Best Practices

| Practice | Why |
|----------|-----|
| **Use remote backend** (S3, GCS) | Shared state across team/CI |
| **Lock state** (DynamoDB, etc.) | Prevent concurrent modifications |
| **Plan on PR, Apply on merge** | Human review before changes |
| **Store secrets securely** | Use GitHub Secrets / Jenkins Credentials |
| **Pin Terraform version** | Avoid unexpected breaking changes |
| **Run `terraform fmt -check`** | Enforce consistent formatting |

---

## Key Differences

| Feature | GitHub Actions | Jenkins |
|---------|---------------|---------|
| Setup | `hashicorp/setup-terraform` action | Install Terraform on agent |
| Secrets | `${{ secrets.X }}` | `credentials('x')` |
| Approval gate | Branch protection + PR review | `input` step |
| Trigger | `on: push/pull_request` | Webhook / SCM polling |

This pattern ensures infrastructure changes are reviewed (plan) before being applied, just like code reviews for application code.
