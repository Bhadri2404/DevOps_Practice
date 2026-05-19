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
    if [ "$i" -eq 5 ]; then# 6. Shell Scripting (Continued)

## 📝 Shell Scripting - 24 Interview Questions with Production Scripts

### Q1: Write a production deployment script with logging and error handling. (Continued)

```bash
        error "Health check failed after 5 attempts!"
    fi
    log "Health check attempt $i failed, retrying..."
    sleep 5
done

log "🎉 Deployment successful! ${APP_NAME} v${VERSION} is live in ${ENVIRONMENT}"
```

**Line-by-line key concepts:**
| Line | Explanation |
|------|-------------|
| `set -euo pipefail` | Safety net - script stops on any error |
| `${1:?message}` | Require argument or show error |
| `tee -a` | Write to both screen AND file (-a = append) |
| `trap '...' EXIT` | Run cleanup code if script fails anywhere |
| `> /dev/null 2>&1` | Silence all output (stdout and stderr) |
| `$?` | Exit code of last command (0=success, non-zero=failure) |

---

### Q2: Write a log rotation and cleanup script.

```bash
#!/bin/bash
# log-cleanup.sh - Clean old logs to prevent disk full
# Run via cron: 0 2 * * * /scripts/log-cleanup.sh

set -euo pipefail

LOG_DIR="/var/log/myapp"
MAX_AGE_DAYS=7
MAX_SIZE_MB=100

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }

log "Starting log cleanup..."

# 1. Delete log files older than 7 days
DELETED=$(find "$LOG_DIR" -name "*.log" -type f -mtime +${MAX_AGE_DAYS} -print -delete | wc -l)
# find → search for files
# -name "*.log" → only .log files
# -type f → only files (not directories)
# -mtime +7 → modified more than 7 days ago
# -print → show what's being deleted
# -delete → delete the file
# | wc -l → count how many lines (files deleted)
log "Deleted $DELETED files older than ${MAX_AGE_DAYS} days"

# 2. Compress logs older than 1 day (save space)
find "$LOG_DIR" -name "*.log" -type f -mtime +1 ! -name "*.gz" -exec gzip {} \;
# ! -name "*.gz" → skip already compressed files
# -exec gzip {} \; → compress each found file
log "Compressed logs older than 1 day"

# 3. Truncate active log files that are too large
find "$LOG_DIR" -name "*.log" -type f -size +${MAX_SIZE_MB}M | while read -r file; do
    SIZE=$(du -sh "$file" | cut -f1)
    log "Truncating oversized file: $file ($SIZE)"
    # Keep last 1000 lines, discard the rest
    tail -1000 "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
done

# 4. Report disk usage
USAGE=$(df -h "$LOG_DIR" | tail -1 | awk '{print $5}')
log "Disk usage for $LOG_DIR partition: $USAGE"
log "Cleanup complete ✅"
```

---

### Q3: Write a server health monitoring script.

```bash
#!/bin/bash
# server-health.sh - Quick server health check
# Usage: ./server-health.sh

set -uo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No Color

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=85

print_status() {
    local label="$1"
    local value="$2"
    local threshold="$3"
    
    if (( $(echo "$value > $threshold" | bc -l) )); then
        echo -e "  ${RED}🚨 $label: ${value}% (threshold: ${threshold}%)${NC}"
    elif (( $(echo "$value > $threshold * 0.8" | bc -l) )); then
        echo -e "  ${YELLOW}⚠️  $label: ${value}%${NC}"
    else
        echo -e "  ${GREEN}✅ $label: ${value}%${NC}"
    fi
}

echo "=================================="
echo "  Server Health Report"
echo "  $(date)"
echo "  Host: $(hostname)"
echo "=================================="

# CPU Usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
# top -bn1 → run top once in batch mode
# grep "Cpu(s)" → find the CPU summary line
# awk '{print $2}' → extract the user CPU percentage
print_status "CPU" "$CPU" "$CPU_THRESHOLD"

# Memory Usage
MEM=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')
# free → show memory info
# /Mem:/ → find the memory line
# ($3/$2)*100 → (used/total)*100 = percentage
print_status "Memory" "$MEM" "$MEM_THRESHOLD"

# Disk Usage (for each mounted filesystem)
echo ""
echo "  Disk Usage:"
df -h --output=target,pcent,size,used | grep -vE "^Mounted|tmpfs|udev" | while read -r mount percent total used; do
    PERCENT_NUM=${percent%\%}  # Remove % sign
    print_status "  $mount" "$PERCENT_NUM" "$DISK_THRESHOLD"
done

# Load Average
echo ""
LOAD=$(uptime | awk -F'average:' '{print $2}' | awk -F, '{print $1}' | tr -d ' ')
CPUS=$(nproc)
echo "  Load Average: $LOAD (CPUs: $CPUS)"
if (( $(echo "$LOAD > $CPUS" | bc -l) )); then
    echo -e "  ${RED}🚨 System is OVERLOADED${NC}"
fi

# Top 5 Memory Consumers
echo ""
echo "  Top 5 Processes (by memory):"
ps aux --sort=-%mem | head -6 | tail -5 | awk '{printf "    %-8s %-6s %-6s %s\n", $1, $4"%", $3"%", $11}'

# Open Connections
CONNECTIONS=$(ss -tan state established | wc -l)
echo ""
echo "  Active network connections: $CONNECTIONS"

# Check critical services
echo ""
echo "  Service Status:"
for svc in nginx docker kubelet sshd; do
    if systemctl is-active --quiet "$svc" 2>/dev/null; then
        echo -e "    ${GREEN}✅ $svc: running${NC}"
    else
        echo -e "    ${RED}❌ $svc: not running${NC}"
    fi
done
```

---

### Q4: Explain variables, conditionals, and loops in shell scripting.

```bash
# ===== VARIABLES =====
NAME="deploy-app"          # No spaces around =
VERSION=1                  # Numbers are still strings
FULL="${NAME}-v${VERSION}" # Variable interpolation
RESULT=$(date +%Y%m%d)    # Command substitution - runs command, stores output
readonly API_KEY="abc123"  # Cannot be changed later

# ===== CONDITIONALS =====
# String comparison
if [ "$ENV" = "production" ]; then
    echo "Production deploy"
elif [ "$ENV" = "staging" ]; then
    echo "Staging deploy"
else
    echo "Dev deploy"
fi

# Numeric comparison
if [ "$CPU" -gt 80 ]; then       # -gt = greater than
    echo "CPU high!"
fi
# -eq (equal), -ne (not equal), -lt (less than), -ge (greater or equal)

# File tests
if [ -f "/etc/config.yml" ]; then  # -f = file exists
    echo "Config found"
fi
if [ -d "/var/log" ]; then         # -d = directory exists
    echo "Dir exists"
fi
if [ -z "$VAR" ]; then             # -z = string is empty
    echo "Variable is empty"
fi

# ===== LOOPS =====
# For loop
for server in web1 web2 web3; do
    echo "Deploying to $server"
    ssh "$server" "systemctl restart app"
done

# For loop with range
for i in {1..5}; do
    echo "Attempt $i"
done

# While loop
COUNT=0
while [ $COUNT -lt 10 ]; do
    echo "Count: $COUNT"
    COUNT=$((COUNT + 1))    # Arithmetic
done

# Read file line by line
while IFS= read -r line; do
    echo "Processing: $line"
done < /etc/hosts
# IFS= → don't trim whitespace
# -r → don't interpret backslashes
```

---

### Q5: Write a backup script with retention policy.

```bash
#!/bin/bash
# backup.sh - Backup databases with 7-day retention
# Cron: 0 1 * * * /scripts/backup.sh

set -euo pipefail

BACKUP_DIR="/backup/db"
RETENTION_DAYS=7
DB_HOST="db.internal"
DB_NAME="production_db"
DB_USER="backup_user"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
S3_BUCKET="s3://company-backups/database"

log() { echo "[$(date '+%H:%M:%S')] $*"; }

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Take database dump
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.sql.gz"
log "Starting backup of $DB_NAME..."

pg_dump -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" | gzip > "$BACKUP_FILE"
# pg_dump → export database
# | gzip → compress immediately (saves disk space)
# > file → write to file

BACKUP_SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
log "Backup created: $BACKUP_FILE ($BACKUP_SIZE)"

# Upload to S3
log "Uploading to S3..."
aws s3 cp "$BACKUP_FILE" "${S3_BUCKET}/$(date +%Y/%m/)$(basename $BACKUP_FILE)"
log "Upload complete"

# Clean old local backups
DELETED=$(find "$BACKUP_DIR" -name "*.sql.gz" -mtime +${RETENTION_DAYS} -delete -print | wc -l)
log "Deleted $DELETED old backup(s) (older than ${RETENTION_DAYS} days)"

# Verify backup is valid (can be read)
if gzip -t "$BACKUP_FILE"; then
    log "✅ Backup verified successfully"
else
    log "❌ Backup file is corrupted!"
    exit 1
fi

log "🎉 Backup complete"
```

---

### Q6: How do you handle errors and exit codes in shell scripts?

```bash
#!/bin/bash

# Method 1: set -e (exit on error)
set -e  # Script stops if ANY command fails

# Method 2: Check exit codes manually
if ! kubectl apply -f deployment.yaml; then
    echo "Deployment failed!"
    exit 1
fi

# Method 3: OR operator for error handling
mkdir -p /data || { echo "Cannot create /data"; exit 1; }
# If mkdir fails → run the code in { }

# Method 4: trap for cleanup
cleanup() {
    echo "Cleaning up temporary files..."
    rm -f /tmp/myapp_*
}
trap cleanup EXIT        # Run cleanup when script exits
trap cleanup ERR         # Run cleanup on error
trap cleanup SIGINT      # Run cleanup on Ctrl+C

# Method 5: Custom error handler
die() {
    echo "FATAL: $*" >&2    # Print to stderr
    exit 1
}

[ -f config.yml ] || die "config.yml not found!"

# Method 6: Retry pattern
retry() {
    local max_attempts=$1
    shift
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if "$@"; then
            return 0
        fi
        echo "Attempt $attempt/$max_attempts failed, retrying..."
        attempt=$((attempt + 1))
        sleep 5
    done
    return 1
}

retry 3 curl -f http://myapp:8080/health
```

---

### Q7: Write a script to check if services are running and restart them.

```bash
#!/bin/bash
# service-watchdog.sh - Monitor and auto-restart critical services
# Cron: */2 * * * * /scripts/service-watchdog.sh

set -uo pipefail

SERVICES=("nginx" "docker" "node-exporter" "filebeat")
ALERT_WEBHOOK="https://hooks.slack.com/services/XXX/YYY/ZZZ"

send_alert() {
    local message="$1"
    curl -s -X POST "$ALERT_WEBHOOK" \
        -H 'Content-type: application/json' \
        -d "{\"text\": \"🚨 $(hostname): $message\"}" > /dev/null
}

for service in "${SERVICES[@]}"; do
    if ! systemctl is-active --quiet "$service"; then
        echo "$(date): $service is DOWN, attempting restart..."
        
        # Try to restart
        if systemctl restart "$service"; then
            echo "$service restarted successfully"
            send_alert "$service was down and has been restarted"
        else
            echo "FAILED to restart $service!"
            send_alert "CRITICAL: $service is DOWN and cannot be restarted!"
        fi
    fi
done
```

---

### Q8: Explain input/output redirection and pipes.

```bash
# STDOUT (file descriptor 1) = Normal output
# STDERR (file descriptor 2) = Error output

# Redirect stdout to file
echo "hello" > file.txt        # Overwrite
echo "hello" >> file.txt       # Append

# Redirect stderr to file
command 2> errors.log          # Errors go to file

# Redirect both stdout and stderr
command > output.log 2>&1      # Both to same file
command &> output.log          # Shorter syntax (bash 4+)

# Discard output completely
command > /dev/null 2>&1       # Silence everything

# Pipe: Send output of one command as input to another
cat access.log | grep "500" | awk '{print $1}' | sort | uniq -c | sort -rn
# cat → read file
# grep "500" → find lines with 500 errors
# awk '{print $1}' → extract first field (IP address)
# sort → sort IPs alphabetically
# uniq -c → count consecutive duplicates
# sort -rn → sort by count, highest first
# Result: Top IPs causing 500 errors

# Here document (multi-line input)
cat <<EOF > /etc/nginx/conf.d/app.conf
server {
    listen 80;
    server_name myapp.com;
    location / {
        proxy_pass http://localhost:8080;
    }
}
EOF
```

