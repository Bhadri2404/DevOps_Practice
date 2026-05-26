# Networking Interview – Practical Questions with Commands (Batch 1: Q1–Q10)

## Q1. How do you check if a server is reachable on the network?

### Typical interview question
“You suspect a server is down. How do you check basic network connectivity from Linux?”

### Answer – step by step with commands

1. **Check basic IP reachability with ping**  
   - Command:  
     ```bash
     ping -c 4 10.0.0.10
     ```  
   - Explanation:  
     - `ping` sends ICMP echo requests to the target IP.  
     - `-c 4` sends 4 packets then stops.  
     - If you get replies with low loss → IP layer connectivity is OK.  
     - If you get 100% packet loss → host unreachable, routing or firewall may be blocking ICMP.

2. **Check DNS resolution if you used a hostname**  
   - Command:  
     ```bash
     nslookup app.internal
     # or
     dig app.internal
     ```  
   - Explanation:  
     - `nslookup` / `dig` show you which IP a hostname resolves to.  
     - If DNS fails, the app can’t connect, even if the server is fine.  
     - If IP is wrong (e.g., old address), you’ll hit the wrong server.

3. **Check routes from your machine**  
   - Command:  
     ```bash
     ip route
     ```  
   - Explanation:  
     - Shows default gateway and routes for different subnets.  
     - If there is no route for the target network, packets will not reach that subnet.  
     - For VPN/cloud issues, wrong or missing routes are common.

---

## Q2. How do you check if a specific TCP port (e.g., 8080) is open on a server?

### Typical question
“Ping works, but app is down or unreachable. How do you test the port?”

### Answer – step by step with commands

1. **Use netcat or nc from your client machine**  
   - Command:  
     ```bash
     nc -vz app.internal 8080
     ```  
   - Explanation:  
     - `nc` (netcat) is a simple TCP client.  
     - `-v` verbose, `-z` “just scan” without sending data.  
     - If it prints `succeeded` or `open`, TCP handshake worked.  
     - If it times out or says `connection refused`, the port is not reachable.

2. **Alternative tool: telnet (older but often available)**  
   - Command:  
     ```bash
     telnet app.internal 8080
     ```  
   - Explanation:  
     - If it connects and shows a blank screen, the TCP port is open.  
     - If it fails immediately → connection refused.  
     - If it hangs → likely a firewall or SG dropping packets.

3. **On the server itself, confirm the port is listening**  
   - Command:  
     ```bash
     ss -lntp    # modern
     # or
     netstat -lntp
     ```  
   - Explanation:  
     - `-l` = listening sockets, `-n` = numeric addresses, `-t` = TCP, `-p` = show process.  
     - Look for a line like `0.0.0.0:8080` or `10.0.0.10:8080` and the process name (e.g., `java`, `nginx`).  
     - If nothing is listening on 8080 → app not started or bound to wrong IP.

---

## Q3. How do you debug DNS problems for a service?

### Typical question
“curl service.internal fails with ‘could not resolve host’. What do you do?”

### Answer – step by step with commands

1. **Test DNS resolution directly**  
   - Command:  
     ```bash
     nslookup service.internal
     # or
     dig service.internal
     ```  
   - Explanation:  
     - If these fail, DNS is broken for that name.  
     - If they return an unexpected IP, your DNS record is wrong.

2. **Check which DNS servers your host uses**  
   - Command:  
     ```bash
     cat /etc/resolv.conf
     ```  
   - Explanation:  
     - Shows `nameserver` lines (e.g., `nameserver 10.0.0.2`).  
     - If wrong DNS IPs are configured, queries will fail or go to the wrong resolver.

3. **Compare direct IP vs name access**  
   - Commands:  
     ```bash
     curl http://10.0.0.10:8080/health
     curl http://service.internal:8080/health
     ```  
   - Explanation:  
     - If curl via IP works but via hostname fails → DNS problem.  
     - If both fail, problem is not DNS (ports, firewall, or app).

---

## Q4. How do you see your own IP address, gateway, and routes in Linux?

### Typical question
“How do you check network configuration on a Linux node?”

### Answer – step by step with commands

1. **List IP addresses on all interfaces**  
   - Command:  
     ```bash
     ip addr
     ```  
   - Explanation:  
     - Shows interfaces like `eth0`, `ens3`, `lo` with assigned IPs.  
     - Look for `inet 10.0.0.10/24` – that shows IP and subnet mask (/24).

2. **View the routing table**  
   - Command:  
     ```bash
     ip route
     ```  
   - Explanation:  
     - Shows default route: `default via 10.0.0.1 dev eth0`.  
     - Any missing route or wrong default gateway will break reachability to some networks.

3. **Check default gateway only**  
   - Command:  
     ```bash
     ip route | grep default
     ```  
   - Explanation:  
     - Quick way to see where traffic for “internet” or unknown networks will go.  
     - Often, 0.0.0.0/0 points to an Internet Gateway/NAT or VPN in cloud.

---

## Q5. How do you check which process is listening on a port and who is connected?

### Typical question
“Port 3306 is in use. How do you see which process and connections?”

### Answer – step by step with commands

1. **Find the listening process**  
   - Command:  
     ```bash
     ss -lntp | grep 3306
     # or
     netstat -lntp | grep 3306
     ```  
   - Explanation:  
     - Shows listening TCP sockets on port 3306 (MySQL).  
     - Last column shows the PID/process name (e.g., `mysqld`).

2. **See established connections**  
   - Command:  
     ```bash
     ss -ntp | grep 3306
     ```  
   - Explanation:  
     - Without `-l` we see active connections.  
     - Columns show local address, foreign address, and state (ESTAB).  
     - Good for finding which clients are hitting the DB.

3. **If port is “already in use” during startup**  
   - Command:  
     ```bash
     lsof -i :3306
     ```  
   - Explanation:  
     - Lists any process with an open socket on port 3306.  
     - Use to detect stray processes or previous instances not shut down.

---

## Q6. How do you test connectivity from inside a Kubernetes pod?

### Typical question
“Inside a pod, how do you test if it can reach another service?”

### Answer – step by step with commands

1. **Exec into the pod**  
   - Command:  
     ```bash
     kubectl exec -it pod-name -- sh
     # or bash if available:
     kubectl exec -it pod-name -- bash
     ```  
   - Explanation:  
     - Drops you into a shell.  
     - From here you can run Linux network commands as if you are inside the container.

2. **Check DNS resolution**  
   - Command (inside pod):  
     ```bash
     nslookup service-name
     ```  
   - Explanation:  
     - Confirms if cluster DNS (CoreDNS) resolves the service name to a ClusterIP.

