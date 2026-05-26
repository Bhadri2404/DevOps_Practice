# AWS Interview – Practical DevOps Q&A with Commands (Batch 1: Q1–Q10)

## Q1. Your EC2 website is not loading from the internet. How do you troubleshoot step by step?

### Typical question
“Users can’t open a website hosted on EC2. Walk me through your debugging steps.”

### Answer – step by step checklist

1. **Check EC2 instance health in console**
   - In AWS Console → EC2 → Instances → select instance.
   - Verify:
     - `Instance state` = running.
     - Both `Status checks` (System reachability & Instance reachability) are `2/2 checks passed`.[web:175]
   - Explanation:
     - If status checks are failing, OS or underlying hardware has an issue; fix that first (restart, check system logs).

2. **Check Security Group rules**
   - In instance details → Security → Security groups → Inbound rules.
   - Ensure:
     - Inbound rule allowing `HTTP (80)` and/or `HTTPS (443)` from correct source (0.0.0.0/0 for public website).
   - Explanation:
     - If ports 80/443 not open, traffic from internet cannot reach your web server.

3. **Check Network ACL and Route Table for subnet**
   - VPC → Subnets → select subnet → routing:
     - Check there is a route `0.0.0.0/0` → Internet Gateway (for public subnet).[web:175]
   - NACL:
     - Inbound/outbound allow traffic on 80/443 and ephemeral ports.
   - Explanation:
     - Missing IGW route or restrictive NACL will block traffic even if SG is open.

4. **Check instance has public IP / Elastic IP**
   - In instance details:
     - Confirm `Public IPv4 address` exists or there’s an Elastic IP attached.
   - Explanation:
     - Without a public IP/EIP and proper IGW, internet clients cannot directly access the instance.

5. **Check web server on the instance**
   - SSH into instance:
     ```bash
     sudo systemctl status httpd   # Amazon Linux/CentOS (Apache)
     sudo systemctl status nginx   # if using NGINX
     ```
   - Explanation:
     - Confirm service is `active (running)`.  
     - If stopped, start and check logs in `/var/log/httpd/` or `/var/log/nginx/`.

6. **Check OS firewall on instance**
   - Commands:
     ```bash
     sudo iptables -L -n -v
     # or
     sudo ufw status
     ```
   - Explanation:
     - Ensure OS firewall allows inbound 80/443.
     - If blocking, either open ports or disable firewall (with caution).

7. **Test locally and then from another machine**
   - On instance:
     ```bash
     curl -I http://localhost
     ```
   - From your laptop:
     ```bash
     curl -I http://<public-ip>
     ```
   - Explanation:
     - If it works locally but not externally, issue is network/SG/NACL/route.
     - If it fails locally, issue is app/server config.

---

## Q2. How do you SSH into an EC2 Linux instance and what do you check if SSH fails?

### Typical question
“How do you connect via SSH, and what is your SSH failure troubleshooting flow?”

### Answer – step by step

1. **Standard SSH command**
   - Command:
     ```bash
     ssh -i my-key.pem ec2-user@ec2-xx-yy-zz.ap-south-1.compute.amazonaws.com
     ```
   - Explanation:
     - `-i` points to private key file (chmod 400).  
     - Username depends on AMI (`ec2-user`, `ubuntu`, `centos`).

2. **If SSH fails – first, check SG & NACL**
   - SG inbound rule:
     - Allow `SSH (22)` from your IP or office/VPN CIDR (not from 0.0.0.0/0 ideally).
   - NACL:
     - Allow inbound 22 and ephemeral ports, outbound replies.
   - Explanation:
     - Missing SG/NACL rules are the most common reason for timeouts.

3. **Check instance reachability and route**
   - Verify:
     - Public IP/EIP.  
     - Subnet route has `0.0.0.0/0` → IGW.
   - Explanation:
     - Wrong route or no public IP → no SSH from internet.

4. **If still failing, check OS-level issues**
   - Use Console → EC2 → `Get system log` to inspect boot logs for:
     - Firewall misconfig, SSH daemon crash, out‑of‑memory, etc.[web:181]
   - If you have SSM/Session Manager enabled, you can connect even without SSH and inspect `/var/log/secure`/`auth.log`.

---

## Q3. How do you check if an EC2 instance in a private subnet can reach the internet (via NAT)?

### Typical question
“Private EC2 needs to download packages from internet but fails. How do you check?”

### Answer – step by step

1. **From the EC2, test DNS and HTTP**
   - Commands:
     ```bash
     dig google.com +short
     curl -I https://www.google.com
     ```
   - Explanation:
     - If DNS fails, check VPC DNS settings (enable DNS hostnames/resolution).
     - If DNS works but HTTP fails, route/NAT/Security is wrong.

2. **Check route table for private subnet**
   - In VPC console:
     - For private subnet route table, confirm:
       ```text
       0.0.0.0/0 -> nat-gateway-id
       ```
   - Explanation:
     - All internet-bound traffic must go to NAT Gateway/instance, not IGW directly.

3. **Check NAT Gateway/instance health**
   - NAT Gateway:
     - Must be in public subnet with route `0.0.0.0/0 → IGW`.[web:173]
   - NAT instance:
     - Must have IP forwarding enabled and proper iptables MASQUERADE.

4. **Check Security Group & NACL for NAT and private instance**
   - Ensure:
     - SG on private instance allows outbound.
     - SG on NAT allows outbound to internet.
     - NACLs do not restrict necessary ports.

---

## Q4. How do you list, describe, and start/stop EC2 instances using AWS CLI?

### Typical question
“Show how you’d use AWS CLI to inspect and manage EC2 instances.”

### Answer – step by step with commands

1. **List instances (basic)**
   - Command:
     ```bash
     aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId'
     ```
   - Explanation:
     - Shows all instance IDs in the region.
     - `--query` filters JSON output to just IDs.[web:172]

2. **Describe a specific instance**
   - Command:
     ```bash
     aws ec2 describe-instances --instance-ids i-0123456789abcdef0
     ```
   - Explanation:
     - Returns full JSON: state, IPs, tags, SGs, subnet, etc.

3. **Stop and start an instance**
   - Commands:
     ```bash
     aws ec2 stop-instances --instance-ids i-0123456789abcdef0
     aws ec2 start-instances --instance-ids i-0123456789abcdef0
     ```
   - Explanation:
     - Useful to simulate reboot or move off underlying hardware (for some issues).
     - Be careful: public IP might change if you’re not using an Elastic IP.

---

## Q5. How do you check which IAM role and permissions an EC2 instance has?

### Typical question
“Your app running on EC2 gets ‘AccessDenied’ when calling AWS APIs. How do you debug IAM side?”

### Answer – step by step

1. **In console, check IAM role attached to instance**
   - EC2 → Instances → select instance → under `IAM role`.
   - Explanation:
     - The instance profile/role defines what AWS APIs instance can call.