---

### Q9: Write a script to parse Nginx access logs and find top IPs.

```bash
#!/bin/bash
# access-log-analyzer.sh - Analyze Nginx access logs

LOG_FILE="${1:-/var/log/nginx/access.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

TOTAL_REQUESTS=$(wc -l < "$LOG_FILE")
echo "📊 Nginx Access Log Analysis"
echo "File: $LOG_FILE"
echo "Total Requests: $TOTAL_REQUESTS"
echo ""

# Top 10 IPs
echo "🔝 Top 10 Client IPs:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10 | \
    awk '{printf "  %6d requests from %s\n", $1, $2}'

echo ""

# HTTP Status Code Distribution
echo "📈 Status Code Distribution:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10 | \
    awk '{printf "  %s: %d requests\n", $2, $1}'

echo ""

# Top 10 Requested URLs
echo "🌐 Top 10 Requested URLs:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10 | \
    awk '{printf "  %6d  %s\n", $1, $2}'

echo ""

# Requests per hour (last 24 hours)
echo "⏰ Requests per Hour (recent):"
awk -F'[' '{print $2}' "$LOG_FILE" | awk -F: '{print $1":"$2}' | \
    sort | uniq -c | tail -24 | \
    awk '{printf "  %s → %d requests\n", $2, $1}'

echo ""

# 5xx Errors
ERROR_COUNT=$(awk '$9 ~ /^5/ {count++} END {print count+0}' "$LOG_FILE")
echo "🚨 5xx Errors: $ERROR_COUNT ($(echo "scale=2; $ERROR_COUNT * 100 / $TOTAL_REQUESTS" | bc)%)"

if [ "$ERROR_COUNT" -gt 0 ]; then
    echo "  Recent 5xx errors:"
    awk '$9 ~ /^5/' "$LOG_FILE" | tail -5 | awk '{print "    "$1, $7, $9}'
fi
```

---

### Q10: Write a script for automated SSH key deployment.

```bash
#!/bin/bash
# deploy-ssh-keys.sh - Deploy SSH public keys to multiple servers

set -euo pipefail

SERVERS=("10.0.1.10" "10.0.1.11" "10.0.1.12" "10.0.1.13")
SSH_USER="deploy"
PUB_KEY_FILE="$HOME/.ssh/id_rsa.pub"

if [ ! -f "$PUB_KEY_FILE" ]; then
    echo "Public key not found. Generating..."
    ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/id_rsa" -N ""
    # -t rsa → key type
    # -b 4096 → key size (bits)
    # -N "" → empty passphrase (for automation)
fi

PUB_KEY=$(cat "$PUB_KEY_FILE")

for server in "${SERVERS[@]}"; do
    echo -n "Deploying key to $server... "
    
    if ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no \
        "${SSH_USER}@${server}" "
            mkdir -p ~/.ssh && chmod 700 ~/.ssh
            echo '$PUB_KEY' >> ~/.ssh/authorized_keys
            chmod 600 ~/.ssh/authorized_keys
            sort -u -o ~/.ssh/authorized_keys ~/.ssh/authorized_keys
        " 2>/dev/null; then
        echo "✅"
    else
        echo "❌ (unreachable or permission denied)"
    fi
done
```

---

### Q11: How do you work with arrays in bash?

```bash
# Declare array
SERVERS=("web1" "web2" "web3" "db1")

# Access elements
echo "${SERVERS[0]}"           # First element: web1
echo "${SERVERS[@]}"           # All elements
echo "${#SERVERS[@]}"          # Length: 4

# Loop through array
for server in "${SERVERS[@]}"; do
    echo "Processing $server"
done

# Add element
SERVERS+=("db2")

# Remove element (by index)
unset 'SERVERS[2]'

# Slice
echo "${SERVERS[@]:1:2}"      # Elements 1 and 2

# Build array from command output
PODS=($(kubectl get pods -o name))
for pod in "${PODS[@]}"; do
    echo "$pod"
done

# Associative array (dictionary/map)
declare -A CONFIG
CONFIG[host]="db.internal"
CONFIG[port]="5432"
CONFIG[name]="mydb"
echo "Connecting to ${CONFIG[host]}:${CONFIG[port]}/${CONFIG[name]}"
```

---

### Q12: Write a script to monitor disk I/O and alert on high usage.

```bash
#!/bin/bash
# disk-io-monitor.sh - Alert when disk I/O is saturated

THRESHOLD_UTIL=90   # Alert if disk utilization > 90%
CHECK_INTERVAL=5    # Check every 5 seconds
ALERT_SENT=false

while true; do
    # iostat shows disk I/O statistics
    # -x = extended stats, -d = device stats only, 1 1 = 1 second interval, 1 report
    UTIL=$(iostat -xd 1 1 | awk '/^[sv]d/ {print $NF}' | sort -rn | head -1)
    # $NF = last field = %util column
    
    if [ -n "$UTIL" ]; then
        UTIL_INT=${UTIL%.*}  # Remove decimal
        
        if [ "$UTIL_INT" -gt "$THRESHOLD_UTIL" ] && [ "$ALERT_SENT" = "false" ]; then
            echo "🚨 HIGH DISK I/O: ${UTIL}% utilization!"
            # Find process doing most I/O
            echo "Top I/O processes:"
            iotop -b -n 1 -o 2>/dev/null | head -5
            ALERT_SENT=true
        elif [ "$UTIL_INT" -lt "$THRESHOLD_UTIL" ]; then
            ALERT_SENT=false
        fi
    fi
    
    sleep "$CHECK_INTERVAL"
done
```

---

### Q13: Explain string manipulation in bash.

```bash
STR="hello-world-production-v1.2.3"

# Length
echo "${#STR}"                    # 30

# Substring
echo "${STR:0:5}"                 # hello (from position 0, 5 chars)
echo "${STR:6}"                   # world-production-v1.2.3 (from position 6)

# Replace
echo "${STR/world/earth}"         # hello-earth-production-v1.2.3 (first match)
echo "${STR//-/_}"                # hello_world_production_v1.2.3 (all matches)

# Remove prefix/suffix
FILENAME="backup-2024-01-15.tar.gz"
echo "${FILENAME%.tar.gz}"        # backup-2024-01-15 (remove shortest suffix)
echo "${FILENAME%%.*}"            # backup-2024-01-15 (remove longest suffix)
echo "${FILENAME#backup-}"        # 2024-01-15.tar.gz (remove prefix)

# Extract version from string
VERSION="myapp-v1.2.3-linux-amd64.tar.gz"
VER=$(echo "$VERSION" | grep -oP 'v\d+\.\d+\.\d+')
echo "$VER"  # v1.2.3

# Default value
echo "${UNDEFINED_VAR:-default_value}"    # Use default if unset
echo "${UNDEFINED_VAR:=default_value}"    # Set AND use default if unset

# Upper/Lower case (bash 4+)
echo "${STR^^}"                   # HELLO-WORLD-PRODUCTION-V1.2.3
echo "${STR,,}"                   # hello-world-production-v1.2.3
```

---

### Q14: Write a script for automated certificate renewal check.

```bash
#!/bin/bash
# cert-check.sh - Check SSL certificate expiry for domains

set -uo pipefail

DOMAINS=("api.company.com" "app.company.com" "admin.company.com")
WARNING_DAYS=30
CRITICAL_DAYS=7

echo "🔐 SSL Certificate Expiry Check"
echo "================================"

for domain in "${DOMAINS[@]}"; do
    # Get certificate expiry date using openssl
    EXPIRY=$(echo | openssl s_client -servername "$domain" -connect "${domain}:443" 2>/dev/null | \
             openssl x509 -noout -enddate 2>/dev/null | cut -d= -f2)
    # openssl s_client → connect to server and get cert
    # -servername → for SNI (multiple certs on same IP)
    # openssl x509 -enddate → extract expiry date
    
    if [ -z "$EXPIRY" ]; then
        echo "  ❌ $domain: Cannot retrieve certificate"
        continue
    fi
    
    # Calculate days remaining
    EXPIRY_EPOCH=$(date -d "$EXPIRY" +%s)
    NOW_EPOCH=$(date +%s)
    DAYS_LEFT=$(( (EXPIRY_EPOCH - NOW_EPOCH) / 86400 ))
    
    if [ "$DAYS_LEFT" -lt "$CRITICAL_DAYS" ]; then
        echo "  🚨 $domain: CRITICAL - ${DAYS_LEFT} days left (expires: $EXPIRY)"
    elif [ "$DAYS_LEFT" -lt "$WARNING_DAYS" ]; then
        echo "  ⚠️  $domain: WARNING - ${DAYS_LEFT} days left (expires: $EXPIRY)"
    else
        echo "  ✅ $domain: OK - ${DAYS_LEFT} days left"
    fi
done
```

---

### Q15: How do you process command-line arguments in scripts?

```bash
#!/bin/bash
# Proper argument parsing with getopts

usage() {
    cat <<EOF
Usage: $0 [OPTIONS]
Options:
    -e, --env        Environment (dev/staging/prod) [required]
    -v, --version    Version to deploy [required]
    -d, --dry-run    Show what would be done without doing it
    -f, --force      Skip confirmation prompt
    -h, --help       Show this help message
EOF
    exit 1
}

# Defaults
DRY_RUN=false
FORCE=false
ENV=""
VERSION=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -e|--env)
            ENV="$2"
            shift 2
            ;;
        -v|--version)
            VERSION="$2"
            shift 2
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Validate required arguments
[ -z "$ENV" ] && { echo "Error: --env is required"; usage; }
[ -z "$VERSION" ] && { echo "Error: --version is required"; usage; }

echo "Deploying v${VERSION} to ${ENV} (dry-run: ${DRY_RUN})"
```

---

### Q16: Write a script to find and clean up zombie/orphan processes.

```bash
#!/bin/bash
# zombie-cleaner.sh - Find and handle zombie processes

echo "🧟 Zombie Process Report"
echo "========================"

# Find zombie processes
ZOMBIES=$(ps aux | awk '$8 == "Z" {print $0}')

if [ -z "$ZOMBIES" ]; then
    echo "✅ No zombie processes found"
    exit 0
fi

ZOMBIE_COUNT=$(echo "$ZOMBIES" | wc -l)
echo "Found $ZOMBIE_COUNT zombie process(es):"
echo ""
echo "$ZOMBIES" | awk '{printf "  PID: %-8s PPID: %-8s CMD: %s\n", $2, $3, $11}'

echo ""
echo "Parent processes:"
echo "$ZOMBIES" | awk '{print $3}' | sort -u | while read -r ppid; do
    PARENT_CMD=$(ps -p "$ppid" -o comm= 2>/dev/null || echo "already dead")
    echo "  PPID $ppid: $PARENT_CMD"
    echo "  → To fix: kill -SIGCHLD $ppid (ask parent to reap)"
    echo "  → Nuclear: kill -9 $ppid (kill parent - zombies disappear)"
done
```

---

### Q17: Write a script for port scanning (simple connectivity test).

```bash
#!/bin/bash
# port-check.sh - Check connectivity to required services

set -uo pipefail

# Define services to check: host:port:description
SERVICES=(
    "db.internal:5432:PostgreSQL"
    "redis.internal:6379:Redis Cache"
    "kafka.internal:9092:Kafka Broker"
    "elasticsearch.internal:9200:Elasticsearch"
    "vault.internal:8200:HashiCorp Vault"
)

TIMEOUT=3
FAILED=0

echo "🔌 Service Connectivity Check"
echo "=============================="

for entry in "${SERVICES[@]}"; do
    IFS=':' read -r host port desc <<< "$entry"
    # IFS=':' → split on colon
    # read -r → read into variables
    
    if nc -z -w "$TIMEOUT" "$host" "$port" 2>/dev/null; then
        echo "  ✅ $desc ($host:$port) - reachable"
    else
        echo "  ❌ $desc ($host:$port) - UNREACHABLE"
        FAILED=$((FAILED + 1))
    fi
done

echo ""
if [ "$FAILED" -gt 0 ]; then
    echo "🚨 $FAILED service(s) unreachable!"
    exit 1
else
    echo "✅ All services reachable"
    exit 0
fi
```

---

### Q18: How do you use `awk` for log analysis?