3. **Test HTTP/TCP connectivity**  
   - Commands (inside pod):  
     ```bash
     curl http://service-name:8080/health
     # or
     nc -vz service-name 8080
     ```  
   - Explanation:  
     - `curl` checks application HTTP response.  
     - `nc` just checks TCP layer.  
     - If DNS works but `nc` fails, it’s ports/firewall/NetworkPolicy.  
     - If both fail, DNS or service definition is broken.

---

## Q7. How do you see Kubernetes Service → Pod mappings?

### Typical question
“How do you confirm that a Service actually points to the right pods?”

### Answer – step by step with commands

1. **Get the Service details**  
   - Command:  
     ```bash
     kubectl get svc my-service
     kubectl describe svc my-service
     ```  
   - Explanation:  
     - `get` gives a summary (ClusterIP, ports, selectors).  
     - `describe` shows selectors and linked Endpoints.

2. **Check endpoints behind the Service**  
   - Command:  
     ```bash
     kubectl get endpoints my-service
     ```  
   - Explanation:  
     - Shows pod IP:port pairs that the Service forwards to.  
     - If `endpoints` is empty, Service has no backing pods (label selector mismatch).

3. **List pods with matching labels**  
   - Command:  
     ```bash
     kubectl get pods -l app=my-service
     ```  
   - Explanation:  
     - Uses the label selector from Service (`selector: app=my-service`).  
     - If no pods show up, labels on pods or Service are wrong.

---

## Q8. How do you trace the route packets take to a destination?

### Typical question
“How do you see intermediate hops between your server and a target?”

### Answer – step by step with commands

1. **Use traceroute or tracepath**  
   - Commands:  
     ```bash
     traceroute 8.8.8.8
     # or, often installed by default:
     tracepath 8.8.8.8
     ```  
   - Explanation:  
     - Sends packets with increasing TTL to discover each router/hop on the path.  
     - Useful to see where packets are getting dropped or delayed.

2. **Interpret results**  
   - Hops with increasing latency show path length.  
   - `* * *` or timeouts at some hop suggest filtering or issues at that point.  
   - If first hops are internal IPs (10.x, 192.168.x), you see internal network; later, ISP/public.

3. **DevOps angle**  
   - Helps debug VPN routes, cross‑region latency, or on‑prem ↔ cloud routing issues.

---

## Q9. How do you check and debug MTU / fragmentation issues?

### Typical question
“Some large requests fail, but small ones succeed. It might be MTU. How do you check?”

### Answer – step by step with commands

1. **Check interface MTU**  
   - Command:  
     ```bash
     ip link
     ```  
   - Explanation:  
     - Shows interfaces with MTU (e.g., 1500, 9001).  
     - Mismatched MTUs across network segments can cause fragmentation or drops.

2. **Use ping with do‑not‑fragment and size**  
   - Linux example:  
     ```bash
     ping -M do -s 1400 10.0.0.10
     ```  
   - Explanation:  
     - `-M do` sets “don’t fragment” bit.  
     - `-s 1400` sets payload size.  
     - If this fails but smaller sizes pass, path MTU is lower than you think.

3. **DevOps use case**  
   - Often appears with VPNs, tunnels, or overlay networks (like VXLAN in Kubernetes).  
   - Fix: adjust MTU on interfaces or configure path MTU discovery correctly.

---

## Q10. How do you inspect firewall rules on a Linux machine?

### Typical question
“You suspect the local firewall is blocking traffic. What do you check?”

### Answer – step by step with commands

1. **Check iptables rules (legacy)**  
   - Command:  
     ```bash
     sudo iptables -L -n -v
     ```  
   - Explanation:  
     - Lists chains (INPUT, OUTPUT, FORWARD) with rules.  
     - `-n` numeric output, `-v` verbose (includes packet count).  
     - Look for rules that drop or reject traffic on the relevant ports/IPs.

2. **If using firewalld (common in RHEL/CentOS)**  
   - Command:  
     ```bash
     sudo firewall-cmd --list-all
     ```  
   - Explanation:  
     - Shows zones, allowed services/ports.  
     - Check if your port/service is present in allowed list.

3. **High‑level decision**  
   - If local firewall is dropping your traffic, either adjust rules or disable firewall for testing (only in safe environments).  
   - Always coordinate with security; don’t blindly flush iptables in production.

# Networking Interview – Practical Questions with Commands (Batch 2: Q11–Q20)

## Q11. How do you check if a Linux server is using the correct DNS servers?

### Typical question
“You suspect DNS is misconfigured on a Linux node. How do you verify which DNS servers it uses?”

### Answer – step by step with commands

1. **Check `/etc/resolv.conf`**  
   - Command:  
     ```bash
     cat /etc/resolv.conf
     ```  
   - Explanation:  
     - Shows `nameserver` lines, for example:  
       `nameserver 10.0.0.2`  
     - These are the DNS servers the OS resolver will query.  
     - If these IPs are wrong (e.g., old on‑prem DNS, or typos), all name resolution will fail.

2. **Confirm DNS servers are reachable**  
   - Command:  
     ```bash
     ping -c 3 10.0.0.2
     ```  
   - Explanation:  
     - Checks network reachability to the DNS IP.  
     - If ping fails, DNS server is down or unreachable, even if IP config is correct.

3. **Query DNS server directly**  
   - Command:  
     ```bash
     dig @10.0.0.2 example.com
     ```  
   - Explanation:  
     - Forces `dig` to ask that specific DNS server.  
     - If this fails, DNS service on that IP is broken or blocked.  
     - If it works but normal lookups fail, maybe `/etc/resolv.conf` is being overwritten by a network manager.

---

## Q12. How do you verify that an HTTP service is reachable through a load balancer?

### Typical question
“Users hit the load balancer URL and see errors. How do you debug from a node?”

### Answer – step by step with commands

1. **Test from a client machine using curl**  
   - Command:  
     ```bash
     curl -v https://api.mybank.com/health
     ```  
   - Explanation:  
     - `-v` (verbose) shows the handshake, DNS resolution, and HTTP headers.  
     - You can see:  
       - DNS result (which IPs the hostname resolves to).  
       - TLS handshake (for HTTPS).  
       - Final HTTP status code (200, 5xx, etc.).

2. **Test backend directly (if allowed)**  
   - Command:  
     ```bash
     curl -v http://10.0.1.10:8080/health
     ```  
   - Explanation:  
     - Bypasses the load balancer and hits the application directly.  
     - If direct backend call works but LB URL fails, the issue is with LB routing, health checks, or LB → backend path.