2. **Describe instance via AWS CLI**
   - Command:
     ```bash
     aws ec2 describe-instances --instance-ids i-0123456789abcdef0 \
       --query 'Reservations.Instances.IamInstanceProfile'
     ```
   - Explanation:
     - Shows instance profile ARN.

3. **In IAM, inspect the role’s policies**
   - IAM → Roles → select role → `Permissions` tab.
   - Explanation:
     - Ensure required actions (e.g., `s3:GetObject`, `dynamodb:PutItem`) are allowed.  
     - If actions missing or restricted by conditions, requests will fail.

4. **On the instance, use AWS CLI to confirm**
   - Command:
     ```bash
     aws sts get-caller-identity
     ```
   - Explanation:
     - Shows which IAM identity the instance is using.
     - If it fails or returns unexpected identity, IAM role/credentials are misconfigured.

---

## Q6. How do you check S3 access from an EC2 instance and debug connectivity vs permissions?

### Typical question
“Instance in VPC must access S3 but fails. How do you differentiate networking vs IAM issues?”

### Answer – step by step

1. **From EC2, run a simple S3 command**
   - Command:
     ```bash
     aws s3 ls
     ```
   - Explanation (from AWS docs):  
     - If network + IAM OK, you get a list of buckets.  
     - If timeout: likely VPC/network configuration issue (no route to S3 endpoint or internet).[web:173]  
     - If `AccessDenied`: VPC is OK but IAM permissions or bucket policy are wrong.

2. **Check VPC Endpoints or routes**
   - If using S3 Gateway Endpoint:
     - Confirm Route Table has `pl-xxxx` prefix list route pointing to endpoint for S3.
   - If using internet:
     - Ensure NAT/IGW/route allow outbound to S3.

3. **Check IAM and bucket policy**
   - IAM role:
     - Has `s3:ListAllMyBuckets` or appropriate `s3:*` permissions.
   - Bucket policy:
     - Allows access from that role or VPC endpoint.

---

## Q7. How do you verify VPC/subnet configuration for an EC2 instance (CIDRs, routes, SG, NACL)?

### Typical question
“You suspect VPC misconfiguration. How do you inspect the networking around an EC2?”

### Answer – step by step

1. **From instance details, note:**
   - VPC ID, Subnet ID, private IP, public IP, Security Groups.
   - Explanation:
     - These identify where instance lives logically.

2. **Check subnet’s route table**
   - VPC console → Subnets → select subnet → Route Table.
   - Look for:
     - Local route for VPC CIDR.
     - 0.0.0.0/0 to IGW (public) or NAT (private).

3. **Check NACL for that subnet**
   - Ensure:
     - Inbound/outbound allow necessary traffic (or use default “allow all” until you’re confident).

4. **Check Security Groups**
   - See inbound/outbound rules:
     - Often allow from other SGs or specific CIDRs.
   - Make sure:
     - For internal communication, SGs reference each other or correct ranges.

---

## Q8. How do you test connectivity between two EC2 instances in the same VPC?

### Typical question
“Instance A must talk to Instance B on port 8080 over private IP, but it fails. What do you do?”

### Answer – step by step

1. **From Instance A, ping or curl Instance B’s private IP**
   - Commands:
     ```bash
     ping -c 3 10.0.2.10
     nc -vz 10.0.2.10 8080
     ```
   - Explanation:
     - If ping succeeds, L3 works; if `nc` fails, port/SG/NACL issue.
     - If ping fails, route or NACL or SG might be blocking.

2. **Verify SG rules**
   - SG on Instance B:
     - Inbound rule: allow `tcp 8080` from A’s SG or subnet CIDR.
   - SG on Instance A:
     - Outbound rule: allow all or at least to B’s IP/port.

3. **Check NACLs for both subnets**
   - Inbound:
     - Allow traffic from other subnet’s CIDR on port 8080.
   - Outbound:
     - Allow ephemeral ports for replies.

4. **Use VPC Reachability Analyzer (optional)**
   - In VPC console:
     - Define source (A’s ENI) and destination (B’s ENI/port).
   - Explanation:
     - Tool runs a path analysis to show where traffic is blocked (SG/NACL/route).[web:177]

---

## Q9. How do you check CloudWatch metrics for an EC2 instance to diagnose performance issues?

### Typical question
“EC2 is slow. How do you use CloudWatch to see if it’s CPU, network, or disk?”

### Answer – step by step

1. **Open EC2 → select instance → Monitoring tab**
   - Look at:
     - `CPUUtilization`
     - `NetworkIn` / `NetworkOut`
     - `DiskReadBytes` / `DiskWriteBytes`
   - Explanation:
     - High CPU → compute bottleneck.
     - High network → possible saturation or data transfer issues.
     - High disk I/O → disk limited.

2. **Open in CloudWatch console**
   - Click “View in metrics” to open full CloudWatch graphs.
   - Explanation:
     - Adjust time range to see spikes vs baseline.
     - Combine metrics in a dashboard for comparison.

3. **Tie metrics to application logs and deployment events**
   - Explanation:
     - If CPU spikes correlate with deploy or traffic spike, problem may be code or load, not infrastructure misconfig.

---

## Q10. How do you summarize your EC2 troubleshooting flow in an interview (high‑level)?

### Typical question
“Summarize how you approach EC2 issues: instance down, unreachable, or slow.”

### Answer – structured talking points

1. **Reachability & health**
   - Check:
     - Instance state + `2/2` health checks.
     - System logs from console if boot issues.

2. **Networking path**
   - Verify:
     - Public/private IP, routes (IGW/NAT), NACLs, Security Groups.
     - Test from client with `ping`, `nc`, `curl`.

3. **OS & service**
   - SSH/SSM in:
     - Check `systemctl status` for target services.
     - Check OS firewall, disk/full, CPU/memory.

4. **IAM & AWS integration**
   - If it calls AWS APIs:
     - Confirm instance role, permissions, and relevant CloudWatch/logging.

5. **CloudWatch metrics**
   - CPU, network, disk patterns over time.
   - Tie spikes to deployments or events.


# AWS Interview – Practical DevOps Q&A (Batch 2: Q11–Q20)

## Q11. Your RDS (PostgreSQL/MySQL) is in a private subnet. How does it reach the internet for patching/backups?

### Typical question
“Explain how an RDS instance in private subnets accesses AWS services (S3, KMS) and the internet, and what you actually configure.”

### Answer – step by step

1. **RDS is in private subnets – no direct public IP**
   - RDS DB subnet group uses **private subnets** only (no IGW route).
   - The DB has **no public IP** and is not directly reachable from the internet.
   - Explanation:
     - This is a security best practice; only app tier or admin via VPN/bastion should reach DB.

2. **RDS talks to AWS services over AWS internal network**
   - For backups, snapshots, and storage, RDS mainly talks to:
     - S3, KMS, control plane endpoints.
   - It uses **AWS internal network**, not public internet.
   - Explanation:
     - You do not manage NAT for RDS core functions; AWS handles internal connectivity.