```bash
# AWK is a pattern scanning and processing language
# Format: awk 'PATTERN {ACTION}' file

# Print specific columns
awk '{print $1, $4, $9}' access.log
# $1=IP, $4=timestamp, $9=status code

# Filter by condition
awk '$9 >= 500' access.log           # Only 5xx errors
awk '$9 == 200 && $10 > 1000' access.log  # 200 OK but response > 1000 bytes

# Count occurrences
awk '{count[$9]++} END {for (c in count) print c, count[c]}' access.log
# Creates array counting each status code, prints at END

# Calculate average response time (assuming $11 is response time)
awk '{sum+=$11; count++} END {print "Average:", sum/count, "ms"}' access.log

# Custom field separator
awk -F',' '{print $2}' data.csv      # Comma-separated
awk -F'|' '{print $3}' data.txt      # Pipe-separated

# Complex example: Find IPs with >100 requests in last hour
awk -v hour=$(date +%H) '$4 ~ ":" hour ":" {ips[$1]++} 
    END {for (ip in ips) if (ips[ip]>100) print ips[ip], ip}' access.log | sort -rn
```

---

### Q19: Write a Docker container monitoring script.

```bash
#!/bin/bash
# docker-monitor.sh - Monitor Docker containers health

set -uo pipefail

echo "🐳 Docker Container Status Report"
echo "==================================="

# Check Docker daemon is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker daemon is not running!"
    exit 1
fi

# List all containers with status
echo ""
echo "Container Status:"
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | head -20

# Check for unhealthy containers
UNHEALTHY=$(docker ps --filter health=unhealthy --format "{{.Names}}" 2>/dev/null)
if [ -n "$UNHEALTHY" ]; then
    echo ""
    echo "🚨 UNHEALTHY Containers:"
    echo "$UNHEALTHY" | while read -r container; do
        echo "  ❌ $container"
        echo "     Last health check: $(docker inspect --format='{{.State.Health.Log}}' "$container" | tail -1)"
    done
fi

# Check for containers restarting too often
echo ""
echo "⚠️  High Restart Counts:"
docker ps --format "{{.Names}} {{.Status}}" | while read -r name status; do
    RESTARTS=$(docker inspect --format='{{.RestartCount}}' "$name" 2>/dev/null)
    if [ "${RESTARTS:-0}" -gt 5 ]; then
        echo "  $name: $RESTARTS restarts"
    fi
done

# Disk usage
echo ""
echo "💾 Docker Disk Usage:"
docker system df

# Resource usage
echo ""
echo "📊 Resource Usage (top 5 by memory):"
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" | head -6
```

---

### Q20: Write a Kubernetes pod troubleshooting script.

```bash
#!/bin/bash
# k8s-debug.sh - Quick Kubernetes troubleshooting script
# Usage: ./k8s-debug.sh <namespace>

NAMESPACE="${1:-default}"

echo "🔍 Kubernetes Debug Report - Namespace: $NAMESPACE"
echo "=================================================="

# Pods not Running
echo ""
echo "❌ Non-Running Pods:"
kubectl get pods -n "$NAMESPACE" --field-selector=status.phase!=Running --no-headers 2>/dev/null | \
    awk '{printf "  %-50s Status: %s  Restarts: %s\n", $1, $3, $4}'

# Pods with high restart count
echo ""
echo "⚠️  Pods with High Restarts (>3):"
kubectl get pods -n "$NAMESPACE" --no-headers | awk '$4 > 3 {print "  "$1": "$4" restarts"}'

# Recent events (warnings only)
echo ""
echo "🚨 Recent Warning Events:"
kubectl get events -n "$NAMESPACE" --field-selector type=Warning --sort-by='.lastTimestamp' | tail -10

# Resource usage
echo ""
echo "📊 Resource Usage:"
kubectl top pods -n "$NAMESPACE" 2>/dev/null | sort -k3 -rn | head -10

# Pending pods (scheduling issues)
PENDING=$(kubectl get pods -n "$NAMESPACE" --field-selector=status.phase=Pending --no-headers 2>/dev/null)
if [ -n "$PENDING" ]; then
    echo ""
    echo "⏳ Pending Pods (scheduling issues):"
    echo "$PENDING" | while read -r line; do
        POD=$(echo "$line" | awk '{print $1}')
        echo "  $POD:"
        kubectl describe pod "$POD" -n "$NAMESPACE" | grep -A 3 "Events:" | tail -3 | sed 's/^/    /'
    done
fi
```

---

### Q21: How do you use `sed` for text processing?

```bash
# SED = Stream Editor - modifies text in files or streams

# Replace text (first occurrence per line)
sed 's/old/new/' file.txt

# Replace ALL occurrences per line
sed 's/old/new/g' file.txt

# Edit file in-place
sed -i 's/old/new/g' file.txt

# Delete lines matching pattern
sed -i '/^#/d' config.yml          # Delete comment lines
sed -i '/^$/d' config.yml          # Delete empty lines

# Insert line before/after match
sed -i '/server {/a\    include /etc/nginx/security.conf;' nginx.conf
# /server {/ → find this pattern
# a\ → append after

# Replace between line numbers
sed -i '10,20s/debug/info/g' app.conf    # Replace only in lines 10-20

# Multiple operations
sed -i -e 's/foo/bar/g' -e 's/baz/qux/g' file.txt

# Production example: Update Kubernetes image tag
sed -i "s|image: myapp:.*|image: myapp:v${VERSION}|" deployment.yaml
# Using | as delimiter (because : is in the text)
```

---

### Q22: Write a script to generate SSH config from AWS EC2.

```bash
#!/bin/bash
# gen-ssh-config.sh - Generate SSH config from running EC2 instances

OUTPUT="$HOME/.ssh/config.d/aws-instances"
KEY_PATH="$HOME/.ssh/aws-key.pem"

echo "# Auto-generated $(date)" > "$OUTPUT"
echo "" >> "$OUTPUT"

aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running" \
    --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value|[0],PrivateIpAddress]' \
    --output text | while read -r name ip; do
    
    # Skip instances without names
    [ "$name" = "None" ] && continue
    
    # Convert name to SSH-friendly hostname
    HOSTNAME=$(echo "$name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
    
    cat >> "$OUTPUT" <<EOF

Host $HOSTNAME
    HostName $ip
    User ec2-user
    IdentityFile $KEY_PATH
    StrictHostKeyChecking no

EOF
    echo "  Added: $HOSTNAME → $ip"
done

echo ""
echo "✅ SSH config written to $OUTPUT"
echo "Usage: ssh $HOSTNAME"
```

---

### Q23: Write a script for automated security patching.

```bash
#!/bin/bash
# security-patch.sh - Apply security patches with safety checks

set -euo pipefail

LOG="/var/log/patching-$(date +%Y%m%d).log"
REBOOT_REQUIRED=false

log() { echo "[$(date '+%H:%M:%S')] $*" | tee -a "$LOG"; }

log "🔒 Starting security patching"

# Pre-patch checks
log "Running pre-patch checks..."
DISK_FREE=$(df / | tail -1 | awk '{print $4}')
if [ "$DISK_FREE" -lt 1048576 ]; then  # Less than 1GB
    log "❌ Insufficient disk space for patching!"
    exit 1
fi

# List available security updates
log "Available security updates:"
apt-get update -qq 2>&1 | tee -a "$LOG"
UPDATES=$(apt-get -s upgrade 2>/dev/null | grep "^Inst" | grep -i securi | wc -l)
log "Found $UPDATES security update(s)"

if [ "$UPDATES" -eq 0 ]; then
    log "✅ System is up to date"
    exit 0
fi

# Apply security patches only
log "Applying security patches..."
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    -o Dpkg::Options::="--force-confold" \
    2>&1 | tee -a "$LOG"
# --force-confold → keep existing config files (don't overwrite)

# Check if reboot needed
if [ -f /var/run/reboot-required ]; then
    REBOOT_REQUIRED=true
    log "⚠️  Reboot required for patches to take effect"
fi

log "✅ Patching complete. Reboot required: $REBOOT_REQUIRED"
```

---

### Q24: Write a comprehensive environment setup validation script.

```bash
#!/bin/bash
# validate-env.sh - Validate all prerequisites before deployment
# Run this before deploying to ensure environment is ready

set -uo pipefail

ERRORS=0
WARNINGS=0

check() {
    local desc="$1"
    local cmd="$2"
    
    if eval "$cmd" > /dev/null 2>&1; then
        echo "  ✅ $desc"
    else
        echo "  ❌ $desc"
        ERRORS=$((ERRORS + 1))
    fi
}

warn() {
    local desc="$1"
    local cmd="$2"
    
    if eval "$cmd" > /dev/null 2>&1; then
        echo "  ✅ $desc"
    else
        echo "  ⚠️  $desc"
        WARNINGS=$((WARNINGS + 1))
    fi
}

echo "🔍 Environment Validation"
echo "========================="

echo ""
echo "📦 Required Tools:"
check "docker installed" "command -v docker"
check "kubectl installed" "command -v kubectl"
check "aws cli installed" "command -v aws"
check "helm installed" "command -v helm"
check "jq installed" "command -v jq"

echo ""
echo "🔌 Connectivity:"
check "Internet access" "ping -c 1 -W 3 8.8.8.8"
check "DNS resolution" "nslookup google.com"
check "Docker registry" "nc -z -w 3 registry.company.com 443"
check "Kubernetes API" "kubectl cluster-info"

echo ""
echo "🔑 Credentials:"
check "AWS credentials valid" "aws sts get-caller-identity"
check "Docker logged in" "docker info 2>&1 | grep -q Username"
check "Kubeconfig valid" "kubectl auth can-i get pods"

echo ""
echo "💾 Resources:"
check "Disk > 5GB free" "[ $(df / | tail -1 | awk '{print $4}') -gt 5242880 ]"
check "Memory > 2GB free" "[ $(free -m | awk '/Mem:/ {print $7}') -gt 2048 ]"
warn "Docker disk < 80%" "[ $(docker system df --format '{{.Size}}' 2>/dev/null | head -1 | grep -v '0B') ]"

echo ""
echo "========================="
echo "Results: $ERRORS error(s), $WARNINGS warning(s)"

if [ "$ERRORS" -gt 0 ]; then
    echo "❌ VALIDATION FAILED - Fix errors before deploying"
    exit 1
else
    echo "✅ Environment is ready for deployment"
    exit 0
fi
```

---

# 7. Ansible

## 📝 Ansible - 24 Interview Questions with Detailed Answers

### Q1: What is Ansible and why is it used?

**Simple explanation:** Ansible is an automation tool that configures servers, deploys applications, and orchestrates tasks - all without installing any agent on the target servers.

**Key features:**
- **Agentless** → Uses SSH (no software to install on targets)
- **Idempotent** → Run it 100 times, same result (safe to repeat)
- **Declarative** → You describe WHAT you want, not HOW to do it
- **YAML-based** → Easy to read and write

**Use cases:** Server configuration, application deployment, patch management, user management, cloud provisioning.

---

### Q2: Explain Ansible architecture and key components.

| Component | Purpose | Example |
|-----------|---------|---------|
| **Inventory** | List of servers to manage | `hosts.ini` or dynamic from AWS |
| **Playbook** | Set of tasks to execute | `deploy.yml` |
| **Task** | Single action to perform | Install package, copy file |
| **Module** | Code that performs the task | `apt`, `copy`, `service`, `docker_container` |
| **Role** | Reusable set of tasks | `nginx-role`, `docker-role` |
| **Handler** | Action triggered by change | Restart nginx when config changes |
| **Variable** | Configurable values | Port numbers, file paths |
| **Template** | Dynamic file with variables | Jinja2 `.j2` files |

---

### Q3: Write a production playbook to configure a web server.

```yaml
---
# webserver.yml - Configure Nginx web server
- name: Configure Web Servers
  hosts: webservers              # Group from inventory
  become: yes                    # Run as root (sudo)
  vars:
    app_port: 8080
    domain: "myapp.company.com"

  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes
        cache_valid_time: 3600    # Don't update if updated within 1 hour

    - name: Install Nginx
      apt:
        name: nginx
        state: present            # Ensure installed (idempotent)
      notify: Restart Nginx       # Trigger handler if changed

    - name: Deploy Nginx config
      template:
        src: templates/nginx.conf.j2    # Jinja2 template
        dest: /etc/nginx/sites-available/myapp.conf
        owner: root
        group: root
        mode: '0644'
      notify: Restart Nginx

    - name: Enable site
      file:
        src: /etc/nginx/sites-available/myapp.conf
        dest: /etc/nginx/sites-enabled/myapp.conf
        state: link               # Create symlink

    - name: Ensure Nginx is running and enabled
      service:
        name: nginx
        state: started
        enabled: yes              # Start on boot

    - name: Open firewall for HTTP/HTTPS
      ufw:
        rule: allow
        port: "{{ item }}"
        proto: tcp
      loop:
        - "80"
        - "443"

  handlers:
    - name: Restart Nginx
      service:
        name: nginx
        state: restarted
```