3. **Check LB health status (cloud or on‑prem)**  
   - Example (AWS):  
     - Use console or CLI:  
       ```bash
       aws elbv2 describe-target-health --target-group-arn <arn>
       ```  
   - Explanation:  
     - Shows which targets (instances/pods) are healthy/unhealthy.  
     - If all targets are unhealthy, LB will return 5xx even if app is up but health endpoint is misconfigured.

---

## Q13. How do you diagnose “connection refused” vs “connection timeout”?

### Typical question
“Explain the difference between ‘connection refused’ and ‘connection timed out’ and how you debug each.”

### Answer – step by step

1. **`connection refused`**  
   - Meaning:  
     - Your packet reached the target IP.  
     - OS immediately responded “no one is listening on that port”.  
   - Debug steps:  
     - On the server:  
       ```bash
       ss -lntp | grep 8080
       ```  
     - If no process is listening → start/fix the application.  
     - If app is listening on `127.0.0.1` only, but clients use private IP → fix bind address.

2. **`connection timed out`**  
   - Meaning:  
     - Your client never got a response.  
     - Packets likely dropped by firewall, SG, NACL, or routing.  
   - Debug steps:  
     - Check security groups/firewalls on both sides.  
     - Use `traceroute` / `tracepath` to see where the path breaks.  
     - In cloud: verify routes and NACLs for both source and destination subnets.

---

## Q14. How do you test outbound internet access from a private subnet / private server?

### Typical question
“A server in a private network should reach the internet via a proxy or NAT. How do you test this?”

### Answer – step by step with commands

1. **Test DNS resolution first**  
   - Command:  
     ```bash
     dig google.com
     ```  
   - Explanation:  
     - Confirms DNS can resolve public names.  
     - If this fails, internet access will also fail for domain-based calls.

2. **Test HTTP access to a well‑known site**  
   - Command:  
     ```bash
     curl -I https://www.google.com
     ```  
   - Explanation:  
     - `-I` fetches only headers (lighter).  
     - If this fails (timeout), NAT or proxy is broken.

3. **If behind corporate proxy**  
   - Command:  
     ```bash
     export http_proxy=http://proxy.internal:3128
     export https_proxy=http://proxy.internal:3128
     curl -I https://www.google.com
     ```  
   - Explanation:  
     - Sets environment variables so CLI tools use the proxy.  
     - If curl works only with proxy set → direct outbound is blocked; must always use proxy.

---

## Q15. How do you verify NetworkPolicies in Kubernetes are not blocking traffic?

### Typical question
“Pod‑to‑pod traffic stopped after adding NetworkPolicies. How do you check it?”

### Answer – step by step with commands

1. **List all NetworkPolicies in the namespace**  
   - Command:  
     ```bash
     kubectl get networkpolicy
     ```  
   - Explanation:  
     - Shows all policies that might be enforcing traffic rules.  
     - Names give a hint (e.g., `deny-all`, `allow-from-frontend`).

2. **Describe a specific NetworkPolicy**  
   - Command:  
     ```bash
     kubectl describe networkpolicy deny-all
     ```  
   - Explanation:  
     - Shows which pods (`podSelector`) and which directions (`ingress`, `egress`) the policy applies to.  
     - Look at `from`, `to`, and port sections to see what is allowed.

3. **Test connectivity with and without matching labels**  
   - Example:  
     - Change pod labels so they do or do not match the policy.  
     - From pod A, run:  
       ```bash
       curl http://service-b:8080/health
       ```  
   - Explanation:  
     - If traffic works when pod doesn’t match policy but fails when it does, the policy is blocking it.  
     - Adjust `from` rules to allow required communication.

---

## Q16. How do you examine VPC routes and security groups for a failing connection (cloud context)?

### Typical question
“In AWS/Azure, an app in one subnet can’t reach an app in another. How do you debug from the networking side?”

### Answer – high‑level steps (you narrate, not commands, but keep mental checklist)

1. **Check routing tables**  
   - Verify that subnet A’s route table has a route to subnet B (direct, peering, transit gateway, etc.).  
   - Likewise, verify subnet B’s routes to A.  
   - Missing or wrong route → packets never arrive.

2. **Check security groups**  
   - Ensure the target SG allows inbound on the correct port from the source’s SG or IP range.  
   - Some designs use SG → SG rules rather than CIDR ranges.

3. **Check NACLs**  
   - For both subnets, check NACLs allow the traffic (inbound/outbound) on that port range.  
   - Because they are stateless, you must allow both directions.

4. **Confirm with in‑VM commands**  
   - From source VM:  
     ```bash
     ping target-ip
     nc -vz target-ip 8080
     ```  
   - Explanation:  
     - If ping fails and there is no security rule for ICMP, try TCP 8080.  
     - Combine command results with route/SG/NACL views to find the block.

---

## Q17. How do you check HTTP headers and see redirects / cookies during debugging?

### Typical question
“You suspect redirects or headers are wrong. How do you inspect raw HTTP from CLI?”

### Answer – step by step with commands

1. **Use `curl -v` to see request and response headers**  
   - Command:  
     ```bash
     curl -v https://api.mybank.com/login
     ```  
   - Explanation:  
     - `-v` shows both request and response headers.  
     - You see `Host`, `User-Agent`, and response headers like `Set-Cookie`, `Location`, `X-*` headers.

2. **Follow redirects**  
   - Command:  
     ```bash
     curl -v -L https://api.mybank.com/login
     ```  
   - Explanation:  
     - `-L` tells curl to follow redirects.  
     - You can see if it is bouncing between HTTP/HTTPS or different hosts, which might cause loops or failures.

3. **Inspect only response headers**  
   - Command:  
     ```bash
     curl -I https://api.mybank.com/login
     ```  
   - Explanation:  
     - `-I` sends a HEAD request.  
     - Faster for checking status code, server type, and key headers.

---

## Q18. How do you capture and analyze network packets for a problem?

### Typical question
“Sometimes you need to see actual packets. How would you do this on Linux?”

### Answer – step by step with commands

1. **Use tcpdump to capture traffic on an interface**  
   - Command (example for port 80):  
     ```bash
     sudo tcpdump -i eth0 port 80 -nn -vv
     ```  
   - Explanation:  
     - `-i eth0` captures on interface eth0.  
     - `port 80` captures only traffic on TCP 80.  
     - `-nn` = no name resolution, `-vv` = very verbose.  
     - Good for real‑time troubleshooting.

2. **Capture to a file for later analysis**  
   - Command:  
     ```bash
     sudo tcpdump -i eth0 port 80 -w capture.pcap
     ```  
   - Explanation:  
     - `-w` writes raw packets to a file.  
     - You can open `capture.pcap` in Wireshark for deep inspection (TLS handshake, HTTP, etc.).