3. **If RDS must reach external endpoints (rare)**
   - For very specific use‑cases you may:
     - Use **NAT Gateway** in a public subnet + route from private subnet.
     - Or configure **VPC endpoints** for AWS services (S3, KMS, Secrets Manager).
   - Explanation:
     - For most standard RDS usage, you don’t open direct internet; you provide VPC internal access and endpoints.

---

## Q12. Your app is in a private subnet. How does it reach the internet for package updates (apt/yum/pip)?

### Typical question
“App servers in private subnets need software updates. How do they safely access internet?”

### Answer – step by step

1. **Private subnet routing via NAT Gateway**
   - For each private subnet route table:
     ```text
     0.0.0.0/0 -> nat-gateway-id
     ```
   - NAT Gateway is in a **public subnet** with route:
     ```text
     0.0.0.0/0 -> internet-gateway-id
     ```
   - Explanation:
     - Private instances send outbound traffic to NAT.  
     - NAT forwards to internet and maps private IP to public IP.

2. **Security Groups and NACLs**
   - SG on app instances:
     - Allow outbound traffic (default “allow all” is common).
   - NACLs:
     - Allow outbound HTTP/HTTPS and return traffic.
   - Explanation:
     - Only outbound is needed; inbound stays blocked from internet side.

3. **From app instance, test updates**
   - Commands:
     ```bash
     ping -c 3 google.com
     curl -I https://www.google.com
     sudo apt update    # or yum update check
     ```
   - Explanation:
     - If these work, NAT + routes are correct.  
     - If they fail, check NAT route, NAT health, and NACL.

---

## Q13. How do you connect to an RDS instance in a private subnet for administration (psql/mysql)?

### Typical question
“RDS has no public endpoint. As a DBA/DevOps, how do you connect to it safely?”

### Answer – step by step

1. **Use a bastion/jump host or VPN inside the VPC**
   - Options:
     - SSH to a **bastion EC2** in a public subnet, then connect to RDS using its private endpoint.
     - Connect via **Site‑to‑Site VPN** or **AWS Client VPN** from on‑prem/laptop into the VPC.
   - Explanation:
     - You must be inside the VPC (or peered VPC) to reach private RDS endpoint.

2. **Ensure Security Group rules allow access**
   - RDS SG inbound:
     - Allow `tcp 5432` (Postgres) or `3306` (MySQL) from:
       - Bastion’s SG, or
       - On‑prem CIDR via VPN.
   - Explanation:
     - Never allow `0.0.0.0/0` on RDS, even if private; always limit by SG/VPN CIDR.

3. **Connect from bastion or VPN client**
   - From bastion EC2:
     ```bash
     psql "host=mydb.abcdefghijk.us-east-1.rds.amazonaws.com port=5432 dbname=mydb user=myuser password=..."
     # or
     mysql -h mydb.abcdefghijk.us-east-1.rds.amazonaws.com -P 3306 -u myuser -p
     ```
   - Explanation:
     - Use RDS endpoint (DNS resolves to private IP).
     - Ensure local firewall on bastion allows the outgoing connection.

4. **Optional: use Session Manager + port forwarding**
   - Use SSM to connect to EC2 in private subnet, then local port forward through it to RDS.

---

## Q14. How do you patch/upgrade RDS (minor version updates) in production?

### Typical question
“How do you handle RDS engine version updates safely (minor upgrades)?”

### Answer – step by step

1. **Check current engine version and target version**
   - In RDS console → select DB instance → see `Engine version`.
   - Explanation:
     - Understand whether upgrade is minor (e.g., 13.7 → 13.10) or major (12 → 13).

2. **Plan maintenance window and automatic minor version upgrades**
   - DB instance setting:
     - Define **Preferred maintenance window** (off‑peak time).
     - Optionally enable **Auto minor version upgrade**.
   - Explanation:
     - AWS will apply upgrades during window.
     - For critical systems, prefer **manual triggered upgrade** during controlled window.

3. **Take manual snapshot before upgrade**
   - In console or CLI:
     ```bash
     aws rds create-db-snapshot --db-instance-identifier mydb --db-snapshot-identifier mydb-pre-upgrade
     ```
   - Explanation:
     - Gives rollback option if something goes wrong.

4. **Apply upgrade**
   - Console: Modify DB instance → select new engine version → Apply during next maintenance window or immediately.
   - Explanation:
     - RDS will perform upgrade; there will be downtime (seconds to minutes).

5. **Post‑upgrade validation**
   - After status is `available`:
     - Run smoke tests from app/bastion.
     - Check CloudWatch metrics (connections, errors).
     - Check app logs for DB-related errors.

---

## Q15. How do you patch/upgrade an app in private subnet with minimal downtime?

### Typical question
“Your EC2‑based app is in private subnets behind an ALB. How do you roll out patches safely?”

### Answer – step by step

1. **Use Auto Scaling Group (ASG) or multiple instances**
   - Ensure at least **2 instances** behind ALB.
   - Explanation:
     - Allows rolling updates without full outage.

2. **Patch one instance at a time**
   - Mark instance `standby` or deregister from target group:
     - In EC2 → Target Groups → deregister instance.
   - On that instance:
     ```bash
     sudo apt update && sudo apt upgrade -y   # or yum
     sudo systemctl restart myapp
     ```
   - Explanation:
     - Traffic is drained off; patching does not affect live traffic.

3. **Re‑add instance and repeat**
   - Once healthy:
     - Register it back in target group.
     - Wait for ALB health checks to mark it healthy.
   - Repeat for next instance until all patched.

---

## Q16. How do you troubleshoot “Application in private subnet can’t connect to RDS in private subnet”?

### Typical question
“App EC2 and RDS are both private; connection fails. What’s your checklist?”

### Answer – step by step

1. **Check RDS endpoint and port in app config**
   - Verify:
     - Correct endpoint (`mydb.abc123...rds.amazonaws.com`).
     - Correct port (5432/3306/etc).

2. **Test connection from EC2 directly**
   - SSH/SSM into app instance:
     ```bash
     nc -vz mydb.abc123.rds.amazonaws.com 5432
     ```
   - Explanation:
     - If `nc` fails → network issue (SG/NACL/routing).
     - If `nc` works but app fails → app config or credentials.

3. **Check Security Groups**
   - RDS SG inbound:
     - Must allow DB port from **app SG**.
   - App SG outbound:
     - Should allow outbound to DB port (often outbound “all”).
   - Explanation:
     - Common mistake: RDS inbound from instance IP instead of app SG, then scaling breaks.

4. **Check NACLs**
   - NACL for subnets of app and RDS must allow:
     - Inbound/outbound for DB port and ephemeral ports.

---

## Q17. How do you verify that RDS backups and snapshots are configured correctly?

### Typical question
“How do you check automated backups, retention, and manual snapshots for RDS?”

### Answer – step by step

1. **Check automated backup retention**
   - RDS console → DB instance → `Maintenance & backups`.
   - Verify:
     - `Backup retention period` > 0 (e.g., 7 days).
   - Explanation:
     - If 0, automated backups are disabled (no point‑in‑time restore).