**Nginx template (`templates/nginx.conf.j2`):**
```nginx
server {
    listen 80;
    server_name {{ domain }};

    location / {
        proxy_pass http://127.0.0.1:{{ app_port }};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

---

### Q4: Explain Ansible inventory (static and dynamic).

```ini
# Static inventory (hosts.ini)
[webservers]
web1.company.com ansible_host=10.0.1.10
web2.company.com ansible_host=10.0.1.11

[dbservers]
db1.company.com ansible_host=10.0.2.10 ansible_user=dbadmin

[production:children]
webservers
dbservers

[production:vars]
ansible_ssh_private_key_file=~/.ssh/prod-key.pem
env=production
```

**Dynamic inventory** (from AWS):
```bash
# ansible.cfg
[defaults]
inventory = aws_ec2.yml

# aws_ec2.yml
plugin: amazon.aws.aws_ec2
regions:
  - us-east-1
filters:
  instance-state-name: running
keyed_groups:
  - key: tags.Environment
    prefix: env
  - key: tags.Role
    prefix: role
```

---

### Q5: What are Ansible Roles and how do you structure them?

```
roles/
└── nginx/
    ├── tasks/
    │   └── main.yml         # Main task list
    ├── handlers/
    │   └── main.yml         # Handlers (restart, reload)
    ├── templates/
    │   └── nginx.conf.j2    # Jinja2 templates
    ├── files/
    │   └── ssl-cert.pem     # Static files
    ├── vars/
    │   └── main.yml         # Role variables
    ├── defaults/
    │   └── main.yml         # Default values (overridable)
    └── meta/
        └── main.yml         # Dependencies on other roles
```

**Using roles in playbook:**
```yaml
- hosts: webservers
  become: yes
  roles:
    - common          # Basic server setup
    - nginx           # Web server
    - monitoring      # Node exporter, etc.
```

---

### Q6: How do you handle secrets in Ansible?

```bash
# Ansible Vault - encrypts sensitive data

# Encrypt a file
ansible-vault encrypt secrets.yml

# Edit encrypted file
ansible-vault edit secrets.yml

# Run playbook with vault password
ansible-playbook deploy.yml --ask-vault-pass
# OR
ansible-playbook deploy.yml --vault-password-file ~/.vault_pass

# Encrypt single variable
ansible-vault encrypt_string 'SuperSecret123' --name 'db_password'
```

```yaml
# secrets.yml (encrypted)
db_password: !vault |
  $ANSIBLE_VAULT;1.1;AES256
  62313365396662643134...

# Usage in playbook
- name: Configure database
  template:
    src: db.conf.j2
    dest: /etc/myapp/db.conf
  vars_files:
    - secrets.yml
```

---

### Q7: How do you make Ansible idempotent?

```yaml
# ✅ IDEMPOTENT (safe to run multiple times)
- name: Ensure file exists with correct content
  copy:
    content: "config_value=true"
    dest: /etc/myapp.conf

# ❌ NOT IDEMPOTENT (appends every time)
- name: Add config
  shell: echo "config_value=true" >> /etc/myapp.conf

# ✅ Fix with lineinfile (idempotent)
- name: Ensure config line exists
  lineinfile:
    path: /etc/myapp.conf
    line: "config_value=true"
    state: present
```

**Rules for idempotency:**
- Use modules (`copy`, `template`, `service`) instead of `shell`/`command`
- Use `creates:` parameter with `command` module
- Use `state: present/absent` parameters
- Use `lineinfile` instead of `echo >>` for file modifications

---

### Q8: Write a playbook for Docker deployment.

```yaml
---
- name: Deploy Docker Application
  hosts: app_servers
  become: yes
  vars:
    app_name: payment-service
    image: "registry.company.com/{{ app_name }}"
    version: "{{ deploy_version | default('latest') }}"
    app_port: 8080

  tasks:
    - name: Ensure Docker is installed
      apt:
        name: docker.io
        state: present

    - name: Log in to Docker registry
      docker_login:
        registry: registry.company.com
        username: "{{ docker_user }}"
        password: "{{ docker_pass }}"

    - name: Pull new image
      docker_image:
        name: "{{ image }}"
        tag: "{{ version }}"
        source: pull
        force_source: yes

    - name: Stop old container
      docker_container:
        name: "{{ app_name }}"
        state: absent

    - name: Start new container
      docker_container:
        name: "{{ app_name }}"
        image: "{{ image }}:{{ version }}"
        state: started
        restart_policy: unless-stopped
        ports:
          - "{{ app_port }}:{{ app_port }}"
        env:
          DATABASE_URL: "{{ db_url }}"
          LOG_LEVEL: "info"
        healthcheck:
          test: ["CMD", "curl", "-f", "http://localhost:{{ app_port }}/health"]
          interval: 30s
          timeout: 10s
          retries: 3

    - name: Wait for application to be healthy
      uri:
        url: "http://localhost:{{ app_port }}/health"
        status_code: 200
      register: health_check
      until: health_check.status == 200
      retries: 10
      delay: 5
```

---

### Q9: How do you use Ansible conditionals and loops?

```yaml
# Conditionals (when)
- name: Install on Ubuntu only
  apt:
    name: nginx
  when: ansible_os_family == "Debian"

- name: Install on CentOS only
  yum:
    name: nginx
  when: ansible_os_family == "RedHat"

# Loops
- name: Create multiple users
  user:
    name: "{{ item.name }}"
    groups: "{{ item.groups }}"
    state: present
  loop:
    - { name: 'deploy', groups: 'docker' }
    - { name: 'monitor', groups: 'prometheus' }
    - { name: 'backup', groups: 'admin' }

# Loop with conditional
- name: Start services only if installed
  service:
    name: "{{ item }}"
    state: started
  loop:
    - nginx
    - docker
    - prometheus-node-exporter
  when: item in ansible_facts.packages
```

---

### Q10: How do you handle errors in Ansible?

```yaml
# Ignore errors on specific task
- name: Check if service exists
  command: systemctl status myapp
  register: service_status
  ignore_errors: yes

- name: Install if not exists
  apt:
    name: myapp
  when: service_status.rc != 0

# Block with rescue (try-catch)
- block:
    - name: Deploy new version
      docker_container:
        name: myapp
        image: "myapp:{{ version }}"
        state: started

    - name: Verify deployment
      uri:
        url: http://localhost:8080/health
        status_code: 200
      register: health
      until: health.status == 200
      retries: 5
      delay: 10

  rescue:
    - name: Rollback on failure
      docker_container:
        name: myapp
        image: "myapp:{{ previous_version }}"
        state: started

    - name: Notify team
      slack:
        token: "{{ slack_token }}"
        msg: "Deployment failed! Rolled back to {{ previous_version }}"

  always:
    - name: Clean up temp files
      file:
        path: /tmp/deploy-artifacts
        state: absent
```

---

### Q11: What is the difference between `copy`, `template`, and `file` modules?

| Module | Purpose | Use When |
|--------|---------|----------|
| `copy` | Copy static file to remote | File content is fixed |
| `template` | Copy file with variable substitution (Jinja2) | File needs dynamic values |
| `file` | Manage file/directory properties | Create dirs, symlinks, set permissions |

---

### Q12: How do you run Ansible against specific hosts?

```bash
# Run against all hosts in inventory
ansible-playbook deploy.yml

# Run against specific group
ansible-playbook deploy.yml --limit webservers

# Run against specific host
ansible-playbook deploy.yml --limit web1.company.com

# Run against multiple groups
ansible-playbook deploy.yml --limit 'webservers:&production'

# Dry run (check mode)
ansible-playbook deploy.yml --check --diff

# Run specific tags only
ansible-playbook deploy.yml --tags "deploy,config"

# Skip certain tags
ansible-playbook deploy.yml --skip-tags "monitoring"
```

---

### Q13: How do you use Ansible with Kubernetes?

```yaml
- name: Deploy to Kubernetes
  hosts: localhost
  connection: local
  tasks:
    - name: Apply deployment manifest
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: myapp
            namespace: production
          spec:
            replicas: 3
            selector:
              matchLabels:
                app: myapp
            template:
              metadata:
                labels:
                  app: myapp
              spec:
                containers:
                - name: myapp
                  image: "registry/myapp:{{ version }}"
                  ports:
                  - containerPort: 8080

    - name: Wait for rollout
      kubernetes.core.k8s_info:
        kind: Deployment
        name: myapp
        namespace: production
      register: deploy_status
      until: deploy_status.resources[0].status.readyReplicas == 3
      retries: 30
      delay: 10
```

---

### Q14: What are Ansible facts and how do you use them?

```yaml
# Facts are auto-collected information about target systems
- name: Show facts
  debug:
    msg: |
      OS: {{ ansible_os_family }}
      IP: {{ ansible_default_ipv4.address }}
      RAM: {{ ansible_memtotal_mb }} MB
      CPUs: {{ ansible_processor_vcpus }}
      Hostname: {{ ansible_hostname }}
      Disk: {{ ansible_mounts[0].size_total }}

# Custom facts
- name: Set custom fact
  set_fact:
    app_version: "1.2.3"
    deploy_time: "{{ ansible_date_time.iso8601 }}"

# Gather subset of facts (faster)
- hosts: all
  gather_facts: yes
  gather_subset:
    - network
    - hardware
```

---

### Q15: How do you optimize Ansible performance?

```ini
# ansible.cfg optimizations
[defaults]
forks = 20                      # Parallel hosts (default is 5)
pipelining = True               # Reduce SSH operations
gathering = smart               # Cache facts
fact_caching = jsonfile
fact_caching_connection = /tmp/ansible_facts
fact_caching_timeout = 3600

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s
# Reuses SSH connections (much faster for multiple tasks)
```

```yaml
# Async tasks (don't wait for completion)
- name: Long-running task
  command: /scripts/rebuild-index.sh
  async: 3600        # Max runtime: 1 hour
  poll: 0            # Don't wait (fire and forget)
```

---

### Q16: Write a playbook for user management.

```yaml
---
- name: Manage Users
  hosts: all
  become: yes
  vars:
    users:
      - name: deploy
        groups: docker,sudo
        ssh_key: "ssh-rsa AAAA... deploy@company"
      - name: monitoring
        groups: prometheus
        ssh_key: "ssh-rsa AAAA... monitor@company"
    removed_users:
      - olduser1
      - contractor_expired

  tasks:
    - name: Create users
      user:
        name: "{{ item.name }}"
        groups: "{{ item.groups }}"
        shell: /bin/bash
        create_home: yes
        state: present
      loop: "{{ users }}"

    - name: Set SSH keys
      authorized_key:
        user: "{{ item.name }}"
        key: "{{ item.ssh_key }}"
        exclusive: yes     # Remove any other keys
      loop: "{{ users }}"

    - name: Remove old users
      user:
        name: "{{ item }}"
        state: absent
        remove: yes        # Remove home directory too
      loop: "{{ removed_users }}"
```

---

### Q17: What is Ansible Galaxy and how do you use it?

```bash
# Install community roles
ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.nginx

# Install from requirements file
# requirements.yml:
# - src: geerlingguy.docker
#   version: 6.0.0
# - src: git+https://github.com/company/ansible-role-app.git
#   version: main
ansible-galaxy install -r requirements.yml

# Use installed role
# playbook.yml:
# - hosts: all
#   roles:
#     - geerlingguy.docker
```

---

### Q18: How do you test Ansible playbooks?

```bash
# 1. Syntax check
ansible-playbook deploy.yml --syntax-check

# 2. Dry run (check mode)
ansible-playbook deploy.yml --check --diff

# 3. Molecule (testing framework)
# molecule/default/molecule.yml
molecule init role my_role
molecule test
```

---

### Q19: How do you handle different environments in Ansible?

```
inventory/
├── production/
│   ├── hosts.ini
│   └── group_vars/
│       ├── all.yml        # Variables for all production hosts
│       └── webservers.yml
├── staging/
│   ├── hosts.ini
│   └── group_vars/
│       ├── all.yml
│       └── webservers.yml
```

```bash
# Deploy to staging
ansible-playbook deploy.yml -i inventory/staging/

