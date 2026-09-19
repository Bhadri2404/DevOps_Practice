# Networking Interview Guide — Beginner Friendly Edition

> Written assuming **zero prior networking knowledge**. Every acronym is spelled out the first time it appears in each section — nothing is assumed. Commands come with real example output, explained piece by piece. Kept short enough to actually finish before an interview.

## How to Use This Guide
Read top to bottom once — each section builds on the last. Every acronym (like TCP, DNS, IP) is spelled out in full the moment it shows up. There's a full glossary at the very end (Section 25) if you ever forget one and want a quick lookup without re-reading a whole section.

## Table of Contents
- [1. Networking Fundamentals](#1-networking-fundamentals)
- [2. OSI Model — 7 Layers](#2-osi-model--7-layers)
- [3. TCP/IP Model — 5 Layers](#3-tcpip-model--5-layers)
- [4. TCP vs UDP](#4-tcp-vs-udp)
- [5. TCP 3-Way Handshake](#5-tcp-3-way-handshake)
- [6. IP Addressing — IPv4, Subnetting & CIDR](#6-ip-addressing--ipv4-subnetting--cidr)
- [7. IPv4 vs IPv6](#7-ipv4-vs-ipv6)
- [8. NAT — Network Address Translation](#8-nat--network-address-translation)
- [9. DNS — Domain Name System](#9-dns--domain-name-system)
- [10. HTTP & HTTPS](#10-http--https)
- [11. HTTP Methods & Status Codes](#11-http-methods--status-codes)
- [12. Cookies & Sessions](#12-cookies--sessions)
- [13. Data Link Layer — MAC & ARP](#13-data-link-layer--mac--arp)
- [14. Networking Devices](#14-networking-devices)
- [15. Firewalls, Security Groups & NACLs](#15-firewalls-security-groups--nacls)
- [16. Load Balancers & Topologies](#16-load-balancers--topologies)
- [17. VPN & Proxy vs Reverse Proxy](#17-vpn--proxy-vs-reverse-proxy)
- [18. CDN — Content Delivery Network](#18-cdn--content-delivery-network)
- [19. Email Protocols — SMTP, IMAP, POP3](#19-email-protocols--smtp-imap-pop3)
- [20. Unicast, Multicast, Broadcast & Anycast](#20-unicast-multicast-broadcast--anycast)
- [21. Essential Commands — Explained Line by Line](#21-essential-commands--explained-line-by-line)
- [22. OSI-Based Troubleshooting Framework](#22-osi-based-troubleshooting-framework)
- [23. Rapid-Fire Interview Q&A](#23-rapid-fire-interview-qa)
- [24. Cheat Sheet](#24-cheat-sheet)
- [25. Full-Form Glossary (A–Z)](#25-full-form-glossary-az)

---

## 1. Networking Fundamentals

**What is a network?** Two or more devices connected together so they can send data to each other. The **internet** is just millions of these small networks all connected together globally.

**Client-Server model:**
- **Client** = the one asking for something (your web browser, your phone app).
- **Server** = the one answering (a computer somewhere running software, waiting for requests).

One machine can be both at the same time — that's what happens when you run something on `localhost` during development: your browser (client) talks to a program running on your own laptop (server).

**What is a protocol?** A protocol is simply an **agreed-upon set of rules** for how two computers talk to each other — like a shared language. Without protocols, every app would invent its own way of sending data, and nothing would understand anything else.

**IP address — full form: Internet Protocol address.** A unique number that identifies *which device* you're talking to on a network — like a street address for a computer.

**Port number.** A number that identifies *which application* on that device should receive the data — like an apartment number at that street address. Ports range from 0 to 65535.
- **0–1023**: reserved for well-known services (port 80 = web traffic, port 443 = secure web traffic, port 22 = secure remote login).
- **1024–49151**: registered for specific applications (port 3306 = MySQL database, port 5432 = PostgreSQL database).
- **49152–65535**: temporary ("ephemeral") ports — your computer picks one of these randomly every time it starts an outgoing connection.

**Public IP vs Private IP:**
- **Public IP** = the one address the whole internet sees for your entire home. Given to you by your **ISP** (Internet Service Provider — the company you pay for internet, like Comcast or Airtel).
- **Private IP** = the internal address each device inside your home gets (like 192.168.1.5), invisible to the outside internet.

Your router uses a trick called **NAT** (explained fully in Section 8) to let many private devices share that one public IP.

**Interview Q&A**
- *Q: What's the difference between an IP address and a port number?* → The IP address identifies which computer/device you're reaching; the port number identifies which specific application on that device should handle the request.
- *Q: What's a protocol, in simple terms?* → An agreed-upon set of rules two computers follow so they can understand each other's data.

---

## 2. OSI Model — 7 Layers

**OSI — full form: Open Systems Interconnection.** It's a 7-layer mental model that explains, step by step, everything that has to happen for data to travel from your computer to another computer.

> 🎯 This is the single most commonly asked networking interview question. Memorize the layer order.

**Mnemonic (top to bottom):** All People Seem To Need Data Processing

| Layer # | Name | What Travels Here | Example Protocols | What It Actually Does |
|---|---|---|---|---|
| 7 | Application | Data | HTTP, DNS | Where your actual app (browser, email client) creates the message |
| 6 | Presentation | Data | TLS/SSL (encryption) | Encrypts, compresses, and formats the data |
| 5 | Session | Data | — | Opens, manages, and closes the conversation between two apps |
| 4 | Transport | Segment | TCP, UDP | Makes sure data actually arrives, in order, to the right app (via ports) |
| 3 | Network | Packet | IP | Figures out the route across the internet (routers work here) |
| 2 | Data Link | Frame | MAC, ARP | Delivers data within one local network (switches work here) |
| 1 | Physical | Bits | — | The actual electrical signal, light pulse, or radio wave on the wire/cable/air |

**"Segment," "Packet," "Frame," "Bits"** are just different names for the same piece of data as it gets wrapped in more information at each layer going down, and unwrapped again going up on the receiving end. This wrapping process is called **encapsulation**; unwrapping is **decapsulation**.

**Interview Q&A**
- *Q: Which OSI layer does HTTP belong to?* → Layer 7 (Application) — but it depends on TCP at Layer 4 and IP at Layer 3 underneath to actually get delivered.
- *Q: What is encapsulation?* → The process where each layer adds its own header (extra info) to the data as it moves down the stack before being sent over the wire.

---

## 3. TCP/IP Model — 5 Layers

**TCP/IP — full form: Transmission Control Protocol / Internet Protocol.** This is the *real-world, practical* model the actual internet runs on — as opposed to OSI, which is more of a *teaching* model.

The difference: TCP/IP squashes OSI's top 3 layers (Application, Presentation, Session) into just one layer called "Application."

```
OSI (7 layers)                 TCP/IP (5 layers)
Application    ┐
Presentation   ├──────►        Application
Session        ┘
Transport      ──────►         Transport
Network        ──────►         Internet
Data Link      ┐
Physical       ├──────►        Network Access
```

**Interview Q&A**
- *Q: Why do we need both OSI and TCP/IP models?* → OSI is more detailed and useful for *explaining* concepts (great for interviews and troubleshooting language); TCP/IP is what's actually implemented in real operating systems and devices.

---

## 4. TCP vs UDP

**TCP — full form: Transmission Control Protocol.** A "careful and reliable" way of sending data — it makes sure every piece arrives, in the correct order, and re-sends anything that gets lost.

**UDP — full form: User Datagram Protocol.** A "fast and careless" way of sending data — it just sends it and doesn't check whether it arrived, doesn't guarantee order, and never re-sends lost pieces.

| | TCP (reliable) | UDP (fast) |
|---|---|---|
| Sets up a connection first? | Yes (a "handshake" — see Section 5) | No |
| Guarantees delivery? | Yes | No |
| Guarantees order? | Yes | No |
| Speed | Slower (more overhead/checking) | Faster (minimal overhead) |
| What happens if data is lost | Automatically re-sent | Just gone — nobody re-sends it |
| Used for | Web browsing, email, file downloads, SSH | Video calls, online gaming, DNS lookups, live streaming |

**Why would anyone want UDP if it's unreliable?** For things like video calls, a dropped video frame from half a second ago is useless anyway — by the time it could be re-sent, you've already moved on. Speed matters more than perfection, so UDP is actually the *better* choice here, not a worse one.

**Interview Q&A**
- *Q: What's the core difference between TCP and UDP?* → TCP guarantees reliable, ordered delivery at the cost of speed; UDP is fast but makes no guarantees about delivery or order.
- *Q: Give an example of when UDP is the right choice.* → Video conferencing — a missing frame is better skipped than waited for, since by the time it's re-sent it would already be too late to be useful.

---

## 5. TCP 3-Way Handshake

Before TCP (Transmission Control Protocol) sends any real data, it does a small "greeting" first to make sure both sides are ready. This greeting has 3 steps, using special signal flags:

- **SYN — full form: Synchronize.** "I want to start a connection."
- **ACK — full form: Acknowledgment.** "I received that, confirmed."
- **FIN — full form: Finish.** "I'm done, let's close the connection."

```
Step 1 — Client → Server:  SYN            "Hi, I'd like to connect."
Step 2 — Server → Client:  SYN + ACK      "Okay, confirmed. I'd like to connect too."
Step 3 — Client → Server:  ACK            "Confirmed. Let's talk."
```

After these 3 steps, the connection is officially "established" and actual data (like a webpage) starts flowing.

**Closing a connection** uses a similar but 4-step process using FIN and ACK, because each side needs to say "I'm done" independently.

**A real attack that abuses this — SYN Flood:** An attacker sends thousands of SYN messages but never completes step 3. The server keeps a little bit of memory reserved for each "half-open" connection, waiting for a reply that never comes. Enough of these and the server runs out of resources for real users. Defenses include something called "SYN cookies" and rate limiting (only allowing so many connection attempts per second from one source).

**Interview Q&A**
- *Q: Explain the TCP 3-way handshake in your own words.* → The client sends a SYN to say "I want to connect," the server replies with SYN-ACK to say "confirmed, and I want to connect too," and the client replies with a final ACK to confirm — after that, the connection is open for real data.
- *Q: What is a SYN flood attack?* → Sending many connection requests (SYNs) without ever finishing the handshake, so the server wastes resources waiting and can't serve real users.

---

## 6. IP Addressing — IPv4, Subnetting & CIDR

**IPv4 — full form: Internet Protocol version 4.** The most common addressing format, made of 4 numbers separated by dots, each between 0–255:
```
192.168.1.100
```
Each of those 4 numbers is 8 bits (a "bit" is a single 1 or 0) — so the whole address is 32 bits total.

**Network part vs Host part:** Every IP address is really two pieces glued together — a "network" part (which network is this device on?) and a "host" part (which specific device on that network?). Something called a **subnet mask** tells you exactly where that split happens.

**CIDR — full form: Classless Inter-Domain Routing.** A shorthand way of writing that split. `192.168.1.0/24` means: "the first 24 bits are the network part," leaving 8 bits (256 possible values, 254 actually usable) for individual devices.

| CIDR notation | Bits left for devices | How many usable addresses |
|---|---|---|
| /24 | 8 | 254 |
| /16 | 16 | 65,534 |
| /8 | 24 | 16,777,214 |

**Private IP ranges** — reserved specifically for internal/home/office networks, never used directly on the public internet:
- `10.0.0.0` to `10.255.255.255`
- `172.16.0.0` to `172.31.255.255`
- `192.168.0.0` to `192.168.255.255`

**A few special addresses worth knowing:**
- `127.0.0.1` = "localhost" / "loopback" — your own computer talking to itself.
- `0.0.0.0` = means "any address" / "not yet assigned."
- `255.255.255.255` = broadcast — "send this to every device on the local network."

**Interview Q&A**
- *Q: What does /24 mean in an IP address like 192.168.1.0/24?* → It means the first 24 bits identify the network, leaving 8 bits (254 usable addresses) to identify individual devices on that network.
- *Q: Why can't you use a private IP address (like 192.168.1.5) directly on the public internet?* → Private ranges are reserved specifically for internal networks; internet routers are configured to never forward traffic to/from them — a technique called NAT (Section 8) is needed to let private devices reach the internet.

---

## 7. IPv4 vs IPv6

**IPv6 — full form: Internet Protocol version 6.** The newer addressing format, created because IPv4 (Internet Protocol version 4) only has about 4.3 billion possible addresses — not nearly enough for every phone, laptop, smart TV, and IoT device (Internet of Things — everyday devices like smart bulbs or fridges connected to the internet) on Earth today.

| | IPv4 | IPv6 |
|---|---|---|
| Size | 32 bits (~4.3 billion addresses) | 128 bits (a mind-bogglingly larger number) |
| Looks like | `192.168.1.1` (decimal, dots) | `2001:db8::1` (hexadecimal, colons) |
| Needs NAT? | Yes (not enough addresses to go around) | No (practically unlimited addresses) |
| Auto-configuration | Needs a helper called DHCP (explained in Section 13) | Built-in, called **SLAAC** — full form: StateLess Address AutoConfiguration |

**Why hasn't everyone switched to IPv6 yet?** IPv4 and IPv6 devices can't talk to each other directly without extra translation steps, upgrading old hardware is expensive, and NAT let IPv4 "stretch" further than it should have been able to. Today, most systems run **dual-stack** — meaning they support both IPv4 and IPv6 at the same time.

**Interview Q&A**
- *Q: Why was IPv6 created?* → IPv4's roughly 4.3 billion addresses aren't enough for the number of internet-connected devices that exist today; IPv6 provides an effectively unlimited supply.
- *Q: Does IPv6 need NAT (Network Address Translation)?* → No — because there are enough IPv6 addresses for every single device to get its own unique, public one.

---

## 8. NAT — Network Address Translation

**NAT — full form: Network Address Translation.** A trick that lets many devices with private IP addresses share a single public IP address when talking to the internet.

```
Phone    (private IP: 192.168.1.2)  ─┐
Laptop   (private IP: 192.168.1.3)  ─┼──►  Router (public IP: 203.0.113.25)  ──►  Internet
Smart TV (private IP: 192.168.1.4)  ─┘
```

To the outside internet, all three devices look like they're coming from just one address: `203.0.113.25`. The router keeps a little lookup table (a "NAT table") remembering which private device made which request, so when a reply comes back, it knows exactly which device to forward it to.

**PAT / NAPT — full form: Port Address Translation / Network Address Port Translation.** The specific technique of using *port numbers* (see Section 1) to tell many devices apart while they share one public IP — this is what your home router is actually doing.

**In the cloud (AWS example):** A **NAT Gateway** lets private servers reach the internet for things like software updates, *without* allowing the internet to initiate a connection back into them — outbound only, which is a big security win.

**Interview Q&A**
- *Q: In simple terms, what problem does NAT solve?* → It lets many devices with private addresses share one public IP address, which is necessary because there aren't enough public IPv4 addresses for every device to have its own.
- *Q: What's the difference between NAT and a NAT Gateway (in AWS)?* → NAT is the general technique; an AWS NAT Gateway is a specific managed service implementing it, giving private cloud servers outbound-only internet access without exposing them to inbound traffic.

---

## 9. DNS — Domain Name System

**DNS — full form: Domain Name System.** The internet's phone book. It translates human-friendly names (`google.com`) into the numeric IP addresses (`142.250.185.46`) computers actually use to find each other.

**Resolution process (what happens when you type a website name):**
```
1. Your browser's own cache   → checked first (fastest)
2. Your computer's OS cache   → checked next
3. Your ISP's DNS server (or a public one like 8.8.8.8)  → asked if not cached
4. Root DNS Server            → "I don't know, but here's who handles .com"
5. TLD Server (Top-Level Domain — handles endings like .com, .org)  → "Here's google.com's own DNS server"
6. Authoritative DNS Server (google.com's own)  → "The IP is 142.250.185.46"
```
Once found, the answer is remembered ("cached") for a while — controlled by a setting called **TTL (Time To Live)**, which is just a countdown of how many seconds/minutes before that cached answer should be thrown away and looked up fresh.

**Common DNS record types you should recognize:**
| Record | Full Meaning | Purpose |
|---|---|---|
| A | Address record | Domain name → IPv4 address |
| AAAA | "Quad-A" record | Domain name → IPv6 address |
| CNAME | Canonical Name record | Domain name → another domain name (an alias/nickname) |
| MX | Mail Exchange record | Which server handles email for this domain |
| TXT | Text record | Arbitrary text — often used to prove domain ownership |
| NS | Name Server record | Which servers are authoritative for this domain |

**Fun fact:** you don't *buy* a domain name forever — you **rent** it for a period (usually 1–10 years, renewable) from a company called a registrar (like GoDaddy), who answers to a global authority called **ICANN** (Internet Corporation for Assigned Names and Numbers).

**Interview Q&A**
- *Q: Explain step by step how DNS resolution works.* → Browser/OS cache is checked first; if not found, a query goes out to a DNS resolver, which asks the Root server, then the TLD server, then finally the domain's own Authoritative server, which returns the actual IP address.
- *Q: What's the difference between an A record and a CNAME record?* → An A record points a domain directly to an IPv4 address; a CNAME points a domain to *another domain name* instead of an IP directly.

---

## 10. HTTP & HTTPS

**HTTP — full form: HyperText Transfer Protocol.** The protocol (set of rules) that powers ordinary web browsing — how your browser asks a server for a page, and how the server sends it back.

**HTTPS — full form: HyperText Transfer Protocol Secure.** The same thing as HTTP, but wrapped in encryption using **TLS** (Transport Layer Security) — an older, now largely-replaced version of this encryption was called **SSL** (Secure Sockets Layer), which is why people still sometimes say "SSL" even though TLS is the modern standard.

**Key properties of HTTP:**
- **Stateless** — every single request is treated as brand new; the server has no memory of previous requests from you. (This is exactly why cookies were invented — see Section 12.)
- Runs on top of **TCP** (Transmission Control Protocol, from Section 4) — for reliable delivery.
- Port 80 = plain HTTP. Port 443 = encrypted HTTPS.

**Why HTTPS matters:** Without it, anything you type (passwords, credit card numbers) travels across the internet in plain, readable text — anyone intercepting the connection could read it. **Always use HTTPS in production, never plain HTTP for anything real.**

**HTTP versions, briefly:**
| Version | What Improved |
|---|---|
| HTTP/1.0 | Opens a brand-new connection for every single request (slow) |
| HTTP/1.1 | "Keep-Alive" — reuses one connection for multiple requests |
| HTTP/2 | "Multiplexing" — sends multiple requests at once over one connection |
| HTTP/3 | Runs on **QUIC** (Quick UDP Internet Connections) — built on UDP instead of TCP, for extra speed |

**Interview Q&A**
- *Q: What does "HTTP is stateless" actually mean?* → Each request stands completely alone — the server doesn't remember anything about your previous request unless something else (like a cookie) is used to reintroduce that context.
- *Q: What's actually different between HTTP and HTTPS under the hood?* → HTTPS adds a TLS encryption layer around the same HTTP request/response process, so the data can't be read or tampered with in transit, and the server's identity is verified using a certificate.

---

## 11. HTTP Methods & Status Codes

**HTTP methods** (sometimes called "verbs") tell the server *what you want to do*. They map to a common pattern called **CRUD — full form: Create, Read, Update, Delete.**

| Method | CRUD Action | Meaning | Repeatable Safely? (Idempotent) |
|---|---|---|---|
| GET | Read | "Give me this data" | Yes |
| POST | Create | "Here's new data, save it" | No — calling twice creates two records |
| PUT | Update (full) | "Replace this entire record" | Yes |
| PATCH | Update (partial) | "Update just these fields" | No |
| DELETE | Delete | "Remove this record" | Yes |

*("Idempotent" is a fancy word that just means: calling it once or calling it 100 times gives the same end result.)*

**HTTP status codes** — a 3-digit number the server always sends back, telling you what happened:

| Starts with | Category | Meaning |
|---|---|---|
| 1 | Informational | "Still processing, hang on" |
| 2 | Success | "It worked!" |
| 3 | Redirection | "Go look somewhere else instead" |
| 4 | Client Error | "You (the client) did something wrong" |
| 5 | Server Error | "I (the server) messed up" |

**The codes you'll actually see most often:**
- **200 OK** — success.
- **201 Created** — success, and something new was made (after a POST).
- **301 / 302** — permanently / temporarily moved elsewhere.
- **400 Bad Request** — your request was malformed.
- **401 Unauthorized** — you're not logged in (or your credentials are missing/invalid).
- **403 Forbidden** — you *are* logged in, but you don't have permission for this specific action.
- **404 Not Found** — the thing you asked for doesn't exist.
- **500 Internal Server Error** — a bug/crash on the server's side.
- **502 Bad Gateway** — a middle server (like a load balancer) couldn't get a valid response from the actual backend server.
- **503 Service Unavailable** — the server is overloaded or down entirely.
- **504 Gateway Timeout** — the backend server took too long to respond.

**Interview Q&A**
- *Q: What's the difference between 401 and 403?* → 401 means you haven't proven who you are (no valid login); 403 means you *have* proven who you are, but you're still not allowed to do this specific thing.
- *Q: A user reports getting a "502 Bad Gateway" — what does that tell you?* → The load balancer/proxy in front of your application couldn't get a valid response from the actual backend server — check if the backend is running and reachable.

---

## 12. Cookies & Sessions

Since HTTP (HyperText Transfer Protocol) is stateless (Section 10) — remembering nothing between requests — **cookies** were invented so a server can "remember" you across multiple requests (e.g., staying logged in, remembering your shopping cart).

**How it works:**
```
1. Server sends this in its response:  Set-Cookie: session=abc123
2. Your browser saves that little piece of text.
3. On every future request to that same website, your browser automatically
   attaches it back:  Cookie: session=abc123
4. The server sees "abc123" and knows exactly who you are.
```

**Important security settings on a cookie:**
- **HttpOnly** — JavaScript on the page cannot read this cookie at all. Protects against an attack called **XSS** (Cross-Site Scripting), where a hacker tries to inject malicious JavaScript to steal your cookie.
- **Secure** — the cookie is only ever sent over HTTPS, never plain HTTP.
- **SameSite** — restricts the cookie from being sent when the request comes from a different website. Protects against an attack called **CSRF** (Cross-Site Request Forgery), where a malicious site tricks your browser into making a request to a site you're logged into.

**Best practice:** only store a random, meaningless **session ID** in the cookie itself — keep the *actual* data (your name, cart contents, etc.) safely stored on the server side (often in a fast database like Redis). Never put real sensitive data directly inside a cookie.

**Interview Q&A**
- *Q: Why do cookies exist?* → HTTP has no memory between requests; cookies let a server recognize the same user across multiple requests by attaching a small identifier the browser sends back automatically.
- *Q: What does the HttpOnly flag protect against?* → It stops JavaScript from reading the cookie's value, which protects against XSS (Cross-Site Scripting) attacks trying to steal a user's session.

---

## 13. Data Link Layer — MAC & ARP

**MAC address — full form: Media Access Control address.** A unique hardware ID number burned into every network device (like a Wi-Fi card or Ethernet port) at the factory — looks like `AA:BB:CC:DD:EE:FF`. Unlike an IP address, a MAC address is only used for delivery *within one local network* (like your home Wi-Fi), not across the whole internet.

**A subtle but important fact:** your IP address stays the same for an entire journey across the internet, but your **MAC address changes at every single "hop"** (every router along the way swaps it for the next short local leg of the journey).

**ARP — full form: Address Resolution Protocol.** Solves this exact problem: "I know this device's IP address, but I need its MAC address to actually deliver data locally." It works like shouting a question to everyone on the local network and waiting for the right device to answer:
```
Your device (broadcasts to everyone nearby): "Who has IP 192.168.1.1?"
Router (replies only to you):                "That's me! My MAC address is FF:EE:DD:CC:BB:AA"
```
This gets remembered temporarily in something called the **ARP cache** (viewable with the `arp -n` command — explained in Section 21).

**DHCP — full form: Dynamic Host Configuration Protocol.** The system that automatically hands a new device its IP address, subnet mask, default gateway, and DNS server settings the moment it joins a network — so nobody has to type these in by hand.

**Interview Q&A**
- *Q: Why does a MAC address change at every hop while an IP address doesn't?* → A MAC address is only meaningful for delivery on one local network segment; the IP address is the one constant identifier used for the entire end-to-end trip across the internet.
- *Q: What problem does ARP solve?* → It figures out which device's MAC address corresponds to a known IP address, which is required before any data can actually be delivered on a local network.

---

## 14. Networking Devices

| Device | Which OSI Layer | What It Does | Still Used Today? |
|---|---|---|---|
| Hub | Layer 1 (Physical) | Blindly copies incoming data to *every* connected device | No, obsolete |
| Repeater | Layer 1 (Physical) | Boosts/regenerates a weak signal over long distances | Rarely |
| Bridge | Layer 2 (Data Link) | Filters traffic between two network segments using MAC addresses | No, obsolete |
| Switch | Layer 2 (Data Link) | Smart version of a hub — learns which device (MAC address) is on which port and sends data *only* there | Yes, everywhere |
| Router | Layer 3 (Network) | Connects *different* networks together and decides the best path using IP addresses | Yes, everywhere |
| Gateway | Multiple layers | Translates between two networks using *completely different* protocols | Yes, at network boundaries |

**Why a switch is smarter than a hub:** A hub has no intelligence — it broadcasts everything to everyone, wasting bandwidth and causing data collisions. A switch keeps a small internal table of "which device's MAC address is plugged into which port" and only sends data to the one port that actually needs it.

**Cloud equivalents:** In AWS (Amazon Web Services), "Route Tables" act like a virtual router's brain, and an "Internet Gateway" acts like the door connecting your private cloud network to the public internet.

**Interview Q&A**
- *Q: What's the main difference between a switch and a router?* → A switch works within *one* local network, forwarding data using MAC addresses (Layer 2); a router connects *different* networks together, forwarding data using IP addresses (Layer 3).

---

## 15. Firewalls, Security Groups & NACLs

**Firewall.** A security checkpoint that inspects network traffic and decides whether to allow or block it, based on rules like IP address, port number, or protocol type.

**Stateless vs Stateful firewalls:**
- **Stateless** — checks every single packet completely on its own, with no memory. You must manually create a rule for both the request *and* the response.
- **Stateful** — remembers ongoing connections. Once a connection is approved, the response traffic is automatically allowed back without needing a separate rule.

**In AWS (Amazon Web Services), two related but different tools:**

| | Security Group | NACL (Network Access Control List) |
|---|---|---|
| Applies to | One specific server (instance-level) | An entire subnet (a whole section of the network) |
| Type | Stateful (remembers connections) | Stateless (must allow both directions manually) |
| Can it explicitly "Deny"? | No, only "Allow" rules | Yes, can explicitly Allow or Deny |

**The golden security rule: least privilege.** Only open the exact ports you actually need, from the exact sources (IP ranges) that genuinely need access — nothing more.

**A very common, very dangerous mistake:** leaving port 22 (SSH — Secure Shell, used for securely logging into a server remotely) open to absolutely everyone on the internet (written as `0.0.0.0/0`). This invites constant automated password-guessing attacks. Always restrict it to specific, known IP addresses.

**Interview Q&A**
- *Q: What's the difference between a Security Group and a NACL in AWS?* → A Security Group is stateful and protects one server; a NACL is stateless and protects an entire subnet, requiring rules for both inbound and outbound traffic separately.
- *Q: Why is opening SSH (port 22) to the whole internet risky?* → It exposes the server to constant automated login-guessing attacks from anywhere in the world; access should be limited to specific, trusted IP addresses.

---

## 16. Load Balancers & Topologies

**Load balancer.** A device/service that sits in front of multiple backend servers and spreads incoming requests across them — so no single server gets overwhelmed, and if one server goes down, traffic automatically stops going to it.

**Layer 4 vs Layer 7 load balancing:**
- **Layer 4 (Transport layer)** — makes decisions based only on IP address and port. Fast and simple. Example: AWS **NLB** (Network Load Balancer).
- **Layer 7 (Application layer)** — actually understands HTTP, and can route traffic based on the URL path or the domain name being requested. Example: AWS **ALB** (Application Load Balancer).

**Network topology** — just a fancy word for "the shape of how devices are connected":

| Topology | How It's Arranged | Its Weak Point |
|---|---|---|
| Bus | Every device shares one single cable | If the cable breaks, the whole network goes down |
| Ring | Devices connected in a circle | One broken link breaks the whole ring |
| Star | Every device connects to one central switch | If the central switch dies, everything dies |
| Mesh | Every device connects to every other device | Very expensive, hard to scale up |

**Real-world cloud connection:** A load balancer sending traffic to many backend servers is basically a "star" shape — and running your servers across multiple data center zones (called Availability Zones in AWS) is exactly how you avoid a star topology's single-point-of-failure weakness.

**Interview Q&A**
- *Q: What's the difference between Layer 4 and Layer 7 load balancing?* → Layer 4 only looks at IP address and port (simple, fast); Layer 7 understands the actual HTTP request and can route based on URL path or domain name.
- *Q: Why deploy servers across multiple Availability Zones?* → So that if one zone (physical data center location) has a problem, the others keep serving traffic — avoiding a single point of failure.

---

## 17. VPN & Proxy vs Reverse Proxy

**VPN — full form: Virtual Private Network.** Creates an encrypted "tunnel" between your device and a remote network, making your internet traffic look like it's coming from that remote network instead of your actual location. Commonly used to securely access a company's private internal systems while working from home, or to protect your privacy on public Wi-Fi.

**Forward Proxy vs Reverse Proxy** — a pair of terms people often mix up:

```
Forward Proxy:                              Reverse Proxy:
  You → Proxy → The Internet                 The Internet → Reverse Proxy → Your Servers
  (hides YOU, the client, from the server)   (hides YOUR SERVERS from the client)
```

- **Forward proxy** — sits in front of *clients*. Example: a company's proxy server that all employees' internet traffic passes through, used for monitoring or content filtering.
- **Reverse proxy** — sits in front of *servers*. Example: Nginx or an AWS load balancer — every visitor's request goes to the reverse proxy first, which then quietly forwards it to the correct backend server, without the visitor ever knowing which actual server handled it.

**Interview Q&A**
- *Q: What's the difference between a forward proxy and a reverse proxy?* → A forward proxy hides and represents the *client* to the outside world; a reverse proxy hides and represents the *server(s)* from the client. A load balancer is essentially a type of reverse proxy.
- *Q: Why would a remote employee use a VPN to connect to their company?* → To securely reach internal-only company resources (like a private database) as if they were physically in the office, with all traffic encrypted along the way.

---

## 18. CDN — Content Delivery Network

**CDN — full form: Content Delivery Network.** A network of servers spread out physically across the world that store cached copies of your website's content (images, videos, static files), so users are served from a location *near* them, instead of always reaching your one distant server.

```
User in Tokyo, WITHOUT a CDN → request travels all the way to your server in Virginia → slow
User in Tokyo, WITH a CDN    → request served from a nearby CDN server in Japan → fast
```

**Why it's valuable:**
- **Lower latency** — physically shorter distance for data to travel.
- **Less load on your actual server** — most requests get served entirely from the CDN's cache.
- **Extra resilience** — can absorb sudden traffic spikes and some attack traffic before it ever reaches your real server.

**Well-known examples:** Cloudflare, AWS CloudFront, Akamai, Fastly.

**Interview Q&A**
- *Q: How does a CDN make websites faster?* → By caching content on servers physically close to users around the world, so requests don't have to travel all the way to a single distant origin server.

---

## 19. Email Protocols — SMTP, IMAP, POP3

| Protocol | Full Form | Port | Job |
|---|---|---|---|
| SMTP | Simple Mail Transfer Protocol | 25 / 587 | *Sending* email — client to server, and server to server |
| POP3 | Post Office Protocol version 3 | 110 | *Receiving* email — downloads it and usually deletes it from the server (no syncing across multiple devices) |
| IMAP | Internet Message Access Protocol | 143 | *Receiving* email — keeps mail on the server and syncs across all your devices (phone, laptop, etc.) — the modern standard |

**The journey of an email:** Alice (using Yahoo) emails Bob (using Gmail) → Alice's email app sends it via **SMTP** to Yahoo's mail server → Yahoo's server relays it via **SMTP** to Gmail's mail server (found using a special DNS record called an **MX record** — Mail Exchange record, from Section 9) → Bob's email app retrieves it using **IMAP**.

**Why TCP, not UDP?** Because email absolutely must arrive complete and in the right order — a half-corrupted email is unacceptable, unlike a slightly-late video frame.

**Interview Q&A**
- *Q: What's the difference between IMAP and POP3?* → IMAP keeps mail on the server and syncs across every device you use; POP3 downloads mail to one device and typically removes it from the server, breaking multi-device consistency.

---

## 20. Unicast, Multicast, Broadcast & Anycast

These describe *how many devices* a piece of network traffic is aimed at:

| Type | Sent To | Real Example |
|---|---|---|
| **Unicast** | One single, specific device | A normal website visit — you talking to one server |
| **Broadcast** | Every single device on the local network | ARP requests (Section 13), DHCP requests (Section 13) |
| **Multicast** | A specific *group* of interested devices (not everyone) | Live IPTV streaming to subscribed viewers |
| **Anycast** | The *nearest* of several servers all sharing the same address | DNS root servers, CDN routing (Section 18) |

**Anycast is the trickiest one, so here's the key idea:** several physical servers around the world all advertise the *exact same* IP address. The internet's routing system automatically sends each user's request to whichever one of those servers is physically/network-wise closest — giving both speed *and* built-in backup if one server goes down.

**Interview Q&A**
- *Q: How does anycast achieve both speed and redundancy?* → Multiple servers share one IP address, and network routing automatically directs each request to the nearest available one — giving low latency and automatic failover if one server is down.

---

## 21. Essential Commands — Explained Line by Line

> This section is the one to slow down on if commands feel intimidating. Every example below shows realistic output, broken down piece by piece.

### `ip addr show` — "What's my own network configuration?"

This command shows every network interface (network connection point) on your computer and its settings. Here's realistic output:

```
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:4e:66:a1 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.15/24 brd 192.168.1.255 scope global dynamic eth0
       valid_lft 84652sec preferred_lft 84652sec
    inet6 fe80::a00:27ff:fe4e:66a1/64 scope link
       valid_lft forever preferred_lft forever
```

Let's break down **every single piece** of this:

- **`2:`** — This is just an internal index number; "2" means this is the second network interface the system found. Not important on its own.
- **`eth0:`** — The **name** of this network interface. `eth0` typically means a wired Ethernet connection (`wlan0` would mean Wi-Fi instead).
- **`<BROADCAST,MULTICAST,UP,LOWER_UP>`** — A list of "flags" describing the interface's current capabilities/state:
  - `BROADCAST` — this interface supports sending broadcast messages (Section 20).
  - `MULTICAST` — this interface supports multicast messages (Section 20).
  - `UP` — the interface is administratively turned on.
  - `LOWER_UP` — the physical cable/connection is actually detected as connected (this is the one to check if you suspect an unplugged cable).
- **`mtu 1500`** — **MTU (Maximum Transmission Unit)**: the biggest single chunk of data (in bytes) this interface can send in one go without breaking it into smaller pieces. 1500 is the standard default for Ethernet.
- **`state UP`** — Confirms again that this interface is active and working.
- **`link/ether 08:00:27:4e:66:a1`** — This is the interface's **MAC address** (Section 13) — its unique hardware ID.
- **`brd ff:ff:ff:ff:ff:ff`** — The MAC broadcast address — sending to this special address means "everyone on the local network."
- **`inet 192.168.1.15/24`** — **This is the important line.** `inet` means "here's my IPv4 address." `192.168.1.15` is the actual private IP address (Section 6) assigned to this computer. `/24` is CIDR notation (Section 6) meaning the first 24 bits are the network portion.
- **`brd 192.168.1.255`** — The broadcast address for this specific local network (the last address in the range).
- **`scope global`** — Means this address is usable more broadly (not just for talking to itself), as opposed to `scope link` (only valid on this one local link).
- **`dynamic`** — This address was assigned automatically by DHCP (Section 13), not manually typed in by a person.
- **`valid_lft 84652sec`** — "Valid lifetime": how many more seconds this IP address assignment (its "DHCP lease") remains valid before it needs to be renewed.
- **`inet6 fe80::a00:27ff:fe4e:66a1/64`** — The same idea as the `inet` line, but for **IPv6** (Section 7) instead of IPv4. Addresses starting with `fe80::` are always "link-local" — only usable on this one local network, never routable across the wider internet.

**Interview one-liner:** *"`ip addr show` is the modern Linux command to check IP addresses; the older equivalent you might also see is `ifconfig`."*

---

### `ping` — "Is this device even reachable?"

```
$ ping google.com
PING google.com (142.250.185.46): 56 data bytes
64 bytes from 142.250.185.46: icmp_seq=0 ttl=116 time=12.4 ms
64 bytes from 142.250.185.46: icmp_seq=1 ttl=116 time=11.9 ms
```

- **`ping`** sends a small test message using a protocol called **ICMP (Internet Control Message Protocol)** — designed specifically for testing connectivity, not carrying real application data.
- **`142.250.185.46`** — the IP address that `google.com` resolved to via DNS (Section 9).
- **`icmp_seq=0`** — sequence number: this is test message #0, then #1, and so on — lets you detect if any replies go missing.
- **`ttl=116`** — **TTL (Time To Live)**: a countdown number that gets reduced by 1 at every router hop the packet passes through; if it hits 0, the packet is discarded. Seeing `ttl=116` (started at 128, a common default) tells you roughly how many routers (about 12 here) the packet passed through.
- **`time=12.4 ms`** — the **round-trip time**: how many milliseconds it took for your message to reach Google and the reply to come back to you.

**Interview one-liner:** *"Ping can't be meaningfully sped up — it's limited by the physical distance and the number of router hops, which is exactly why CDNs (Section 18) exist to put servers physically closer to users."*

---

### `dig` — "Detailed DNS lookup"

```
$ dig google.com

;; ANSWER SECTION:
google.com.        190     IN      A       142.250.185.46

;; Query time: 24 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
```

- **`ANSWER SECTION`** — the actual result of the lookup.
- **`google.com.`** — the domain you asked about (the trailing dot represents the invisible "root" of the entire DNS system).
- **`190`** — the **TTL** (Time To Live) in seconds — how much longer this answer should be cached before asking again.
- **`IN`** — stands for "Internet" (a leftover naming convention from when DNS supported other, now-extinct, network types).
- **`A`** — the record type (Section 9) — an "A record" means "this maps a name to an IPv4 address."
- **`142.250.185.46`** — the actual IP address answer.
- **`Query time: 24 msec`** — how long the lookup took.
- **`SERVER: 8.8.8.8#53`** — which DNS server answered (`8.8.8.8` is one of Google's public DNS servers), and `#53` is the port number DNS runs on.

---

### `curl -v` — "Show me the full request and response"

```
$ curl -v https://example.com

> GET / HTTP/1.1
> Host: example.com
> User-Agent: curl/8.4.0
>
< HTTP/1.1 200 OK
< Content-Type: text/html
< Content-Length: 1256
<
```

- Lines starting with **`>`** — this is what *your computer sent* to the server (the request).
- Lines starting with **`<`** — this is what *the server sent back* (the response).
- **`GET / HTTP/1.1`** — the HTTP method (Section 11) is GET, requesting the root page (`/`), using HTTP version 1.1 (Section 10).
- **`Host: example.com`** — tells the server which website you want (important because one server can host many different websites).
- **`HTTP/1.1 200 OK`** — the response line: HTTP version 1.1, status code 200 (Section 11) meaning success.
- **`Content-Type: text/html`** — tells your browser what kind of data is coming (in this case, a webpage).
- **`Content-Length: 1256`** — the size of the response body, in bytes.

---

### `traceroute` — "Which router along the way is slow or broken?"

```
$ traceroute google.com
1  192.168.1.1     1.2 ms   (your own home router)
2  10.10.0.1       5.1 ms   (your ISP's first router)
3  72.14.215.165   11.5 ms  (deeper into the internet backbone)
4  142.250.185.46  12.1 ms  (Google's actual server)
```

Each numbered line is one "hop" (one router) along the path. The time shown is the round-trip time to reach *that specific router*, not the final destination. If one line suddenly shows a huge time jump (or `* * *`, meaning no response), that's exactly where the slowdown or break is happening.

---

### `ss -tlnp` — "What's listening on my machine?"

```
$ ss -tlnp
State    Local Address:Port    Process
LISTEN   0.0.0.0:80            nginx
LISTEN   127.0.0.1:5432        postgres
```

- **`ss`** — a modern tool for showing network socket (connection) information (an older, still-common equivalent is `netstat`).
- **`-t`** — show TCP connections only.
- **`-l`** — show only *listening* sockets (things waiting for incoming connections, i.e., servers).
- **`-n`** — show raw numbers (IP/port) instead of trying to look up friendly names — faster and clearer.
- **`-p`** — show which *process* (program) owns each socket.
- **`0.0.0.0:80`** — nginx is listening on port 80 (HTTP), on *all* network interfaces (`0.0.0.0` means "any address on this machine").
- **`127.0.0.1:5432`** — postgres (a database) is listening on port 5432, but *only* on `127.0.0.1` (localhost) — meaning only programs on this same machine can connect to it, not the outside network.

**Interview Q&A**
- *Q: How would you check whether a specific port is open and reachable on a remote server?* → `nc -zv host port` attempts a quick TCP connection without sending data; you'll see whether it succeeds or times out.
- *Q: If `ping` works but a website won't load in the browser, what would you check next?* → Whether the specific port (443 for HTTPS) is actually reachable (`nc -zv host 443`), then use `curl -v` to see the full request/response and spot exactly where it's failing.

---

## 22. OSI-Based Troubleshooting Framework

> When something's broken, don't guess randomly — work through the OSI layers (Section 2) **from the bottom up**.

```
Layer 1 (Physical)   → Is the cable plugged in? Is Wi-Fi turned on?
Layer 2 (Data Link)  → Can you reach your own router? (check with ping/arp)
Layer 3 (Network)    → Can you reach the wider internet? (ping 8.8.8.8)
Layer 4 (Transport)  → Is the specific port actually open? (nc -zv host port)
Layer 7 (Application)→ Is the app giving back the right response? (curl -v)
```

**Worked example — "the website won't load":**
1. Is your internet even working at all? Try a completely different website.
2. Does the domain name resolve? (`nslookup` or `dig`)
3. Can you reach that IP address at all? (`ping`)
4. Is the specific port (443 for HTTPS) actually open? (`nc -zv host 443`)
5. What does the full request/response actually say? (`curl -v`)

In real jobs, most "mystery" outages turn out to be one of three things: a DNS problem, an expired TLS certificate, or a firewall/security-group rule silently blocking a port. Check those three before assuming the application code itself is broken.

**Interview Q&A**
- *Q: A service suddenly becomes unreachable — what's your troubleshooting order?* → Work bottom-up through the OSI layers: physical connectivity → can you reach your local gateway → can you reach the broader internet → is the specific port open → is the application actually returning a correct response.

---

## 23. Rapid-Fire Interview Q&A

**Q: What happens when you type a URL and press Enter?**
A: DNS (Domain Name System) resolves the domain name to an IP address → your computer does a TCP (Transmission Control Protocol) 3-way handshake with that IP on port 443 → a TLS (Transport Layer Security) handshake happens for encryption → your browser sends an HTTP (HyperText Transfer Protocol) request → it may pass through a load balancer to a specific backend server → the server responds → your browser renders the page.

**Q: What's the difference between a packet and a frame?**
A: A "packet" is the unit of data at the Network layer (Layer 3), carrying IP addresses; a "frame" is the unit at the Data Link layer (Layer 2), carrying MAC addresses. It's the same underlying data, just wrapped with different information at each stage.

**Q: What is TTL and why does it exist?**
A: TTL (Time To Live) is a countdown number in a packet that decreases by one at every router it passes through; when it hits zero, the packet is discarded. It exists purely to stop a packet from looping forever if there's ever a routing mistake.

**Q: What's the difference between authentication and authorization?**
A: Authentication proves *who you are* (like logging in); authorization decides *what you're allowed to do* once you're identified. A 401 error means authentication failed; a 403 means you're authenticated, but not authorized for that specific action.

**Q: Why does a load balancer need health checks?**
A: To detect when a backend server has stopped working properly, and automatically stop sending it traffic — so users never get routed to a broken server.

**Q: What's risky about an outbound rule that allows all traffic to anywhere (0.0.0.0/0)?**
A: If that server is ever compromised, an attacker has free rein to send stolen data out to anywhere on the internet with no restriction.

**Q: How would you investigate intermittent packet loss?**
A: Run `ping` with a high count to measure the loss percentage, use `traceroute` (or `mtr`) to see which specific router hop is dropping packets, and check the network interface's error counters for a possible hardware issue.

---

## 24. Cheat Sheet

### Well-Known Ports
| Port | Service |
|---|---|
| 20/21 | FTP (File Transfer Protocol) |
| 22 | SSH (Secure Shell) |
| 25 / 587 | SMTP (Simple Mail Transfer Protocol) |
| 53 | DNS (Domain Name System) |
| 80 | HTTP (HyperText Transfer Protocol) |
| 110 | POP3 (Post Office Protocol version 3) |
| 143 | IMAP (Internet Message Access Protocol) |
| 443 | HTTPS (HTTP Secure) |
| 3306 | MySQL |
| 5432 | PostgreSQL |
| 6379 | Redis |
| 27017 | MongoDB |

### HTTP Status Codes at a Glance
```
2xx success   → 200 OK · 201 Created · 204 No Content
3xx redirect  → 301 Permanent · 302 Temporary · 304 Not Modified
4xx client    → 400 Bad Request · 401 Unauthorized · 403 Forbidden · 404 Not Found · 429 Too Many Requests
5xx server    → 500 Internal Error · 502 Bad Gateway · 503 Unavailable · 504 Gateway Timeout
```

### OSI Layers, One Line Each
```
L7 Application  (data)    → HTTP, DNS — the actual message
L6 Presentation (data)    → TLS/SSL encryption, formatting
L5 Session      (data)    → Opens/manages/closes the conversation
L4 Transport    (segment) → TCP/UDP — ports, reliability
L3 Network      (packet)  → IP — routing across networks
L2 Data Link    (frame)   → MAC/ARP — local delivery
L1 Physical     (bits)    → Actual signals on wire/fibre/radio
```

### Quick Facts Worth Memorizing
- TCP = reliable but slower. UDP = fast but no guarantees.
- Private IP ranges: `10.x`, `172.16–31.x`, `192.168.x`.
- `/24` = 254 usable hosts. `/16` = 65,534. `/8` = 16.7 million.
- Security Group = stateful, per-server. NACL = stateless, per-subnet.
- 401 = not logged in. 403 = logged in but not allowed.
- Forward proxy hides the client. Reverse proxy hides the server.
- CDN = cache content near users. Anycast = same IP, nearest server answers.

---

## 25. Full-Form Glossary (A–Z)

| Acronym | Full Form |
|---|---|
| ACK | Acknowledgment |
| ALB | Application Load Balancer |
| ARP | Address Resolution Protocol |
| CDN | Content Delivery Network |
| CIDR | Classless Inter-Domain Routing |
| CNAME | Canonical Name (a type of DNS record) |
| CRUD | Create, Read, Update, Delete |
| CSRF | Cross-Site Request Forgery |
| DHCP | Dynamic Host Configuration Protocol |
| DNS | Domain Name System |
| FIN | Finish (a TCP connection-closing signal) |
| FTP | File Transfer Protocol |
| HTTP | HyperText Transfer Protocol |
| HTTPS | HyperText Transfer Protocol Secure |
| ICANN | Internet Corporation for Assigned Names and Numbers |
| ICMP | Internet Control Message Protocol |
| IMAP | Internet Message Access Protocol |
| IP | Internet Protocol |
| IPv4 / IPv6 | Internet Protocol version 4 / version 6 |
| ISP | Internet Service Provider |
| MAC | Media Access Control (address) |
| MTU | Maximum Transmission Unit |
| MX | Mail Exchange (a type of DNS record) |
| NACL | Network Access Control List |
| NAT | Network Address Translation |
| NLB | Network Load Balancer |
| NS | Name Server (a type of DNS record) |
| OSI | Open Systems Interconnection |
| PAT / NAPT | Port Address Translation / Network Address Port Translation |
| QUIC | Quick UDP Internet Connections |
| RTT | Round-Trip Time |
| SLAAC | StateLess Address AutoConfiguration |
| SMTP | Simple Mail Transfer Protocol |
| SSH | Secure Shell |
| SSL | Secure Sockets Layer (older version of TLS) |
| SYN | Synchronize |
| TCP | Transmission Control Protocol |
| TLD | Top-Level Domain |
| TLS | Transport Layer Security |
| TTL | Time To Live |
| TXT | Text (a type of DNS record) |
| UDP | User Datagram Protocol |
| VPN | Virtual Private Network |
| XSS | Cross-Site Scripting |

---

*End of guide — beginner-friendly edition, covers every core networking interview topic with full forms and annotated command output.*