2. **Check recent backups & snapshots**
   - RDS → `Snapshots`:
     - See list of manual + automatic snapshots.
   - Explanation:
     - Confirm latest snapshots exist and are recent.

3. **Test snapshot restore in non‑prod**
   - Restore a snapshot to a new test DB:
     - Validate data, connectivity.
   - Explanation:
     - Proves backup & restore process works, not just that backups exist.

---

## Q18. How does an application in one VPC talk to RDS in another VPC (no public exposure)?

### Typical question
“You have app VPC and shared DB VPC. How do you connect app to RDS privately?”

### Answer – step by step

1. **Use VPC Peering or Transit Gateway**
   - Create VPC Peering (or attach both VPCs to a Transit Gateway).
   - Update route tables:
     - VPC A’s route to VPC B’s CIDR via peering/TGW.  
     - VPC B’s route to VPC A’s CIDR similarly.

2. **Ensure non‑overlapping CIDR blocks**
   - Explanation:
     - VPC CIDRs must not overlap for peering/TGW to work correctly.

3. **Security Groups**
   - RDS SG inbound:
     - Allow DB port from app’s VPC CIDR or app SG via VPC peer.
   - Explanation:
     - Even with peering, SGs still enforce traffic allow/deny.

4. **Test from app EC2**
   - Command:
     ```bash
     nc -vz mydb.sharedvpc.rds.amazonaws.com 5432
     ```
   - Explanation:
     - If connection works, peering + SG + route are OK.

---

## Q19. How do you attach and expand EBS volume for an EC2 instance (e.g., to fix disk full)?

### Typical question
“Root disk is small. How do you resize EBS and filesystem safely?”

### Answer – step by step

1. **Modify EBS volume size**
   - EC2 console → Volumes → select volume → `Modify volume`.
   - Increase size (e.g., from 20 GiB → 50 GiB).
   - Explanation:
     - Volume modification is online, but OS still sees old size until you rescan and resize the filesystem.

2. **On the EC2 instance, confirm new size at block level**
   - Commands:
     ```bash
     lsblk
     sudo file -s /dev/xvda1   # or correct device
     ```
   - Explanation:
     - `lsblk` shows block devices and partition sizes.
     - You should see larger size after a short time.

3. **Resize filesystem**
   - For ext4 root volume:
     ```bash
     sudo resize2fs /dev/xvda1
     ```
   - For XFS:
     ```bash
     sudo xfs_growfs /
     ```
   - Explanation:
     - Expands filesystem to consume new space from volume.

4. **Verify with df**
   - Command:
     ```bash
     df -h
     ```
   - Explanation:
     - Confirm that the root filesystem now shows increased size.

---

## Q20. How do you describe your typical AWS “app in private subnet + RDS + internet access” architecture in an interview?

### Typical question
“Describe a secure 3‑tier architecture for a web app on AWS.”

### Answer – structured talking points

1. **Networking & subnets**
   - Public subnets:
     - ALB / NAT Gateways.
   - Private subnets:
     - App EC2/ECS/EKS workers, RDS.
   - Routes:
     - Public subnets → IGW.
     - Private app subnets → NAT GW for outbound internet.
     - Private DB subnets → no direct IGW route.

2. **Connectivity**
   - Clients → ALB (public).
   - ALB → app instances via private IPs.
   - App → RDS via RDS private endpoint (Security Group‑based).
   - App → external APIs via NAT Gateway.
   - Admin/DBA → RDS via VPN/bastion in public subnet.

3. **Security**
   - SGs:
     - ALB SG allowing 80/443 from internet; ALB SG allowed into app SG on app port.
     - App SG allowed into RDS SG on DB port.
   - NACLs:
     - Restrictive, but often left near default until rules are stable.
   - IAM:
     - Instance roles for S3/logs, no hardcoded credentials.

4. **Operations**
   - CloudWatch for metrics and logs (EC2, RDS, ALB).
   - Automated RDS backups + scheduled maintenance.
   - Rolling updates for app in private subnets via ASG and ALB.


# AWS Interview – Practical DevOps Q&A (Batch 3: Q21–Q30)

## Q21. Your app is behind an Application Load Balancer (ALB) and returns 502/504. How do you debug it?

### Typical question
“Users hit the ALB DNS name and see 502 Bad Gateway or 504 Gateway Timeout. What are your steps?”

### Answer – step by step

1. **Check ALB target health**
   - Console → EC2 → Target Groups → select target group → `Targets` tab.
   - Verify:
     - Targets (EC2/ECS/IP) are `healthy`.
   - Explanation:
     - If all targets are `unhealthy`, ALB will return 5xx even if instances seem up.

2. **Check target health checks**
   - In Target Group:
     - Health check path (e.g., `/health`), port, and protocol.
   - Explanation:
     - If health endpoint returns non‑2xx or times out, targets become `unhealthy`.
     - Ensure app actually exposes the configured health path.

3. **Test target directly**
   - SSH into instance or use SSM, then:
     ```bash
     curl -v http://localhost:8080/health
     ```
   - Explanation:
     - If this fails locally → app problem.  
     - If local works but ALB health fails → SG/NACL or wrong health check port/path.

4. **Check SGs**
   - ALB SG:
     - Inbound 80/443 from internet; outbound to app port.
   - App SG:
     - Inbound from ALB SG on app port (e.g., 8080).
   - Explanation:
     - If app SG does not allow inbound from ALB SG, health checks and user traffic fail.

---

## Q22. How do you verify ALB listens on the right ports and protocols?

### Typical question
“How do you confirm ALB is configured to receive HTTP/HTTPS correctly?”

### Answer – step by step

1. **Check ALB listeners**
   - EC2 console → Load Balancers → select ALB → `Listeners` tab.
   - Verify listeners like:
     - `HTTP 80 → redirect to HTTPS 443`
     - `HTTPS 443 → forward to target group`
   - Explanation:
     - Ensure HTTPS listener has proper SSL cert and forwards to the right target group.

2. **Test from CLI**
   - Commands:
     ```bash
     curl -I http://alb-dns-name
     curl -I https://alb-dns-name
     ```
   - Explanation:
     - Check for redirects, SSL handshake success, and final HTTP codes.

3. **Check security groups**
   - ALB SG inbound:
     - Allow 80/443 from 0.0.0.0/0 (for internet site).
   - Explanation:
     - If ports are closed, ALB will not receive traffic at all.

---

## Q23. How do you use Route 53 to route traffic to an ALB? How do you debug DNS issues?

### Typical question
“You have `app.example.com` pointing to an ALB. Users say DNS is wrong or not resolving. Steps?”

### Answer – step by step

1. **Check Route 53 record**
   - Route 53 → Hosted zones → `example.com` → find `app.example.com`.
   - Confirm:
     - Type: `A` (Alias) or `CNAME` pointing to ALB DNS name.
   - Explanation:
     - Alias is recommended for ALB (no extra cost, integrates nicely).