3. **DevOps caution**  
   - Only capture where you are allowed; packet capture can see sensitive data.  
   - Use filters to limit to relevant targets.

---

## Q19. How do you test if a reverse proxy (like NGINX) is correctly forwarding requests to backend?

### Typical question
“You set up NGINX as reverse proxy in front of a backend. Clients get 502/504. How do you debug?”

### Answer – step by step with commands

1. **Check NGINX status and config**  
   - Commands:  
     ```bash
     sudo nginx -t
     sudo systemctl status nginx
     ```  
   - Explanation:  
     - `nginx -t` tests configuration syntax and shows if config is valid.  
     - `systemctl status` shows if process is running and any recent errors.

2. **Test backend directly**  
   - Command:  
     ```bash
     curl http://127.0.0.1:8080/health
     ```  
   - Explanation:  
     - If NGINX forwards to `http://127.0.0.1:8080`, check that this endpoint responds.  
     - If backend is down or slow → NGINX returns 502 or 504.

3. **Test via proxy**  
   - Command:  
     ```bash
     curl -v http://proxy-host:80/health
     ```  
   - Explanation:  
     - Compare backend vs proxy results.  
     - If backend ok but proxy fails, review `proxy_pass` configuration, upstream block, and EIP/SG rules (if LB involved).

---

## Q20. How do you quickly see active connections and where they are coming from on a Linux server?

### Typical question
“You want to know who is hitting your service in real time. How do you check?”

### Answer – step by step with commands

1. **Use `ss` to see active TCP connections**  
   - Command:  
     ```bash
     ss -ntp
     ```  
   - Explanation:  
     - `-n` numeric addresses, `-t` TCP, `-p` show process.  
     - Shows local address:port, remote address:port, connection state.

2. **Filter by service port**  
   - Command:  
     ```bash
     ss -ntp | grep ':8080 '
     ```  
   - Explanation:  
     - Shows only connections involving port 8080.  
     - Useful to see which client IPs are connected to your app.

3. **Top talkers (rough style)**  
   - Command:  
     ```bash
     ss -ntp | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
     ```  
   - Explanation (high level):  
     - Extract remote address column, cut off port, count occurrences.  
     - Show IPs with most connections – gives a quick idea of which clients are hitting you hardest.
# Networking Interview – Practical Questions with Commands (Batch 3: Q21–Q30)

## Q21. How do you check if two Linux servers can reach each other over a specific port (end‑to‑end)?

### Typical question
“Service A on server1 must talk to service B on server2:443. How do you verify connectivity?”

### Answer – step by step with commands

1. **From server1, test basic IP reachability to server2**  
   - Command:  
     ```bash
     ping -c 3 server2
     # or by IP:
     ping -c 3 10.0.2.15
     ```  
   - Explanation:  
     - Confirms that ICMP reaches the IP.  
     - If ping fails, check routes and firewall/SG blocking ICMP.

2. **From server1, test TCP connectivity to port 443 on server2**  
   - Command:  
     ```bash
     nc -vz 10.0.2.15 443
     ```  
   - Explanation:  
     - `nc` tries to open a TCP connection on port 443.  
     - If it prints `succeeded` → path + port are open.  
     - If it times out → likely firewall/SG/NACL issue.  
     - If it is refused → server reached but nothing listening on 443.

3. **On server2, confirm it listens on the expected port**  
   - Command:  
     ```bash
     ss -lntp | grep ':443 '
     ```  
   - Explanation:  
     - Shows whether any process is bound to port 443.  
     - If nothing is listening, the problem is application-side, not network.

---

## Q22. How do you verify and debug ARP issues on Linux?

### Typical question
“Two machines are in the same subnet, but one can’t reach the other. How do you look at ARP?”

### Answer – step by step with commands

1. **View the ARP table**  
   - Command:  
     ```bash
     ip neigh
     ```  
   - Explanation:  
     - Shows mappings of IP → MAC (e.g., `10.0.0.1 lladdr aa:bb:cc:dd:ee:ff`).  
     - If entry is `FAILED` or `INCOMPLETE`, ARP resolution isn’t working.

2. **Clear a possibly stale ARP entry**  
   - Command:  
     ```bash
     sudo ip neigh flush dev eth0
     ```  
   - Explanation:  
     - Flushes ARP entries for interface `eth0` so they will be relearned.  
     - Useful when IP/MAC mappings changed.

3. **Ping again after flushing**  
   - Command:  
     ```bash
     ping -c 3 10.0.0.1
     ```  
   - Explanation:  
     - Initiates new ARP requests.  
     - If still failing, check switch/VM settings or duplicate IP conflicts.

---

## Q23. How do you confirm which network interface is used for traffic to a specific destination?

### Typical question
“Server has multiple NICs. Which interface will it use for 8.8.8.8?”

### Answer – step by step with commands

1. **Use `ip route get`**  
   - Command:  
     ```bash
     ip route get 8.8.8.8
     ```  
   - Example output (simplified):  
     `8.8.8.8 via 10.0.0.1 dev eth0 src 10.0.0.10`  
   - Explanation:  
     - `dev eth0` shows which interface will be used.  
     - `src 10.0.0.10` shows which source IP will be used.

2. **DevOps angle**  
   - Useful when debugging multi‑homed servers, VPNs, or policy routing.  
   - Helps you know which SG/NACL/VPC route table is actually in play.

---

## Q24. How do you see open listening ports and associated services on Linux?

### Typical question
“You suspect a service isn’t listening on the right port. How to list listening ports?”

### Answer – step by step with commands

1. **Use `ss` (modern tool)**  
   - Command:  
     ```bash
     sudo ss -lntp
     ```  
   - Explanation:  
     - `-l` = listening, `-n` = numeric, `-t` = TCP, `-p` = show process.  
     - You see lines like `LISTEN 0 128 0.0.0.0:8080 ... users:(("java",pid=1234,fd=10))`.

2. **Filter by specific port**  
   - Command:  
     ```bash
     sudo ss -lntp | grep ':8080 '
     ```  
   - Explanation:  
     - Quickly confirm if your web app is bound on 8080 and which IP (0.0.0.0 vs 127.0.0.1).

3. **Alternative: `netstat`**  
   - Command:  
     ```bash
     sudo netstat -lntp
     ```  
   - Explanation:  
     - Older but similar output; many admins still use it.

---

## Q25. How do you debug “curl works from one machine but not from another” to the same URL?

### Typical question
“From host A, curl works. From host B, curl fails. What’s your approach?”

### Answer – step by step