# Deploy to production
ansible-playbook deploy.yml -i inventory/production/
```

---

### Q20: Write a playbook for security hardening.

```yaml
---
- name: Security Hardening
  hosts: all
  become: yes
  tasks:
    - name: Disable root SSH
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: '^PermitRootLogin'
        line: 'PermitRootLogin no'
      notify: Restart SSH

    - name: Disable password authentication
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: '^PasswordAuthentication'
        line: 'PasswordAuthentication no'
      notify: Restart SSH

    - name: Set SSH timeout
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: '^ClientAliveInterval'
        line: 'ClientAliveInterval 300'
      notify: Restart SSH

    - name: Install fail2ban
      apt:
        name: fail2ban
        state: present

    - name: Configure firewall
      ufw:
        rule: "{{ item.rule }}"
        port: "{{ item.port }}"
        proto: tcp
      loop:
        - { rule: 'allow', port: '22' }
        - { rule: 'allow', port: '443' }
        - { rule: 'deny', port: '23' }    # Block telnet

    - name: Enable firewall
      ufw:
        state: enabled
        policy: deny    # Deny all by default

  handlers:
    - name: Restart SSH
      service:
        name: sshd
        state: restarted
```

---

### Q21: How do you use Ansible callback plugins and logging?

```ini
# ansible.cfg
[defaults]
callback_whitelist = timer, profile_tasks
log_path = /var/log/ansible.log

# profile_tasks → shows time taken per task (find slow tasks)
# timer → shows total playbook time
```

---

### Q22: How do you delegate tasks in Ansible?

```yaml
# Run task on a different host
- name: Remove host from load balancer
  uri:
    url: "http://lb.internal/api/remove"
    method: POST
    body_format: json
    body: '{"host": "{{ inventory_hostname }}"}'
  delegate_to: localhost      # Run this on control machine, not target

- name: Deploy application
  apt:
    name: myapp
    state: latest

- name: Add host back to load balancer
  uri:
    url: "http://lb.internal/api/add"
    method: POST
    body_format: json
    body: '{"host": "{{ inventory_hostname }}"}'
  delegate_to: localhost
```

---

### Q23: What is `register` and how do you use task output?

```yaml
- name: Check if app is running
  command: pgrep -f myapp
  register: app_status
  ignore_errors: yes

# Use registered variable
- name: Start app if not running
  command: /opt/myapp/start.sh
  when: app_status.rc != 0
  # .rc = return code (0=found, 1=not found)

- name: Show output
  debug:
    msg: "App PIDs: {{ app_status.stdout_lines }}"
  when: app_status.rc == 0
```

---

### Q24: How do you do rolling deployments with Ansible?

```yaml
---
- name: Rolling Deployment
  hosts: webservers
  serial: 2              # Deploy to 2 servers at a time
  max_fail_percentage: 25  # Stop if >25% of hosts fail
  become: yes

  pre_tasks:
    - name: Remove from load balancer
      uri:
        url: "http://lb/api/drain/{{ inventory_hostname }}"
        method: POST
      delegate_to: localhost

    - name: Wait for connections to drain
      pause:
        seconds: 30

  tasks:
    - name: Deploy new version
      apt:
        name: myapp
        state: latest
      notify: Restart app

  post_tasks:
    - name: Verify health
      uri:
        url: "http://{{ inventory_hostname }}:8080/health"
        status_code: 200
      retries: 5
      delay: 10

    - name: Add back to load balancer
      uri:
        url: "http://lb/api/enable/{{ inventory_hostname }}"
        method: POST
      delegate_to: localhost

  handlers:
    - name: Restart app
      service:
        name: myapp
        state: restarted
```

---

# 8. Docker

## 📝 Docker - 24 Interview Questions with Detailed Answers

### Q1: What is Docker and why do we use it?

**Simple explanation:** Docker packages your application AND everything it needs (libraries, runtime, config) into a single portable unit called a **container**.

**Real-world analogy:** Shipping containers - doesn't matter what's inside, they all fit on the same ship. Docker containers work the same on any server.

**Problems it solves:**
- "Works on my machine" → Same container runs identically everywhere
- Dependency conflicts → Each app has its own isolated environment
- Slow deployments → Start containers in seconds
- Resource waste → Multiple containers share one OS (lighter than VMs)

---

### Q2: Write a production-ready Dockerfile.

```dockerfile
# Multi-stage build - keeps final image small and secure
# Stage 1: Build
FROM node:18-alpine AS builder
# node:18-alpine = small base image (5MB alpine vs 900MB ubuntu)
# AS builder = name this stage for reference later

WORKDIR /app
# Set working directory (like cd /app, creates if not exists)

COPY package*.json ./
# Copy only package files first (Docker caching optimization)
# If dependencies don't change, this layer is cached = faster builds

RUN npm ci --only=production
# npm ci = clean install (reproducible, uses package-lock.json)
# --only=production = skip dev dependencies (smaller image)

COPY . .
# Copy rest of application source code

RUN npm run build
# Build the application

# Stage 2: Production image
FROM node:18-alpine AS production
# Fresh image - only copy what we need from builder

# Security: Don't run as root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
# -S = system user/group (no password, no home)

WORKDIR /app

# Copy only built artifacts from builder stage
COPY --from=builder --chown=appuser:appgroup /app/dist ./dist
COPY --from=builder --chown=appuser:appgroup /app/node_modules ./node_modules
COPY --from=builder --chown=appuser:appgroup /app/package.json ./

# Switch to non-root user
USER appuser

# Document which port the app uses
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1

# Start the application
CMD ["node", "dist/server.js"]
# Use exec form (array) not shell form - proper signal handling
```

---

### Q3: What is the difference between CMD, ENTRYPOINT, and RUN?

| Instruction | When it runs | Purpose | Overridable? |
|------------|-------------|---------|--------------|
| `RUN` | During image BUILD | Install packages, build code | N/A (baked into image) |
| `CMD` | When container STARTS | Default command to run | Yes (docker run ... <new_cmd>) |
| `ENTRYPOINT` | When container STARTS | Fixed command (always runs) | Only with --entrypoint |

```dockerfile
# Example showing the difference:
RUN apt-get update && apt-get install -y curl    # Runs during build
ENTRYPOINT ["python", "app.py"]                   # Always runs python app.py
CMD ["--port", "8080"]                            # Default args (overridable)

# docker run myapp               → python app.py --port 8080
# docker run myapp --port 9090   → python app.py --port 9090
```

---

### Q4: How does Docker networking work?

```bash
# Default networks
docker network ls
# bridge  → Default for standalone containers (isolation per container)
# host    → Container shares host's network (no isolation)
# none    → No networking

# Create custom network (RECOMMENDED)
docker network create myapp-network

# Containers on same custom network can reach each other BY NAME
docker run -d --name api --network myapp-network api-image
docker run -d --name db --network myapp-network postgres
# api can reach db at hostname "db" (Docker DNS)

# Expose ports to host
docker run -d -p 8080:3000 myapp
# 8080 = host port (what external clients use)
# 3000 = container port (what app listens on inside)
```

---

### Q5: How do you debug a container that keeps crashing?

```bash
# Step 1: Check container logs
docker logs <container-id> --tail 50
docker logs <container-id> -f    # Follow in real-time

# Step 2: Check container events
docker inspect <container-id> | jq '.[0].State'
# Look at: ExitCode, OOMKilled, Error

# Step 3: If OOMKilled=true → Container ran out of memory
# Fix: Increase memory limit
docker run -m 512m myapp

# Step 4: Start container with shell (bypass CMD)
docker run -it --entrypoint /bin/sh myapp
# Now you're inside → debug manually

# Step 5: Check what's different from working state
docker diff <container-id>      # Shows changed files
docker top <container-id>       # Shows running processes
docker stats <container-id>     # Shows resource usage
```

---

### Q6: What are Docker volumes and when to use them?

```bash
# Volumes persist data beyond container lifecycle

# Named volume (Docker manages storage)
docker volume create db-data
docker run -v db-data:/var/lib/postgresql/data postgres

# Bind mount (map host directory into container)
docker run -v /host/path:/container/path myapp
# Useful for: development (code changes reflect immediately)

# tmpfs mount (in memory, fast but not persistent)
docker run --tmpfs /tmp myapp
```

| Type | Use Case | Persistence |
|------|----------|-------------|
| Named Volume | Database data, persistent storage | Survives container removal |
| Bind Mount | Dev environment, config files | Host filesystem |
| tmpfs | Secrets, temp data | Gone when container stops |

---

### Q7: How do you optimize Docker image size?

```dockerfile
# ❌ BAD: 1.2GB image
FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install -y python3 python3-pip
RUN pip install -r requirements.txt
COPY . .

# ✅ GOOD: 85MB image
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

FROM python:3.11-slim
COPY --from=builder /root/.local /root/.local
COPY . /app
WORKDIR /app
ENV PATH=/root/.local/bin:$PATH
CMD ["python", "app.py"]
```

**Optimization tips:**
1. Use `alpine` or `slim` base images
2. Multi-stage builds (build in one, run in another)
3. Combine RUN commands (fewer layers)
4. Use `.dockerignore` (exclude node_modules, .git, etc.)
5. Order Dockerfile for cache efficiency (static → dynamic)

---

### Q8: Explain Docker Compose with a production example.

```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "8080:8080"
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/mydb
      - REDIS_URL=redis://cache:6379
    depends_on:
      db:
        condition: service_healthy
      cache:
        condition: service_started
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M

  db:
    image: postgres:15-alpine
    volumes:
      - db-data:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: mydb
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 10s
      timeout: 5s
      retries: 5

  cache:
    image: redis:7-alpine
    volumes:
      - redis-data:/data

volumes:
  db-data:
  redis-data:
```

---

### Q9: What is the difference between Docker image and container?

| Concept | Image | Container |
|---------|-------|-----------|
| What is it | Blueprint/template | Running instance of image |
| State | Read-only (immutable) | Read-write (has runtime state) |
| Analogy | Class (in programming) | Object (instance of class) |
| Storage | Stored in registry | Runs on Docker host |
| Create from | Dockerfile | docker run <image> |

---

### Q10: How do you scan Docker images for vulnerabilities?

```bash
# Using Trivy (most popular)
trivy image myapp:latest

# In CI/CD pipeline:
trivy image --severity HIGH,CRITICAL --exit-code 1 myapp:latest
# --exit-code 1 → Fail the pipeline if vulnerabilities found

# Docker Scout (built into Docker)
docker scout cves myapp:latest

# Best practices:
# 1. Scan in CI/CD before pushing to registry
# 2. Use minimal base images (less attack surface)
# 3. Update base images regularly
# 4. Don't run as root in containers
```

---

### Q11: How does Docker layer caching work?

Each line in Dockerfile creates a layer. Docker caches layers and reuses them if nothing changed.

```dockerfile
# ✅ Good order (cache-friendly)
COPY package.json .          # Layer 1: Changes rarely
RUN npm install              # Layer 2: Cached if package.json didn't change
COPY . .                     # Layer 3: Changes often (source code)

# ❌ Bad order (breaks cache)
COPY . .                     # Layer 1: Changes every time
RUN npm install              # Layer 2: NEVER cached (because Layer 1 always changes)
```

---

### Q12: How do you implement container health checks?

```dockerfile
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1
```

```bash
# Check health status
docker inspect --format='{{.State.Health.Status}}' mycontainer
# Output: healthy / unhealthy / starting

# Docker Compose health check
healthcheck:
  test: ["CMD", "pg_isready"]
  interval: 10s
  timeout: 5s
  retries: 5
  start_period: 30s
```

---

### Q13: What are Docker security best practices?

1. **Don't run as root** → Use `USER` instruction
2. **Use minimal base images** → `alpine`, `distroless`
3. **Scan for vulnerabilities** → Trivy, Snyk
4. **Don't store secrets in images** → Use env vars or secret mounts
5. **Read-only filesystem** → `docker run --read-only`
6. **Limit resources** → `--memory`, `--cpus`
7. **Use `.dockerignore`** → Don't copy secrets/keys into image
8. **Pin versions** → `FROM node:18.17.0-alpine` not `FROM node:latest`

---

### Q14: How do you clean up Docker resources?

```bash
# Remove all stopped containers
docker container prune -f

# Remove unused images
docker image prune -a -f

# Remove unused volumes
docker volume prune -f

# Remove everything unused (nuclear option)
docker system prune -a --volumes -f

# Check disk usage
docker system df
```

---

### Q15: How do you pass secrets to Docker containers securely?

```bash
# ❌ BAD: Secrets in Dockerfile or docker-compose env
ENV API_KEY=supersecret    # Visible in image layers!