2. **Test DNS from outside**
   - Command:
     ```bash
     dig app.example.com +short
     ```
   - Explanation:
     - Output should show ALB IPs (if Alias) or CNAME chain to ALB.
     - If it doesn’t resolve or points elsewhere, fix record.

3. **Check DNS TTL and propagation**
   - Record TTL (e.g., 60 seconds).
   - Explanation:
     - If you recently changed target, clients might still cache old IP.
     - Use low TTLs when doing cutovers.

---

## Q24. How do you design blue/green deployment with ALB and Auto Scaling Groups?

### Typical question
“How would you do a safe blue/green release for EC2‑based app behind ALB?”

### Answer – step by step

1. **Create two independent target groups / ASGs**
   - Blue environment:
     - ASG A → Target Group A.
   - Green environment:
     - ASG B → Target Group B.
   - Explanation:
     - Both sets can run in parallel.

2. **ALB listener forwards to one target group at a time**
   - Listener 443:
     - Forward either to Target Group A (blue) or B (green).
   - Explanation:
     - ALB controls which environment receives production traffic.

3. **Deploy new version to green**
   - Launch new ASG B with updated AMI or user data.
   - Wait until all instances are healthy behind Target Group B.

4. **Switch traffic**
   - Modify ALB listener action:
     - From forward → Target Group A to Target Group B.
   - Explanation:
     - Traffic flips almost instantly; blue remains as fallback.

5. **Rollback plan**
   - If issues observed:
     - Switch ALB listener back to Target Group A.
     - Debug green while blue continues serving traffic.

---

## Q25. How do you check NLB (Network Load Balancer) target health and connectivity?

### Typical question
“For TCP load (like gRPC, custom protocols), how do you debug NLB issues?”

### Answer – step by step

1. **Check NLB target group health**
   - EC2 → Target Groups → select NLB target group → `Targets`.
   - Explanation:
     - Health check is often TCP or HTTP; if failing, NLB will not forward.

2. **Test directly from client to target**
   - Command:
     ```bash
     nc -vz target-private-ip 50051
     ```
   - Explanation:
     - If direct connects but NLB fails, check SGs for NLB and targets.

3. **Check SGs and NACLs (if used with NLB)**
   - Target SG:
     - Allow inbound from NLB’s IP range or SG on appropriate port.
   - NACLs:
     - Allow inbound/outbound for NLB traffic.

---

## Q26. How do you troubleshoot “ALB reports targets as unhealthy” even though app is running?

### Typical question
“Targets show `unhealthy` in Target Group, but you can curl the app locally. Why?”

### Answer – step by step

1. **Check health check path/port**
   - In Target Group:
     - Path (e.g., `/health`), port, protocol.
   - Explanation:
     - If health check hits wrong path or port, it will fail even if app works on `/`.

2. **Test health check from instance perspective**
   - On instance:
     ```bash
     curl -v http://localhost:8080/health
     ```
   - Explanation:
     - If local `/health` returns non‑2xx or is slow, ALB health check fails.

3. **Check SG from ALB to instance**
   - App SG must allow inbound from ALB SG on health check port.
   - Explanation:
     - If SG blocks health check port, ALB marks target unhealthy.

4. **Look into logs**
   - App logs:
     - Are health check requests failing due to authentication or rate‑limiting?
   - Explanation:
     - Some frameworks require whitelisting `/health` or skipping auth.

---

## Q27. How do you configure and debug CloudWatch alarms for EC2/ALB metrics?

### Typical question
“How do you set an alarm for high CPU or high 5xx on ALB and verify it works?”

### Answer – step by step

1. **Create CloudWatch alarm on EC2 metric**
   - Metric:
     - `EC2 → Per-Instance Metrics → CPUUtilization`.
   - Alarm:
     - Threshold, e.g., `> 80%` for `5 minutes`.
   - Explanation:
     - Alarm goes to `ALARM` state when condition met.

2. **Create CloudWatch alarm on ALB 5xx**
   - Metric:
     - `AWS/ApplicationELB → LoadBalancer → HTTPCode_ELB_5XX_Count` or `HTTPCode_Target_5XX_Count`.
   - Explanation:
     - Choose the relevant load balancer.

3. **Test alarm**
   - Temporarily lower threshold.
   - Trigger condition (e.g., CPU with stress test or manual 5xx).
   - Explanation:
     - Check alarm transitions from `OK` → `ALARM` and notifications are received.

---

## Q28. How do you troubleshoot “Route 53 health check is failing” for an endpoint?

### Typical question
“Route 53 health checks say endpoint is unhealthy. What do you check?”

### Answer – step by step

1. **Check health check configuration**
   - Protocol (HTTP/HTTPS/TCP), port, and path (`/health`).
   - Explanation:
     - Ensure it matches the actual endpoint.

2. **Simulate from outside using curl**
   - From a machine outside VPC:
     ```bash
     curl -v http://public-endpoint/health
     ```
   - Explanation:
     - If this fails, issue is not specific to Route 53; endpoint itself is unhealthy.

3. **Check security groups/firewalls**
   - Ensure IP ranges of health checkers (AWS provided list) are allowed to access the endpoint.
   - Explanation:
     - If health checker IPs are blocked, checks always fail.

---

## Q29. How do you debug “DNS name for ALB resolves but curl fails with timeout”?

### Typical question
“`dig app.example.com` works and shows ALB IPs, but `curl` times out. Steps?”

### Answer – step by step

1. **Confirm DNS resolution**
   - Command:
     ```bash
     dig app.example.com +short
     ```
   - Explanation:
     - Confirms DNS points to ALB.

2. **Test connectivity to ALB ports**
   - Commands:
     ```bash
     nc -vz app.example.com 80
     nc -vz app.example.com 443
     ```
   - Explanation:
     - If TCP fails, route/SG/NACL in front of ALB could be wrong.

3. **Check ALB SG inbound rules**
   - Ensure:
     - Inbound 80/443 from your IP (for test) or 0.0.0.0/0 for public website.

4. **Check ALB → target connectivity**
   - If ALB reachable but HTTP times out, check target group health and SG between ALB and targets.

---

## Q30. In an interview, how would you narrate a real ALB/Route53 incident you solved?

### Typical question
“Describe a real incident involving ALB/Route53 and how you solved it.”

### Answer – structure you can reuse

1. **Context**
   - “We had a microservice behind an ALB, DNS via Route 53, hosting internal/external traffic.”

2. **Symptom**
   - “Users reported 504 timeouts after a new deployment. `curl` from internet timed out.”

3. **Investigation steps**
   - Checked ALB target group:
     - Targets were `unhealthy`.
   - Tested health endpoint directly on instance:
     ```bash
     curl -v http://localhost:8080/health
     ```
     - Got 200 OK.
   - Checked Target Group configuration:
     - Health check path was `/` instead of `/health`.
   - After fix:
     - Health checks started passing; ALB returned 200 to clients.