1. **Compare DNS resolution**  
   - On both hosts:  
     ```bash
     dig api.mybank.com +short
     ```  
   - Explanation:  
     - Ensure both hosts resolve to the same IP(s).  
     - If different, one host may be using a different DNS (on‑prem vs cloud, or old records).

2. **Compare routes/gateways**  
   - On both hosts:  
     ```bash
     ip route
     ```  
   - Explanation:  
     - Check default routes.  
     - One host might be behind a VPN or different VPC route table.

3. **Compare firewall/SGs**  
   - In cloud:  
     - Compare security groups and NACLs for the two hosts.  
   - On‑prem:  
     - Check local firewalls (`iptables`, `firewalld`) and upstream firewall rules.  
   - Explanation:  
     - Possibly host B’s subnet or IP range is not allowed at the destination.

---

## Q26. How do you verify if a reverse DNS (PTR) record is set for an IP?

### Typical question
“You need to check reverse DNS for an IP address. How do you do that?”

### Answer – step by step with commands

1. **Use `dig -x`**  
   - Command:  
     ```bash
     dig -x 8.8.8.8
     ```  
   - Explanation:  
     - `-x` performs a reverse lookup (IP → name).  
     - Shows PTR record, e.g., `dns.google.`

2. **Use `host` command**  
   - Command:  
     ```bash
     host 8.8.8.8
     ```  
   - Explanation:  
     - A simpler wrapper around reverse DNS queries.  
     - Useful for mail server checks, log analysis, etc.

3. **DevOps angle**  
   - Reverse DNS sometimes required for email servers (SPAM checks).  
   - Helps identify unknown IPs in logs.

---

## Q27. How do you quickly check which outbound ports are allowed by a firewall?

### Typical question
“You want to know if a server can call out on ports 80, 443, 5432, etc. How do you test?”

### Answer – step by step with commands

1. **Use `nc` to test outbound to a known test server**  
   - Command:  
     ```bash
     nc -vz testserver.example.com 80
     nc -vz testserver.example.com 443
     nc -vz testserver.example.com 5432
     ```  
   - Explanation:  
     - If you control `testserver`, open those ports and see if connections succeed.  
     - If some ports fail → outbound firewall is blocking them.

2. **Use public services for common ports**  
   - Examples:  
     ```bash
     nc -vz google.com 443
     ```  
   - Explanation:  
     - If this fails from your server, outbound 443 is blocked or proxy required.

3. **DevOps note**  
   - Always be careful with scanning unknown hosts; prefer controlled test endpoints.

---

## Q28. How do you inspect and test HTTP/HTTPS through a corporate proxy?

### Typical question
“Environment requires HTTP traffic through a proxy. How do you verify and debug it?”

### Answer – step by step with commands

1. **Set proxy environment variables**  
   - Commands:  
     ```bash
     export http_proxy=http://proxy.internal:3128
     export https_proxy=http://proxy.internal:3128
     ```  
   - Explanation:  
     - Many CLI tools (curl, pip, etc.) read `http_proxy` and `https_proxy`.  
     - Without these, requests may fail with timeout.

2. **Test with curl**  
   - Command:  
     ```bash
     curl -I https://www.google.com
     ```  
   - Explanation:  
     - If it works only when proxy is set, direct internet access is blocked.  
     - If it still fails, proxy settings or credentials could be wrong.

3. **Check no_proxy for internal services**  
   - Command:  
     ```bash
     export no_proxy="localhost,127.0.0.1,.internal"
     ```  
   - Explanation:  
     - Prevents traffic to internal domains from going through the proxy.  
     - Useful to avoid weird routing for internal APIs.

---

## Q29. How do you check bandwidth usage or network throughput on a Linux server?

### Typical question
“You suspect network congestion. How can you quickly see network usage?”

### Answer – step by step with commands

1. **Use `ifstat` or `sar` (if installed)**  
   - Command:  
     ```bash
     ifstat -i eth0 1
     ```  
   - Explanation:  
     - Shows RX/TX rates per interface every second.  
     - Quick view of whether traffic is heavy.

2. **Use `nload` for nicer visual output**  
   - Command:  
     ```bash
     nload eth0
     ```  
   - Explanation:  
     - Shows incoming/outgoing bandwidth graphically.  
     - Good for spotting spikes.

3. **DevOps angle**  
   - Combine with app logs and metrics to see if high throughput is expected or indicates problems (e.g., DDoS, misconfigured client).

---

## Q30. How do you view and analyze VPC Flow Logs (high‑level) to debug network issues in cloud?

### Typical question
“In cloud, how do you use VPC Flow Logs to debug dropped connections?”

### Answer – high‑level steps (you describe, not necessarily commands)

1. **Enable VPC Flow Logs on relevant VPC or subnet**  
   - Logs contain:
     - Source IP/port, destination IP/port.  
     - Protocol, action (`ACCEPT`/`REJECT`), bytes, and timestamps.[web:148]

2. **Send logs to CloudWatch Logs or S3 (or similar)**  
   - Then query:
     - For specific source/destination IPs and ports.  
     - Filter by `REJECT` to see what traffic is being blocked.

3. **Use logs for RCA**  
   - If you see `REJECT` entries between specific IPs, tie back to:
     - NACL or SG rules that block that traffic.  
     - Misconfigured route tables.

4. **DevOps link**  
   - Flow logs are like wire‑level traces at VPC level, useful when you can’t install tcpdump on all instances.

# Networking Interview – Practical Questions with Commands (Batch 4: Q31–Q40)

## Q31. How do you check which ports are open from *outside* a Kubernetes cluster service?

### Typical question
“An external client can’t reach a Service exposed via LoadBalancer/Ingress. How do you test from outside?”

### Answer – step by step

1. **Resolve the external hostname to IP**  
   - Command (from any external Linux box):  
     ```bash
     dig myapp.example.com +short
     ```  
   - Explanation:  
     - Shows the IP/frontend the client is actually connecting to (public LB, etc.).  
     - Confirms DNS is pointing to the correct load balancer.

2. **Test TCP connectivity to the expected port**  
   - Command:  
     ```bash
     nc -vz myapp.example.com 80
     nc -vz myapp.example.com 443
     ```  
   - Explanation:  
     - Checks whether the LB listens and accepts TCP connections on 80/443.  
     - If these fail → network/firewall/LB config problem before hitting K8s.

3. **If TCP works, test HTTP path**  
   - Command:  
     ```bash
     curl -v https://myapp.example.com/health
     ```  
   - Explanation:  
     - Verifies routing at HTTP level (Ingress rules, paths, hosts).  
     - If `/health` fails, inspect Ingress or backend Service configuration.

---

## Q32. How do you verify that Kubernetes Ingress routes traffic to the correct Service?