# ✅ Option 1: Runtime environment variables
docker run -e API_KEY="$(vault read -field=key secret/myapp)" myapp

# ✅ Option 2: Docker secrets (Swarm mode)
echo "supersecret" | docker secret create api_key -

# ✅ Option 3: Mount secret file
docker run -v /run/secrets/api_key:/run/secrets/api_key:ro myapp

# ✅ Option 4: BuildKit secrets (for build-time)
docker build --secret id=npmrc,src=.npmrc .
# In Dockerfile:
RUN --mount=type=secret,id=npmrc cp /run/secrets/npmrc ~/.npmrc && npm ci
```

---

### Q16: How do you do container-to-container communication?

```bash
# Same Docker network → use container name as hostname
docker network create backend
docker run -d --name api --network backend api-image
docker run -d --name db --network backend postgres

# From api container: connect to "db:5432" (Docker DNS resolves it)

# Cross-network communication
docker network connect frontend api
# Now api is on both "backend" and "frontend" networks
```

---

### Q17: What is Docker BuildKit and why use it?

```bash
# Enable BuildKit
DOCKER_BUILDKIT=1 docker build .

# Benefits:
# - Parallel stage execution (faster builds)
# - Better caching (cache mounts)
# - Secret mounts (don't leak secrets in layers)
# - SSH forwarding for private repos

# Cache mount example (speeds up package installs)
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install -r requirements.txt
```

---

### Q18: How do you monitor Docker containers in production?

```bash
# Real-time stats
docker stats

# cAdvisor (Container Advisor by Google)
docker run -d --name cadvisor \
    -v /:/rootfs:ro \
    -v /var/run:/var/run:ro \
    -v /sys:/sys:ro \
    -v /var/lib/docker/:/var/lib/docker:ro \
    -p 9090:8080 \
    gcr.io/cadvisor/cadvisor

# Prometheus + Grafana stack for production monitoring
# cadvisor exposes metrics → Prometheus scrapes → Grafana displays
```

---

### Q19: How do you handle logging in Docker?

```bash
# View logs
docker logs <container> --tail 100 -f

# Logging drivers
docker run --log-driver=json-file --log-opt max-size=10m --log-opt max-file=3 myapp
# max-size=10m → Each log file max 10MB
# max-file=3 → Keep max 3 rotated files

# Send to centralized logging
docker run --log-driver=fluentd --log-opt fluentd-address=localhost:24224 myapp
```

---

### Q20: What is the difference between `docker stop` and `docker kill`?

| Command | Signal | Behavior |
|---------|--------|----------|
| `docker stop` | SIGTERM → wait 10s → SIGKILL | Graceful (app can cleanup) |
| `docker kill` | SIGKILL immediately | Forced (no cleanup, data loss risk) |

---

### Q21: How do you manage Docker images in CI/CD?

```bash
# Build with meaningful tags
docker build -t myapp:${GIT_SHA} -t myapp:latest .

# Push to registry
docker push myapp:${GIT_SHA}

# Best practice: Tag with commit SHA (immutable, traceable)
# Never rely solely on :latest in production
```

---

### Q22: How do you limit container resources?

```bash
docker run \
    --memory=512m \           # Max 512MB RAM
    --memory-swap=1g \        # Max 1GB RAM + swap
    --cpus=1.5 \              # Max 1.5 CPU cores
    --pids-limit=100 \        # Max 100 processes
    --ulimit nofile=1024:1024 \  # File descriptor limit
    myapp
```

---

### Q23: What is Docker overlay network?

Used in Docker Swarm/multi-host deployments to allow containers on different physical hosts to communicate as if on the same network.

```bash
docker network create --driver overlay --attachable my-overlay
# --driver overlay → Multi-host networking
# --attachable → Standalone containers can join too
```

---

### Q24: How do you troubleshoot Docker networking issues?

```bash
# 1. Check container's network settings
docker inspect <container> | jq '.[0].NetworkSettings'

# 2. Check DNS resolution inside container
docker exec <container> nslookup other-service

# 3. Check connectivity
docker exec <container> nc -zv other-service 8080

# 4. Check if port is published correctly
docker port <container>

# 5. Check iptables rules (Docker adds its own)
iptables -t nat -L -n | grep DOCKER

# 6. Test from inside container
docker exec -it <container> sh
# Then use curl, ping, nc, etc.
```

---

# 9. Kubernetes

## 📝 Kubernetes - 24 Interview Questions with Detailed Answers

### Q1: What is Kubernetes and why do we need it?

**Simple explanation:** Kubernetes (K8s) is a container orchestration platform - it manages running, scaling, healing, and networking of containers across multiple servers.

**What it solves:**
- **Self-healing** → Container crashes? K8s restarts it automatically
- **Scaling** → Traffic spike? K8s creates more containers
- **Load balancing** → Distributes traffic across containers
- **Rolling updates** → Deploy new versions without downtime
- **Service discovery** → Containers find each other by name

---

### Q2: Explain Kubernetes architecture.

```
┌─────────────── Control Plane (Master) ───────────────┐
│  API Server  │  Scheduler  │  Controller  │  etcd    │
│  (frontend)  │  (placement)│  (desired    │  (state  │
│              │             │   state)     │  store)  │
└──────────────────────────────────────────────────────┘
         │
         ├──── Worker Node 1
         │     ├── kubelet (agent)
         │     ├── kube-proxy (networking)
         │     └── Pods (containers)
         │
         └──── Worker Node 2
               ├── kubelet
               ├── kube-proxy
               └── Pods
```

| Component | Role |
|-----------|------|
| API Server | Front door - all requests go through here |
| etcd | Database storing entire cluster state |
| Scheduler | Decides which node runs new pods |
| Controller Manager | Ensures desired state matches actual state |
| kubelet | Agent on each node, manages pods |
| kube-proxy | Handles networking rules on each node |

---

### Q3: What is a Pod, Deployment, Service, and Ingress?

| Resource | Purpose | Analogy |
|----------|---------|---------|
| **Pod** | Smallest unit, runs 1+ containers | A single apartment |
| **Deployment** | Manages pod replicas and updates | Building manager |
| **Service** | Stable network endpoint for pods | Reception desk |
| **Ingress** | External HTTP routing to services | Main entrance gate |

```yaml
# Complete example: Deploy a web app
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  namespace: production
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: registry/myapp:v1.2.3
        ports:
        - containerPort: 8080
        resources:
          requests:
            cpu: 100m          # Minimum guaranteed
            memory: 128Mi
          limits:
            cpu: 500m          # Maximum allowed
            memory: 512Mi
        readinessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 15
          periodSeconds: 20
---
apiVersion: v1
kind: Service
metadata:
  name: myapp
spec:
  selector:
    app: myapp       # Routes to pods with this label
  ports:
  - port: 80         # Service port (what clients use)
    targetPort: 8080  # Container port
  type: ClusterIP     # Internal only
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: myapp.company.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: myapp
            port:
              number: 80
```

---

### Q4: How do you troubleshoot a pod that won't start?

```bash
# Step 1: Check pod status
kubectl get pods -n <namespace>
# STATUS column: Pending, CrashLoopBackOff, ImagePullBackOff, Error

# Step 2: Describe pod (shows events)
kubectl describe pod <pod-name> -n <namespace>
# Look at "Events" section at the bottom

# Step 3: Based on status:

# ImagePullBackOff → Can't download the image
# Fix: Check image name/tag, registry credentials
kubectl get events --field-selector reason=Failed

# CrashLoopBackOff → Container starts and crashes repeatedly
# Fix: Check logs
kubectl logs <pod-name> -n <namespace>
kubectl logs <pod-name> -n <namespace> --previous  # Previous crash logs

# Pending → Can't be scheduled
# Fix: Check resources, node conditions
kubectl describe pod <pod> | grep -A 5 "Events"
# Common: "Insufficient cpu" or "Insufficient memory"

# OOMKilled → Ran out of memory
kubectl describe pod <pod> | grep -i "oom"
# Fix: Increase memory limits
```

---

### Q5: What are liveness and readiness probes?

| Probe | Purpose | On Failure |
|-------|---------|------------|
| **Liveness** | "Is the app alive?" | K8s restarts the container |
| **Readiness** | "Is the app ready for traffic?" | K8s removes from Service (no traffic) |
| **Startup** | "Has the app finished starting?" | Delays other probes |

```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 30    # Wait 30s before first check
  periodSeconds: 10          # Check every 10s
  failureThreshold: 3        # 3 failures = restart

readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 5
  failureThreshold: 2        # 2 failures = remove from service
```

---

### Q6: How does Horizontal Pod Autoscaler (HPA) work?

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: myapp-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: myapp
  minReplicas: 2
  maxReplicas: 20
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70    # Scale up when CPU > 70%
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

```bash
# Check HPA status
kubectl get hpa
# NAME        REFERENCE       TARGETS   MINPODS   MAXPODS   REPLICAS
# myapp-hpa   Deployment/myapp   45%/70%   2         20        3
```

---

### Q7: What are ConfigMaps and Secrets?

```yaml
# ConfigMap - Non-sensitive configuration
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DATABASE_HOST: "db.internal"
  LOG_LEVEL: "info"
  config.yml: |
    server:
      port: 8080
      timeout: 30s

---
# Secret - Sensitive data (base64 encoded)
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  DB_PASSWORD: cGFzc3dvcmQxMjM=    # echo -n 'password123' | base64

---
# Using in Pod
spec:
  containers:
  - name: myapp
    envFrom:
    - configMapRef:
        name: app-config
    - secretRef:
        name: app-secrets
    volumeMounts:
    - name: config-volume
      mountPath: /etc/myapp
  volumes:
  - name: config-volume
    configMap:
      name: app-config
```

---

### Q8: How do you do rolling updates and rollbacks?

```bash
# Update image (triggers rolling update)
kubectl set image deployment/myapp myapp=registry/myapp:v2.0.0

# Watch rollout progress
kubectl rollout status deployment/myapp

# Check rollout history
kubectl rollout history deployment/myapp

# Rollback to previous version
kubectl rollout undo deployment/myapp

# Rollback to specific revision
kubectl rollout undo deployment/myapp --to-revision=3

# Pause/Resume rollout (canary-style)
kubectl rollout pause deployment/myapp
# ... verify ...
kubectl rollout resume deployment/myapp
```

---

### Q9: What are Namespaces and when to use them?

```bash
# Namespaces = Virtual clusters within a physical cluster

# Common namespace strategy:
kubectl create namespace development
kubectl create namespace staging
kubectl create namespace production
kubectl create namespace monitoring

# Set default namespace
kubectl config set-context --current --namespace=production

# Resource quotas per namespace
apiVersion: v1
kind: ResourceQuota
metadata:
  name: prod-quota
  namespace: production
spec:
  hard:
    requests.cpu: "10"
    requests.memory: 20Gi
    limits.cpu: "20"
    limits.memory: 40Gi
    pods: "50"
```

---

### Q10: How do you debug Kubernetes networking issues?

```bash
# 1. Check Service endpoints
kubectl get endpoints <service-name>
# If empty → selector doesn't match pod labels

# 2. Check DNS resolution
kubectl run tmp-debug --image=busybox --rm -it -- nslookup myservice.mynamespace.svc.cluster.local

# 3. Check CoreDNS
kubectl get pods -n kube-system -l k8s-app=kube-dns
kubectl logs -n kube-system -l k8s-app=kube-dns

# 4. Check Network Policies
kubectl get networkpolicies -A

# 5. Test pod-to-pod connectivity
kubectl exec <pod-a> -- nc -zv <pod-b-ip> 8080

# 6. Check kube-proxy
kubectl get pods -n kube-system -l k8s-app=kube-proxy
kubectl logs -n kube-system -l k8s-app=kube-proxy
```

---

### Q11: What are DaemonSet, StatefulSet, and Job?

| Resource | Purpose | Use Case |
|----------|---------|----------|
| **DaemonSet** | Run one pod per node | Log collectors, monitoring agents |
| **StatefulSet** | Pods with stable identity + storage | Databases, Kafka, Elasticsearch |
| **Job** | Run to completion | Database migrations, batch processing |
| **CronJob** | Scheduled Jobs | Nightly backups, report generation |

---

### Q12: How do you manage storage in Kubernetes?

```yaml
# PersistentVolumeClaim
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: db-storage
spec:
  accessModes:
    - ReadWriteOnce       # Only one node can mount
  storageClassName: gp3   # AWS EBS gp3
  resources:
    requests:
      storage: 50Gi