4. **Root cause & prevention**
   - Misconfigured health check path in TF/CloudFormation.
   - Added:
     - Review checklist for ALB health checks in each deployment.
     - Integration test to verify ALB health before DNS cutover.

# AWS Interview – Practical DevOps Q&A (Batch 4: Q31–Q40)

## Q31. Your app gets “AccessDenied” when reading from S3. How do you debug it?

### Typical question
“An EC2/EKS app tries `s3:GetObject` and gets `AccessDenied`. What’s your step‑by‑step approach?”

### Answer – step by step

1. **Check which IAM identity the app is using**
   - For EC2:
     ```bash
     aws sts get-caller-identity
     ```
   - Explanation:
     - Shows the IAM role (via instance profile) currently used.
     - Confirm it matches the role you expect.

2. **Inspect IAM role policies**
   - In IAM console → Roles → select role → `Permissions` tab.
   - Look for:
     - Policy with `Action: s3:GetObject` and appropriate `Resource` for bucket/keys.
   - Explanation:
     - If role doesn’t have `s3:GetObject` on that bucket/key, AccessDenied is expected.

3. **Check S3 bucket policy**
   - S3 console → bucket → Permissions → Bucket policy.
   - Explanation:
     - Bucket policy can override or block access, even if IAM role allows it.
     - Ensure there is no explicit `Deny` for that principal or source VPC/account.

4. **Test from the instance directly**
   - Commands:
     ```bash
     aws s3 ls s3://my-bucket
     aws s3 cp s3://my-bucket/test.txt /tmp/
     ```
   - Explanation:
     - If this fails, problem is IAM or bucket policy, not app code.

---

## Q32. Your S3 bucket must be private but serve content via CloudFront. How do you secure that?

### Typical question
“How do you prevent direct public access to S3 but allow access through CloudFront CDN?”

### Answer – step by step

1. **Block public access on S3**
   - In S3 bucket → Permissions → Block public access:
     - Enable block public ACLs and policies.
   - Explanation:
     - Ensures no direct public S3 URLs.

2. **Use Origin Access Control (OAC) or Origin Access Identity (OAI) with CloudFront**
   - Configure CloudFront distribution:
     - Set S3 bucket as origin.
     - Attach OAC/OAI that has permission to read from bucket.[web:174]
   - Explanation:
     - Only CloudFront can access S3; users only hit CloudFront URL.

3. **Bucket policy grants access only to CloudFront**
   - Policy example (conceptual):
     - Allow `s3:GetObject` for principal = CloudFront OAC/OAI.
   - Explanation:
     - Direct S3 access from internet is blocked; CloudFront still works.

---

## Q33. How do you enable versioning and lifecycle management on an S3 bucket?

### Typical question
“How do you keep old versions and automatically expire/archive data?”

### Answer – step by step

1. **Enable versioning**
   - S3 console → bucket → Properties → Bucket Versioning → Enable.
   - Explanation:
     - Every overwrite/create keeps previous versions; accidental deletes can be recovered.

2. **Configure lifecycle rules**
   - S3 → bucket → Management → Lifecycle rules:
     - Example:
       - After 30 days → move to S3 Standard‑IA.
       - After 90 days → move to Glacier.
       - After 365 days → expire objects.
   - Explanation:
     - Automates cost optimization and retention.

3. **Verify using `aws s3api`**
   - Commands:
     ```bash
     aws s3api get-bucket-versioning --bucket my-bucket
     aws s3api get-bucket-lifecycle-configuration --bucket my-bucket
     ```
   - Explanation:
     - Confirm that settings are active as expected.

---

## Q34. How do you restrict S3 bucket access to only a specific VPC (e.g., from private subnets/EKS)?

### Typical question
“How do you ensure S3 is accessible only from your VPC, not from anywhere on the internet?”

### Answer – step by step

1. **Create a VPC Gateway Endpoint for S3**
   - VPC console → Endpoints → Create endpoint:
     - Service: `com.amazonaws.<region>.s3`
     - Type: Gateway
     - Attach to desired route tables.
   - Explanation:
     - Traffic to S3 from those subnets goes via the endpoint, not internet.[web:173]

2. **Add bucket policy restricting to that VPC (or endpoint)**
   - In bucket policy:
     - Condition on `aws:SourceVpce` (Endpoint ID) or `aws:SourceVpc`.
   - Explanation:
     - Deny any access not coming via that endpoint/VPC.

3. **Test from EC2 inside and outside the VPC**
   - Inside VPC with endpoint:
     ```bash
     aws s3 ls s3://my-bucket
     ```
   - From outside/other VPC:
     - Expect AccessDenied or no route.

---

## Q35. How do you debug S3 “RequestTimeTooSkewed” errors?

### Typical question
“Your app talking to S3 gets `RequestTimeTooSkewed`. What does it mean and how do you fix it?”

### Answer – step by step

1. **Understand the error**
   - It means:
     - The system time on client (EC2/container) is too far from AWS service time (usually > 5 minutes difference).
   - Explanation:
     - AWS signs requests based on timestamp; large skew invalidates signatures.

2. **Check system time on client**
   - Command:
     ```bash
     date
     ```
   - Explanation:
     - If time is off significantly, fix NTP.

3. **Check NTP synchronization**
   - Commands:
     ```bash
     timedatectl
     # or on some systems:
     ntpq -p
     ```
   - Explanation:
     - Ensure NTP is enabled and synchronized.
     - After fixing, S3 requests should succeed again.

---

## Q36. How do you upload large files to S3 reliably and efficiently?

### Typical question
“How do you handle large file uploads (e.g., >100 MB or GB) to S3?”

### Answer – step by step

1. **Use multipart upload**
   - AWS CLI:
     ```bash
     aws s3 cp largefile.bin s3://my-bucket/ --storage-class STANDARD
     ```
   - Explanation:
     - CLI uses multipart upload automatically for large files (by default threshold).
     - Improves reliability; failed parts can be retried independently.[web:174]

2. **Use `aws s3api` for custom multipart upload (advanced)**
   - Steps:
     - `create-multipart-upload`
     - `upload-part` for each chunk
     - `complete-multipart-upload`
   - Explanation:
     - Gives fine control over part size, concurrency.

3. **Interview angle**
   - Mention:
     - Multipart is essential for large file uploads over unstable networks.
     - Also important for parallelization and throughput.

---

## Q37. How do you implement server‑side encryption for S3 objects and verify it?

### Typical question
“How do you ensure everything stored in S3 is encrypted at rest and how do you verify it?”

### Answer – step by step

1. **Enable default encryption on the bucket**
   - S3 console → bucket → Properties → Default encryption:
     - SSE‑S3 (AES‑256) or SSE‑KMS with specific CMK.
   - Explanation:
     - New objects are encrypted by default when uploaded.

2. **Verify using object metadata**
   - Command:
     ```bash
     aws s3api head-object --bucket my-bucket --key path/to/object
     ```
   - Explanation:
     - Response shows:
       - `ServerSideEncryption: AES256` or `aws:kms`.
       - For KMS, `SSEKMSKeyId` shows CMK used.