### Typical question
“Requests hit Ingress, but wrong service or 404 is returned. How to debug?”

### Answer – step by step

1. **Inspect Ingress resource**  
   - Command:  
     ```bash
     kubectl get ingress
     kubectl describe ingress my-ingress
     ```  
   - Explanation:  
     - `describe` shows hostnames, paths, and mapped Services and ports.  
     - Make sure the `host` and `path` match what the client calls.

2. **Ensure backend Services exist and have endpoints**  
   - Command:  
     ```bash
     kubectl get svc backend-service
     kubectl get endpoints backend-service
     ```  
   - Explanation:  
     - Service must exist with correct `port` and selectors.  
     - Endpoints must be non‑empty; otherwise Ingress has nowhere to send traffic.

3. **Test Service directly from inside the cluster**  
   - Command:  
     ```bash
     kubectl exec -it some-pod -- curl -v http://backend-service:8080/health
     ```  
   - Explanation:  
     - If this works but Ingress fails, the issue is with Ingress rules or Ingress controller, not the app.

---

## Q33. How do you check if a Kubernetes Service is using the right type (ClusterIP / NodePort / LoadBalancer)?

### Typical question
“Service is not reachable from outside. Did we choose the right Service type?”

### Answer – step by step

1. **Check Service type**  
   - Command:  
     ```bash
     kubectl get svc my-service
     ```  
   - Explanation:  
     - The `TYPE` column shows `ClusterIP`, `NodePort`, or `LoadBalancer`.  
     - `ClusterIP` is only reachable inside cluster, `NodePort` via nodeIP:nodePort, `LoadBalancer` via cloud LB.

2. **Describe Service for details**  
   - Command:  
     ```bash
     kubectl describe svc my-service
     ```  
   - Explanation:  
     - Shows ports, nodePort (if any), and external IPs if type is `LoadBalancer`.  
     - For `LoadBalancer`, check whether an external IP/hostname has been assigned.

3. **Test accordingly**  
   - For `ClusterIP`: test from a pod.  
   - For `NodePort`:  
     ```bash
     nc -vz <node-ip> <nodePort>
     ```  
   - For `LoadBalancer`:  
     ```bash
     curl -v http://<lb-dns-name>/
     ```  
   - Explanation:  
     - Validates that the Service type aligns with how clients are attempting to reach it.

---

## Q34. How do you check if a Kubernetes Pod has the correct IP and DNS settings?

### Typical question
“You suspect Pod network config is broken. How do you verify inside the Pod?”

### Answer – step by step

1. **Exec into the pod**  
   - Command:  
     ```bash
     kubectl exec -it mypod -- sh
     ```  

2. **Check IP configuration**  
   - Command (inside pod):  
     ```bash
     ip addr
     ```  
   - Explanation:  
     - Shows the Pod IP and interfaces.  
     - The IP should match what `kubectl get pod -o wide` displays.

3. **Check DNS configuration**  
   - Command (inside pod):  
     ```bash
     cat /etc/resolv.conf
     ```  
   - Explanation:  
     - Shows nameservers and search domains.  
     - For K8s, DNS server is usually the cluster DNS service (e.g., CoreDNS IP).

4. **Check routing**  
   - Command (inside pod):  
     ```bash
     ip route
     ```  
   - Explanation:  
     - Default route usually points to the node’s virtual gateway.  
     - If there’s no default route, Pod won’t reach anything outside its own subnet.

---

## Q35. How do you confirm that a Kubernetes cluster’s DNS (CoreDNS) is healthy?

### Typical question
“Pods report DNS resolution failures. How do you validate CoreDNS?”

### Answer – step by step

1. **Check CoreDNS pods status**  
   - Command:  
     ```bash
     kubectl get pods -n kube-system -l k8s-app=kube-dns
     ```  
   - Explanation:  
     - All CoreDNS pods should be `Running`.  
     - If they are `CrashLoopBackOff` or `Pending`, DNS will be unreliable.

2. **Check logs of CoreDNS**  
   - Command:  
     ```bash
     kubectl logs -n kube-system <coredns-pod-name>
     ```  
   - Explanation:  
     - Look for error messages, timeouts, or upstream DNS failures.

3. **Run DNS test from a test pod**  
   - Command:  
     ```bash
     kubectl run -it dns-test --image=busybox --restart=Never -- sh
     nslookup kubernetes.default
     ```  
   - Explanation:  
     - If `kubernetes.default` resolves, cluster DNS is working.  
     - If not, the problem is in DNS config or CoreDNS upstream.

---

## Q36. How do you test connectivity between two namespaces in Kubernetes?

### Typical question
“App in namespace A must talk to DB in namespace B. How do you verify?”

### Answer – step by step

1. **Ensure Service FQDN is correct**  
   - FQDN pattern:  
     ```text
     service-name.namespace.svc.cluster.local
     ```  
   - Explanation:  
     - For a Service `db` in namespace `data`, FQDN is: `db.data.svc.cluster.local`.

2. **From a pod in namespace A, test using Service FQDN**  
   - Command:  
     ```bash
     kubectl exec -it pod-in-A -n ns-a -- sh
     # inside pod:
     nc -vz db.data.svc.cluster.local 5432
     ```  
   - Explanation:  
     - Confirms DNS and TCP from ns‑a pods to db in ns‑b.

3. **If NetworkPolicies exist, verify allow rules**  
   - Command:  
     ```bash
     kubectl get networkpolicy -n data
     kubectl describe networkpolicy <name>
     ```  
   - Explanation:  
     - Ensure NetworkPolicies in `data` namespace allow ingress from namespace `ns-a` on required ports.

---

## Q37. How do you verify that your node’s time (NTP) is not causing TLS/expiry issues?

### Typical question
“Sometimes TLS/SSL fails due to wrong server time. How do you check and correct it?”

### Answer – step by step

1. **Check current time and timezone**  
   - Command:  
     ```bash
     date
     ```  
   - Explanation:  
     - Shows current system date/time and timezone.  
     - If significantly different from real time, TLS cert validation may fail.

2. **Check NTP sync status (systemd‑timesyncd example)**  
   - Command:  
     ```bash
     timedatectl
     ```  
   - Explanation:  
     - Shows whether NTP is active and synchronized.  
     - `NTP synchronized: yes` is what you want.

3. **If not synced, restart/enable NTP service**  
   - Command (example):  
     ```bash
     sudo systemctl restart systemd-timesyncd
     sudo systemctl enable systemd-timesyncd
     ```  
   - Explanation:  
     - Once sync is working, certificate checks that use `NotBefore`/`NotAfter` will be consistent.

---