# Use in Pod
spec:
  containers:
  - name: postgres
    volumeMounts:
    - name: data
      mountPath: /var/lib/postgresql/data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: db-storage
```

---

### Q13: What is RBAC in Kubernetes?

```yaml
# Role (namespace-scoped permissions)
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer-role
  namespace: development
rules:
- apiGroups: [""]
  resources: ["pods", "services", "configmaps"]
  verbs: ["get", "list", "watch", "create", "update"]
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["get", "list", "watch"]

---
# RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-binding
  namespace: development
subjects:
- kind: User
  name: john@company.com
roleRef:
  kind: Role
  name: developer-role
  apiGroup: rbac.authorization.k8s.io
```

---

### Q14: How do you handle secrets securely in Kubernetes?

1. **External Secrets Operator** → Syncs from AWS Secrets Manager/Vault
2. **Sealed Secrets** → Encrypted secrets safe to commit to Git
3. **CSI Secret Store Driver** → Mounts secrets as volumes from external provider

```yaml
# External Secrets Operator example
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: app-secret
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: aws-secrets-manager
    kind: ClusterSecretStore
  target:
    name: app-secret
  data:
  - secretKey: DB_PASSWORD
    remoteRef:
      key: /production/myapp/db-password
```

---

### Q15: What are Network Policies?

```yaml
# Allow traffic only from specific pods
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: postgres          # Apply to postgres pods
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: api           # Only allow from api pods
    ports:
    - protocol: TCP
      port: 5432
```

---

### Q16: How do you monitor Kubernetes?

```bash
# Built-in commands
kubectl top nodes            # Node resource usage
kubectl top pods -n prod     # Pod resource usage

# Prometheus Stack (industry standard)
# Components: Prometheus + Grafana + AlertManager + node-exporter
helm install prometheus prometheus-community/kube-prometheus-stack

# Key metrics to monitor:
# - Pod restarts
# - CPU/Memory usage vs limits
# - Node conditions
# - Pending pods (scheduling issues)
# - API server latency
```

---

### Q17: What is a Service Mesh (Istio/Linkerd)?

A service mesh adds observability, security, and traffic management between services without changing application code.

**Features:** mTLS between services, traffic splitting (canary), retries, circuit breaking, observability (tracing).

---

### Q18: How do you handle pod scheduling (affinity, taints, tolerations)?

```yaml
# Node affinity - Schedule on specific nodes
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: instance-type
            operator: In
            values: ["gpu", "compute-optimized"]

# Pod anti-affinity - Don't put 2 pods on same node
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              app: myapp
          topologyKey: kubernetes.io/hostname

# Taints and Tolerations
# Taint a node:  kubectl taint nodes node1 gpu=true:NoSchedule
# Pod must tolerate:
spec:
  tolerations:
  - key: "gpu"
    operator: "Equal"
    value: "true"
    effect: "NoSchedule"
```

---

### Q19: How do you do blue-green deployment in Kubernetes?

```bash
# Deploy green version alongside blue
kubectl apply -f deployment-green.yaml  # app: myapp, version: green

# Switch Service selector from blue to green
kubectl patch service myapp -p '{"spec":{"selector":{"version":"green"}}}'

# If something goes wrong, switch back
kubectl patch service myapp -p '{"spec":{"selector":{"version":"blue"}}}'
```

---

### Q20: What are Init Containers?

Containers that run BEFORE the main container starts. Used for setup tasks.

```yaml
spec:
  initContainers:
  - name: wait-for-db
    image: busybox
    command: ['sh', '-c', 'until nc -z db-service 5432; do sleep 2; done']
  - name: run-migrations
    image: myapp:latest
    command: ['python', 'manage.py', 'migrate']
  containers:
  - name: myapp
    image: myapp:latest
```

---

### Q21: How do you manage Kubernetes configuration with Helm?

```bash
# Install an application
helm install myapp ./my-chart --values prod-values.yaml

# Upgrade
helm upgrade myapp ./my-chart --values prod-values.yaml

# Rollback
helm rollback myapp 1

# List releases
helm list
```

---

### Q22: What is Pod Disruption Budget (PDB)?

```yaml
# Ensure minimum availability during maintenance
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: myapp-pdb
spec:
  minAvailable: 2    # Always keep at least 2 pods running
  selector:
    matchLabels:
      app: myapp
```

---

### Q23: How do you troubleshoot OOMKilled pods?

```bash
# Check if pod was OOMKilled
kubectl describe pod <pod> | grep -i "oom\|killed\|memory"

# Check actual memory usage
kubectl top pod <pod>

# Fix: Increase memory limit
# OR fix memory leak in application
# OR add JVM flags: -Xmx512m (for Java apps)
```

---

### Q24: What are Kubernetes best practices for production?

1. **Always set resource requests AND limits**
2. **Use namespaces** for isolation
3. **Implement RBAC** (least privilege)
4. **Use Network Policies** (deny by default)
5. **Health probes on every container** (liveness + readiness)
6. **Pod Disruption Budgets** for high availability
7. **Horizontal Pod Autoscaler** for traffic spikes
8. **Don't use `latest` tag** (use specific versions)
9. **Store configs in ConfigMaps/Secrets** (not in images)
10. **Monitor everything** (Prometheus + Grafana)

---

# 10. Monitoring

## 📝 Monitoring - 24 Interview Questions with Detailed Answers

### Q1: What is monitoring and why is it critical?

**Monitoring** = Continuously collecting, analyzing, and alerting on system metrics to detect issues before users do.

**Three Pillars of Observability:**
- **Metrics** → Numbers over time (CPU, memory, request count)
- **Logs** → Event records (errors, access logs)
- **Traces** → Request path through multiple services

---

### Q2: Explain Prometheus architecture and how it works.

```
┌─────────────────────────────────────────────┐
│              Prometheus Server                │
│  ┌─────────┐  ┌──────────┐  ┌───────────┐  │
│  │Retrieval │  │  TSDB    │  │ HTTP API  │  │
│  │(scraping)│  │(storage) │  │(PromQL)   │  │
│  └─────────┘  └──────────┘  └───────────┘  │
└─────────────────────────────────────────────┘
      ↑ scrapes                    ↓ queries
      │                            │
┌──────────┐                 ┌──────────┐
│ Targets  │                 │ Grafana  │
│(exporters)│                │(dashboards)│
└──────────┘                 └──────────┘
```

**How it works:**
1. Applications expose metrics at `/metrics` endpoint
2. Prometheus **pulls** (scrapes) these metrics on a schedule
3. Stores in time-series database (TSDB)
4. AlertManager sends alerts based on rules
5. Grafana visualizes with dashboards

---

### Q3: What are the 4 Golden Signals of monitoring?

| Signal | What It Measures | Example Metric |
|--------|-----------------|----------------|
| **Latency** | Response time | `http_request_duration_seconds` |
| **Traffic** | Request volume | `http_requests_total` |
| **Errors** | Failure rate | `http_requests_total{status="500"}` |
| **Saturation** | Resource fullness | CPU usage, queue depth |

---

### Q4: Write a PromQL query for common monitoring scenarios.

```promql
# Request rate (requests per second over 5 minutes)
rate(http_requests_total[5m])

# Error rate percentage
sum(rate(http_requests_total{status=~"5.."}[5m])) / sum(rate(http_requests_total[5m])) * 100

# 95th percentile response time
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))

# CPU usage percentage per pod
sum(rate(container_cpu_usage_seconds_total[5m])) by (pod) * 100

# Memory usage
container_memory_usage_bytes / container_spec_memory_limit_bytes * 100

# Disk usage prediction (when will disk be full?)
predict_linear(node_filesystem_free_bytes[6h], 24*3600) < 0
# If this is true → disk will be full within 24 hours
```

---

### Q5: How do you set up alerting rules?

```yaml
# prometheus-rules.yaml
groups:
- name: application-alerts
  rules:
  - alert: HighErrorRate
    expr: sum(rate(http_requests_total{status=~"5.."}[5m])) / sum(rate(http_requests_total[5m])) > 0.05
    for: 5m              # Must be true for 5 minutes
    labels:
      severity: critical
    annotations:
      summary: "High error rate: {{ $value | humanizePercentage }}"
      description: "Error rate is above 5% for the last 5 minutes"

  - alert: PodCrashLooping
    expr: rate(kube_pod_container_status_restarts_total[15m]) > 0
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Pod {{ $labels.pod }} is crash-looping"

  - alert: DiskSpaceLow
    expr: (node_filesystem_avail_bytes / node_filesystem_size_bytes) < 0.15
    for: 10m
    labels:
      severity: warning
    annotations:
      summary: "Disk space below 15% on {{ $labels.instance }}"
```

---

### Q6: What is Grafana and how do you create dashboards?

Grafana is a visualization tool that connects to data sources (Prometheus, CloudWatch, Elasticsearch) and creates dashboards.

**Key dashboard panels for DevOps:**
- Request rate and error rate
- Response time (p50, p95, p99)
- CPU/Memory usage per pod
- Pod restarts
- Node health
- Disk I/O and usage

---

### Q7: How do you monitor Kubernetes clusters?

```bash
# Deploy kube-prometheus-stack (all-in-one)
helm install monitoring prometheus-community/kube-prometheus-stack \
    --namespace monitoring --create-namespace

# This installs:
# - Prometheus (metrics collection)
# - Grafana (dashboards - pre-built K8s dashboards included)
# - AlertManager (alerts)
# - Node Exporter (host metrics)
# - kube-state-metrics (K8s object metrics)
```

**Key metrics to monitor:**
- `kube_pod_container_status_restarts_total` → Pod restarts
- `kube_node_status_condition` → Node health
- `kube_pod_status_phase` → Pod phases
- `container_memory_usage_bytes` → Memory per container

---

### Q8: What is the difference between USE and RED methods?

| Method | For | Metrics |
|--------|-----|---------|
| **USE** | Infrastructure (servers, DBs) | Utilization, Saturation, Errors |
| **RED** | Services (APIs, microservices) | Rate, Errors, Duration |

---

### Q9: How do you implement application-level metrics?

```python
# Python with prometheus_client library
from prometheus_client import Counter, Histogram, start_http_server

# Define metrics
REQUEST_COUNT = Counter('http_requests_total', 'Total requests', ['method', 'endpoint', 'status'])
REQUEST_DURATION = Histogram('http_request_duration_seconds', 'Request duration', ['endpoint'])

# Record metrics in your app
@app.route('/api/users')
def get_users():
    with REQUEST_DURATION.labels(endpoint='/api/users').time():
        result = fetch_users()
        REQUEST_COUNT.labels(method='GET', endpoint='/api/users', status='200').inc()
        return result

# Expose metrics endpoint
start_http_server(9090)  # /metrics on port 9090
```

---

### Q10: How do you set up on-call alerts without alert fatigue?

**Best practices:**
1. **Page only for actionable alerts** → If no action needed, it's not an alert
2. **Set appropriate thresholds** → Alert at 80% disk, not 50%
3. **Use `for` duration** → Don't alert on brief spikes
4. **Severity levels** → Critical (page) vs Warning (ticket) vs Info (dashboard)
5. **Group related alerts** → One notification, not 50
6. **Runbooks for every alert** → Link to fix instructions

---

### Q11: What is distributed tracing?

Traces follow a request across multiple services to identify where time is spent.

**Tools:** Jaeger, Zipkin, OpenTelemetry

```
User → API Gateway (2ms) → Auth Service (50ms) → Database (200ms) → Response
                                                    ↑ BOTTLENECK
```

---

### Q12: How do you monitor Docker containers?

```yaml
# docker-compose monitoring stack
services:
  prometheus:
    image: prom/prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"

  cadvisor:
    image: gcr.io/cadvisor/cadvisor
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
    ports:
      - "8080:8080"

  node-exporter:
    image: prom/node-exporter
    ports:
      - "9100:9100"
```

---

### Q13: What are SLI, SLO, and SLA?

| Term | Meaning | Example |
|------|---------|---------|
| **SLI** (Indicator) | Actual measured metric | 99.8% of requests succeed |
| **SLO** (Objective) | Target we aim for | 99.9% success rate |
| **SLA** (Agreement) | Contract with customers | 99.5% or credits issued |

---

### Q14: How do you create effective alert notifications?

```yaml
# AlertManager config
route:
  group_by: ['alertname', 'cluster']
  group_wait: 30s          # Wait to batch alerts
  group_interval: 5m
  repeat_interval: 4h      # Don't spam same alert
  receiver: 'slack-critical'
  routes:
  - match:
      severity: critical
    receiver: 'pagerduty'
  - match:
      severity: warning
    receiver: 'slack-warnings'