3. **Combine with bucket policy**
   - Enforce encryption:
     - Bucket policy can **deny** `PutObject` when `x-amz-server-side-encryption` is missing.
   - Explanation:
     - Ensures no unencrypted objects are stored even by mistake.

---

## Q38. How do you allow cross‑account access to an S3 bucket (e.g., from another AWS account)?

### Typical question
“Another AWS account must read/write to your S3 bucket. How do you set that up securely?”

### Answer – step by step

1. **Identify the external account and role**
   - External account creates an IAM role that will access your bucket.
   - You get the **role ARN** or account ID.

2. **Update your S3 bucket policy**
   - Add a statement:
     - `Principal` = that role ARN or account ID.
     - `Action` = needed S3 actions (`GetObject`, `PutObject`).
     - `Resource` = `arn:aws:s3:::my-bucket/*`.
   - Explanation:
     - This grants that external principal access to your bucket.

3. **Ensure external role’s policy also allows S3**
   - In external account:
     - Role policy must allow `s3:*` on your bucket ARN(s).
   - Explanation:
     - Both sides (bucket policy + role policy) must allow.

4. **Test from external account**
   - Using AWS CLI with that role:
     ```bash
     aws s3 ls s3://my-bucket
     ```

---

## Q39. How do you troubleshoot S3 “SlowDown” or throttling errors?

### Typical question
“High‑throughput workload gets S3 `SlowDown` responses. What does it mean and what can you do?”

### Answer – step by step

1. **Understand the error**
   - S3 `SlowDown` indicates:
     - You are sending too many requests too fast to S3; service is throttling.

2. **Check request rate and key patterns**
   - Avoid:
     - Very high request rate on a small set of object keys.
   - Explanation:
     - Use key name randomness/prefixes to distribute load (S3 scales automatically but per‑prefix hot spots can appear).

3. **Use retries with backoff**
   - Application / SDK:
     - Implement exponential backoff and retry on 503/SlowDown responses.
   - Explanation:
     - AWS SDKs typically handle this automatically; custom code must mimic it.

---

## Q40. In an interview, how would you summarize your S3 + IAM troubleshooting approach?

### Typical question
“Summarize how you handle S3 access and security issues end‑to‑end.”

### Answer – structured talking points

1. **Identity first**
   - Identify which IAM principal is calling S3:
     - `aws sts get-caller-identity` from the environment.
   - Check its IAM policies for S3 permissions.

2. **Bucket policy second**
   - Review bucket policy for:
     - Allows and explicit denies.
     - Conditions on VPC, IP, encryption, principals.

3. **Network considerations**
   - For private access:
     - VPC endpoints and endpoint policies.
   - For public access:
     - Block public access config and correct use of CloudFront if needed.

4. **Encryption and compliance**
   - Enforce SSE (SSE‑S3 or SSE‑KMS).
   - Verify object metadata and configure lifecycle accordingly.

5. **Narrate a real incident**
   - Example:
     - Prod app suddenly got `AccessDenied`.
     - You:
       - Checked role identity.
       - Found new bucket policy Deny due to missing encryption header.
       - Updated app to send SSE header and restored access.

# AWS Interview – Practical DevOps Q&A (Batch 5: Q41–Q50 – EKS & AWS Networking)

## Q41. Your EKS cluster is created, but `kubectl` cannot connect. How do you fix and verify kubeconfig?

### Typical question
“You just created an EKS cluster, but `kubectl get nodes` fails. What do you do?”

### Answer – step by step

1. **Update kubeconfig using AWS CLI**
   - Command:
     ```bash
     aws eks update-kubeconfig --name my-cluster --region ap-south-1
     ```
   - Explanation:
     - Writes/updates your `~/.kube/config` to add EKS cluster endpoint & auth config.
     - Uses AWS IAM for auth via `aws-iam-authenticator` mechanism.

2. **Verify cluster entry in kubeconfig**
   - Command:
     ```bash
     kubectl config get-contexts
     ```
   - Explanation:
     - Ensure there is a context for `arn:aws:eks:...:cluster/my-cluster`.
     - Confirm current context is set to the EKS cluster.

3. **Test connection**
   - Command:
     ```bash
     kubectl get nodes
     ```
   - Explanation:
     - If you get nodes list → kubeconfig and IAM access are correct.
     - If you get `error: You must be logged in`, IAM auth or AWS credentials are wrong.

---

## Q42. `kubectl get nodes` returns no nodes or nodes are `NotReady`. How do you debug?

### Typical question
“Control plane exists, but worker nodes aren’t joining or stay NotReady. Steps?”

### Answer – step by step

1. **Check node group status in EKS console**
   - EKS → Clusters → my‑cluster → Compute:
     - Check managed/ self‑managed node group health and desired vs actual nodes.
   - Explanation:
     - If node group failed to create, no nodes to join cluster.

2. **On EC2 nodes, check kubelet/kube-proxy**
   - SSH/SSM into a worker node:
     ```bash
     sudo systemctl status kubelet
     kubectl get nodes  # from your machine, not node
     ```
   - Explanation:
     - If kubelet is not running or misconfigured, node won’t register.

3. **Check security groups and IAM role for nodes**
   - Node IAM role:
     - Must have EKS worker node permissions (e.g., AmazonEKSWorkerNodePolicy etc.).
   - Node SG:
     - Must allow:
       - Outbound to cluster endpoint.
       - Inbound on required ports from cluster SG (if separate).
   - Explanation:
     - Incorrect SG or IAM can prevent nodes from joining.

---

## Q43. Pods in EKS cannot reach the internet (for apt/pip). How do you debug?

### Typical question
“Your pods are in private subnets in EKS; they can’t reach internet. What do you check?”

### Answer – step by step

1. **Check EKS worker node subnets and route tables**
   - Worker nodes typically in private subnets.
   - Route table must have:
     ```text
     0.0.0.0/0 -> nat-gateway-id
     ```
   - Explanation:
     - Pod traffic NATs through worker node ENI; nodes need NAT path to internet.

2. **From a pod, test outbound access**
   - Commands:
     ```bash
     kubectl exec -it pod-name -- sh
     # inside:
     curl -I https://www.google.com
     ```
   - Explanation:
     - If this fails, confirm nodes themselves can reach internet:
       ```bash
       curl -I https://www.google.com    # on node
       ```

3. **Check NACLs for node subnets**
   - Ensure NACL allows outbound 80/443 and ephemeral ports, inbound replies.
   - Explanation:
     - Restrictive NACL can block NATed traffic.

---

## Q44. A pod in EKS cannot reach an internal AWS service (e.g., RDS). What’s your flow?

### Typical question
“Pod can’t connect to RDS in same VPC. How do you debug from EKS side and VPC side?”

### Answer – step by step

1. **From pod, test connectivity**
   - Commands:
     ```bash
     kubectl exec -it pod-a -- sh
     nc -vz mydb.abc123.rds.amazonaws.com 5432
     ```
   - Explanation:
     - If `nc` fails, network issue; if `nc` works but app fails, app config/credentials.

