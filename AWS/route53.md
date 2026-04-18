# 🌐 End-to-End: Domain → Route 53 → ALB → HTTPS (ACM)

## 📌 Prerequisites

- Domain purchased (GoDaddy / Namecheap / etc.)
- AWS Account
- Application running on EC2 / Target Group
- Application Load Balancer (ALB) created

---

# 🧭 Architecture Flow

User → Domain → Route 53 → ALB (HTTPS) → Target Group → EC2 App

---

# 🪜 Step 1: Create Hosted Zone in Route 53

1. Go to AWS Route 53
2. Click **Hosted Zones**
3. Click **Create Hosted Zone**
4. Enter:
   - Domain Name: yourdomain.com
   - Type: Public Hosted Zone
5. Click Create

👉 AWS creates:
- NS (Name Server)
- SOA record

---

# 🪜 Step 2: Update Nameservers in Domain Provider

1. Copy NS records from Route 53
2. Go to domain registrar (GoDaddy / Namecheap)
3. Replace existing nameservers with AWS nameservers
4. Save changes

⏱️ DNS propagation: few minutes to 24 hrs

---

# 🪜 Step 3: Create Record for ALB

1. Go to Route 53 → Hosted Zone
2. Click **Create Record**

### Root Domain Mapping

- Record Type: A
- Enable: Alias = Yes
- Alias Target: Select your ALB

### Optional (www)

- Name: www
- Type: A (Alias)
- Target: ALB

---

# 🔐 Step 4: Request SSL Certificate (ACM)

1. Go to AWS Certificate Manager (ACM)
2. Click **Request Certificate**
3. Select:
   - Public Certificate
4. Add domain names:
   - yourdomain.com
   - *.yourdomain.com (optional)
5. Choose validation:
   - DNS Validation

---

# 🪜 Step 5: Validate Certificate (DNS)

1. ACM gives CNAME record
2. Go to Route 53
3. Create CNAME record exactly as provided

👉 Wait until status = **Issued**

---

# 🪜 Step 6: Attach Certificate to ALB

1. Go to EC2 → Load Balancers
2. Select your ALB
3. Go to **Listeners**
4. Click **Add Listener**

### Configure HTTPS Listener

- Protocol: HTTPS
- Port: 443
- Certificate: Select ACM cert
- Forward to: Target Group

---

# 🔁 Step 7: Redirect HTTP → HTTPS

1. Edit HTTP (port 80) listener
2. Change action to:

- Type: Redirect
- Protocol: HTTPS
- Port: 443
- Status Code: 301

---

# 🔐 Step 8: Security Group Configuration

Ensure ALB allows:

Inbound Rules:
- HTTP (80)
- HTTPS (443)

---

# ✅ Step 9: Test

Open browser:

https://yourdomain.com

✔️ Should show:
- Secure lock icon 🔒
- Application working

---

# ⚠️ Common Issues

- Certificate in wrong region
- DNS validation not completed
- Nameservers not updated
- Port 443 blocked
- ALB not linked to target group

---

# 🧠 Final Flow Summary

Domain Purchase
   ↓
Route 53 Hosted Zone
   ↓
Update Nameservers
   ↓
Create A Record → ALB
   ↓
Request ACM Certificate
   ↓
DNS Validation
   ↓
Attach to ALB (HTTPS 443)
   ↓
Redirect HTTP → HTTPS
   ↓
Done 🎉

---

# 🚀 Best Practices

- Use wildcard certificates (*.domain.com)
- Use Terraform for automation
- Enable health checks in target group
- Use HTTPS only (force redirect)

---

# 💡 Bonus

ACM Certificates:
- Free
- Auto-renewed
- Easy integration with ALB

---