receivers:
- name: 'pagerduty'
  pagerduty_configs:
  - service_key: '<key>'
- name: 'slack-critical'
  slack_configs:
  - api_url: '<webhook>'
    channel: '#alerts-critical'
```

---

### Q15: How do you monitor network performance?

```bash
# Blackbox exporter - probe endpoints
# Measures: latency, SSL expiry, HTTP status

# prometheus.yml
scrape_configs:
- job_name: 'blackbox'
  metrics_path: /probe
  params:
    module: [http_2xx]
  static_configs:
  - targets:
    - https://api.company.com/health
    - https://app.company.com
  relabel_configs:
  - source_labels: [__address__]
    target_label: __param_target
```

---

### Q16: What is CloudWatch and how does it compare to Prometheus?

| Feature | Prometheus | CloudWatch |
|---------|-----------|------------|
| Type | Self-hosted, pull-based | AWS managed, push-based |
| Cost | Free (infra cost only) | Pay per metric/alarm |
| Flexibility | Full control, PromQL | Limited, built-in metrics |
| Retention | Configurable | 15 months |
| Best for | K8s, custom metrics | AWS services (EC2, RDS, Lambda) |

---

### Q17: How do you implement synthetic monitoring?

Synthetic monitoring = Automated tests that simulate user actions continuously.

```bash
# Simple example: Check website every minute
*/1 * * * * curl -s -o /dev/null -w "%{http_code},%{time_total}" https://myapp.com/health >> /var/log/synthetic.log
```

---

### Q18: How do you monitor database performance?

Key metrics: Query latency, connection count, slow queries, replication lag, disk I/O.

```bash
# PostgreSQL exporter for Prometheus
docker run -d --name postgres-exporter \
    -e DATA_SOURCE_NAME="postgresql://user:pass@db:5432/mydb?sslmode=disable" \
    -p 9187:9187 \
    quay.io/prometheuscommunity/postgres-exporter
```

---

### Q19: What is anomaly detection in monitoring?

Detecting unusual patterns without manually setting thresholds.

```promql
# Simple anomaly: Current value vs 1-week average
http_requests_total - avg_over_time(http_requests_total[7d]) > 3 * stddev_over_time(http_requests_total[7d])
```

---

### Q20: How do you size and retain Prometheus data?

```yaml
# Storage calculation:
# Ingestion rate × retention period × bytes per sample
# 100k samples/s × 15 days × 2 bytes = ~250GB

# prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

# Command line flags
--storage.tsdb.retention.time=15d
--storage.tsdb.retention.size=200GB
```

---

### Q21: How do you create a monitoring strategy for microservices?

1. **Infrastructure layer** → Node metrics (CPU, RAM, disk, network)
2. **Platform layer** → K8s metrics (pod health, scheduling)
3. **Application layer** → RED metrics per service
4. **Business layer** → Orders/min, signup rate, revenue
5. **User experience** → Page load time, error rate

---

### Q22: What is uptime monitoring?

External checks that verify your service is accessible from the internet. Tools: Pingdom, UptimeRobot, Datadog Synthetics.

---

### Q23: How do you handle alert storms?

1. **Group alerts** → Combine related alerts into one
2. **Inhibition rules** → If cluster is down, suppress pod alerts
3. **Silences** → Mute during maintenance windows
4. **Deduplication** → Same alert from multiple sources = one notification

---

### Q24: How do you build a monitoring dashboard for executives?

Focus on business impact:
- Service availability (uptime %)
- Error budget remaining
- User-facing error rate
- Deployment frequency and success rate
- Mean time to recovery
- Cost metrics

---

# 11. Logging

## 📝 Logging - 24 Interview Questions with Detailed Answers

### Q1: What is centralized logging and why is it needed?

**Problem:** With 50+ servers and 100+ containers, you can't SSH into each one to read logs.

**Solution:** Centralized logging collects ALL logs to one searchable location.

**Architecture (EFK/ELK Stack):**
```
App Logs → Filebeat/Fluentd (collector) → Elasticsearch (storage) → Kibana (visualization)
```

---

### Q2: Explain the ELK/EFK stack.

| Component | Role | Alternative |
|-----------|------|-------------|
| **Elasticsearch** | Store and index logs | OpenSearch, Loki |
| **Logstash/Fluentd** | Collect, parse, transform logs | Filebeat, Fluent Bit |
| **Kibana** | Search and visualize logs | Grafana |

---

### Q3: How do you configure Fluentd/Fluent Bit for Kubernetes?

```yaml
# Fluent Bit DaemonSet (runs on every node)
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluent-bit
  namespace: logging
spec:
  template:
    spec:
      containers:
      - name: fluent-bit
        image: fluent/fluent-bit:latest
        volumeMounts:
        - name: varlog
          mountPath: /var/log
        - name: containers
          mountPath: /var/lib/docker/containers
          readOnly: true
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
      - name: containers
        hostPath:
          path: /var/lib/docker/containers
```

---

### Q4: What is structured logging and why is it important?

```json
// ❌ Unstructured (hard to search/parse)
"ERROR: Failed to connect to database at 10.0.1.5:5432 for user admin"

// ✅ Structured (easy to search, filter, analyze)
{
  "timestamp": "2024-01-15T10:30:45Z",
  "level": "ERROR",
  "service": "payment-api",
  "message": "Database connection failed",
  "host": "10.0.1.5",
  "port": 5432,
  "user": "admin",
  "error": "Connection refused",
  "trace_id": "abc-123-xyz"
}
```

---

### Q5: How do you search logs effectively in Kibana/Elasticsearch?

```
# Kibana Query Language (KQL)
level: ERROR AND service: "payment-api"
message: "timeout" AND NOT host: "staging*"
status >= 500 AND @timestamp >= "2024-01-15"

# Find all errors from a specific trace
trace_id: "abc-123-xyz"

# Find slow requests
response_time > 5000
```

---

### Q6: What are log levels and when to use each?

| Level | Use For | Example |
|-------|---------|---------|
| **DEBUG** | Development details | "Querying user with ID 123" |
| **INFO** | Normal operations | "Server started on port 8080" |
| **WARN** | Potential issues | "Retry 2/3 for API call" |
| **ERROR** | Failures needing attention | "Database connection failed" |
| **FATAL** | System cannot continue | "Out of memory, shutting down" |

**Production:** Set to INFO. Use DEBUG only when troubleshooting.

---

### Q7: How do you handle log rotation?

```bash
# /etc/logrotate.d/myapp
/var/log/myapp/*.log {
    daily              # Rotate daily
    rotate 14          # Keep 14 days
    compress           # gzip old logs
    delaycompress      # Don't compress most recent rotation
    missingok          # Don't error if log missing
    notifempty         # Don't rotate empty files
    copytruncate       # Truncate original (for apps that keep file open)
    size 100M          # Also rotate if >100MB
}
```

---

### Q8: How do you correlate logs across microservices?

Use a **trace ID** that follows the request through all services:

```
Request → API Gateway (trace: abc-123) → Auth (trace: abc-123) → DB (trace: abc-123)
```

Search for `trace_id: abc-123` → See the complete request lifecycle across all services.

---

### Q9: What is Grafana Loki?

Lightweight log aggregation (like Prometheus, but for logs). Doesn't index log content - only indexes labels (cheaper and faster than Elasticsearch for many use cases).

```yaml
# Query with LogQL
{namespace="production", app="payment"} |= "error"
{job="nginx"} | json | status >= 500
```

---

### Q10: How do you set up alerting on logs?

```yaml
# Alert when error rate spikes in logs (Loki/Grafana)
# Rule: More than 10 errors per minute from payment service
sum(rate({app="payment"} |= "ERROR" [1m])) > 10
```

---

### Q11: How do you handle sensitive data in logs?

1. **Never log:** Passwords, API keys, credit card numbers, SSNs
2. **Mask/redact** at the application level
3. **Log filtering** in Fluentd/Logstash (remove sensitive fields)
4. **Access control** on log systems

```python
# Python: Mask sensitive data before logging
import re
def mask_sensitive(msg):
    msg = re.sub(r'password=\S+', 'password=***', msg)
    msg = re.sub(r'\b\d{16}\b', '****-****-****-****', msg)  # Credit cards
    return msg
```

---

### Q12: How do you manage log storage costs?

1. **Retention policies** → Delete logs older than 30 days
2. **Tiered storage** → Hot (7 days) → Warm (30 days) → Cold/S3 (archive)
3. **Only index what you search** → Don't index debug logs
4. **Sampling** → Store only 10% of debug logs
5. **Compression** → Always compress archived logs

---

### Q13: How do you debug issues using container logs?

```bash
# Docker
docker logs <container> --tail 100 -f
docker logs <container> --since 1h

# Kubernetes
kubectl logs <pod> -f
kubectl logs <pod> --previous      # Previous crashed container
kubectl logs <pod> -c <container>  # Specific container in pod
kubectl logs -l app=myapp --all-containers  # All pods with label
```

---

### Q14: What is log aggregation pipeline?

```
Application → Sidecar/Agent → Buffer/Queue → Processing → Storage → UI
   (logs)     (Fluent Bit)     (Kafka)       (Logstash)    (ES)    (Kibana)
```

---

### Q15: How do you implement audit logging?

```python
# Track WHO did WHAT, WHEN, and WHERE
audit_log = {
    "timestamp": "2024-01-15T10:30:00Z",
    "actor": "user@company.com",
    "action": "DELETE",
    "resource": "deployment/payment-service",
    "namespace": "production",
    "source_ip": "10.0.1.50",
    "result": "success"
}
```

---

### Q16: How do you handle logging in serverless?

- Lambda/Functions → CloudWatch Logs (automatic)
- Structure your logs (JSON)
- Include request ID for tracing
- Set appropriate log retention

---

### Q17: What are common logging mistakes?

1. Logging too much (fills disk, high cost)
2. Logging too little (can't debug)
3. Unstructured logs (can't search)
4. No log rotation (disk full)
5. Logging sensitive data (security breach)
6. No correlation IDs (can't trace across services)

---

### Q18: How do you troubleshoot missing logs?

```bash
# 1. Check if app is writing logs
ls -la /var/log/myapp/
tail -f /var/log/myapp/app.log

# 2. Check log collector agent
systemctl status filebeat
filebeat test output    # Test connectivity to Elasticsearch

# 3. Check disk space (agent might have stopped)
df -h

# 4. Check for permission issues
ls -la /var/log/myapp/   # Check ownership

# 5. Check network (agent → Elasticsearch)
nc -zv elasticsearch:9200
```

---

### Q19: How do you parse unstructured logs?

```conf
# Logstash/Fluentd grok pattern
# Input: 10.0.1.5 - - [15/Jan/2024:10:30:45 +0000] "GET /api/users HTTP/1.1" 200 1234

filter {
  grok {
    match => { "message" => "%{IP:client_ip} .* \[%{HTTPDATE:timestamp}\] \"%{WORD:method} %{URIPATH:path} HTTP/%{NUMBER}\" %{NUMBER:status} %{NUMBER:bytes}" }
  }
}
```

---

### Q20: How do you set up logging for a new microservice?

1. Choose structured format (JSON)
2. Include: timestamp, level, service name, trace_id, message
3. Configure log rotation
4. Deploy log collector sidecar/agent
5. Create Kibana index pattern
6. Build dashboard for the service
7. Set up alerts for errors

---

### Q21: What is log sampling?

Only store a percentage of logs (e.g., 10% of DEBUG logs) to reduce cost while still having enough data for debugging.

---

### Q22: How do you search for patterns across time in logs?

Use time-based queries in Kibana/Loki to identify patterns:
- Error spikes correlating with deployments
- Periodic errors (memory leak → OOM every 24h)
- Gradual increase in response times

---

### Q23: How do you integrate logging with incident response?

1. Alert fires → Link to relevant log dashboard
2. Log dashboard shows → Affected services, error messages
3. Correlation → Use trace_id to find root cause
4. Timeline → When did errors start? What changed?

---

### Q24: Explain the difference between push and pull logging.

| Model | How It Works | Example |
|-------|-------------|---------|
| **Push** | App sends logs to central system | Fluentd → Elasticsearch |
| **Pull** | Central system fetches logs | Prometheus (for metrics) |

Most
        