2. **Check RDS Security Group**
   - Inbound:
     - Allow DB port from:
       - Node SG, or
       - Separate SG used for EKS worker nodes (if referenced directly).
   - Explanation:
     - Traffic originates from node ENIs, not pod IPs (unless custom CNI).

3. **Check VPC route tables and NACLs**
   - Ensure worker node subnets can route to RDS subnets.
   - NACLs on both subnets allow traffic on DB port + ephemeral ports.

---

## Q45. How do you debug a Kubernetes Service of type LoadBalancer created in EKS that never gets an external IP?

### Typical question
“You create `Service type: LoadBalancer`, but `EXTERNAL-IP` stays `<pending>`. What do you do?”

### Answer – step by step

1. **Check EKS cluster IAM/OIDC and AWS Load Balancer Controller**
   - Usually need AWS Load Balancer Controller installed for ALB/NLB type LBs.
   - Ensure:
     - Controller pod is running in cluster.
     - Controller IAM role has correct permissions (via IRSA).
   - Explanation:
     - Without proper controller/permissions, AWS resources can’t be created.

2. **Check Service annotations**
   - `kubectl get svc my-svc -o yaml`:
     - Look for annotations like `service.beta.kubernetes.io/aws-load-balancer-*`.
   - Explanation:
     - Misconfigured annotations can block LB provisioning.

3. **Check AWS side**
   - EC2 → Load Balancers:
     - See if any new ALB/NLB is being created and failing.
   - Explanation:
     - If failing, check event logs or CloudTrail for permission errors.

---

## Q46. How do you confirm that EKS control plane can talk to worker nodes (and vice versa)?

### Typical question
“Cluster seems flaky. How do you validate the path between control plane and nodes?”

### Answer – step by step

1. **Check cluster endpoint access configuration**
   - EKS console → Cluster → Networking:
     - Endpoint access: Public/Private/Both.
   - Explanation:
     - For private‑only, ensure worker node subnets have route to control plane ENIs (via private link inside VPC).

2. **Check Node SG inbound rules**
   - Node SG must allow:
     - Control plane IPs / SG on required ports for kubelet/kube-proxy.  
     - In AWS recommended config, EKS cluster SG and node SG should mutually allow required ports.

3. **Test from node to control plane**
   - On node:
     ```bash
     curl -k https://<cluster-endpoint>/
     ```
   - Explanation:
     - Should get HTTP 403 or similar (not connection timeout).
     - Timeout indicates path issue (route/SG/NACL).

---

## Q47. How do you use VPC CNI metrics/logs to debug pod IP exhaustion in EKS?

### Typical question
“Pods fail to schedule because no IPs available. How do you debug at VPC CNI level?”

### Answer – step by step

1. **Check number of ENIs and IPs assigned per node**
   - Use:
     ```bash
     kubectl get pods -n kube-system | grep aws-node
     ```
   - Then look into VPC CNI logs:
     ```bash
     kubectl logs -n kube-system <aws-node-pod>
     ```
   - Explanation:
     - Logs may show IP allocation failures.

2. **Check subnet IP utilization in VPC**
   - VPC console → Subnets → check used/available IPs.
   - Explanation:
     - If subnet is nearly full, node cannot get more secondary IPs for pods.

3. **Mitigation**
   - Add more/bigger subnets and attach them to node groups.
   - Use prefix delegation or adjust `WARM_IP_TARGET`/`MIN_IP_TARGET` in CNI config for scaling.

---

## Q48. How do you restrict which AWS APIs pods in EKS can call (IAM for Service Accounts)?

### Typical question
“How do you avoid giving node IAM role too many permissions and instead scope by pod?”

### Answer – step by step

1. **Enable IAM Roles for Service Accounts (IRSA)**
   - Associate an OIDC provider with the EKS cluster.
   - Explanation:
     - Allows mapping Kubernetes ServiceAccounts to IAM roles.

2. **Create IAM role with trust policy for specific ServiceAccount**
   - Trust policy:
     - Allows `sts:AssumeRoleWithWebIdentity` only from ServiceAccount `namespace:sa-name` in that cluster.
   - Explanation:
     - Scopes this role to that pod identity.

3. **Annotate ServiceAccount in Kubernetes**
   - YAML:
     ```yaml
     apiVersion: v1
     kind: ServiceAccount
     metadata:
       name: s3-access-sa
       namespace: default
       annotations:
         eks.amazonaws.com/role-arn: arn:aws:iam::<account-id>:role/s3-access-role
     ```
   - Explanation:
     - Pods using this SA will receive temporary credentials for that IAM role.

4. **Verify from pod**
   - In pod:
     ```bash
     aws sts get-caller-identity
     ```
   - Explanation:
     - Confirms it’s using correct IAM role, not node role.

---

## Q49. How do you debug “pod cannot resolve DNS names” in EKS?

### Typical question
“Pods say `Unknown host` when calling internal/external services. Steps?”

### Answer – step by step

1. **Check CoreDNS pods**
   - Commands:
     ```bash
     kubectl get pods -n kube-system -l k8s-app=kube-dns
     kubectl logs -n kube-system <coredns-pod-name>
     ```
   - Explanation:
     - Ensure CoreDNS pods are `Running`.
     - Logs show upstream DNS errors if any.

2. **Test DNS from a debug pod**
   - Command:
     ```bash
     kubectl run dns-test --image=busybox --restart=Never -it -- nslookup kubernetes.default
     ```
   - Explanation:
     - If this fails, DNS configuration or CoreDNS is broken.

3. **Check VPC DNS settings**
   - VPC must have:
     - `enableDnsHostnames` and `enableDnsSupport` = true.
   - Explanation:
     - If disabled, DNS resolution inside VPC (and thus EKS) fails.

---

## Q50. In an interview, how would you summarize your EKS + AWS networking troubleshooting approach?

### Typical question
“Summarize how you debug issues in an EKS cluster running inside a VPC.”

### Answer – structured talking points

1. **Start at control plane & nodes**
   - Check:
     - `aws eks update-kubeconfig`, `kubectl get nodes`.
     - Node group health, kubelet status.

2. **Check pod and service connectivity**
   - `kubectl get pods,svc,endpoints`.
   - Use `kubectl exec` + `curl` / `nc` inside pods for connectivity tests.

3. **Map Kubernetes to VPC**
   - Understand that:
     - Pods’ traffic flows via node ENIs.
     - SGs, NACLs, and route tables on subnets control actual traffic.

4. **Use AWS‑specific tools**
   - VPC Reachability Analyzer, CloudWatch metrics for EKS, VPC CNI logs, and Flow Logs as needed.

5. **Narrate a concrete EKS incident**
   - For example:
     - New cluster had pods that couldn’t reach RDS.
     - Steps:
       - Test from pod → network issue.
       - Check RDS SG, saw it allowed old node SG only.
       - Add node SG of new node group; connectivity fixed.
