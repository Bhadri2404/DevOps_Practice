Here are your comprehensive Platform Engineer interview preparation notes. Given the massive scope (14 topics × 24 questions each), I'll provide the complete structured notes with the Networking section in full depth as requested, followed by all other topics with detailed Q&A.

---

````markdown name=Platform-Engineer-Interview-Notes.md
# 🚀 Platform Engineer & DevOps Interview Preparation Notes

## 📋 Table of Contents

- [1. Networking (Highest Priority)](#1-networking-highest-priority)
- [2. Linux](#2-linux)
- [3. Jenkins](#3-jenkins)
- [4. CI/CD](#4-cicd)
- [5. Python Scripting](#5-python-scripting)
- [6. Shell Scripting](#6-shell-scripting)
- [7. Ansible](#7-ansible)
- [8. Docker](#8-docker)
- [9. Kubernetes](#9-kubernetes)
- [10. Monitoring](#10-monitoring)
- [11. Logging](#11-logging)
- [12. Troubleshooting](#12-troubleshooting)
- [13. EC2/Cloud Infrastructure](#13-ec2cloud-infrastructure)
- [14. Security](#14-security)

---

# 1. Networking (Highest Priority)

## 🌐 Networking Basics - Explained from Scratch

### What is Networking?
Networking is simply **computers talking to each other**. Just like humans use phones to communicate, computers use networks (cables, Wi-Fi, internet) to send and receive data.

**Real-world analogy:** Think of networking like a postal system:
- **IP Address** = Your home address (where to deliver)
- **Port** = The apartment number (which app gets the mail)
- **Protocol (TCP/UDP)** = The delivery method (registered post vs regular mail)
- **DNS** = Phone book (converts names to addresses)
- **Router** = Post office (decides where to send the mail next)
- **Firewall** = Security guard (decides what's allowed in/out)

### Key Networking Concepts

| Concept | Simple Explanation | Example |
|---------|-------------------|---------|
| IP Address | Unique address of a computer | 192.168.1.10 |
| Port | Door number for a specific service | 80 (HTTP), 443 (HTTPS), 22 (SSH) |
| TCP | Reliable delivery (confirms receipt) | Web browsing, SSH |
| UDP | Fast delivery (no confirmation) | Video streaming, DNS |
| DNS | Converts domain names to IP addresses | google.com → 142.250.80.46 |
| Subnet | A smaller network inside a bigger network | 10.0.1.0/24 = 256 addresses |
| Gateway | The exit door to reach other networks | Your router at home |
| CIDR | Shorthand for subnet ranges | /24 = 256 IPs, /16 = 65536 IPs |
| NAT | Shares one public IP among many private devices | Your home WiFi router |
| Load Balancer | Distributes traffic across multiple servers | AWS ALB/NLB |

---

## 🔧 Essential Networking Commands - Line-by-Line Explained

### Command: `ss -tulnp`

```bash
ss -tulnp
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `ss` | Socket Statistics - shows network connections (modern replacement for netstat) |
| `-t` | Show TCP connections only |
| `-u` | Show UDP connections only |
| `-l` | Show only LISTENING ports (services waiting for connections) |
| `-n` | Show numbers instead of names (faster, shows 80 instead of "http") |
| `-p` | Show the process/program using each port |

**When engineers use it:** When you deploy an app and want to check if it's actually running and listening on the expected port.

**Sample output:**
```
State   Recv-Q  Send-Q  Local Address:Port  Peer Address:Port  Process
LISTEN  0       128     0.0.0.0:22          0.0.0.0:*          users:(("sshd",pid=1234,fd=3))
LISTEN  0       128     0.0.0.0:80          0.0.0.0:*          users:(("nginx",pid=5678,fd=6))
LISTEN  0       128     127.0.0.1:5432      0.0.0.0:*          users:(("postgres",pid=9012,fd=4))
```

**How to read the output:**
- Line 1: SSH service is listening on port 22 on ALL interfaces (0.0.0.0) - anyone can connect
- Line 2: Nginx is listening on port 80 on ALL interfaces - web traffic
- Line 3: PostgreSQL is listening on port 5432 on LOCALHOST ONLY (127.0.0.1) - only local connections allowed

**Problem it solves:** "My app is deployed but users can't access it" → Check if it's actually listening on the right port.

---

### Command: `netstat -tulnp`

```bash
netstat -tulnp
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `netstat` | Network statistics - older tool to show connections (being replaced by `ss`) |
| `-t` | TCP connections |
| `-u` | UDP connections |
| `-l` | Listening ports only |
| `-n` | Numeric output (no DNS resolution) |
| `-p` | Show process ID and name |

**Same purpose as `ss -tulnp`** but older. Some legacy systems still use it.

---

### Command: `tcpdump`

```bash
tcpdump -i eth0 port 80 -n -c 10
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `tcpdump` | Captures and displays network packets (like wiretapping a phone line) |
| `-i eth0` | Listen on interface eth0 (the network card) |
| `port 80` | Only capture traffic on port 80 (HTTP) |
| `-n` | Don't resolve hostnames (faster output) |
| `-c 10` | Capture only 10 packets then stop |

**When engineers use it:** When you suspect network traffic isn't reaching your server, or you need to debug API calls between services.

**Sample output:**
```
14:23:01.123456 IP 10.0.1.5.54321 > 10.0.1.10.80: Flags [S], seq 123456
14:23:01.123789 IP 10.0.1.10.80 > 10.0.1.5.54321: Flags [S.], seq 789012, ack 123457
14:23:01.124000 IP 10.0.1.5.54321 > 10.0.1.10.80: Flags [.], ack 789013
```

**How to read:**
- Line 1: Client (10.0.1.5) sends SYN to server (10.0.1.10:80) - "Hey, can we talk?"
- Line 2: Server responds with SYN-ACK - "Yes, let's talk"
- Line 3: Client sends ACK - "Great, connection established"
- This is the **TCP 3-way handshake** (the foundation of every TCP connection)

**Problem it solves:** "Kubernetes pods can't communicate" → Capture traffic to see if packets are reaching the destination.

---

### Command: `curl`

```bash
curl -v http://myapp.example.com:8080/health
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `curl` | Command-line tool to make HTTP requests (like a browser without the UI) |
| `-v` | Verbose mode - shows full request/response details |
| `http://` | Use HTTP protocol |
| `myapp.example.com` | The domain name to connect to |
| `:8080` | Connect to port 8080 |
| `/health` | Request the /health endpoint |

**When engineers use it:** To test if APIs are working, health checks, debugging connectivity.

**Other useful curl examples:**
```bash
# Check response code only
curl -o /dev/null -s -w "%{http_code}" http://myapp:8080/health

# POST request with JSON
curl -X POST -H "Content-Type: application/json" -d '{"key":"value"}' http://api:8080/data

# With timeout (important in production scripts)
curl --connect-timeout 5 --max-time 10 http://myapp:8080/health
```

---

### Command: `dig`

```bash
dig example.com
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `dig` | DNS lookup tool - asks "What IP address does this domain point to?" |
| `example.com` | The domain name to look up |

**Sample output:**
```
;; ANSWER SECTION:
example.com.    300    IN    A    93.184.216.34
```

**How to read:** example.com points to IP 93.184.216.34, with a TTL (cache time) of 300 seconds.

**Advanced usage:**
```bash
# Query specific DNS server
dig @8.8.8.8 example.com

# Look up specific record type
dig example.com MX      # Mail records
dig example.com CNAME   # Alias records
dig example.com NS      # Nameserver records
```

**Problem it solves:** "Users can't reach our website" → Check if DNS is resolving correctly.

---

### Command: `traceroute`

```bash
traceroute google.com
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `traceroute` | Shows the path (every router/hop) your data takes to reach a destination |
| `google.com` | The destination |

**Real-world analogy:** Like tracking a package - you can see every post office it passes through.

**Sample output:**
```
 1  gateway (10.0.0.1)       1.234 ms
 2  isp-router (203.0.113.1) 5.678 ms
 3  * * *
 4  google-edge (142.250.1.1) 15.234 ms
```

**How to read:**
- Hop 1: Your local gateway (1ms - very fast, it's local)
- Hop 2: Your ISP's router (5ms)
- Hop 3: `* * *` means this router doesn't respond to traceroute (normal for many routers)
- Hop 4: Reached Google's network (15ms)

**Problem it solves:** "Our app is slow for some users" → Traceroute shows where the delay is happening.

---

### Command: `ping`

```bash
ping -c 4 10.0.1.5
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `ping` | Sends a small packet and waits for reply - checks if a host is reachable |
| `-c 4` | Send only 4 packets then stop (without this, it pings forever on Linux) |
| `10.0.1.5` | The target IP address |

**Problem it solves:** "Is this server alive/reachable?"

**Note:** Many production servers block ping (ICMP) for security. If ping fails, the server may still be running - use `curl` or `nc` instead.

---

### Command: `nslookup`

```bash
nslookup myapp.internal.company.com
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `nslookup` | Simple DNS lookup tool (simpler than dig) |
| `myapp.internal.company.com` | Domain to look up |

**Problem it solves:** Quick check if DNS resolution works for internal services.

---

### Command: `ip addr`

```bash
ip addr show
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `ip` | Modern networking tool (replaces ifconfig) |
| `addr` | Show address information |
| `show` | Display all interfaces |

**Sample output:**
```
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP>
    inet 10.0.1.10/24 brd 10.0.1.255 scope global eth0
```

**How to read:** Interface eth0 has IP 10.0.1.10 with subnet /24 (255 addresses in this network).

---

### Command: `route` / `ip route`

```bash
ip route show
```

**Sample output:**
```
default via 10.0.1.1 dev eth0
10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.10
```

**How to read:**
- Line 1: Default route - anything not in local network goes through 10.0.1.1 (the gateway)
- Line 2: Local network 10.0.1.0/24 is directly accessible via eth0

---

### Command: `iptables`

```bash
iptables -L -n -v
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `iptables` | Linux firewall tool - controls what traffic is allowed/blocked |
| `-L` | List all rules |
| `-n` | Numeric output |
| `-v` | Verbose (show packet counts) |

**Problem it solves:** "My app is running but nobody can connect" → Maybe the firewall is blocking traffic.

---

### Command: `nc` (netcat)

```bash
nc -zv 10.0.1.5 8080
```

**Line-by-line breakdown:**
| Part | Meaning |
|------|---------|
| `nc` | Netcat - the "Swiss army knife" of networking |
| `-z` | Just check if port is open (don't send data) |
| `-v` | Verbose output |
| `10.0.1.5` | Target host |
| `8080` | Target port |

**Output if successful:** `Connection to 10.0.1.5 8080 port [tcp/*] succeeded!`
**Output if failed:** `Connection to 10.0.1.5 8080 port [tcp/*] failed: Connection refused`

**Problem it solves:** "Can my server reach the database on port 5432?" → Quick port connectivity check.

---

## 📝 Networking - 24 Interview Questions with Detailed Answers

### Q1: An EC2 instance is running but you cannot SSH into it. How do you troubleshoot?

**Issue Description:** You launched an EC2 instance, the status checks pass, but `ssh ec2-user@<IP>` times out or gets "Connection refused."

**How to identify the issue:**
```bash
# Step 1: Check if the instance is reachable at all
ping -c 4 <EC2-PUBLIC-IP>
# If timeout → Network-level issue (Security Group, NACL, or routing)

# Step 2: Check if SSH port is open
nc -zv <EC2-PUBLIC-IP> 22 -w 5
# -w 5 = timeout after 5 seconds
# If "Connection refused" → SSH service not running
# If timeout → Firewall blocking

# Step 3: If you have access to another instance in same VPC
# Check from inside the VPC
nc -zv <EC2-PRIVATE-IP> 22

# Step 4: Check Security Group (via AWS CLI)
aws ec2 describe-security-groups --group-ids sg-xxxxx --query 'SecurityGroups[*].IpPermissions'
```

**Root Cause Analysis (Common Causes):**
1. **Security Group** doesn't allow inbound SSH (port 22) from your IP
2. **NACL (Network ACL)** blocking traffic
3. **No Internet Gateway** attached to the VPC
4. **Route table** doesn't have 0.0.0.0/0 → IGW route
5. **SSH service** not running inside the instance
6. **Wrong key pair** used
7. **Disk full** preventing SSH daemon from accepting connections

**Practical Solution:**
1. Check Security Group → Add inbound rule: Port 22, Source: Your IP/32
2. Check Route Table → Ensure 0.0.0.0/0 → igw-xxxxx exists
3. Check NACL → Ensure both inbound AND outbound rules allow traffic
4. Use EC2 Serial Console or Systems Manager Session Manager as alternative access

**Production Best Practices:**
- Never open SSH to 0.0.0.0/0 (the whole internet)
- Use Systems Manager Session Manager instead of direct SSH
- Use a bastion/jump host for SSH access
- Enable VPC Flow Logs to see rejected traffic

---

### Q2: What is the difference between TCP and UDP? When is each used?

**Issue Description:** Understanding when services use TCP vs UDP is critical for firewall rules and troubleshooting.

**Answer:**

| Feature | TCP | UDP |
|---------|-----|-----|
| Reliability | Guaranteed delivery (confirms receipt) | No guarantee (fire and forget) |
| Speed | Slower (overhead for reliability) | Faster (no confirmation needed) |
| Connection | Connection-oriented (3-way handshake) | Connectionless |
| Use Case | Web (HTTP/HTTPS), SSH, Database | DNS, Video streaming, Gaming |
| Analogy | Registered mail (you get confirmation) | Dropping a letter in a mailbox |

**Real-world production examples:**
- **TCP port 443** → HTTPS web traffic (must be reliable)
- **TCP port 22** → SSH (every command must arrive correctly)
- **TCP port 5432** → PostgreSQL database
- **UDP port 53** → DNS queries (speed matters, small packets)
- **UDP port 123** → NTP time synchronization

**Why this matters in production:**
- Security Groups need correct protocol (TCP/UDP)
- Load balancers need correct protocol configuration
- Kubernetes Services use TCP by default; DNS uses UDP

---

### Q3: Explain DNS resolution step by step. What happens when you type google.com in a browser?

**Answer (Step by Step):**

1. **Browser cache** → Checks if it already knows the IP (from previous visits)
2. **OS cache** → Checks local DNS cache (`/etc/hosts` on Linux)
3. **Resolver (ISP/Corporate DNS)** → Asks your configured DNS server
4. **Root DNS Server** → Says "I don't know google.com, but ask .com servers"
5. **TLD Server (.com)** → Says "Ask Google's nameservers"
6. **Authoritative Nameserver** → Returns the actual IP: 142.250.80.46
7. **Response cached** → Stored for TTL duration to speed up next request

**Real-world analogy:** 
- You want to call "John Smith"
- You check your phone contacts (browser cache)
- You check your address book (OS cache)  
- You call directory assistance (DNS resolver)
- They say "which country?" (Root server)
- Then "which city?" (TLD server)
- Then give you the number (Authoritative server)

**Production commands to debug DNS:**
```bash
# Check what DNS server your system uses
cat /etc/resolv.conf

# Test DNS resolution
dig google.com +short
# Output: 142.250.80.46

# Check if local caching works
dig google.com | grep "Query time"
# First time: Query time: 50 msec
# Second time: Query time: 0 msec (cached!)

# Flush DNS cache (on systemd systems)
sudo systemd-resolve --flush-caches
```

---

### Q4: A Kubernetes pod cannot communicate with another pod. How do you troubleshoot?

**Issue Description:** Service A pod cannot reach Service B pod. API calls between microservices are failing.

**How to identify:**
```bash
# Step 1: Check if pods are running
kubectl get pods -o wide
# Look at STATUS and NODE columns

# Step 2: Get into the source pod and test connectivity
kubectl exec -it <pod-a> -- sh

# Step 3: Test DNS resolution inside the pod
nslookup service-b.namespace.svc.cluster.local
# If fails → CoreDNS issue

# Step 4: Test port connectivity
nc -zv service-b.namespace.svc.cluster.local 8080
# If fails → Network Policy or Service misconfiguration

# Step 5: Check the target service
kubectl get svc service-b -n namespace
kubectl get endpoints service-b -n namespace
# If endpoints is empty → Labels don't match between Service and Pod

# Step 6: Check Network Policies
kubectl get networkpolicies -n namespace
```

**Root Cause Analysis:**
1. **DNS not resolving** → CoreDNS pods crashed or misconfigured
2. **Endpoints empty** → Service selector labels don't match pod labels
3. **Network Policy** blocking traffic between namespaces
4. **Pod not ready** → Readiness probe failing, so it's removed from Service
5. **Wrong port** → Service targeting wrong container port

**Practical Solution:**
```bash
# Fix 1: Verify labels match
kubectl get pod <pod-b> --show-labels
kubectl get svc service-b -o yaml | grep selector

# Fix 2: Check CoreDNS
kubectl get pods -n kube-system | grep coredns
kubectl logs -n kube-system <coredns-pod>

# Fix 3: Check Network Policy allows traffic
kubectl describe networkpolicy <policy-name> -n namespace
```

---

### Q5: What is a subnet and CIDR? Explain with production examples.

**Answer:**

**Subnet** = A smaller network carved out of a bigger network. Like dividing a building into floors.

**CIDR (Classless Inter-Domain Routing)** = A shorthand way to define subnet size.

| CIDR | Subnet Mask | Available IPs | Use Case |
|------|-------------|---------------|----------|
| /32 | 255.255.255.255 | 1 IP | Single host rule in Security Group |
| /24 | 255.255.255.0 | 256 (254 usable) | Typical subnet for one AZ |
| /16 | 255.255.0.0 | 65,536 | Entire VPC range |
| /8 | 255.0.0.0 | 16 million | Large internal networks |

**Real-world analogy:**
- VPC (10.0.0.0/16) = The entire apartment complex
- Subnet (10.0.1.0/24) = One floor of the building
- Each EC2 instance = One apartment on that floor

**Production VPC Design Example:**
```
VPC: 10.0.0.0/16 (65,536 IPs total)
├── Public Subnet AZ-A:  10.0.1.0/24 (Web servers, ALB)
├── Public Subnet AZ-B:  10.0.2.0/24 (Web servers, ALB)
├── Private Subnet AZ-A: 10.0.10.0/24 (App servers)
├── Private Subnet AZ-B: 10.0.20.0/24 (App servers)
├── DB Subnet AZ-A:      10.0.100.0/24 (RDS, ElastiCache)
└── DB Subnet AZ-B:      10.0.200.0/24 (RDS, ElastiCache)
```

---

### Q6: What is the difference between Security Group and NACL in AWS?

| Feature | Security Group | NACL |
|---------|---------------|------|
| Level | Instance (ENI) level | Subnet level |
| State | Stateful (return traffic auto-allowed) | Stateless (must allow both directions) |
| Rules | Allow only (no deny rules) | Both Allow and Deny |
| Evaluation | All rules evaluated together | Rules evaluated in order (lowest number first) |
| Default | Denies all inbound, allows all outbound | Allows all traffic |

**Production example:**
- Security Group: "Allow port 443 from ALB security group" (instance-level)
- NACL: "Block all traffic from IP 203.0.113.50" (subnet-level block for a bad actor)

---

### Q7: Jenkins agent cannot connect to the master. How do you troubleshoot?

**Issue Description:** Jenkins shows agent as "offline" and builds are stuck in queue.

**How to identify:**
```bash
# Step 1: Check if Jenkins master port is reachable from agent
nc -zv jenkins-master.internal:50000 -w 5
# Port 50000 is default JNLP agent port

# Step 2: Check if agent can resolve Jenkins master DNS
dig jenkins-master.internal

# Step 3: Check agent logs
journalctl -u jenkins-agent -f
# or check the agent jar log

# Step 4: Check firewall between agent and master
# On master:
ss -tulnp | grep 50000
# Should show Jenkins listening

# Step 5: Check from AWS console
# Security Group of agent → allows outbound to master:50000
# Security Group of master → allows inbound from agent on port 50000
```

**Root Cause Analysis:**
1. Security Group not allowing port 50000 between master and agent
2. Agent's JNLP secret/token expired
3. DNS resolution failing for Jenkins master hostname
4. Jenkins master restarted and agent hasn't reconnected
5. Network route between VPCs/subnets broken

**Solution:**
- Verify Security Groups allow bidirectional communication
- Restart agent service: `sudo systemctl restart jenkins-agent`
- Reconfigure agent with new secret from Jenkins UI
- Use SSH-based agents instead of JNLP (more reliable)

---

### Q8: What are the common ports every DevOps engineer must know?

| Port | Service | Protocol | Purpose |
|------|---------|----------|---------|
| 22 | SSH | TCP | Remote server access |
| 80 | HTTP | TCP | Web traffic (unencrypted) |
| 443 | HTTPS | TCP | Web traffic (encrypted) |
| 53 | DNS | UDP/TCP | Name resolution |
| 25/587 | SMTP | TCP | Email sending |
| 3306 | MySQL | TCP | Database |
| 5432 | PostgreSQL | TCP | Database |
| 6379 | Redis | TCP | Cache |
| 8080 | HTTP Alt | TCP | Jenkins, Tomcat, dev servers |
| 9090 | Prometheus | TCP | Monitoring |
| 3000 | Grafana | TCP | Dashboards |
| 2379 | etcd | TCP | Kubernetes state store |
| 10250 | Kubelet | TCP | K8s node agent |
| 6443 | K8s API | TCP | Kubernetes API server |
| 50000 | Jenkins JNLP | TCP | Jenkins agent communication |
| 27017 | MongoDB | TCP | Database |

---

### Q9: What is NAT Gateway and why is it needed?

**Simple explanation:** NAT (Network Address Translation) Gateway allows private instances (no public IP) to access the internet for updates/downloads, while preventing the internet from initiating connections to them.

**Real-world analogy:** Like a PO Box - you can send letters out, but people can't come to your home address.

**Production use case:**
- App servers in private subnets need to download packages (`apt update`, pull Docker images)
- They can't have public IPs (security requirement)
- NAT Gateway sits in public subnet and forwards their traffic

```
Private Instance (10.0.10.5) → NAT Gateway (in public subnet) → Internet
Internet → ❌ Cannot reach 10.0.10.5 directly
```

---

### Q10: How does a Load Balancer work? Explain ALB vs NLB.

**Simple explanation:** A Load Balancer is like a receptionist who distributes incoming visitors to different meeting rooms (servers) so no single room gets overcrowded.

| Feature | ALB (Application LB) | NLB (Network LB) |
|---------|----------------------|-------------------|
| Layer | Layer 7 (HTTP/HTTPS) | Layer 4 (TCP/UDP) |
| Routing | URL path, headers, host | IP and port only |
| Speed | Slightly slower | Ultra-fast (millions of req/s) |
| Use Case | Web apps, microservices | Gaming, IoT, extreme performance |
| Static IP | No (use DNS name) | Yes (Elastic IP support) |

**Production example:**
```
ALB routing:
  /api/*     → API service target group
  /static/*  → CDN/static server target group
  /admin/*   → Admin service target group
```

---

### Q11: What is the TCP 3-Way Handshake?

**Simple explanation:** Before two computers talk via TCP, they do a 3-step greeting:

```
Client → Server:  SYN      ("Hey, can we talk?")
Server → Client:  SYN-ACK  ("Yes, I'm ready!")
Client → Server:  ACK      ("Great, let's go!")
```

**Why it matters:** If you see connections stuck in `SYN_SENT` state (via `ss`), it means the server isn't responding - likely firewall blocking or service down.

```bash
# Check for stuck connections
ss -tan state syn-sent
```

---

### Q12: Explain the OSI Model in simple terms relevant to troubleshooting.

| Layer | Name | What It Does | Troubleshooting Tool | Example Issue |
|-------|------|-------------|---------------------|---------------|
| 7 | Application | Your app (HTTP, DNS) | curl, browser | 404 error, API timeout |
| 4 | Transport | TCP/UDP connections | ss, netstat, nc | Port not open, connection refused |
| 3 | Network | IP routing | ping, traceroute, ip route | Can't reach server, wrong route |
| 2 | Data Link | Local network (MAC) | arp, ip neigh | Duplicate IP, switch issues |
| 1 | Physical | Cables, hardware | ethtool, dmesg | Cable unplugged, NIC failure |

**Production troubleshooting approach:** Always start from Layer 1 upward:
1. Can I ping it? (Layer 3)
2. Can I reach the port? (Layer 4)
3. Does the app respond correctly? (Layer 7)

---

### Q13: Docker containers cannot communicate with each other. How to fix?

**Issue:** Two Docker containers need to talk but connection is refused.

```bash
# Step 1: Check if containers are on same network
docker network ls
docker inspect <container> | grep -A 10 "Networks"

# Step 2: Containers on different networks can't communicate by default
# Solution: Put them on the same user-defined network
docker network create myapp-network
docker run --network myapp-network --name app1 myimage1
docker run --network myapp-network --name app2 myimage2

# Step 3: Test connectivity (containers can use names as DNS)
docker exec app1 ping app2
docker exec app1 nc -zv app2 8080
```

**Key insight:** On user-defined networks, Docker provides built-in DNS - containers can reach each other by name. On the default bridge network, you must use IP addresses.

---

### Q14: What is a VPC Peering and when do you use it?

**Simple explanation:** VPC Peering connects two VPCs so they can communicate using private IP addresses, as if they were on the same network.

**Real-world analogy:** Like building a bridge between two separate office buildings.

**When to use:**
- Shared services VPC (logging, monitoring) needs to talk to application VPCs
- Different teams have separate VPCs but share databases
- Multi-account strategy where accounts need private communication

**Limitations:**
- No transitive peering (A↔B and B↔C does NOT mean A↔C)
- CIDR ranges cannot overlap
- Must update route tables on BOTH sides

---

### Q15: How do you troubleshoot "Connection Timed Out" vs "Connection Refused"?

| Error | Meaning | Common Cause | Fix |
|-------|---------|--------------|-----|
| **Connection Timed Out** | Packets sent but no response received | Firewall blocking, wrong IP, no route | Check Security Groups, NACLs, routing |
| **Connection Refused** | Server received request but rejected it | Service not running on that port | Start the service, check port binding |

```bash
# Connection Refused example:
$ nc -zv 10.0.1.5 8080
Connection refused
# Meaning: Server is reachable but nothing is listening on port 8080
# Fix: Start the application, check ss -tulnp on the server

# Connection Timed Out example:
$ nc -zv 10.0.1.5 8080 -w 5
Connection timed out
# Meaning: No response at all - packets are being dropped
# Fix: Check firewalls (Security Groups, NACLs, iptables)
```

---

### Q16: What is DNS TTL and how does it affect deployments?

**TTL (Time To Live)** = How long (in seconds) DNS resolvers cache a record before asking again.

**Production impact:**
- **High TTL (86400 = 24 hours):** Reduces DNS queries but makes changes slow to propagate
- **Low TTL (60 = 1 minute):** Fast propagation but more DNS load

**Before a migration/cutover:**
```bash
# 1. Days before: Lower TTL to 60 seconds
# 2. Perform the DNS change (point to new IP)
# 3. Within 60 seconds, all users get new IP
# 4. After migration: Raise TTL back to 3600+
```

---

### Q17: Explain port forwarding and SSH tunneling.

**SSH Tunnel (Local Port Forward):**
```bash
ssh -L 5432:database.internal:5432 bastion-host
```

**Breakdown:**
| Part | Meaning |
|------|---------|
| `-L` | Local port forward |
| `5432` (first) | Local port on your machine |
| `database.internal:5432` | Remote destination (from bastion's perspective) |
| `bastion-host` | The jump server you connect through |

**After running:** Connect to `localhost:5432` on your laptop → traffic goes through bastion → reaches database.internal:5432

**Use case:** Access a private database for debugging without exposing it to the internet.

---

### Q18: How do you check if a specific port is open on a remote server?

```bash
# Method 1: netcat
nc -zv remote-host 443 -w 5

# Method 2: telnet (if available)
telnet remote-host 443

# Method 3: curl (for HTTP ports)
curl -v --connect-timeout 5 http://remote-host:8080

# Method 4: /dev/tcp (bash built-in, no tools needed)
echo > /dev/tcp/remote-host/443 && echo "Port open" || echo "Port closed"

# Method 5: nmap (if installed)
nmap -p 443 remote-host
```

---

### Q19: What are VPC Flow Logs and when do you use them?

**Simple explanation:** VPC Flow Logs record metadata about every network connection in your VPC - like CCTV for your network.

**What they capture:** Source IP, Destination IP, Ports, Protocol, Action (ACCEPT/REJECT), Bytes transferred

**Sample flow log entry:**
```
2 123456789012 eni-abc123 10.0.1.5 10.0.2.10 54321 443 6 10 840 ACCEPT
```

**Reading the entry:**
- Source: 10.0.1.5, Port: 54321
- Destination: 10.0.2.10, Port: 443
- Protocol 6 = TCP
- 10 packets, 840 bytes
- Action: ACCEPT (allowed through)

**When to use:** "Traffic should work but doesn't" → Check Flow Logs for REJECT entries.

---

### Q20: What is the difference between public and private subnets?

| Feature | Public Subnet | Private Subnet |
|---------|---------------|----------------|
| Internet access (inbound) | Yes (via Internet Gateway) | No |
| Internet access (outbound) | Yes (direct) | Via NAT Gateway only |
| Route table | Has 0.0.0.0/0 → IGW | Has 0.0.0.0/0 → NAT GW |
| Use for | ALB, Bastion hosts, NAT GW | App servers, databases, workers |
| Public IP | Can have | Typically doesn't have |

---

### Q21: How does Kubernetes networking work (Pod-to-Pod, Pod-to-Service)?

**Pod-to-Pod:** Every pod gets its own IP. Pods can reach each other directly by IP (flat network - no NAT).

**Pod-to-Service:** Services provide a stable DNS name and IP for a group of pods.
```
Pod A → service-b.namespace.svc.cluster.local → kube-proxy → one of Service B's pods
```

**Key components:**
- **CNI plugin** (Calico/Flannel/AWS VPC CNI): Assigns IPs to pods
- **kube-proxy**: Programs iptables/IPVS rules for Service routing
- **CoreDNS**: Resolves service names to ClusterIP

---

### Q22: A health check is failing on a Load Balancer. How do you debug?

```bash
# Step 1: Check what health check is configured
aws elbv2 describe-target-health --target-group-arn <arn>

# Step 2: Simulate the health check from the instance itself
curl -v http://localhost:8080/health
# Must return 200 OK

# Step 3: Check if the app is listening
ss -tulnp | grep 8080

# Step 4: Check Security Group allows health check traffic
# ALB has its own SG → Target instance SG must allow from ALB SG

# Step 5: Check app logs for errors
journalctl -u myapp -f
docker logs <container-id>
```

**Common causes:** App crashed, wrong health check path, Security Group blocking ALB, app listening on 127.0.0.1 instead of 0.0.0.0.

---

### Q23: What is the difference between Layer 4 and Layer 7 load balancing?

| Feature | Layer 4 (Transport) | Layer 7 (Application) |
|---------|---------------------|----------------------|
| Sees | IP + Port | Full HTTP request (URL, headers, cookies) |
| Routing | Based on IP/port only | Based on URL path, hostname, headers |
| Speed | Very fast | Slightly slower (parses HTTP) |
| SSL | Pass-through possible | Terminates SSL (can inspect content) |
| AWS | NLB | ALB |
| Use case | TCP services, databases | Web apps, APIs, microservices |

---

### Q24: Explain the difference between iptables ACCEPT, DROP, and REJECT.

| Action | Behavior | Client Experience |
|--------|----------|-------------------|
| ACCEPT | Allow the packet through | Connection works normally |
| DROP | Silently discard the packet | Client sees "Connection timed out" (no response) |
| REJECT | Refuse and notify the client | Client sees "Connection refused" (immediate) |

**Production use:**
- **ACCEPT**: For allowed traffic
- **DROP**: For blocking attackers (don't reveal server exists)
- **REJECT**: For internal services (faster feedback for debugging)

```bash
# Example: Block an IP
iptables -A INPUT -s 203.0.113.50 -j DROP

# Example: Allow HTTP
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# View rules with packet counts
iptables -L -n -v --line-numbers
```

---

# 2. Linux

## 📝 Linux - 24 Interview Questions with Detailed Answers

### Q1: How do you check disk space and troubleshoot "disk full" issues?

```bash
# Check disk usage summary
df -h
# -h = human readable (shows GB/MB instead of bytes)

# Find which directories are consuming the most space
du -sh /var/* | sort -rh | head -10
# du = disk usage
# -s = summary (don't show subdirectories)
# -h = human readable
# sort -rh = sort by size, largest first
# head -10 = show top 10

# Find large files (>100MB)
find / -type f -size +100M -exec ls -lh {} \;

# Check inodes (sometimes disk shows space but inodes are full)
df -i
```

**Production scenario:** Jenkins builds fill up /var with old artifacts. Docker images fill /var/lib/docker.

**Solution:**
```bash
# Clean Docker
docker system prune -a --volumes

# Clean old journals
journalctl --vacuum-size=500M

# Clean old packages
apt-get autoremove && apt-get clean
```

---

### Q2: How do you find and kill a process consuming high CPU?

```bash
# Step 1: Identify the process
top -c
# Press 'P' to sort by CPU (already default)
# -c shows full command

# Step 2: Alternative - snapshot view
ps aux --sort=-%cpu | head -10
# aux = all users, user-oriented format, include processes without terminal
# --sort=-%cpu = sort by CPU descending

# Step 3: Get more details about the process
strace -p <PID> -c
# Shows what system calls the process is making

# Step 4: Kill the process
kill -15 <PID>    # Graceful shutdown (SIGTERM)
kill -9 <PID>     # Force kill (SIGKILL) - last resort
```

---

### Q3: Explain file permissions in Linux. What does chmod 755 mean?

```
Permission format: rwxrwxrwx
                   ↑   ↑   ↑
                 Owner Group Others

r=4 (read), w=2 (write), x=1 (execute)

chmod 755:
  7 = rwx (4+2+1) → Owner can read, write, execute
  5 = r-x (4+0+1) → Group can read and execute
  5 = r-x (4+0+1) → Others can read and execute
```

**Common permissions:**
| Permission | Number | Use Case |
|-----------|--------|----------|
| rwxr-xr-x | 755 | Scripts, directories |
| rw-r--r-- | 644 | Regular files, configs |
| rwx------ | 700 | Private scripts |
| rw------- | 600 | SSH private keys, secrets |

---

### Q4: How do you check system memory usage?

```bash
# Method 1: free command
free -h
#               total    used    free    shared  buff/cache   available
# Mem:          16Gi    4.2Gi    1.8Gi   512Mi    10.2Gi      11.0Gi

# Key insight: "available" is what matters, not "free"
# Linux uses free memory for cache (buff/cache) - this is normal!
# "available" = free + reclaimable cache

# Method 2: Check which process uses most memory
ps aux --sort=-%mem | head -10

# Method 3: Detailed view
cat /proc/meminfo | head -5
```

---

### Q5: What is the difference between soft link and hard link?

| Feature | Soft Link (Symbolic) | Hard Link |
|---------|---------------------|-----------|
| Command | `ln -s target link` | `ln target link` |
| Cross filesystem | Yes | No |
| Original deleted | Link breaks (dangling) | Link still works |
| Inode | Different inode | Same inode |
| Analogy | Shortcut/alias | Second name for same file |

**Production use of soft links:**
```bash
# Point /etc/nginx/sites-enabled to config file
ln -s /etc/nginx/sites-available/myapp.conf /etc/nginx/sites-enabled/

# Version switching
ln -sf /opt/java-17 /opt/java-current
```

---

### Q6: How do you view and manage system services?

```bash
# Check service status
systemctl status nginx

# Start/Stop/Restart
systemctl start nginx
systemctl stop nginx
systemctl restart nginx    # Full restart
systemctl reload nginx     # Reload config without downtime

# Enable at boot
systemctl enable nginx

# View service logs
journalctl -u nginx -f      # Follow live
journalctl -u nginx --since "1 hour ago"

# List all failed services
systemctl --failed
```

---

### Q7: How do you troubleshoot high load average on a server?

```bash
# Check load average
uptime
# Output: load average: 4.50, 3.20, 2.10
# These are 1-min, 5-min, 15-min averages
# Rule: If load > number of CPUs, system is overloaded

# Check number of CPUs
nproc
# Output: 4
# So load of 4.50 means system is slightly overloaded

# Find what's causing load
top -c
# Look at:
# %CPU - CPU-bound processes
# D state - processes waiting for disk I/O

# Check I/O wait specifically
iostat -x 1 5
# High %iowait = disk is the bottleneck

# Check which process is doing I/O
iotop
```

---

### Q8: How do you search for text in files?

```bash
# Search for text in files
grep -rn "database_url" /etc/myapp/
# -r = recursive (search subdirectories)
# -n = show line numbers
# "database_url" = text to find

# Case insensitive search
grep -rni "error" /var/log/

# Search and show context (lines before/after)
grep -B 3 -A 3 "Exception" app.log
# -B 3 = 3 lines Before match
# -A 3 = 3 lines After match

# Search with regex
grep -E "ERROR|FATAL|CRITICAL" /var/log/app.log

# Find files containing text
find /opt -name "*.yml" -exec grep -l "password" {} \;
```

---

### Q9: How do you schedule tasks with cron?

```bash
# Edit crontab
crontab -e

# Format: MIN HOUR DAY MONTH WEEKDAY COMMAND
# Examples:
*/5 * * * *  /scripts/health-check.sh       # Every 5 minutes
0 2 * * *    /scripts/backup.sh              # Daily at 2 AM
0 0 * * 0    /scripts/weekly-cleanup.sh      # Every Sunday midnight
0 */6 * * *  /scripts/sync-data.sh           # Every 6 hours

# View current crontab
crontab -l

# Important: Always redirect output in cron
*/5 * * * * /scripts/check.sh >> /var/log/check.log 2>&1
```

---

### Q10: How do you check and manage network interfaces?

```bash
# Show all interfaces
ip addr show

# Bring interface up/down
ip link set eth0 up
ip link set eth0 down

# Add an IP address
ip addr add 10.0.1.100/24 dev eth0

# Show routing table
ip route show

# Add a static route
ip route add 10.0.2.0/24 via 10.0.1.1 dev eth0
```

---

### Q11: How do you check open files and file descriptors?

```bash
# List open files for a process
lsof -p <PID>

# Check who's using a file
lsof /var/log/app.log

# Check who's using a port
lsof -i :8080

# Check system-wide limits
cat /proc/sys/fs/file-max

# Check per-process limits
ulimit -n
# Output: 1024 (default, often too low for production)

# Increase limit (temporarily)
ulimit -n 65535
```

**Production issue:** "Too many open files" error → Increase file descriptor limits in `/etc/security/limits.conf`.

---

### Q12: How do you manage users and groups?

```bash
# Create user
useradd -m -s /bin/bash deploy
# -m = create home directory
# -s = set default shell

# Set password
passwd deploy

# Add user to group
usermod -aG docker deploy
# -a = append (don't remove from other groups)
# -G = supplementary group

# Check user's groups
groups deploy
id deploy

# Switch user
su - deploy

# Give sudo access
echo "deploy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/deploy
```

---

### Q13: How do you check and rotate logs?

```bash
# View last 100 lines
tail -100 /var/log/app.log

# Follow logs in real-time
tail -f /var/log/app.log

# View logs with timestamp filter
journalctl --since "2024-01-15 10:00:00" --until "2024-01-15 11:00:00"

# Configure logrotate (/etc/logrotate.d/myapp)
cat <<EOF > /etc/logrotate.d/myapp
/var/log/myapp/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    postrotate
        systemctl reload myapp
    endscript
}
EOF
```

---

### Q14: How do you transfer files between servers?

```bash
# SCP (Secure Copy)
scp file.tar.gz user@remote:/tmp/
scp -r directory/ user@remote:/opt/

# Rsync (better for large/repeated transfers)
rsync -avz --progress /local/path/ user@remote:/remote/path/
# -a = archive (preserves permissions, timestamps)
# -v = verbose
# -z = compress during transfer
# --progress = show progress

# Between two remote servers (via your machine)
rsync -avz user1@server1:/data/ user2@server2:/backup/
```

---

### Q15: What is /proc filesystem and how is it useful?

```bash
# /proc is a virtual filesystem - shows kernel/process info in real-time

# CPU info
cat /proc/cpuinfo | grep "model name" | head -1

# Memory info
cat /proc/meminfo | head -5

# Process info (for PID 1234)
cat /proc/1234/status     # Process status
cat /proc/1234/cmdline    # Full command
ls -la /proc/1234/fd      # Open file descriptors

# System uptime in seconds
cat /proc/uptime

# Kernel parameters
cat /proc/sys/net/ipv4/ip_forward   # Is IP forwarding enabled?
```

---

### Q16: How do you troubleshoot SSH connection issues?

```bash
# Verbose SSH (shows exactly what's happening)
ssh -vvv user@host

# Common issues and fixes:
# 1. Permission denied (publickey)
chmod 600 ~/.ssh/id_rsa          # Fix key permissions
chmod 700 ~/.ssh                  # Fix .ssh directory permissions

# 2. Host key verification failed
ssh-keygen -R hostname           # Remove old host key

# 3. Connection timeout
# Check Security Group / firewall allows port 22

# 4. Check SSH config on server
cat /etc/ssh/sshd_config | grep -v "^#" | grep -v "^$"
# Look for: PermitRootLogin, PasswordAuthentication, AllowUsers
```

---

### Q17: How do you mount filesystems and manage storage?

```bash
# List block devices
lsblk

# Check filesystem type
blkid /dev/xvdf

# Create filesystem
mkfs.ext4 /dev/xvdf

# Mount
mount /dev/xvdf /data

# Persistent mount (survives reboot)
echo "/dev/xvdf /data ext4 defaults 0 2" >> /etc/fstab

# Extend LVM volume
lvextend -l +100%FREE /dev/mapper/vg-lv
resize2fs /dev/mapper/vg-lv
```

---

### Q18: How do you check system boot and hardware issues?

```bash
# Boot logs
dmesg | tail -50
journalctl -b    # Current boot logs

# Check for hardware errors
dmesg | grep -i error
dmesg | grep -i "out of memory"

# Check last reboot
last reboot | head -5

# Check why system rebooted
journalctl --list-boots
journalctl -b -1    # Previous boot logs
```

---

### Q19: How do you secure a Linux server (basic hardening)?

```bash
# 1. Update packages
apt update && apt upgrade -y

# 2. Disable root SSH login
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# 3. Use key-based auth only
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# 4. Configure firewall
ufw allow 22/tcp
ufw allow 443/tcp
ufw enable

# 5. Disable unused services
systemctl disable --now cups bluetooth

# 6. Set automatic security updates
apt install unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades
```

---

### Q20: What is swap and when should you use it?

```bash
# Check swap usage
swapon --show
free -h

# Create swap file (2GB)
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Make persistent
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

# Adjust swappiness (how eagerly Linux uses swap)
cat /proc/sys/vm/swappiness     # Default: 60
echo "vm.swappiness=10" >> /etc/sysctl.conf  # Prefer RAM over swap
sysctl -p
```

**Production note:** High swap usage = server needs more RAM. Swap is emergency overflow, not a RAM replacement.

---

### Q21: How do you use awk and sed for text processing?

```bash
# AWK - Column extraction
# Print 5th column of top memory-consuming processes
ps aux | sort -k4 -rn | head -5 | awk '{print $1, $4, $11}'
# $1=user, $4=%mem, $11=command

# SED - Text replacement
# Replace all occurrences in file
sed -i 's/old_value/new_value/g' config.yml
# -i = edit in place
# s/ = substitute
# /g = global (all occurrences)

# Delete lines containing pattern
sed -i '/^#/d' config.yml    # Remove comment lines

# AWK - Sum a column
awk '{sum+=$1} END {print sum}' numbers.txt
```

---

### Q22: How do you analyze network connections on a server?

```bash
# Count connections by state
ss -tan | awk '{print $1}' | sort | uniq -c | sort -rn
# Common output:
# 150 ESTAB       → Active connections
# 30  TIME-WAIT   → Connections closing (normal)
# 5   CLOSE-WAIT  → App not closing connections (potential leak!)

# Count connections per IP
ss -tan | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -rn | head -10

# Check for connection floods (possible DDoS)
ss -tan state established | wc -l
```

---

### Q23: What is the difference between /etc/hosts, /etc/resolv.conf, and /etc/nsswitch.conf?

| File | Purpose | Example |
|------|---------|---------|
| `/etc/hosts` | Local DNS override (hostname → IP mapping) | `10.0.1.5 db.internal` |
| `/etc/resolv.conf` | Which DNS servers to query | `nameserver 10.0.0.2` |
| `/etc/nsswitch.conf` | Order of name resolution | `hosts: files dns` (check /etc/hosts first, then DNS) |

**Production use:** Add internal service entries to `/etc/hosts` as a quick fix while DNS is being configured.

---

### Q24: How do you troubleshoot "Permission Denied" errors?

```bash
# Step 1: Check file permissions
ls -la /path/to/file

# Step 2: Check ownership
stat /path/to/file

# Step 3: Check if running as correct user
whoami
id

# Step 4: Check directory permissions (need execute to enter)
namei -l /path/to/file
# Shows permissions for EVERY directory in the path

# Step 5: Check for SELinux/AppArmor
getenforce          # SELinux status
ls -Z /path/to/file # SELinux context

# Common fixes:
chown deploy:deploy /path/to/file
chmod 755 /path/to/directory
chmod 644 /path/to/file
```

---

# 3. Jenkins

## 📝 Jenkins - 24 Interview Questions with Detailed Answers

### Q1: What is Jenkins and how does it work?

**Simple explanation:** Jenkins is an automation server that runs your CI/CD pipelines - it builds code, runs tests, and deploys applications automatically when developers push code.

**How it works:**
1. Developer pushes code to Git
2. Git webhook triggers Jenkins
3. Jenkins pulls the code
4. Runs build steps (compile, test, package)
5. Deploys to target environment
6. Notifies team of result

---

### Q2: Explain Jenkinsfile (Declarative Pipeline) with a production example.

```groovy
pipeline {
    agent any                          // Run on any available agent

    environment {
        DOCKER_REGISTRY = 'ecr.aws/mycompany'
        APP_NAME = 'payment-service'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/company/app.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                sh """
                    docker build -t ${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_NUMBER} .
                    docker push ${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_NUMBER}
                """
            }
        }

        stage('Deploy to K8s') {
            steps {
                sh """
                    kubectl set image deployment/${APP_NAME} \
                        ${APP_NAME}=${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_NUMBER}
                """
            }
        }
    }

    post {
        failure {
            slackSend channel: '#alerts', message: "Build FAILED: ${env.JOB_NAME}"
        }
        success {
            slackSend channel: '#deployments', message: "Deployed ${APP_NAME}:${BUILD_NUMBER}"
        }
    }
}
```

---

### Q3: What is the difference between Declarative and Scripted Pipeline?

| Feature | Declarative | Scripted |
|---------|-------------|----------|
| Syntax | Structured (pipeline → stages → steps) | Free-form Groovy |
| Learning curve | Easier for beginners | Requires Groovy knowledge |
| Flexibility | Limited but sufficient | Maximum flexibility |
| Error handling | Built-in post{} blocks | try-catch blocks |
| Recommended | Yes (modern standard) | For complex logic only |

---

### Q4: How do you configure Jenkins agents (master-agent architecture)?

**Why agents?** Master handles UI/scheduling; agents execute builds. This distributes load and allows builds on different OS/environments.

**Types:**
- **SSH Agent**: Master SSHs into agent to run jobs
- **JNLP Agent**: Agent connects TO master (good for firewalled networks)
- **Docker Agent**: Spins up containers as temporary agents
- **Kubernetes Agent**: Creates pods as dynamic agents

```groovy
// Dynamic agent per stage
pipeline {
    agent none
    stages {
        stage('Build') {
            agent { docker { image 'maven:3.8' } }
            steps { sh 'mvn package' }
        }
        stage('Test') {
            agent { docker { image 'python:3.11' } }
            steps { sh 'pytest' }
        }
    }
}
```

---

### Q5: Jenkins build is failing. How do you troubleshoot?

```bash
# Step 1: Check console output in Jenkins UI
# Look for the FIRST error (scroll up from the failure)

# Step 2: Common issues:
# a) "Permission denied" → Agent doesn't have permissions
# b) "Command not found" → Tool not installed on agent
# c) "Out of memory" → Agent needs more resources
# d) "Cannot connect to Docker" → Jenkins user not in docker group
# e) "Tests failed" → Check test reports

# Step 3: Check agent connectivity
# Jenkins UI → Manage Jenkins → Nodes → Click agent → Check logs

# Step 4: Check disk space on agent
df -h /var/lib/jenkins

# Step 5: Check Jenkins system logs
# Manage Jenkins → System Log → All Jenkins Logs
```

---

### Q6: How do you handle secrets/credentials in Jenkins?

```groovy
pipeline {
    agent any
    environment {
        // Binds Jenkins credential to variable
        DB_PASSWORD = credentials('db-password-id')
        AWS_CREDS = credentials('aws-access-keys')
    }
    stages {
        stage('Deploy') {
            steps {
                // Credentials are masked in console output
                sh 'echo $DB_PASSWORD'  // Shows ****
                
                // Using withCredentials block
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                }
            }
        }
    }
}
```

**Best practices:**
- Never hardcode secrets in Jenkinsfile
- Use Jenkins Credentials Store or external secret manager (Vault, AWS Secrets Manager)
- Mask passwords in logs
- Rotate credentials regularly

---

### Q7: What is a Jenkins Shared Library?

A reusable code library that multiple pipelines can call, avoiding duplication.

```groovy
// vars/deployToK8s.groovy (in shared library repo)
def call(Map config) {
    sh """
        kubectl set image deployment/${config.app} \
            ${config.app}=${config.image}:${config.tag} \
            -n ${config.namespace}
    """
}

// Jenkinsfile (in app repo)
@Library('my-shared-library') _

pipeline {
    stages {
        stage('Deploy') {
            steps {
                deployToK8s(
                    app: 'payment-service',
                    image: 'ecr.aws/mycompany/payment',
                    tag: env.BUILD_NUMBER,
                    namespace: 'production'
                )
            }
        }
    }
}
```

---

### Q8: How do you trigger Jenkins jobs?

| Trigger | Configuration | Use Case |
|---------|---------------|----------|
| Webhook | GitHub webhook → Jenkins URL | Build on every push |
| Poll SCM | `pollSCM('H/5 * * * *')` | Check for changes every 5 min |
| Cron | `cron('0 2 * * *')` | Nightly builds |
| Upstream | `upstream('build-job')` | Build after another job completes |
| Manual | No trigger configured | Production deployments |
| API | `curl -X POST jenkins/job/name/build` | External system triggers |

---

### Q9: How do you implement parallel stages in Jenkins?

```groovy
stage('Tests') {
    parallel {
        stage('Unit Tests') {
            agent { docker { image 'maven:3.8' } }
            steps { sh 'mvn test' }
        }
        stage('Integration Tests') {
            agent { docker { image 'maven:3.8' } }
            steps { sh 'mvn verify -Pintegration' }
        }
        stage('Security Scan') {
            agent { docker { image 'aquasec/trivy' } }
            steps { sh 'trivy fs .' }
        }
    }
}
```

---

### Q10: How do you backup Jenkins?

```bash
# Jenkins stores everything in JENKINS_HOME (usually /var/lib/jenkins)

# Critical items to backup:
# - config.xml (main config)
# - jobs/*/config.xml (job configurations)
# - credentials.xml (encrypted credentials)
# - users/ (user configs)
# - secrets/ (encryption keys)
# - plugins/ (installed plugins)

# Simple backup script
#!/bin/bash
JENKINS_HOME=/var/lib/jenkins
BACKUP_DIR=/backup/jenkins/$(date +%Y%m%d)

mkdir -p $BACKUP_DIR
tar -czf $BACKUP_DIR/jenkins-backup.tar.gz \
    --exclude='$JENKINS_HOME/workspace' \
    --exclude='$JENKINS_HOME/.cache' \
    $JENKINS_HOME

# Upload to S3
aws s3 cp $BACKUP_DIR/jenkins-backup.tar.gz s3://company-backups/jenkins/
```

---

### Q11: What is Blue Ocean in Jenkins?

A modern UI plugin for Jenkins that provides visual pipeline editor and better pipeline visualization. Shows each stage as a visual step with clear pass/fail indicators.

---

### Q12: How do you configure Jenkins for high availability?

- Use **external storage** for JENKINS_HOME (EFS/NFS)
- Run Jenkins behind a **Load Balancer**
- Use **Configuration as Code (JCasC)** plugin for reproducible setup
- Store jobs as **Jenkinsfiles in Git** (not in Jenkins)
- Use **dynamic agents** (Kubernetes/Docker) - no permanent agents to manage
- Regular **automated backups**

---

### Q13: How do you handle pipeline failures and retries?

```groovy
stage('Deploy') {
    steps {
        retry(3) {
            sh './deploy.sh'
        }
    }
    post {
        failure {
            // Retry with longer timeout
            timeout(time: 5, unit: 'MINUTES') {
                sh './deploy.sh --retry'
            }
        }
    }
}

// Timeout for entire stage
stage('Integration Tests') {
    options {
        timeout(time: 30, unit: 'MINUTES')
    }
    steps {
        sh 'mvn verify'
    }
}
```

---

### Q14: What is Jenkins Configuration as Code (JCasC)?

```yaml
# jenkins.yaml - entire Jenkins config in code
jenkins:
  systemMessage: "Jenkins configured via JCasC"
  numExecutors: 0    # No builds on master
  securityRealm:
    ldap:
      configurations:
        - server: ldap.company.com
  nodes:
    - permanent:
        name: "build-agent-1"
        remoteFS: "/home/jenkins"
        launcher:
          ssh:
            host: "agent1.internal"
            credentialsId: "agent-ssh-key"

credentials:
  system:
    domainCredentials:
      - credentials:
          - string:
              id: "docker-token"
              secret: "${DOCKER_TOKEN}"
```

---

### Q15: How do you optimize Jenkins pipeline performance?

1. **Parallel stages** for independent tasks
2. **Docker layer caching** for faster builds
3. **Artifact caching** (Maven .m2, npm node_modules)
4. **Skip unnecessary stages** with `when` conditions
5. **Use lightweight agents** (spin up only when needed)
6. **Clean workspace** only when necessary (not every build)

```groovy
stage('Build') {
    when {
        changeset "src/**"  // Only build when source changes
    }
    steps {
        sh 'mvn package -DskipTests'
    }
}
```

---

### Q16: How do you implement approval gates in Jenkins?

```groovy
stage('Deploy to Production') {
    steps {
        input message: 'Deploy to production?', 
              ok: 'Deploy',
              submitter: 'tech-leads,devops-team'
        sh './deploy-prod.sh'
    }
}
```

---

### Q17: How do you handle multi-branch pipelines?

```groovy
// Automatically discovers branches with Jenkinsfiles
// Configure in Jenkins UI: New Item → Multibranch Pipeline

// Jenkinsfile with branch-specific behavior
stage('Deploy') {
    when {
        branch 'main'
    }
    steps {
        sh './deploy-production.sh'
    }
}

stage('Deploy to Staging') {
    when {
        branch 'develop'
    }
    steps {
        sh './deploy-staging.sh'
    }
}
```

---

### Q18: How do you integrate Jenkins with Docker?

```groovy
pipeline {
    agent {
        docker {
            image 'node:18-alpine'
            args '-v /tmp/.npm:/root/.npm'  // Cache npm packages
        }
    }
    stages {
        stage('Install') { steps { sh 'npm ci' } }
        stage('Test') { steps { sh 'npm test' } }
        stage('Build Docker Image') {
            agent any  // Need Docker socket for this
            steps {
                sh 'docker build -t myapp:${BUILD_NUMBER} .'
                sh 'docker push registry/myapp:${BUILD_NUMBER}'
            }
        }
    }
}
```

---

### Q19: What are Jenkins plugins you must know?

| Plugin | Purpose |
|--------|---------|
| Pipeline | Enables Jenkinsfile-based pipelines |
| Git | Git integration |
| Docker Pipeline | Docker agent support |
| Kubernetes | K8s dynamic agents |
| Credentials Binding | Secure credential access |
| Blue Ocean | Modern UI |
| Slack Notification | Alert to Slack |
| JUnit | Test result parsing |
| SonarQube | Code quality |
| OWASP Dependency-Check | Security scanning |

---

### Q20: How do you set up Jenkins in Docker/Kubernetes?

```yaml
# Kubernetes Deployment for Jenkins
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      containers:
      - name: jenkins
        image: jenkins/jenkins:lts
        ports:
        - containerPort: 8080
        - containerPort: 50000
        volumeMounts:
        - name: jenkins-home
          mountPath: /var/jenkins_home
      volumes:
      - name: jenkins-home
        persistentVolumeClaim:
          claimName: jenkins-pvc
```

---

### Q21: How do you clean old builds and artifacts?

```groovy
// In Jenkinsfile
pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        disableConcurrentBuilds()
    }
}

// Cleanup script (cron job)
#!/bin/bash
# Remove builds older than 30 days
find /var/lib/jenkins/jobs/*/builds -maxdepth 1 -mtime +30 -exec rm -rf {} \;

# Remove old Docker images on agents
docker image prune -a --filter "until=168h" -f
```

---

### Q22: How do you implement environment-specific deployments?

```groovy
pipeline {
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'production'])
    }
    stages {
        stage('Deploy') {
            steps {
                script {
                    def config = [
                        dev:        [cluster: 'dev-cluster', replicas: 1],
                        staging:    [cluster: 'staging-cluster', replicas: 2],
                        production: [cluster: 'prod-cluster', replicas: 5]
                    ]
                    def env = config[params.ENVIRONMENT]
                    sh """
                        kubectl config use-context ${env.cluster}
                        kubectl scale deployment/myapp --replicas=${env.replicas}
                    """
                }
            }
        }
    }
}
```

---

### Q23: How do you secure Jenkins?

1. **Enable authentication** (LDAP/AD/SAML)
2. **Role-based access control** (RBAC plugin)
3. **Run Jenkins behind HTTPS** (reverse proxy with Nginx)
4. **Disable script console** for non-admins
5. **Audit logging** for all actions
6. **Keep plugins updated** (security vulnerabilities are common)
7. **No builds on master** (set executors to 0)
8. **Credential management** (use Jenkins credential store)

---

### Q24: What is Jenkins Pipeline as Code and why is it important?

**Pipeline as Code** = Storing your entire CI/CD pipeline definition in a `Jenkinsfile` in your Git repository.

**Benefits:**
- **Version controlled** → Track changes to pipeline
- **Code review** → Pipeline changes go through PRs
- **Reproducible** → Anyone can see exactly what the pipeline does
- **Branch-specific** → Each branch can have its own pipeline
- **Disaster recovery** → Pipeline is in Git, not lost if Jenkins dies

---

# 4. CI/CD

## 📝 CI/CD - 24 Interview Questions with Detailed Answers

### Q1: What is CI/CD? Explain with a real-world example.

**CI (Continuous Integration):** Developers merge code to main branch frequently (multiple times daily). Each merge triggers automated build and tests.

**CD (Continuous Delivery):** Code is always in a deployable state. Deployment to production requires manual approval.

**CD (Continuous Deployment):** Every change that passes tests is automatically deployed to production (no manual approval).

**Real-world flow:**
```
Developer pushes code → Build → Unit Tests → Integration Tests → 
Security Scan → Build Docker Image → Deploy to Staging → 
Automated E2E Tests → Manual Approval → Deploy to Production
              CI                              CD
```

---

### Q2: What is the difference between Continuous Delivery and Continuous Deployment?

| Aspect | Continuous Delivery | Continuous Deployment |
|--------|--------------------|--------------------|
| Production deploy | Manual approval needed | Fully automated |
| Risk | Lower (human check) | Higher (requires excellent tests) |
| Speed | Slower (waiting for approval) | Fastest possible |
| Maturity needed | Medium | High (requires strong test coverage) |
| Common in | Most companies | Netflix, Facebook-scale companies |

---

### Q3: Design a complete CI/CD pipeline for a microservice.

```
┌─────────────────────────────────────────────────────────────────┐
│                     CI/CD Pipeline                                │
├─────────┬──────────┬──────────┬──────────┬──────────┬──────────┤
│ Checkout│  Build   │  Test    │  Scan    │  Package │  Deploy  │
│         │          │          │          │          │          │
│ Git pull│ Compile  │ Unit     │ SAST     │ Docker   │ Dev      │
│ Deps    │ Lint     │ Integra- │ DAST     │ Build    │ Staging  │
│ install │ Format   │ tion     │ Secrets  │ Push to  │ Prod     │
│         │          │ Coverage │ Deps     │ Registry │          │
└─────────┴──────────┴──────────┴──────────┴──────────┴──────────┘
```

---

### Q4: What are deployment strategies? Explain each.

| Strategy | How It Works | Rollback Speed | Risk | Use Case |
|----------|-------------|----------------|------|----------|
| **Rolling** | Replace instances gradually | Medium | Medium | Default K8s |
| **Blue-Green** | Run two identical environments, switch traffic | Instant | Low | Critical services |
| **Canary** | Send small % of traffic to new version | Fast | Lowest | High-traffic apps |
| **Recreate** | Kill all old, start new | Slow | High | Dev environments |
| **A/B Testing** | Route by user attributes | Fast | Low | Feature experiments |

---

### Q5: How do you implement rollback in CI/CD?

```bash
# Kubernetes rollback
kubectl rollout undo deployment/myapp
kubectl rollout undo deployment/myapp --to-revision=3

# Docker rollback (re-deploy previous image tag)
kubectl set image deployment/myapp myapp=registry/myapp:previous-tag

# Automated rollback based on health
# In Kubernetes:
spec:
  strategy:
    rollingUpdate:
      maxUnavailable: 0
      maxSurge: 1
  minReadySeconds: 30
  progressDeadlineSeconds: 120  # Auto-rollback if not ready in 2 min
```

---

### Q6: What is GitOps and how does it relate to CI/CD?

**GitOps** = Git is the single source of truth for infrastructure AND application state.

**Principle:** "If it's not in Git, it doesn't exist."

**Tools:** ArgoCD, Flux

**Flow:**
```
Developer pushes code → CI builds image → Updates manifest in Git →
ArgoCD detects change → Deploys to Kubernetes
```

**Benefits:** Full audit trail, easy rollback (git revert), declarative state.

---

### Q7: How do you handle database migrations in CI/CD?

```bash
# Approach: Run migrations as part of deployment (before app starts)

# Kubernetes Job:
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migration
spec:
  template:
    spec:
      containers:
      - name: migration
        image: myapp:latest
        command: ["python", "manage.py", "migrate"]
      restartPolicy: Never
```

**Best practices:**
- Migrations must be backward-compatible (old app + new schema works)
- Never drop columns immediately (deprecate → deploy new code → then drop)
- Use migration tools (Flyway, Alembic, Liquibase)

---

### Q8: What is artifact management in CI/CD?

**Artifacts** = Build outputs (Docker images, JARs, binaries, packages)

| Tool | Artifact Type |
|------|--------------|
| Docker Registry (ECR, Docker Hub) | Container images |
| Nexus / Artifactory | JARs, npm packages, Python wheels |
| S3 | Build outputs, logs, reports |

**Best practices:**
- Tag with build number (not `latest`)
- Scan for vulnerabilities before storing
- Set retention policies (delete old artifacts)
- Use immutable tags (never overwrite)

---

### Q9: How do you implement feature flags in CI/CD?

Feature flags decouple deployment from release:
```python
# Deploy code to production but hide feature behind flag
if feature_flags.is_enabled('new-checkout', user_id=request.user.id):
    return new_checkout_flow()
else:
    return old_checkout_flow()
```

**Benefits:** Deploy anytime, enable for specific users, instant rollback (just disable flag).

**Tools:** LaunchDarkly, Unleash, Flagsmith.

---

### Q10: What is pipeline security (DevSecOps)?

```
Code → SAST → Build → Image Scan → Deploy → DAST → Monitor

SAST (Static Analysis): SonarQube, Semgrep - scans code
SCA (Dependency Scan): Snyk, Dependabot - checks libraries
Image Scan: Trivy, Grype - scans Docker images
Secret Scan: GitLeaks, TruffleHog - finds leaked secrets
DAST (Dynamic): OWASP ZAP - tests running application
```

---

### Q11: How do you handle environment-specific configurations?

```yaml
# Use ConfigMaps/Secrets in K8s per environment
# dev/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DATABASE_HOST: "dev-db.internal"
  LOG_LEVEL: "debug"

# prod/configmap.yaml  
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DATABASE_HOST: "prod-db.internal"
  LOG_LEVEL: "info"
```

**Rule:** Same Docker image across ALL environments. Only config changes.

---

### Q12: What are CI/CD best practices?

1. **Fast feedback** → Run quick tests first, slow tests later
2. **Fail fast** → Stop pipeline on first failure
3. **Immutable artifacts** → Same image from dev to prod
4. **Trunk-based development** → Short-lived branches, frequent merges
5. **Automated everything** → No manual steps in pipeline
6. **Pipeline as code** → Jenkinsfile/GitHub Actions YAML in repo
7. **Secret management** → Never store secrets in code
8. **Monitoring deployments** → Watch error rates after deploy
9. **Rollback capability** → Always be able to undo
10. **Test in production-like environments** → Staging mirrors production

---

### Q13: How do you handle monorepo CI/CD?

```yaml
# Only build what changed
# GitHub Actions example:
on:
  push:
    paths:
      - 'services/payment/**'

# Or detect changes dynamically
steps:
  - name: Detect changes
    id: changes
    run: |
      CHANGED=$(git diff --name-only HEAD~1 | grep "^services/" | cut -d/ -f2 | sort -u)
      echo "services=$CHANGED" >> $GITHUB_OUTPUT
```

---

### Q14: What is the difference between GitHub Actions and Jenkins?

| Feature | Jenkins | GitHub Actions |
|---------|---------|----------------|
| Hosting | Self-hosted (or managed) | Cloud-hosted by GitHub |
| Config | Jenkinsfile (Groovy) | YAML files |
| Agents | Self-managed | GitHub-provided or self-hosted |
| Plugins | 1800+ plugins | Marketplace actions |
| Cost | Free (infra cost) | Free tier + pay per minute |
| Best for | Enterprise, complex pipelines | GitHub-native projects |

---

### Q15: How do you test CI/CD pipelines?

1. **Lint pipeline files** (`yamllint`, Jenkins pipeline linter)
2. **Run pipelines on feature branches** first
3. **Use staging/test environments** before production
4. **Monitor pipeline metrics** (success rate, duration)
5. **Integration tests** that test the pipeline itself

---

### Q16: How do you handle secrets rotation in CI/CD?

- Store secrets in external secret managers (Vault, AWS Secrets Manager)
- Pipelines fetch secrets at runtime (never stored in pipeline config)
- Automate rotation with lambda/cron
- Use short-lived credentials (IAM roles, OIDC tokens)

---

### Q17: What is a canary deployment? How do you implement it?

```yaml
# Using Istio VirtualService
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: myapp
spec:
  http:
  - route:
    - destination:
        host: myapp
        subset: stable
      weight: 90        # 90% to current version
    - destination:
        host: myapp
        subset: canary
      weight: 10        # 10% to new version
```

**Promotion criteria:** Error rate < 1%, latency p99 < 500ms, no crashes. If criteria met → shift more traffic. If not → rollback.

---

### Q18: How do you reduce CI/CD pipeline execution time?

1. **Caching** (dependencies, Docker layers)
2. **Parallel execution** (tests, builds)
3. **Skip unchanged** (only build affected services)
4. **Use faster runners** (more CPU/RAM)
5. **Optimize Docker builds** (multi-stage, layer ordering)
6. **Pre-built base images** (don't install deps every time)

---

### Q19: What is Infrastructure as Code (IaC) in CI/CD?

Using code (Terraform, CloudFormation, Pulumi) to define and deploy infrastructure through the same pipeline as application code.

```
IaC Pipeline: Code change → Plan → Review → Apply → Verify
```

---

### Q20: How do you implement CI/CD for Kubernetes?

```
Code Push → Build Image → Push to Registry → Update K8s Manifests →
ArgoCD syncs → K8s applies changes → Health checks → Done
```

---

### Q21: What are CI/CD metrics you should track?

| Metric | Target | Why |
|--------|--------|-----|
| Deployment frequency | Multiple per day | Agility |
| Lead time for changes | < 1 hour | Speed |
| Change failure rate | < 5% | Quality |
| Mean time to recovery | < 1 hour | Resilience |
| Pipeline duration | < 15 min | Developer experience |
| Test coverage | > 80% | Confidence |

---

### Q22: How do you handle multi-environment deployments?

```
Feature branch → Dev (auto) → Staging (auto) → Production (manual approval)

Each environment has:
- Its own K8s namespace or cluster
- Its own config (ConfigMaps, Secrets)
- Same Docker image (different configs only)
```

---

### Q23: What is a CI/CD anti-pattern?

1. **Long-lived branches** → Merge conflicts, integration hell
2. **Manual steps** → Human error, delays
3. **Deploying on Fridays** → Nobody wants to fix issues over weekend
4. **No rollback plan** → Stuck with broken deployment
5. **Testing in production only** → Users find bugs first
6. **Snowflake environments** → "Works in staging, fails in prod"

---

### Q24: How do you implement zero-downtime deployments?

Requirements:
1. **Health checks** → Load balancer removes unhealthy instances
2. **Rolling updates** → Replace gradually, never all at once
3. **Graceful shutdown** → Handle in-flight requests before stopping
4. **Database backward compatibility** → Old and new code work with same schema
5. **Connection draining** → Wait for existing connections to complete

```yaml
# Kubernetes zero-downtime config
spec:
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0  # Never have fewer pods than desired
  template:
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: app
        readinessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 10
          periodSeconds: 5
        lifecycle:
          preStop:
            exec:
              command: ["sleep", "15"]  # Wait for LB to deregister
```

---

# 5. Python Scripting

## 📝 Python - 24 Interview Questions with Production Scripts

### Q1: Write a health check script that monitors multiple services.

```python
#!/usr/bin/env python3
"""
Health Check Script - Monitors multiple services and alerts on failure.
Used in production as a cron job or monitoring sidecar.
"""

import requests          # Library to make HTTP calls (like curl)
import smtplib           # Library to send emails
import time              # For timestamps and delays
import json              # To work with JSON data
from datetime import datetime  # For human-readable timestamps

# List of services to monitor - add your services here
SERVICES = [
    {"name": "Payment API", "url": "http://payment:8080/health", "timeout": 5},
    {"name": "User Service", "url": "http://users:8080/health", "timeout": 5},
    {"name": "Order Service", "url": "http://orders:8080/health", "timeout": 5},
]

def check_service(service):
    """
    Check if a single service is healthy.
    Returns a dict with service name, status, and response time.
    """
    try:
        # Send GET request to the health endpoint
        # timeout=service["timeout"] → don't wait more than 5 seconds
        start = time.time()
        response = requests.get(service["url"], timeout=service["timeout"])
        elapsed = round(time.time() - start, 3)
        
        # HTTP 200 means healthy, anything else is a problem
        if response.status_code == 200:
            return {"name": service["name"], "status": "UP", "response_time": elapsed}
        else:
            return {"name": service["name"], "status": "DOWN", 
                    "error": f"HTTP {response.status_code}", "response_time": elapsed}
    
    except requests.exceptions.Timeout:
        # Service took too long to respond
        return {"name": service["name"], "status": "DOWN", "error": "Timeout"}
    
    except requests.exceptions.ConnectionError:
        # Cannot connect at all (service crashed or network issue)
        return {"name": service["name"], "status": "DOWN", "error": "Connection refused"}
    
    except Exception as e:
        # Any unexpected error
        return {"name": service["name"], "status": "DOWN", "error": str(e)}


def send_alert(failed_services):
    """Send alert when services are down."""
    message = f"🚨 ALERT: {len(failed_services)} service(s) DOWN at {datetime.now()}\n\n"
    for svc in failed_services:
        message += f"  ❌ {svc['name']}: {svc.get('error', 'Unknown')}\n"
    
    print(message)  # In production: send to Slack, PagerDuty, email
    # Example: requests.post(SLACK_WEBHOOK_URL, json={"text": message})


def main():
    """Main function - runs health checks and alerts if any fail."""
    print(f"=== Health Check at {datetime.now()} ===")
    
    results = []
    for service in SERVICES:
        result = check_service(service)
        results.append(result)
        status_icon = "✅" if result["status"] == "UP" else "❌"
        print(f"  {status_icon} {result['name']}: {result['status']}")
    
    # Find all failed services
    failed = [r for r in results if r["status"] == "DOWN"]
    
    if failed:
        send_alert(failed)
        exit(1)  # Exit with error code (useful for monitoring tools)
    else:
        print("All services healthy! ✅")
        exit(0)


if __name__ == "__main__":
    main()
```

---

### Q2: Write a script to parse logs and find errors.

```python
#!/usr/bin/env python3
"""
Log Parser - Finds errors in log files and generates summary report.
Used for: Daily log analysis, incident investigation.
"""

import re               # Regular expressions - pattern matching in text
from collections import Counter  # Counts occurrences of items
from datetime import datetime

def parse_log_file(filepath):
    """
    Read a log file and extract all ERROR/FATAL lines.
    Returns list of error entries with timestamp and message.
    """
    errors = []
    
    # Pattern to match log lines like: 2024-01-15 10:30:45 ERROR [ServiceName] Message
    pattern = re.compile(
        r'(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\s+(ERROR|FATAL)\s+\[(.+?)\]\s+(.*)'
    )
    # Breakdown:
    # (\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) → Captures timestamp
    # (ERROR|FATAL) → Captures log level
    # \[(.+?)\] → Captures service/class name in brackets
    # (.*) → Captures the error message
    
    with open(filepath, 'r') as f:
        for line_num, line in enumerate(f, 1):
            match = pattern.search(line)
            if match:
                errors.append({
                    "line": line_num,
                    "timestamp": match.group(1),
                    "level": match.group(2),
                    "source": match.group(3),
                    "message": match.group(4)
                })
    
    return errors


def generate_report(errors):
    """Generate a summary report of errors."""
    if not errors:
        print("✅ No errors found!")
        return
    
    print(f"\n🚨 Found {len(errors)} errors\n")
    
    # Count errors by source
    sources = Counter(e["source"] for e in errors)
    print("Top error sources:")
    for source, count in sources.most_common(5):
        print(f"  {source}: {count} errors")
    
    # Count error messages (group similar errors)
    messages = Counter(e["message"][:80] for e in errors)
    print("\nTop error messages:")
    for msg, count in messages.most_common(5):
        print(f"  [{count}x] {msg}")
    
    # Show most recent errors
    print("\nMost recent errors:")
    for error in errors[-5:]:
        print(f"  [{error['timestamp']}] {error['source']}: {error['message'][:100]}")


if __name__ == "__main__":
    import sys
    filepath = sys.argv[1] if len(sys.argv) > 1 else "/var/log/app.log"
    errors = parse_log_file(filepath)
    generate_report(errors)
```

---

### Q3: Write a script to clean up old Docker images.

```python
#!/usr/bin/env python3
"""
Docker Cleanup Script - Removes old/unused Docker images to free disk space.
Used as a cron job on build agents and servers.
"""

import subprocess   # Run shell commands from Python
import json         # Parse JSON output
from datetime import datetime, timedelta

# Keep images newer than this many days
MAX_AGE_DAYS = 7

def run_command(cmd):
    """
    Run a shell command and return output.
    shell=True → allows running command as a string (like in terminal)
    capture_output=True → captures stdout and stderr
    text=True → returns string instead of bytes
    """
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout.strip()


def get_docker_images():
    """Get all Docker images with their details."""
    output = run_command('docker images --format "{{json .}}"')
    images = []
    for line in output.split('\n'):
        if line:
            images.append(json.loads(line))
    return images


def cleanup_old_images():
    """Remove Docker images older than MAX_AGE_DAYS."""
    print(f"🧹 Docker Image Cleanup (removing images older than {MAX_AGE_DAYS} days)")
    
    # Get disk usage before
    before = run_command("docker system df --format '{{.Size}}' | head -1")
    print(f"Disk usage before: {before}")
    
    # Remove dangling images (no tag, not used)
    run_command("docker image prune -f")
    
    # Remove images older than MAX_AGE_DAYS
    cutoff = datetime.now() - timedelta(days=MAX_AGE_DAYS)
    images = get_docker_images()
    
    removed = 0
    for img in images:
        created = img.get("CreatedAt", "")
        if created:
            # Parse creation date
            try:
                img_date = datetime.strptime(created[:19], "%Y-%m-%d %H:%M:%S")
                if img_date < cutoff and img["Repository"] != "<none>":
                    image_ref = f"{img['Repository']}:{img['Tag']}"
                    print(f"  Removing: {image_ref} (created: {created[:10]})")
                    run_command(f"docker rmi {image_ref} 2>/dev/null")
                    removed += 1
            except (ValueError, KeyError):
                continue
    
    # Get disk usage after
    after = run_command("docker system df --format '{{.Size}}' | head -1")
    print(f"\n✅ Removed {removed} images")
    print(f"Disk usage after: {after}")


if __name__ == "__main__":
    cleanup_old_images()
```

---

### Q4: Write a script to check AWS EC2 instance status.

```python
#!/usr/bin/env python3
"""
EC2 Instance Monitor - Checks status of all EC2 instances.
Reports any instances that are stopped, impaired, or missing tags.
"""

import boto3        # AWS SDK for Python
from datetime import datetime

def get_ec2_status():
    """Check all EC2 instances in the region."""
    # Create EC2 client (uses AWS credentials from environment/IAM role)
    ec2 = boto3.client('ec2', region_name='us-east-1')
    
    # Describe all instances
    response = ec2.describe_instances()
    
    instances = []
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            # Get the Name tag
            name = "No Name"
            for tag in instance.get('Tags', []):
                if tag['Key'] == 'Name':
                    name = tag['Value']
            
            instances.append({
                'id': instance['InstanceId'],
                'name': name,
                'state': instance['State']['Name'],
                'type': instance['InstanceType'],
                'private_ip': instance.get('PrivateIpAddress', 'N/A'),
                'public_ip': instance.get('PublicIpAddress', 'N/A'),
            })
    
    return instances


def main():
    print(f"=== EC2 Instance Status Report ({datetime.now()}) ===\n")
    
    instances = get_ec2_status()
    
    running = [i for i in instances if i['state'] == 'running']
    stopped = [i for i in instances if i['state'] == 'stopped']
    other = [i for i in instances if i['state'] not in ('running', 'stopped')]
    
    print(f"Running: {len(running)} | Stopped: {len(stopped)} | Other: {len(other)}\n")
    
    if stopped:
        print("⚠️  STOPPED instances (verify if intentional):")
        for i in stopped:
            print(f"  - {i['name']} ({i['id']}) - {i['type']}")
    
    if other:
        print("🚨 ABNORMAL state instances:")
        for i in other:
            print(f"  - {i['name']} ({i['id']}) - State: {i['state']}")


if __name__ == "__main__":
    main()
```

---

### Q5: Write a REST API health checker with retry logic.

```python
#!/usr/bin/env python3
"""
API Health Checker with Retry Logic.
Retries failed checks before alerting (avoids false positives).
"""

import requests
import time

def check_with_retry(url, max_retries=3, delay=5, timeout=10):
    """
    Check a URL with retry logic.
    
    Parameters:
    - url: The endpoint to check
    - max_retries: How many times to retry before declaring failure
    - delay: Seconds to wait between retries
    - timeout: Max seconds to wait for response
    
    Returns: (success: bool, details: str)
    """
    for attempt in range(1, max_retries + 1):
        try:
            response = requests.get(url, timeout=timeout)
            
            if response.status_code == 200:
                return True, f"OK (attempt {attempt}, {response.elapsed.total_seconds():.2f}s)"
            else:
                error = f"HTTP {response.status_code}"
                
        except requests.exceptions.Timeout:
            error = "Timeout"
        except requests.exceptions.ConnectionError:
            error = "Connection refused"
        except Exception as e:
            error = str(e)
        
        if attempt < max_retries:
            print(f"  ⚠️  Attempt {attempt} failed ({error}), retrying in {delay}s...")
            time.sleep(delay)
    
    return False, f"FAILED after {max_retries} attempts: {error}"


# Usage
endpoints = [
    "http://api.example.com/health",
    "http://auth.example.com/health",
    "http://db-proxy.example.com/health",
]

for endpoint in endpoints:
    success, details = check_with_retry(endpoint)
    icon = "✅" if success else "❌"
    print(f"{icon} {endpoint}: {details}")
```

---

### Q6: What are Python data types and when to use each?

| Type | Example | Use Case |
|------|---------|----------|
| `str` | `"hello"` | Names, messages, file paths |
| `int` | `42` | Counts, port numbers |
| `float` | `3.14` | Percentages, metrics |
| `bool` | `True/False` | Flags, conditions |
| `list` | `[1, 2, 3]` | Ordered collection, can modify |
| `tuple` | `(1, 2, 3)` | Fixed collection, can't modify |
| `dict` | `{"key": "value"}` | Key-value pairs (configs, API responses) |
| `set` | `{1, 2, 3}` | Unique items, deduplication |

---

### Q7: How do you handle exceptions in Python?

```python
import sys
import traceback

def safe_operation():
    """Proper exception handling for production code."""
    try:
        # Risky operation
        result = requests.get("http://api.example.com/data", timeout=5)
        result.raise_for_status()  # Raises exception for 4xx/5xx
        return result.json()
    
    except requests.exceptions.Timeout:
        # Handle specific exception first
        print("ERROR: API request timed out")
        return None
    
    except requests.exceptions.HTTPError as e:
        # HTTP errors (404, 500, etc.)
        print(f"ERROR: API returned {e.response.status_code}")
        return None
    
    except Exception as e:
        # Catch-all for unexpected errors
        print(f"UNEXPECTED ERROR: {e}")
        traceback.print_exc()  # Print full stack trace for debugging
        return None
    
    finally:
        # Always runs (cleanup code)
        print("Request completed")
```

---

### Q8: Write a script to monitor disk space and alert.

```python
#!/usr/bin/env python3
"""Disk space monitor - alerts when usage exceeds threshold."""

import shutil       # Provides disk_usage function
import os

THRESHOLD_PERCENT = 80  # Alert when disk is 80% full

def check_disk_space(path="/"):
    """Check disk usage for given path."""
    usage = shutil.disk_usage(path)
    
    total_gb = usage.total / (1024**3)      # Convert bytes to GB
    used_gb = usage.used / (1024**3)
    free_gb = usage.free / (1024**3)
    percent = (usage.used / usage.total) * 100
    
    return {
        "path": path,
        "total_gb": round(total_gb, 1),
        "used_gb": round(used_gb, 1),
        "free_gb": round(free_gb, 1),
        "percent": round(percent, 1)
    }

# Check important mount points
paths = ["/", "/var", "/tmp"]
for path in paths:
    if os.path.exists(path):
        info = check_disk_space(path)
        icon = "🚨" if info["percent"] > THRESHOLD_PERCENT else "✅"
        print(f"{icon} {info['path']}: {info['percent']}% used "
              f"({info['used_gb']}GB / {info['total_gb']}GB, {info['free_gb']}GB free)")
```

---

### Q9: How do you work with files in Python?

```python
# Reading a file
with open("/var/log/app.log", "r") as f:
    content = f.read()       # Read entire file
    # OR
    lines = f.readlines()    # Read as list of lines
    # OR
    for line in f:           # Read line by line (memory efficient)
        process(line)

# Writing to a file
with open("/tmp/report.txt", "w") as f:    # "w" = write (overwrites)
    f.write("Report generated\n")

with open("/tmp/report.txt", "a") as f:    # "a" = append
    f.write("Additional line\n")

# Working with JSON
import json
with open("config.json", "r") as f:
    config = json.load(f)           # Parse JSON file to dict

with open("output.json", "w") as f:
    json.dump(data, f, indent=2)    # Write dict as JSON

# Working with YAML (common in DevOps)
import yaml
with open("deployment.yaml", "r") as f:
    manifest = yaml.safe_load(f)
```

---

### Q10: Write a script to automate SSL certificate expiry checking.

```python
#!/usr/bin/env python3
"""Check SSL certificate expiry for domains."""

import ssl
import socket
from datetime import datetime

def check_ssl_expiry(hostname, port=443):
    """Check when an SSL certificate expires."""
    context = ssl.create_default_context()
    
    with socket.create_connection((hostname, port), timeout=10) as sock:
        with context.wrap_socket(sock, server_hostname=hostname) as ssock:
            cert = ssock.getpeercert()
            
            # Parse expiry date
            expiry_str = cert['notAfter']  # 'Mar 15 12:00:00 2024 GMT'
            expiry_date = datetime.strptime(expiry_str, '%b %d %H:%M:%S %Y %Z')
            
            days_remaining = (expiry_date - datetime.now()).days
            return days_remaining, expiry_date

domains = ["google.com", "github.com", "example.com"]

for domain in domains:
    try:
        days, expiry = check_ssl_expiry(domain)
        icon = "🚨" if days < 30 else "⚠️" if days < 60 else "✅"
        print(f"{icon} {domain}: {days} days remaining (expires {expiry.date()})")
    except Exception as e:
        print(f"❌ {domain}: Error - {e}")
```

---

### Q11: What are list comprehensions and when to use them?

```python
# Traditional loop
results = []
for i in range(10):
    if i % 2 == 0:
        results.append(i * 2)

# List comprehension (same thing, shorter)
results = [i * 2 for i in range(10) if i % 2 == 0]
# Output: [0, 4, 8, 12, 16]

# Production examples:
# Filter running pods
running_pods = [p for p in pods if p['status'] == 'Running']

# Extract IPs from instances
ips = [inst['PrivateIpAddress'] for inst in instances if inst['State'] == 'running']

# Dict comprehension
status_map = {svc['name']: svc['status'] for svc in services}
```

---

### Q12: Write a script to interact with Kubernetes API.

```python
#!/usr/bin/env python3
"""Check Kubernetes pod status using Python kubernetes client."""

from kubernetes import client, config

# Load kubeconfig (uses ~/.kube/config or in-cluster config)
try:
    config.load_incluster_config()    # If running inside K8s
except:
    config.load_kube_config()         # If running locally

v1 = client.CoreV1Api()

# List all pods in a namespace
namespace = "production"
pods = v1.list_namespaced_pod(namespace=namespace)

print(f"Pods in {namespace} namespace:")
for pod in pods.items:
    name = pod.metadata.name
    status = pod.status.phase
    restarts = sum(cs.restart_count for cs in (pod.status.container_statuses or []))
    
    icon = "✅" if status == "Running" and restarts == 0 else "⚠️"
    print(f"  {icon} {name}: {status} (restarts: {restarts})")
```

---

### Q13: How do you use subprocess to run shell commands?

```python
import subprocess

# Simple command
result = subprocess.run(["ls", "-la"], capture_output=True, text=True)
print(result.stdout)

# Command with pipe (need shell=True)
result = subprocess.run(
    "ps aux | grep nginx | grep -v grep",
    shell=True, capture_output=True, text=True
)

# Check return code
if result.returncode != 0:
    print(f"Command failed: {result.stderr}")

# Run with timeout
try:
    result = subprocess.run(["ping", "-c", "4", "google.com"], 
                          capture_output=True, text=True, timeout=10)
except subprocess.TimeoutExpired:
    print("Command timed out!")
```

---

### Q14: Write a simple Flask health endpoint.

```python
#!/usr/bin/env python3
"""Simple health check API - common pattern in microservices."""

from flask import Flask, jsonify
import psutil    # System monitoring library
import time

app = Flask(__name__)
START_TIME = time.time()

@app.route('/health')
def health():
    """Health check endpoint for load balancers."""
    return jsonify({
        "status": "healthy",
        "uptime_seconds": int(time.time() - START_TIME),
        "cpu_percent": psutil.cpu_percent(),
        "memory_percent": psutil.virtual_memory().percent,
        "disk_percent": psutil.disk_usage('/').percent
    }), 200

@app.route('/ready')
def ready():
    """Readiness check - is the app ready to serve traffic?"""
    # Add checks: database connection, cache connection, etc.
    return jsonify({"status": "ready"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
```

---

### Q15: How do you work with environment variables in Python?

```python
import os

# Get environment variable (returns None if not set)
db_host = os.environ.get("DATABASE_HOST", "localhost")
db_port = int(os.environ.get("DATABASE_PORT", "5432"))
debug = os.environ.get("DEBUG", "false").lower() == "true"

# Required variable (fail if not set)
api_key = os.environ.get("API_KEY")
if not api_key:
    raise ValueError("API_KEY environment variable is required!")
```

---

### Q16: Write a script to find and kill zombie processes.

```python
#!/usr/bin/env python3
"""Find and report zombie processes on the system."""

import psutil

zombies = []
for proc in psutil.process_iter(['pid', 'name', 'status', 'ppid']):
    if proc.info['status'] == psutil.STATUS_ZOMBIE:
        zombies.append(proc.info)

if zombies:
    print(f"🧟 Found {len(zombies)} zombie processes:")
    for z in zombies:
        print(f"  PID: {z['pid']}, Name: {z['name']}, Parent PID: {z['ppid']}")
    print("\nFix: Kill the parent process or investigate why it's not reaping children")
else:
    print("✅ No zombie processes found")
```

---

### Q17: How do you make HTTP requests with error handling?

```python
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

def create_session_with_retry():
    """Create requests session with automatic retries."""
    session = requests.Session()
    
    retry = Retry(
        total=3,              # Max 3 retries
        backoff_factor=1,     # Wait 1, 2, 4 seconds between retries
        status_forcelist=[500, 502, 503, 504]  # Retry on these HTTP codes
    )
    
    adapter = HTTPAdapter(max_retries=retry)
    session.mount("http://", adapter)
    session.mount("https://", adapter)
    
    return session

# Usage
session = create_session_with_retry()
response = session.get("http://api.example.com/data", timeout=10)
```

---

### Q18: Write a script to generate a system health report.

```python
#!/usr/bin/env python3
"""System health report - generates overview of server status."""

import psutil
import platform
from datetime import datetime

def system_report():
    print(f"{'='*50}")
    print(f"System Health Report - {datetime.now()}")
    print(f"{'='*50}")
    print(f"Hostname: {platform.node()}")
    print(f"OS: {platform.system()} {platform.release()}")
    print(f"Uptime: {int((datetime.now() - datetime.fromtimestamp(psutil.boot_time())).total_seconds() / 3600)} hours")
    
    # CPU
    print(f"\n📊 CPU: {psutil.cpu_percent(interval=1)}% used ({psutil.cpu_count()} cores)")
    
    # Memory
    mem = psutil.virtual_memory()
    print(f"🧠 Memory: {mem.percent}% used ({mem.used // (1024**3)}GB / {mem.total // (1024**3)}GB)")
    
    # Disk
    disk = psutil.disk_usage('/')
    print(f"💾 Disk (/): {disk.percent}% used ({disk.used // (1024**3)}GB / {disk.total // (1024**3)}GB)")
    
    # Top processes by memory
    print(f"\n🔝 Top 5 processes by memory:")
    procs = sorted(psutil.process_iter(['pid', 'name', 'memory_percent']), 
                   key=lambda p: p.info['memory_percent'] or 0, reverse=True)[:5]
    for p in procs:
        print(f"  {p.info['pid']:>6} {p.info['name']:<20} {p.info['memory_percent']:.1f}%")

system_report()
```

---

### Q19: How do you use decorators in Python?

```python
import time
import functools

def timer(func):
    """Decorator that measures function execution time."""
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        elapsed = time.time() - start
        print(f"{func.__name__} took {elapsed:.2f}s")
        return result
    return wrapper

def retry(max_attempts=3, delay=1):
    """Decorator that retries a function on failure."""
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(1, max_attempts + 1):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    if attempt == max_attempts:
                        raise
                    time.sleep(delay)
        return wrapper
    return decorator

# Usage
@timer
@retry(max_attempts=3, delay=2)
def fetch_data(url):
    return requests.get(url, timeout=5).json()
```

---

### Q20: Write a script to parse and validate YAML configs.

```python
#!/usr/bin/env python3
"""Validate Kubernetes YAML manifests before applying."""

import yaml
import sys

REQUIRED_LABELS = ['app', 'environment', 'team']

def validate_k8s_manifest(filepath):
    """Validate a K8s manifest has required fields."""
    errors = []
    
    with open(filepath, 'r') as f:
        docs = list(yaml.safe_load_all(f))
    
    for doc in docs:
        if not doc:
            continue
        
        kind = doc.get('kind', 'Unknown')
        name = doc.get('metadata', {}).get('name', 'unnamed')
        
        # Check required labels
        labels = doc.get('metadata', {}).get('labels', {})
        for label in REQUIRED_LABELS:
            if label not in labels:
                errors.append(f"{kind}/{name}: missing required label '{label}'")
        
        # Check resource limits (for Deployments)
        if kind == 'Deployment':
            containers = doc.get('spec', {}).get('template', {}).get('spec', {}).get('containers', [])
            for c in containers:
                if 'resources' not in c:
                    errors.append(f"{kind}/{name}: container '{c['name']}' missing resource limits")
    
    return errors

# Usage
filepath = sys.argv[1] if len(sys.argv) > 1 else "deployment.yaml"
errors = validate_k8s_manifest(filepath)

if errors:
    print(f"❌ Validation failed ({len(errors)} errors):")
    for e in errors:
        print(f"  - {e}")
    sys.exit(1)
else:
    print("✅ Validation passed!")
```

---

### Q21: What is the difference between `==` and `is` in Python?

```python
# == checks VALUE equality
# is checks if same OBJECT in memory

a = [1, 2, 3]
b = [1, 2, 3]
print(a == b)   # True (same values)
print(a is b)   # False (different objects)

# Use 'is' only for: None, True, False
if result is None:    # ✅ Correct
    pass
if result == None:    # ❌ Works but not Pythonic
    pass
```

---

### Q22: Write a script to backup files to S3.

```python
#!/usr/bin/env python3
"""Backup important files to S3 with timestamp."""

import boto3
import os
from datetime import datetime

def backup_to_s3(local_path, bucket, prefix="backups"):
    """Upload a file to S3 with date prefix."""
    s3 = boto3.client('s3')
    
    date_prefix = datetime.now().strftime("%Y/%m/%d")
    filename = os.path.basename(local_path)
    s3_key = f"{prefix}/{date_prefix}/{filename}"
    
    print(f"Uploading {local_path} → s3://{bucket}/{s3_key}")
    s3.upload_file(local_path, bucket, s3_key)
    print("✅ Upload complete")

# Backup critical configs
files_to_backup = [
    "/etc/nginx/nginx.conf",
    "/etc/myapp/config.yml",
    "/var/lib/jenkins/config.xml"
]

for filepath in files_to_backup:
    if os.path.exists(filepath):
        backup_to_s3(filepath, "my-backup-bucket")
```

---

### Q23: How do you handle command-line arguments?

```python
#!/usr/bin/env python3
"""Example script with proper argument parsing."""

import argparse

parser = argparse.ArgumentParser(description='Deploy application to environment')
parser.add_argument('--env', required=True, choices=['dev', 'staging', 'prod'],
                    help='Target environment')
parser.add_argument('--version', required=True, help='Version to deploy (e.g., v1.2.3)')
parser.add_argument('--dry-run', action='store_true', help='Show what would be done')

args = parser.parse_args()

print(f"Deploying version {args.version} to {args.env}")
if args.dry_run:
    print("DRY RUN - no changes made")
else:
    print("Deploying...")

# Usage: python deploy.py --env prod --version v1.2.3 --dry-run
```

---

### Q24: Write a connection pool checker for databases.

```python
#!/usr/bin/env python3
"""Check database connectivity and connection count."""

import psycopg2  # PostgreSQL driver

def check_db_connections(host, port, dbname, user, password):
    """Check database connectivity and active connections."""
    try:
        conn = psycopg2.connect(
            host=host, port=port, dbname=dbname,
            user=user, password=password, connect_timeout=5
        )
        cursor = conn.cursor()
        
        # Check active connections
        cursor.execute("""
            SELECT count(*) as total,
                   count(*) FILTER (WHERE state = 'active') as active,
                   count(*) FILTER (WHERE state = 'idle') as idle
            FROM pg_stat_activity
            WHERE datname = %s
        """, (dbname,))
        
        total, active, idle = cursor.fetchone()
        
        # Get max connections
        cursor.execute("SHOW max_connections")
        max_conn = int(cursor.fetchone()[0])
        
        usage_pct = (total / max_conn) * 100
        
        conn.close()
        
        icon = "🚨" if usage_pct > 80 else "⚠️" if usage_pct > 60 else "✅"
        print(f"{icon} Database: {total}/{max_conn} connections "
              f"({usage_pct:.0f}%) - Active: {active}, Idle: {idle}")
        
        return True
    
    except psycopg2.OperationalError as e:
        print(f"❌ Cannot connect to database: {e}")
        return False
```

---

# 6. Shell Scripting

## 📝 Shell Scripting - 24 Interview Questions with Production Scripts

### Q1: Write a production deployment script with logging and error handling.

```bash
#!/bin/bash
# deploy.sh - Production deployment script with safety checks
# Usage: ./deploy.sh <environment> <version>

set -euo pipefail
# set -e → Exit immediately if any command fails
# set -u → Treat unset variables as errors
# set -o pipefail → Pipeline fails if any command in pipe fails

# ===== Configuration =====
ENVIRONMENT="${1:?Usage: $0 <environment> <version>}"
# ${1:?message} → If $1 is empty, print error message and exit
VERSION="${2:?Usage: $0 <environment> <version>}"
APP_NAME="payment-service"
LOG_FILE="/var/log/deploy/${APP_NAME}-$(date +%Y%m%d-%H%M%S).log"
REGISTRY="ecr.aws/mycompany"

# ===== Functions =====
log() {
    # Print message with timestamp to both screen and log file
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

error() {
    log "ERROR: $*"
    exit 1
}

rollback() {
    log "🔄 Rolling back to previous version..."
    kubectl rollout undo deployment/${APP_NAME} -n ${ENVIRONMENT}
    log "Rollback complete"
}

# Trap EXIT signal → if script fails at any point, run rollback
trap 'if [ $? -ne 0 ]; then rollback; fi' EXIT

# ===== Pre-flight Checks =====
log "🚀 Starting deployment: ${APP_NAME} v${VERSION} → ${ENVIRONMENT}"

# Check if image exists
if ! docker manifest inspect ${REGISTRY}/${APP_NAME}:${VERSION} > /dev/null 2>&1; then
    error "Image ${REGISTRY}/${APP_NAME}:${VERSION} not found!"
fi

# Check cluster connectivity
if ! kubectl cluster-info > /dev/null 2>&1; then
    error "Cannot connect to Kubernetes cluster!"
fi

# ===== Deploy =====
log "📦 Deploying image: ${REGISTRY}/${APP_NAME}:${VERSION}"
kubectl set image deployment/${APP_NAME} \
    ${APP_NAME}=${REGISTRY}/${APP_NAME}:${VERSION} \
    -n ${ENVIRONMENT}

# ===== Wait for rollout =====
log "⏳ Waiting for rollout to complete..."
if ! kubectl rollout status deployment/${APP_NAME} -n ${ENVIRONMENT} --timeout=300s; then
    error "Rollout failed! Auto-rolling back..."
fi

# ===== Health Check =====
log "🏥 Running health checks..."
sleep 10  # Wait for service to stabilize
HEALTH_URL="http://${APP_NAME}.${ENVIRONMENT}.svc.cluster.local:8080/health"

for i in {1..5}; do
    STATUS=$(kubectl exec deploy/${APP_NAME} -n ${ENVIRONMENT} -- \
        curl -s -o /dev/null -w "%{http_code}" localhost:8080/health)
    if [ "$STATUS" = "200" ]; then
        log "✅ Health check passed!"
        break
    fi
    if [ "$i" -eq 5 ]; then
        