## Q38. How do you test a service listening only on localhost (127.0.0.1) from remote?

### Typical question
“App binds to 127.0.0.1:9000; external hosts can’t access it. How can you debug and fix?”

### Answer – step by step

1. **Check binding address**  
   - Command:  
     ```bash
     ss -lntp | grep 9000
     ```  
   - Explanation:  
     - If you see `127.0.0.1:9000`, it’s only bound to localhost.  
     - If you want remote access, it must bind to `0.0.0.0` or a specific private IP.

2. **Test locally on server**  
   - Command:  
     ```bash
     curl http://127.0.0.1:9000/health
     ```  
   - Explanation:  
     - If this works, app itself is fine; only binding prevents remote access.

3. **Update app config**  
   - Change listen address from `127.0.0.1` to `0.0.0.0` (or a specific interface IP).  
   - Restart the app and re‑test:  
     ```bash
     ss -lntp | grep 9000
     nc -vz server-ip 9000
     ```  
   - Explanation:  
     - After binding to non‑localhost, remote clients should reach it (assuming firewall/SG allow it).

---

## Q39. How do you verify ICMP (ping) is blocked or allowed by security rules?

### Typical question
“You’re not sure if ping is blocked by firewall or not. How do you check?”

### Answer – step by step

1. **Test ping from client to server**  
   - Command:  
     ```bash
     ping -c 4 10.0.0.10
     ```  
   - Explanation:  
     - If you see 100% packet loss but know the server is up, ICMP may be blocked.

2. **Check server’s local firewall rules**  
   - Command:  
     ```bash
     sudo iptables -L -n -v | grep icmp
     ```  
   - Explanation:  
     - Look for rules dropping or rejecting ICMP echo requests.

3. **Check cloud security rules (if in cloud)**  
   - Verify security groups / NACLs that might restrict ICMP.  
   - Explanation:  
     - Some companies intentionally block ping for security.  
     - So failure of ping doesn’t always mean server is down.

---

## Q40. How do you verify that an HTTP/HTTPS endpoint is using the correct certificate (domain, expiry)?

### Typical question
“Users report SSL warnings. How do you check the certificate from CLI?”

### Answer – step by step

1. **Inspect certificate with openssl**  
   - Command:  
     ```bash
     echo | openssl s_client -connect api.mybank.com:443 -servername api.mybank.com 2>/dev/null | openssl x509 -noout -text
     ```  
   - Explanation:  
     - First `openssl s_client` connects to server and gets the cert.  
     - Piped into `openssl x509 -text` to display cert details.  
     - `-servername` handles SNI (multiple certs on same IP).

2. **Check subject, SANs, and expiry**  
   - In output, check:
     - `Subject:` – CN (common name).  
     - `X509v3 Subject Alternative Name` – list of hostnames.  
     - `Not Before` / `Not After` – certificate validity period.  
   - Explanation:  
     - Ensure domain matches your hostname.  
     - Ensure `Not After` is in the future.

3. **DevOps angle**  
   - You can use this in an automated check to alert before cert expiry.  
   - Also helps confirm LB/Ingress is using the updated cert after rotation.


# Networking Interview – Practical Questions with Commands (Batch 5: Q41–Q50)

## Q41. How do you check if a server is in a public or private subnet in cloud?

### Typical question
“In AWS/Azure, how do you know if a server is in a public subnet or private subnet?”

### Answer – step by step

1. **Check if the instance has a public IP**  
   - AWS CLI example:  
     ```bash
     aws ec2 describe-instances --instance-ids <id> \
       --query 'Reservations.Instances.PublicIpAddress'
     ```  
   - Explanation:  
     - If there is a public IP assigned, the instance is usually in a subnet that allows direct internet routing (though SGs still matter).

2. **Check the subnet’s route table**  
   - AWS CLI example:  
     ```bash
     aws ec2 describe-route-tables \
       --filters "Name=association.subnet-id,Values=<subnet-id>"
     ```  
   - Explanation:  
     - Look for a route `0.0.0.0/0` pointing to an Internet Gateway (IGW).  
     - Subnet with IGW default route → public subnet.  
     - Subnet with default route to NAT Gateway/instance only → private subnet.

3. **DevOps implication**  
   - Public subnet: instances can have public IPs and be reachable (with proper SG).  
   - Private subnet: instances typically reach internet via NAT, not directly reachable from internet.

---

## Q42. How do you debug “instances in private subnet cannot reach internet via NAT”?

### Typical question
“Private instances should reach the internet via NAT, but outbound `curl` fails. What do you check?”

### Answer – step by step

1. **Check route table for private subnet**  
   - Confirm that:  
     ```text
     0.0.0.0/0 -> nat-gateway-id
     ```  
   - Explanation:  
     - If default route is missing or points to wrong target, traffic never reaches NAT.

2. **Check NAT Gateway/instance health**  
   - In AWS, ensure NAT Gateway is in a public subnet with a route to IGW.  
   - If NAT instance is used, ensure it is running and configured to forward traffic (IP forwarding + iptables MASQUERADE).

3. **Test from private instance**  
   - Command:  
     ```bash
     curl -I https://www.google.com
     ```  
   - Explanation:  
     - If fails, narrow down using `traceroute` to see where packets stop (likely at subnet/router).

---

## Q43. How do you verify security group rules for an EC2 instance (or VM)?

### Typical question
“Connection fails; might be SG. How do you inspect security group rules?”

### Answer – step by step

1. **List SGs associated with the instance**  
   - AWS CLI example:  
     ```bash
     aws ec2 describe-instances --instance-ids <id> \
       --query 'Reservations.Instances.SecurityGroups'
     ```  
   - Explanation:  
     - Shows which SG IDs are attached to the instance.

2. **Describe each SG’s inbound/outbound rules**  
   - Command:  
     ```bash
     aws ec2 describe-security-groups --group-ids <sg-id>
     ```  
   - Explanation:  
     - Look at `IpPermissions` (inbound) and `IpPermissionsEgress` (outbound).  
     - Ensure the protocol (tcp), port (e.g., 443), and source/dest CIDR or SG are allowed.

3. **DevOps approach**  
   - Combine SG info with logs and `nc`/`curl` tests from clients to verify traffic is permitted.

---

## Q44. How do you test/verify VPC peering connectivity between two VPCs?

### Typical question
“Two VPCs are peered, but services can’t talk. How do you check peering networking?”

### Answer – step by step

1. **Check VPC peering state**  
   - Command (AWS example):  
     ```bash
     aws ec2 describe-vpc-peering-connections --vpc-peering-connection-ids <pcx-id>
     ```  
   - Explanation:  
     - Ensure status is `active`.

