# 📚 Platform Engineer & DevOps Interview Notes

## Master Table of Contents

| # | Topic | Status |
|---|-------|--------|
| 1 | [Linux](#01---linux) | Below |
| 2 | [Networking](#02---networking) | Below |
| 3 | [Jenkins](#03---jenkins) | Below |
| 4 | [CI/CD](#04---cicd) | Below |
| 5 | [Python](#05---python) | Below |
| 6 | [Shell Scripting](#06---shell-scripting) | Below |
| 7 | [Ansible](#07---ansible) | Below |
| 8 | [Docker](#08---docker) | Below |
| 9 | [Kubernetes](#09---kubernetes) | Below |
| 10 | [Monitoring](#10---monitoring) | Below |
| 11 | [Logging](#11---logging) | Below |
| 12 | [Troubleshooting](#12---troubleshooting) | Below |
| 13 | [EC2/Cloud](#13---ec2cloud) | Below |
| 14 | [Security](#14---security) | Below |

---

> ⚠️ Due to response length limits, I'll deliver **2–3 topics per message**. Just reply **"next"** after each response to get the next set.

---

# 01 - Linux

### Topic Index
| # | Question |
|---|----------|
| 1 | [Server running slow — how to troubleshoot?](#q1-server-running-slow) |
| 2 | [Find top CPU-consuming process](#q2-top-cpu-process) |
| 3 | [Disk 100% full — how to fix?](#q3-disk-full) |
| 4 | [What is load average?](#q4-load-average) |
| 5 | [OOM Killer — what is it and how to check?](#q5-oom-killer) |
| 6 | [How to check open files by a process?](#q6-open-files) |
| 7 | [Difference between soft and hard links?](#q7-links) |
| 8 | [How to find and kill zombie processes?](#q8-zombie) |
| 9 | [How to check which port a service is running on?](#q9-ports) |
| 10 | [How to schedule a cron job?](#q10-cron) |
| 11 | [How to check why a service failed to start?](#q11-service-failed) |
| 12 | [File permissions explained with chmod](#q12-permissions) |
| 13 | [How to add swap space?](#q13-swap) |
| 14 | [How to check network connectivity from a server?](#q14-network-check) |
| 15 | [How to find large files consuming disk?](#q15-large-files) |
| 16 | [What are inodes and how can they cause issues?](#q16-inodes) |
| 17 | [How to check memory usage in detail?](#q17-memory) |
| 18 | [How to trace what a process is doing?](#q18-strace) |
| 19 | [How to persist environment variables?](#q19-env-vars) |
| 20 | [How to check boot logs and system startup issues?](#q20-boot-logs) |
| 21 | [How to manage users and sudo access?](#q21-users-sudo) |
| 22 | [How to rotate logs to prevent disk full?](#q22-log-rotate) |
| 23 | [How to check and set kernel parameters?](#q23-kernel-params) |
| 24 | [How to troubleshoot SSH connection failures?](#q24-ssh-issues) |

---

### Q1: Server Running Slow

**Issue:** High response time, SSH lag, application timeout.

**Troubleshoot:**
```bash
uptime                        # Check load average — if > number of CPUs, system is overloaded
top -bn1 | head -20           # Identify top CPU/memory consumers
vmstat 1 5                    # Check CPU wait (wa column), swap in/out
iostat -x 1 3                 # Disk I/O — %util > 80% = disk bottleneck
free -h                       # Memory usage — check 'available' column
df -h                         # Disk space — 100% = no space left
dmesg | tail -30              # Kernel errors, OOM kills, hardware faults
```

**Root Cause:** CPU saturation, memory exhaustion, disk full, I/O wait.  
**Solution:** Kill offending process, free disk, add resources, optimize app.

---

### Q2: Top CPU Process

```bash
ps aux --sort=-%cpu | head -10      # Top 10 CPU-hungry processes
top -bn1 -o %CPU | head -15        # Batch mode sorted by CPU
pidstat 1 5                         # Per-process CPU every 1 sec
```

**Follow-up:**
```bash
strace -cp <PID>                    # What system calls is it making?
kill -15 <PID>                      # Graceful kill; -9 only as last resort
```

---

### Q3: Disk Full

```bash
df -h                               # Identify full mount point
du -sh /var/* | sort -rh | head     # Largest dirs in /var
find / -type f -size +100M -exec ls -lh {} \;   # Files > 100MB
lsof +L1                            # Deleted files still held open by processes
journalctl --vacuum-size=100M       # Clean systemd journal logs
```

**Common culprits:** `/var/log`, old Docker images, temp files.  
**Solution:** Delete old logs, restart process holding deleted files, set up log rotation.

---

### Q4: Load Average

**What:** Numbers shown by `uptime` — avg number of processes waiting for CPU over 1, 5, 15 min.

```bash
uptime                  # Output: load average: 4.2, 3.8, 2.1
nproc                   # Check number of CPU cores (e.g., 4)
```

**Rule of thumb:**  
- Load = CPU cores → fully utilized  
- Load > CPU cores → overloaded  
- Load < CPU cores → healthy  

**Example:** 4 cores, load 8.0 = double overloaded, processes are queuing.

---

### Q5: OOM Killer

**What:** Kernel kills processes when system runs out of memory.

```bash
dmesg | grep -i "oom"                          # Check if OOM killer triggered
grep -i "killed process" /var/log/messages     # Which process got killed
journalctl -k | grep -i "oom"                  # Systemd kernel logs
```

**Expected output:** `Out of memory: Killed process 1234 (java) total-vm:4096000kB`

**Solution:**
- Increase RAM or add swap
- Set memory limits for apps (`-Xmx` for Java)
- Tune `vm.overcommit_memory` kernel param

---

### Q6: Open Files by Process

```bash
lsof -p <PID>                   # All files opened by specific process
lsof -u nginx                   # All files opened by nginx user
ls -l /proc/<PID>/fd | wc -l   # Count open file descriptors
ulimit -n                       # Check max open files limit (default 1024)
```

**Issue:** "Too many open files" error.  
**Fix:** Increase limit in `/etc/security/limits.conf`:
```
nginx  soft  nofile  65535
nginx  hard  nofile  65535
```

---

### Q7: Soft vs Hard Links

| Feature | Soft Link | Hard Link |
|---------|-----------|-----------|
| Across filesystems | ✅ Yes | ❌ No |
| Link to directories | ✅ Yes | ❌ No |
| Original deleted | ❌ Breaks | ✅ Still works |
| Inode | Different | Same |

```bash
ln -s /path/to/file symlink     # Create soft link (shortcut)
ln /path/to/file hardlink       # Create hard link (same inode)
ls -li file                     # Check inode number
```

---

### Q8: Zombie Processes

**What:** Process finished but parent hasn't read its exit status.

```bash
ps aux | grep 'Z'               # Find zombies (state = Z)
ps -eo pid,ppid,stat,cmd | grep Z   # Get parent PID of zombie
kill -SIGCHLD <PPID>            # Tell parent to reap zombie
kill -9 <PPID>                  # Last resort — kill the parent
```

**Note:** Zombies don't consume CPU/memory but consume PID entries.

---

### Q9: Check Ports

```bash
ss -tulnp                       # Show all listening TCP/UDP ports with process names
netstat -tlnp                   # Legacy alternative to ss
lsof -i :8080                   # What process is using port 8080?
```

**Expected output:**
```
tcp  LISTEN  0  128  0.0.0.0:80  users:(("nginx",pid=1234,fd=6))
```

---

### Q10: Cron Jobs

```bash
crontab -e                      # Edit current user's cron
crontab -l                      # List current cron jobs
cat /etc/crontab                # System-wide cron
```

**Format:** `MIN HOUR DAY MONTH WEEKDAY COMMAND`

```bash
# Run backup every day at 2 AM
0 2 * * * /opt/scripts/backup.sh >> /var/log/backup.log 2>&1

# Health check every 5 minutes
*/5 * * * * /opt/scripts/health_check.sh
```

**Debugging cron:**
```bash
grep CRON /var/log/syslog       # Check if cron actually ran
```

---

### Q11: Service Failed to Start

```bash
systemctl status nginx                  # Check service status and error snippet
journalctl -u nginx --no-pager -n 50   # Last 50 log lines for nginx
systemctl list-units --failed           # All failed services
nginx -t                                # Test config syntax (service-specific)
```

**Common causes:** Config syntax error, port already in use, missing file/permission.

---

### Q12: File Permissions

```
-rwxr-xr-- = 754
 |||
 ||| Owner: rwx = 7
 ||| Group: r-x = 5
 ||| Others: r-- = 4
```

```bash
chmod 755 script.sh             # Owner full, group+others read+execute
chmod u+x script.sh            # Add execute for owner only
chown app:app /opt/myapp        # Change owner and group
```

**Production tip:** Never use `chmod 777` — security risk.

---

### Q13: Add Swap Space

```bash
fallocate -l 2G /swapfile       # Create 2GB file for swap
chmod 600 /swapfile             # Restrict permissions (security)
mkswap /swapfile                # Format as swap
swapon /swapfile                # Enable swap immediately
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab   # Persist after reboot
free -h                         # Verify swap is active
```

---

### Q14: Network Connectivity Check

```bash
ping -c 4 google.com            # Basic connectivity + DNS resolution
curl -v http://app:8080/health  # Test HTTP endpoint with verbose output
traceroute 10.0.1.50            # Find where packets are dropping
dig example.com                 # DNS resolution check
nc -zv 10.0.1.50 443            # Test if specific port is reachable
```

---

### Q15: Find Large Files

```bash
find / -type f -size +500M -exec ls -lhS {} \; 2>/dev/null   # Files > 500MB
du -ah /var | sort -rh | head -20    # Top 20 largest items in /var
ncdu /                               # Interactive disk usage browser (install if available)
```

---

### Q16: Inodes

**What:** Metadata entries for files. Disk can have space but run out of inodes (too many small files).

```bash
df -i                           # Check inode usage per filesystem
find /tmp -type f | wc -l      # Count files in /tmp (common culprit)
```

**Fix:** Delete millions of small temp/session files:
```bash
find /tmp -type f -mtime +7 -delete   # Delete files older than 7 days
```

---

### Q17: Memory Usage

```bash
free -h                         # Overview: total, used, free, available
cat /proc/meminfo               # Detailed breakdown
ps aux --sort=-%mem | head -10  # Top memory-consuming processes
smem -tk                        # Per-process actual memory (PSS)
```

**Key insight:** `available` column in `free -h` is what matters, not `free`. Linux uses free RAM for cache (which is reclaimable).

---

### Q18: Trace a Process (strace)

```bash
strace -p <PID>                 # Attach to running process, see live syscalls
strace -cp <PID>                # Summary of syscalls with time spent
strace -e open,read ls          # Trace only specific syscalls
ltrace -p <PID>                 # Trace library calls instead of syscalls
```

**Use case:** App hangs → strace shows it's stuck on `read()` waiting for network response.

---

### Q19: Persist Environment Variables

```bash
# For single user — add to ~/.bashrc or ~/.bash_profile
export APP_ENV=production

# For all users — add to /etc/environment
APP_ENV=production

# For a systemd service — add to unit file
# /etc/systemd/system/myapp.service
[Service]
Environment="APP_ENV=production"
EnvironmentFile=/etc/myapp/env    # Or load from file
```

```bash
source ~/.bashrc                # Reload without logout
systemctl daemon-reload         # Reload after changing unit files
```

---

### Q20: Boot Logs

```bash
journalctl -b                   # Logs from current boot
journalctl -b -1                # Logs from previous boot (useful after crash)
journalctl -b --priority=err    # Only errors from current boot
systemd-analyze blame           # Which services took longest to start
dmesg | head -50                # Hardware/kernel messages during boot
```

---

### Q21: Users & Sudo Access

```bash
useradd -m -s /bin/bash devops  # Create user with home dir and bash shell
passwd devops                   # Set password
usermod -aG sudo devops         # Add to sudo group (Debian/Ubuntu)
usermod -aG wheel devops        # Add to wheel group (RHEL/CentOS)
```

**Grant specific sudo without password:**
```bash
visudo   # Always use visudo to edit safely
# Add line:
devops ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx
```

---

### Q22: Log Rotation

```bash
cat /etc/logrotate.d/myapp
```
```
/var/log/myapp/*.log {
    daily              # Rotate daily
    rotate 7           # Keep 7 days
    compress           # gzip old logs
    missingok          # Don't error if log missing
    notifempty         # Skip if empty
    copytruncate       # Truncate in place (no restart needed)
}
```

```bash
logrotate -f /etc/logrotate.d/myapp   # Force rotation now (test)
```

---

### Q23: Kernel Parameters (sysctl)

```bash
sysctl -a | grep ip_forward         # Check current value
sysctl -w net.ipv4.ip_forward=1     # Set temporarily (lost on reboot)
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf   # Persist
sysctl -p                            # Apply changes from file
```

**Common production tuning:**
```bash
net.core.somaxconn = 65535           # Max socket connections (high traffic)
vm.swappiness = 10                   # Reduce swap usage (keep in RAM)
fs.file-max = 2097152                # Max open files system-wide
```

---

### Q24: SSH Connection Failures

**Troubleshoot step by step:**
```bash
ssh -vvv user@host                   # Verbose output shows where it fails
systemctl status sshd                # Is SSH service running on target?
ss -tlnp | grep 22                   # Is port 22 listening?
cat /etc/ssh/sshd_config | grep -i permitroot   # Root login allowed?
tail -f /var/log/auth.log            # Real-time auth failures (Ubuntu)
tail -f /var/log/secure              # Real-time auth failures (RHEL)
```

**Common causes & fixes:**

| Cause | Fix |
|-------|-----|
| Port not open in firewall | `ufw allow 22` or SG rule in AWS |
| Wrong key permissions | `chmod 600 ~/.ssh/id_rsa` |
| Key not in authorized_keys | `ssh-copy-id user@host` |
| sshd not running | `systemctl start sshd` |
| DNS not resolving | Use IP instead, fix `/etc/hosts` |

---

# 02 - Networking

### Topic Index
| # | Question |
|---|----------|
| 1 | [OSI Model — simple production explanation](#n-q1) |
| 2 | [TCP vs UDP](#n-q2) |
| 3 | [How DNS resolution works?](#n-q3) |
| 4 | [Troubleshoot "connection refused"](#n-q4) |
| 5 | [Troubleshoot "connection timed out"](#n-q5) |
| 6 | [What is a subnet and CIDR?](#n-q6) |
| 7 | [How to check if a remote port is open?](#n-q7) |
| 8 | [What is NAT and why is it used?](#n-q8) |
| 9 | [Difference between public and private IP?](#n-q9) |
| 10 | [How does a load balancer work?](#n-q10) |
| 11 | [What is a reverse proxy?](#n-q11) |
| 12 | [Troubleshoot DNS not resolving](#n-q12) |
| 13 | [What are iptables/firewalld?](#n-q13) |
| 14 | [Difference between L4 and L7 load balancing?](#n-q14) |
| 15 | [What is MTU and how does it cause issues?](#n-q15) |
| 16 | [How to capture network packets?](#n-q16) |
| 17 | [What is ARP?](#n-q17) |
| 18 | [What happens when you type a URL in browser?](#n-q18) |
| 19 | [VPN vs VPC peering vs Transit Gateway?](#n-q19) |
| 20 | [How to troubleshoot intermittent network drops?](#n-q20) |
| 21 | [What is TCP 3-way handshake?](#n-q21) |
| 22 | [How to check network bandwidth usage?](#n-q22) |
| 23 | [What is CORS and how to fix it?](#n-q23) |
| 24 | [TLS/SSL handshake — how does HTTPS work?](#n-q24) |

---

### N-Q1: OSI Model (Production Simplified)

| Layer | Name | Production Example |
|-------|------|--------------------|
| 7 | Application | HTTP, DNS, SSH — your app talks here |
| 4 | Transport | TCP/UDP — ports, connections |
| 3 | Network | IP addresses, routing, subnets |
| 2 | Data Link | MAC addresses, switches, ARP |
| 1 | Physical | Cables, NICs |

**Interview tip:** "When troubleshooting, I start from Layer 1 upward — is the network cable OK? Can I ping (L3)? Is the port open (L4)? Is the app responding (L7)?"

---

### N-Q2: TCP vs UDP

| Feature | TCP | UDP |
|---------|-----|-----|
| Reliable | ✅ Guaranteed delivery | ❌ Best effort |
| Connection | Connection-oriented (3-way handshake) | Connectionless |
| Speed | Slower | Faster |
| Use case | HTTP, SSH, DB | DNS, video streaming, gaming |

---

### N-Q3: DNS Resolution Flow

```
Browser cache → OS cache (/etc/hosts) → Resolver (ISP/corporate DNS) 
→ Root servers → TLD (.com) → Authoritative NS → IP returned
```

```bash
dig example.com +trace         # Trace full DNS resolution path
nslookup example.com           # Quick DNS lookup
cat /etc/resolv.conf           # Check configured DNS servers
```

---

### N-Q4: "Connection Refused"

**Meaning:** Target is reachable but nothing is listening on that port.

```bash
curl -v http://10.0.1.5:8080   # Will show "connection refused"
ss -tlnp | grep 8080           # On target: is anything listening?
systemctl status myapp          # Is the app running?
```

**Root cause:** Service is down, crashed, or listening on different port/interface.

---

### N-Q5: "Connection Timed Out"

**Meaning:** Packets never reach the target or response never comes back.

```bash
traceroute 10.0.1.5            # Where are packets dropping?
ping 10.0.1.5                  # Is host reachable at all?
nc -zv -w5 10.0.1.5 8080      # Test port with 5-sec timeout
```

**Root cause:** Firewall blocking, Security Group rule missing, route table misconfigured, server down.

---

### N-Q6: Subnets & CIDR

```
10.0.0.0/24 = 256 IPs (10.0.0.0 - 10.0.0.255)
10.0.0.0/16 = 65,536 IPs
10.0.0.0/32 = Single IP (used in security group rules)
```

**Quick calc:** 32 - CIDR = power of 2 for hosts.  
`/24` → 2^8 = 256 IPs (254 usable, AWS reserves 5).

```bash
ipcalc 10.0.1.0/24             # Calculate subnet details
ip addr show                    # Check assigned IPs and subnet masks
```

---

### N-Q7: Check Remote Port Open

```bash
nc -zv 10.0.1.5 443            # Netcat — quick port test
telnet 10.0.1.5 80             # Legacy method
curl -I https://example.com    # HTTP-level check
nmap -p 22,80,443 10.0.1.5    # Scan multiple ports
```

**Output interpretation:**
- `Connection succeeded` → port open
- `Connection refused` → port closed (service down)
- `Connection timed out` → firewall blocking

---

### N-Q8: NAT (Network Address Translation)

**What:** Translates private IPs to public IPs for internet access.

**AWS example:** EC2 in private subnet → NAT Gateway → Internet (for updates, API calls).

```
Private EC2 (10.0.1.5) → NAT GW (public IP) → Internet
Internet → Cannot reach 10.0.1.5 directly (security!)
```

**Use case:** Servers that need outbound internet but shouldn't be publicly accessible.

---

### N-Q9: Public vs Private IP

| Type | Range | Accessible from internet? |
|------|-------|---------------------------|
| Private | 10.x.x.x, 172.16-31.x.x, 192.168.x.x | ❌ No |
| Public | Everything else | ✅ Yes |

```bash
curl ifconfig.me                # Check your public IP
ip addr show eth0               # Check private IP assigned to interface
```

---

### N-Q10: Load Balancer

**What:** Distributes traffic across multiple servers for high availability.

**Types in AWS:**
- **ALB (L7):** HTTP/HTTPS, path-based routing, host-based routing
- **NLB (L4):** TCP/UDP, ultra-low latency, static IP
- **CLB:** Legacy, avoid in new designs

**Health check:** LB pings `/health` on each target; removes unhealthy ones automatically.

---

### N-Q11: Reverse Proxy

**What:** Sits in front of backend servers, receives client requests, forwards to backend.

**Example (Nginx):**
```nginx
server {
    listen 80;
    location / {
        proxy_pass http://backend:8080;   # Forward to app server
        proxy_set_header Host $host;       # Preserve original host header
    }
}
```

**Benefits:** SSL termination, caching, hiding backend IPs, rate limiting.

---

### N-Q12: DNS Not Resolving

```bash
cat /etc/resolv.conf                    # What DNS server is configured?
dig example.com @8.8.8.8               # Test with Google DNS (bypass local)
systemd-resolve --status               # Check systemd-resolved config
ping 8.8.8.8                           # Can we reach internet at all? (L3 check)
```

**Common fixes:**
- Add `nameserver 8.8.8.8` to `/etc/resolv.conf`
- Fix VPC DNS settings (enableDnsHostnames, enableDnsSupport in AWS)
- Check if corporate DNS is down

---

### N-Q13: Firewall (iptables/firewalld)

```bash
# iptables — check rules
iptables -L -n --line-numbers          # List all rules with numbers

# Allow port 80
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# firewalld (RHEL/CentOS)
firewall-cmd --list-all                # Current rules
firewall-cmd --add-port=8080/tcp --permanent   # Open port
firewall-cmd --reload                  # Apply changes
```

---

### N-Q14: L4 vs L7 Load Balancing

| Feature | L4 (Transport) | L7 (Application) |
|---------|----------------|-------------------|
| Routes based on | IP + Port | URL path, headers, cookies |
| Protocol awareness | TCP/UDP only | HTTP/HTTPS/gRPC |
| Speed | Faster | Slightly slower |
| Use case | Database, TCP apps | Microservices, API routing |
| AWS | NLB | ALB |

---

### N-Q15: MTU Issues

**What:** Maximum Transmission Unit — max packet size (default 1500 bytes).

**Symptom:** Large files fail, small requests work. SSH works but SCP hangs.

```bash
ping -M do -s 1472 target_ip           # Test MTU (1472 + 28 header = 1500)
ip link show eth0                       # Check current MTU setting
ip link set eth0 mtu 1400              # Reduce MTU to fix issues
```

**Common in:** VPN tunnels, Docker overlay networks, AWS VPC peering.

---

### N-Q16: Packet Capture (tcpdump)

```bash
tcpdump -i eth0 port 80                     # Capture HTTP traffic
tcpdump -i any host 10.0.1.5 -w dump.pcap  # Save capture to file
tcpdump -i eth0 'tcp[tcpflags] & tcp-syn != 0'  # Only SYN packets (new connections)
```

**Use case:** App says "connection made" but server says "never received" → tcpdump proves where packets are lost.

---

### N-Q17: ARP

**What:** Resolves IP address → MAC address on local network.

```bash
arp -a                          # View ARP table (IP-to-MAC mappings)
ip neigh show                   # Modern alternative
arping 10.0.1.1                 # Test ARP resolution
```

**Issue:** ARP table full or stale entries → communication fails within subnet.

---

### N-Q18: What Happens When You Type a URL

1. Browser checks cache → OS checks `/etc/hosts` → DNS resolves domain to IP
2. TCP 3-way handshake (SYN → SYN-ACK → ACK)
3. TLS handshake (if HTTPS) — certificate exchange, key agreement
4. HTTP request sent (GET /path)
5. Server processes, returns HTTP response (200 OK + HTML)
6. Browser renders page, loads CSS/JS/images (more requests)

---

### N-Q19: VPN vs VPC Peering vs Transit Gateway

| Feature | VPN | VPC Peering | Transit Gateway |
|---------|-----|-------------|-----------------|
| Connects | On-prem ↔ Cloud | VPC ↔ VPC | Many VPCs + On-prem |
| Encrypted | ✅ | ❌ (private network) | ✅ (for VPN attachments) |
| Bandwidth | Limited (~1.25 Gbps) | High (no bottleneck) | High |
| Transitive | ❌ | ❌ | ✅ |
| Cost | Low | Free (data transfer cost) | Higher |

---

### N-Q20: Intermittent Network Drops

```bash
mtr 10.0.1.5                            # Continuous traceroute — shows packet loss per hop
ping -c 100 10.0.1.5 | tail -5          # Check packet loss percentage
ethtool eth0 | grep -i link             # Physical link status
dmesg | grep -i "link"                  # NIC up/down events
sar -n DEV 1 10                         # Network throughput per interface
```

**Common causes:** NIC flapping, switch issues, bandwidth saturation, SG rule hitting limit.

---

### N-Q21: TCP 3-Way Handshake

```
Client → SYN → Server         (Hey, want to connect?)
Client ← SYN-ACK ← Server    (Sure, I'm ready)
Client → ACK → Server         (Great, let's talk)
```

**If handshake fails:**
- No SYN-ACK → firewall blocking or server down
- SYN flood → DDoS attack (many SYNs, no ACKs)

```bash
ss -s                           # Show TCP connection state summary
netstat -ant | grep SYN_RECV   # Check for SYN flood
```

---

### N-Q22: Network Bandwidth Usage

```bash
iftop -i eth0                   # Live bandwidth per connection (install: apt install iftop)
nethogs                         # Bandwidth per process
nload eth0                      # Simple in/out bandwidth graph
sar -n DEV 1 5                  # Network stats every 1 sec for 5 samples
```

---

### N-Q23: CORS Issues

**What:** Browser blocks requests from `app.com` to `api.example.com` if API doesn't allow it.

**Error:** `Access-Control-Allow-Origin header missing`

**Fix (Nginx):**
```nginx
add_header 'Access-Control-Allow-Origin' 'https://app.com';
add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization';
```

**Note:** This is a browser security feature, not a server issue. `curl` won't show this error.

---

### N-Q24: TLS/SSL Handshake

```
Client → ClientHello (supported ciphers, TLS version)
Server → ServerHello + Certificate (public key)
Client → Verifies cert, sends encrypted pre-master secret
Both → Derive session key → Encrypted communication starts
```

**Troubleshoot certificate issues:**
```bash
openssl s_client -connect example.com:443    # Check certificate details
curl -vI https://example.com 2>&1 | grep -i "expire\|subject\|issuer"
echo | openssl s_client -connect host:443 2>/dev/null | openssl x509 -noout -dates  # Check expiry
```

---

