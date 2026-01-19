# Docker Complete Guide

## 1. Dockerfile

```dockerfile
FROM ubuntu
WORKDIR /var/www/html
RUN apt-get update \
    && apt-get install apache2 -y
ADD web.tar.gz . 
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
```

### Dockerfile Explanation (Simple Words)

| Line | Command | What it does |
|------|---------|--------------|
| `FROM ubuntu` | Starting point | Use Ubuntu as the base operating system |
| `WORKDIR /var/www/html` | Set working directory | Go to this folder inside the container |
| `RUN apt-get update && apt-get install apache2 -y` | Install software | Update package list and install Apache web server |
| `ADD web.tar.gz .` | Copy and extract | Copy web. tar.gz file and automatically extract it here |
| `EXPOSE 80` | Open port | Tell Docker that this container will listen on port 80 |
| `CMD ["apache2ctl", "-D", "FOREGROUND"]` | Start command | Run Apache web server when container starts |

---

## 2. Docker Run Command

```bash
docker run -d -p 8080:80 -v hostvolume:/var/www/html --name webcontainer webapp:latest
```

### Explanation (Simple Words)

**What this command does:** Creates and starts a new container from the `webapp:latest` image.

| Part | What it means |
|------|---------------|
| `docker run` | Create and start a new container |
| `-d` | **Detached mode** - Run container in background (you get your terminal back) |
| `-p 8080:80` | **Port mapping** - Connect your computer's port 8080 to container's port 80 |
| | 👉 Access via:  `http://localhost:8080` on your computer |
| `-v hostvolume:/var/www/html` | **Volume** - Share storage between your computer and container |
| | 👉 Data in container's `/var/www/html` is stored in `hostvolume` |
| `--name webcontainer` | **Container name** - Give this container the name "webcontainer" |
| `webapp:latest` | **Image** - Use the image called "webapp" with tag "latest" |

**In one sentence:** Run a web server in the background, accessible at port 8080, with shared storage, named "webcontainer".

---

## 3. Docker Remove Command

```bash
docker rm -f containerid
```

### Explanation (Simple Words)

**What this command does:** Deletes a container. 

| Part | What it means |
|------|---------------|
| `docker rm` | Remove (delete) a container |
| `-f` | **Force** - Stop and remove even if container is running |
| `containerid` | Replace this with actual container ID or name |

**Example:**
```bash
docker rm -f webcontainer
# OR
docker rm -f abc123def456
```

**In one sentence:** Forcefully stop and delete a container. 

---

## 4. Docker Volume List

```bash
docker volume ls
```

### Explanation (Simple Words)

**What this command does:** Shows all Docker volumes on your system.

**Output looks like:**
```
DRIVER    VOLUME NAME
local     hostvolume
local     mydata
local     database_vol
```

**What are volumes? **
- Think of volumes as **external hard drives** for containers
- They store data **permanently** even if containers are deleted
- Used for databases, uploaded files, configuration, etc.

**In one sentence:** List all storage volumes used by Docker containers.

---

## 5. Docker Network List

```bash
docker network ls
```

### Explanation (Simple Words)

**What this command does:** Shows all Docker networks on your system.

**Output looks like:**
```
NETWORK ID     NAME      DRIVER    SCOPE
abc123def456   bridge    bridge    local
def456ghi789   host      host      local
ghi789jkl012   none      null      local
```

**What are networks?**
- Think of networks as **Wi-Fi connections** for containers
- Containers on the same network can talk to each other
- Default types: 
  - **bridge** - Default network, containers can communicate
  - **host** - Uses your computer's network directly
  - **none** - No network access

**In one sentence:** List all networks that containers can use to communicate.

---

## 6. AWS Security Group - Open Port 8080

### Step-by-Step Instructions

#### Method 1: AWS Management Console (Web Interface)

1. **Login to AWS Console**
   - Go to https://aws.amazon.com/console/
   - Sign in with your credentials

2. **Navigate to EC2**
   - Search for "EC2" in the search bar
   - Click on "EC2" service

3. **Find Security Groups**
   - In the left sidebar, click **"Security Groups"** (under Network & Security)

4. **Select Your Security Group**
   - Find the security group attached to your EC2 instance
   - Click on the Security Group ID

5. **Edit Inbound Rules**
   - Click on **"Inbound rules"** tab
   - Click **"Edit inbound rules"** button

6. **Add New Rule**
   - Click **"Add rule"** button
   - Fill in the details:
   
   | Field | Value |
   |-------|-------|
   | Type | Custom TCP |
   | Protocol | TCP |
   | Port range | `8080` |
   | Source | `0.0.0.0/0` (Anywhere - for testing) or Your IP |
   | Description | Docker web application |

7. **Save Rules**
   - Click **"Save rules"** button

#### Method 2: AWS CLI (Command Line)

```bash
# Replace with your security group ID
aws ec2 authorize-security-group-ingress \
    --group-id sg-0123456789abcdef0 \
    --protocol tcp \
    --port 8080 \
    --cidr 0.0.0.0/0
```

### Security Best Practices

⚠️ **Important Security Notes:**

| Setting | Risk Level | When to Use |
|---------|-----------|-------------|
| `0.0.0.0/0` | ⚠️ HIGH RISK | Only for testing/development |
| `Your IP/32` | ✅ SAFE | When only you need access |
| `Company IP range` | ✅ SAFE | For internal applications |

### Verify Port is Open

After opening the port, test access: 

```bash
# From your local computer
curl http://YOUR-EC2-IP-ADDRESS:8080

# Example
curl http://54.123.45.67:8080
```

### Common Issues

| Problem | Solution |
|---------|----------|
| Can't access port 8080 | Check if Docker container is running:  `docker ps` |
| Security group not working | Make sure you edited the correct security group |
| Still can't connect | Check EC2 instance's firewall (iptables/firewalld) |

---

## Quick Reference Cheat Sheet

```bash
# Build Docker image
docker build -t webapp:latest .

# Run container
docker run -d -p 8080:80 -v hostvolume:/var/www/html --name webcontainer webapp:latest

# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop container
docker stop webcontainer

# Start container
docker start webcontainer

# Remove container (must stop first or use -f)
docker rm webcontainer
docker rm -f webcontainer  # Force remove

# View logs
docker logs webcontainer

# Execute command in running container
docker exec -it webcontainer /bin/bash

# List volumes
docker volume ls

# List networks
docker network ls

# Remove unused volumes
docker volume prune

# Remove unused networks
docker network prune
```

---

## Complete Workflow Example

```bash
# 1. Build the image
docker build -t webapp: latest .

# 2. Create a volume
docker volume create hostvolume

# 3. Run the container
docker run -d -p 8080:80 -v hostvolume:/var/www/html --name webcontainer webapp: latest

# 4. Check if it's running
docker ps

# 5. Access in browser
# Open: http://localhost:8080

# 6. View logs if needed
docker logs webcontainer

# 7. Stop and remove when done
docker stop webcontainer
docker rm webcontainer
```

---

## Troubleshooting

| Problem | Command to Check | Solution |
|---------|------------------|----------|
| Container not starting | `docker logs webcontainer` | Check error messages |
| Port already in use | `docker ps` or `netstat -ano \| findstr 8080` | Stop other service using port 8080 |
| Volume data missing | `docker volume inspect hostvolume` | Check volume mount path |
| Can't connect from AWS | Check security group | Open port 8080 in inbound rules |

---

**Created:** 2026-01-19  
**For:** Docker Container Management & AWS Configuration