2. **Check route tables in both VPCs**  
   - For VPC A’s subnets:  
     - Route for VPC B’s CIDR pointing to peering connection ID.  
   - For VPC B’s subnets:  
     - Route for VPC A’s CIDR pointing to same peering connection ID.  
   - Explanation:  
     - Both directions need routes for traffic to flow.

3. **Check overlapping CIDRs and SGs**  
   - CIDRs of VPCs must not overlap.  
   - Security Groups must allow traffic from the other VPC’s IP ranges.  
   - Test with:  
     ```bash
     ping -c 3 <remote-ip>
     nc -vz <remote-ip> <port>
     ```  

---

## Q45. How do you check for duplicate IP addresses on a subnet?

### Typical question
“Network behaves strangely; might be duplicate IP. How do you detect it?”

### Answer – step by step

1. **Watch ARP entries for changes**  
   - Command:  
     ```bash
     watch -n 1 ip neigh
     ```  
   - Explanation:  
     - If the MAC address for the same IP keeps changing, there might be a duplicate IP conflict.

2. **Ping from multiple hosts and inspect ARP**  
   - From host A and B:  
     ```bash
     ping -c 3 10.0.0.50
     ip neigh | grep 10.0.0.50
     ```  
   - Explanation:  
     - If you see different MACs for 10.0.0.50 at different times, that IP is claimed by more than one device.

3. **DevOps note**  
   - Duplicate IPs are rarer in cloud VPCs (managed), more common in on‑prem or misconfigured static environments.

---

## Q46. How do you quickly check if a web application is behind a proxy or load balancer?

### Typical question
“In debugging headers, how do you see if a request passes through proxies/LBs?”

### Answer – step by step

1. **Inspect response headers with curl**  
   - Command:  
     ```bash
     curl -I https://app.example.com
     ```  
   - Explanation:  
     - Look for headers like `Via`, `X-Forwarded-For`, `X-Forwarded-Proto`, `X-Request-ID`, or specific LB/WAF headers.

2. **Inspect request path with verbose mode**  
   - Command:  
     ```bash
     curl -v https://app.example.com
     ```  
   - Explanation:  
     - See if there are multiple `Location` redirects, or if `Server` header indicates a known proxy (e.g., `nginx`, `envoy`, `cloudfront`).

3. **DevOps angle**  
   - Knowing if a proxy terminates TLS or rewrites headers is crucial for debugging original IP, scheme (http/https), and cookie behavior.

---

## Q47. How do you diagnose high network latency between two systems?

### Typical question
“Users complain of slowness. How do you check if network latency is the cause?”

### Answer – step by step

1. **Measure round‑trip time with ping**  
   - Command:  
     ```bash
     ping -c 10 10.0.2.15
     ```  
   - Explanation:  
     - Look at `avg` and `max` times.  
     - Very high values compared to normal baseline may indicate latency.

2. **Use traceroute/tracepath to find where latency spikes**  
   - Command:  
     ```bash
     traceroute 10.0.2.15
     # or
     tracepath 10.0.2.15
     ```  
   - Explanation:  
     - Check each hop’s RTT.  
     - A specific hop with huge jump indicates where the slowdown occurs (e.g., cross‑region, congested link).

3. **Combine with app metrics**  
   - If network RTT is low but app latency is high, the issue is application or DB, not network.

---

## Q48. How do you verify that a WAF (Web Application Firewall) is not blocking legitimate requests?

### Typical question
“Users get 403/blocked from WAF. How do you debug whether WAF is the cause?”

### Answer – step by step

1. **Check WAF logs for blocked requests**  
   - In cloud (e.g., AWS WAF → CloudWatch logs, etc.).  
   - Filter by client IP, path, or time window when user saw issues.  
   - Explanation:  
     - Look for rules that triggered, such as SQL injection or XSS rules.

2. **Replay the request with curl and examine headers/body**  
   - Command (simplified):  
     ```bash
     curl -v -X POST https://app.example.com/login \
       -H "User-Agent: ..." \
       -d "username=...&password=..."
     ```  
   - Explanation:  
     - Try to replicate the request that WAF blocked.  
     - Adjust payload to see which part triggers WAF (e.g., certain characters or patterns).

3. **Adjust or exclude rules**  
   - Based on logs, tune rule sets or add exceptions for safe, known traffic (e.g., internal tools).  
   - Always validate with another round of testing.

---

## Q49. How do you ensure that logs and metrics capture client IP correctly when behind proxies/LBs?

### Typical question
“App sits behind ALB/NGINX. How do you log real client IP instead of LB IP?”

### Answer – step by step

1. **Check what headers proxies add**  
   - Typical headers:  
     - `X-Forwarded-For` – original client IP.  
     - `X-Forwarded-Proto` – original scheme (http/https).  
     - `X-Forwarded-Host` – original host header.

2. **Adjust web server / app config to trust those headers**  
   - NGINX example (log format):  
     ```nginx
     log_format main '$http_x_forwarded_for - $remote_user [$time_local] '
                     '"$request" $status $body_bytes_sent '
                     '"$http_referer" "$http_user_agent"';
     ```  
   - Explanation:  
     - Use `$http_x_forwarded_for` instead of `$remote_addr` for real client IP.

3. **Validate in logs**  
   - After deploying config, check access logs:  
     ```bash
     tail -f /var/log/nginx/access.log
     ```  
   - Explanation:  
     - Confirm that client IPs match expectations (not just LB IPs).

---

## Q50. How do you summarize your networking troubleshooting approach in an interview?

### Typical question
“In general, what is your approach to debugging network issues in production?”

### Answer – structured, step by step

1. **Start from the client side**  
   - Check:  
     - URL/hostname.  
     - DNS resolution (`dig`, `nslookup`).  
     - Basic connectivity (`ping`, `curl`, `nc`).

2. **Check the path**  
   - On Linux:  
     ```bash
     ip route
     traceroute target
     ```  
   - In cloud: verify VPC routes, peering, VPN, and NAT where relevant.

3. **Check access controls**  
   - Local firewall (`iptables`/`firewalld`).  
   - Cloud SGs and NACLs.  
   - Kubernetes NetworkPolicies.

4. **Check the service itself**  
   - On server: `ss -lntp`, service logs, health endpoints.  
   - Check LB/Ingress status and health checks.

5. **Use observability**  
   - Metrics: latency, error rates, saturation.  
   - Logs: connection errors, timeouts, 4xx/5xx patterns.  
   - Correlate spikes with deploys or config changes.

6. **Communicate clearly**  
   - While debugging, keep notes of steps taken and evidence.  
   - After resolution, document an RCA with: symptom → investigation → root cause → fix → prevention.
