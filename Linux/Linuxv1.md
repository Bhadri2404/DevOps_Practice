# 🐧 Linux Mastery Guide — For DevOps, SysAdmins & Cloud Engineers

> **Audience:** Beginners → L3 Production Engineers | **Style:** Conceptual + Practical + Interview-Ready

---

## 📋 Table of Contents

1. [Core Linux Commands](#1-core-linux-commands)
   - [pwd](#-pwd--print-working-directory) | [ls](#-ls--list-directory-contents) | [cd](#-cd--change-directory) | [tree](#-tree--directory-tree) | [stat](#-stat--file-status) | [touch](#-touch--create-files) | [file](#-file--determine-file-type) | [cat](#-cat--concatenate--display) | [less/more](#-less--more--paging) | [head/tail](#-head--tail--line-display) | [nano/vim](#-nano--vim--text-editors) | [cmp/diff](#-cmp--diff--file-comparison)
2. [Searching & Text Processing](#2-searching--text-processing)
   - [grep](#-grep--search-patterns) | [find](#-find--search-files) | [awk](#-awk--pattern-processing) | [sed](#-sed--stream-editor) | [cut/sort/uniq](#-cut--sort--uniq) | [xargs/tee](#-xargs--tee) | [jq/yq](#-jq--yq--json--yaml)
3. [User & Group Management](#3-user--group-management)
   - [useradd/usermod](#-useradd--usermod) | [passwd](#-passwd) | [groups/id](#-groups--id) | [sudo/visudo](#-sudo--visudo) | [su](#-su--switch-user)
4. [Permissions & Ownership](#4-permissions--ownership)
   - [chmod](#-chmod--change-permissions) | [chown/chgrp](#-chown--chgrp) | [umask](#-umask) | [ACLs](#-getfacl--setfacl--access-control-lists) | [chattr/lsattr](#-chattr--lsattr)
5. [Process & Job Management](#5-process--job-management)
   - [ps](#-ps--process-status) | [top/htop](#-top--htop) | [kill/pkill](#-kill--pkill) | [jobs/fg/bg](#-jobs--fg--bg) | [nohup](#-nohup) | [nice/renice](#-nice--renice) | [lsof](#-lsof--list-open-files)
6. [System Monitoring & Performance](#6-system-monitoring--performance)
   - [iostat](#-iostat) | [vmstat](#-vmstat) | [sar](#-sar) | [iotop](#-iotop) | [strace](#-strace) | [free](#-free)
7. [Disk & Filesystem Management](#7-disk--filesystem-management)
   - [lsblk/blkid](#-lsblk--blkid) | [fdisk/parted](#-fdisk--parted) | [mkfs/fsck](#-mkfs--fsck) | [mount/umount](#-mount--umount) | [df/du](#-df--du) | [swap](#-swap-management)
8. [Compression & Archiving](#8-compression--archiving)
   - [tar](#-tar) | [gzip/bzip2/xz](#-gzip--bzip2--xz) | [zip/7z](#-zip--7z) | [dd](#-dd--low-level-copy) | [split](#-split)
9. [Networking & Remote Access](#9-networking--remote-access)
   - [ip/ifconfig](#-ip--ifconfig) | [ping/traceroute/mtr](#-ping--traceroute--mtr) | [curl/wget](#-curl--wget) | [ssh](#-ssh) | [scp/rsync](#-scp--rsync) | [ss/netstat](#-ss--netstat) | [tcpdump/nmap](#-tcpdump--nmap) | [dig/nslookup](#-dig--nslookup)
10. [Package Management](#10-package-management)
    - [apt](#-apt--debian--ubuntu) | [dnf/yum](#-dnf--yum--rhel) | [rpm/dpkg](#-rpm--dpkg) | [snap/flatpak](#-snap--flatpak)
11. [Services & Systemd](#11-services--systemd)
    - [systemctl](#-systemctl) | [journalctl](#-journalctl) | [service](#-service-legacy) | [logger](#-logger)
12. [Scheduling](#12-scheduling)
    - [cron/crontab](#-cron--crontab) | [at/batch](#-at--batch) | [anacron](#-anacron) | [systemd timers](#-systemd-timers)
13. [Shell Environment & Variables](#13-shell-environment--variables)
    - [export/env](#-export--env) | [alias](#-alias) | [bashrc/profile](#-bashrc--profile) | [set/unset](#-set--unset) | [PATH](#-path) | [history](#-history)
14. [Security & Access Control](#14-security--access-control)
    - [SELinux](#-selinux) | [AppArmor](#-apparmor) | [ufw/firewalld](#-ufw--firewalld) | [iptables](#-iptables) | [openssl](#-openssl) | [gpg](#-gpg) | [checksums](#-checksums) | [chroot](#-chroot)
15. [Logging & Auditing](#15-logging--auditing)
    - [journalctl](#-journalctl-1) | [syslog/messages](#-syslog--messages) | [dmesg](#-dmesg) | [auditd](#-auditd) | [logrotate](#-logrotate) | [last/lastb](#-last--lastb)
16. [System Information & OS Details](#16-system-information--os-details)
    - [uname/arch](#-uname--arch) | [lscpu/lshw](#-lscpu--lshw) | [hostname](#-hostname) | [timedatectl](#-timedatectl) | [lsns](#-lsns)
17. [Power & Boot Management](#17-power--boot-management)
    - [shutdown/reboot](#-shutdown--reboot) | [GRUB](#-grub) | [rescue mode](#-rescue-mode)
18. [File Transfer & Sharing](#18-file-transfer--sharing)
    - [scp/rsync](#-scp--rsync-1) | [NFS](#-nfs) | [Samba](#-samba) | [python http.server](#-python-http-server)
19. [Virtualization & Containers](#19-virtualization--containers)
    - [KVM/virsh](#-kvm--virsh) | [docker](#-docker) | [podman](#-podman) | [crictl](#-crictl)
20. [Developer Tools](#20-developer-tools)
    - [gcc/make](#-gcc--make) | [git](#-git) | [gdb/strace](#-gdb--strace) | [ldd](#-ldd)
21. [Troubleshooting & Recovery](#21-troubleshooting--recovery)
22. [Fun & Miscellaneous](#22-fun--miscellaneous)
23. [🔥 Interview Preparation](#23--interview-preparation)

---

# 1. Core Linux Commands

## What Is This Section About?
Core Linux commands are the **fundamental building blocks** of working with a Linux system. Every DevOps engineer, system administrator, and cloud engineer must know these commands cold — they are the first things you type when you SSH into any server.

## Why It Matters in Production
When a production alert fires at 2 AM and you SSH into a server, you have no GUI. You must navigate, read files, inspect configuration, and understand file metadata using nothing but the command line. These commands are your eyes and hands on the system.

---

## 🔹 `pwd` — Print Working Directory

### What It Does Internally
`pwd` reads the value of the `$PWD` environment variable maintained by the shell, OR it calls the `getcwd()` system call which walks up the directory tree by reading inode entries to construct the full absolute path.

### Architecture Flow
```
You type: pwd
  └─► Shell checks $PWD environment variable
        └─► If $PWD is set → prints it (logical path)
        └─► If -P flag → calls getcwd() system call
              └─► Kernel walks inode tree from current dir to root
                    └─► Returns full real path string
```

### Syntax & Examples
```bash
pwd           # prints current directory
pwd -P        # physical path (resolves symlinks)
pwd -L        # logical path (default, follows $PWD variable)
```

```bash
$ pwd
# Output: /home/ec2-user
# Explanation: You are in the ec2-user home directory

$ cd /var/log/nginx && pwd
# Output: /var/log/nginx
# Explanation: Changed to nginx log dir and confirmed location

$ cd /data && pwd
# Output: /data          ← shows logical (symlink) path

$ cd /data && pwd -P
# Output: /mnt/storage/real-data   ← shows actual physical path behind symlink
```

### Real-World DevOps Scenario
**Situation:** You're on a production Nginx web server via SSH, navigating deep into config directories. Before running `rm -rf *` to clean old configs, you MUST confirm you're in the right place.
```bash
cd /etc/nginx/conf.d/backup
pwd
# Output: /etc/nginx/conf.d/backup    ← confirmed! Safe to delete from here
```

### Common Mistakes
- **Running destructive commands without `pwd` check first** — always `pwd` before `rm`, `chmod -R`, or `chown -R`
- **Using relative paths in shell scripts** — relative paths break when the script is called from different directories

### Best Practices
```bash
# In shell scripts, always capture script's own directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# This gives you the real directory of the script, not where it was called from
```

### 🎯 Interview Point
> `pwd` uses the `$PWD` shell variable. `pwd -L` (default) shows the logical path including symlinks. `pwd -P` calls the `getcwd()` system call and resolves all symlinks to show the true physical path. This distinction matters in complex storage setups.

---

## 🔹 `ls` — List Directory Contents

### What It Does Internally
`ls` calls the `opendir()` and `readdir()` system calls to read directory entries (which are just inode number + filename pairs). It then calls `stat()` or `lstat()` on each entry to get metadata (permissions, size, timestamps). All of this is formatted and printed.

### Architecture Flow
```
ls -lah /etc/nginx
  └─► open("/etc/nginx", O_RDONLY|O_DIRECTORY)  — open directory
        └─► readdir() — read all directory entries (inode + name pairs)
              └─► For each entry: stat(entry) — get metadata
                    └─► Format output: permissions | links | owner | group | size | time | name
                          └─► Print to stdout
```

### Syntax & Examples
```bash
ls              # basic list
ls -l           # long format (permissions, owner, size, date)
ls -a           # show hidden files (dotfiles like .bashrc, .env)
ls -h           # human-readable sizes (KB, MB, GB)
ls -t           # sort by modification time (newest first)
ls -r           # reverse sort order
ls -R           # recursive (all subdirectories)
ls -S           # sort by file size (largest first)
ls -i           # show inode numbers
ls -lah         # most used combination: long + hidden + human-readable
```

```bash
$ ls -lah /etc/nginx/
# Output:
# total 64K
# drwxr-xr-x  6 root root 4.0K Apr 10 10:00 .          ← current dir
# drwxr-xr-x 98 root root 4.0K Apr 10 09:00 ..         ← parent dir
# -rw-r--r--  1 root root 1.5K Apr 10 10:00 nginx.conf  ← config file
# drwxr-xr-x  2 root root 4.0K Apr 10 10:00 conf.d      ← subdirectory
#
# Column breakdown:
# drwxr-xr-x = permissions (d=dir, rwx=owner, r-x=group, r-x=others)
#           6 = hard link count
#        root = owner
#        root = group
#        4.0K = size (human-readable due to -h)
#  Apr 10 10:00 = last modification time
#      nginx.conf = filename

$ ls -lt /var/log/
# Output sorted newest first:
# -rw-r--r-- 1 root root 145K Apr 17 18:00 syslog
# -rw-r--r-- 1 root root  50K Apr 17 10:00 auth.log
# Explanation: -t sorts by modification time, useful for finding recently changed logs

$ ls -lS /var/log/
# Output sorted largest first:
# -rw-r--r-- 1 root root 2.1G Apr 17 18:00 app.log    ← this is huge!
# -rw-r--r-- 1 root root 145K Apr 17 18:00 syslog
# Explanation: -S sorts by size, useful for finding disk-hogging files
```

### Permission String Breakdown
```
-rwxr-xr--
│├──┤├──┤├──┤
│ u   g   o
│
└─ File type:
   - = regular file
   d = directory
   l = symbolic link
   c = character device
   b = block device
   p = named pipe
   s = socket

Permission bits per group:
r = read    (4)
w = write   (2)
x = execute (1)
- = denied  (0)
```

### Real-World DevOps Scenario
**Before deploying a web app**, verify the web root has correct files and permissions:
```bash
ls -lah /var/www/html/
# Check: files owned by www-data, permissions 644 for files, 755 for dirs
# If you see 777 anywhere — that's a security risk, fix immediately
```

### Common Mistakes
- **Forgetting `-a`** to see hidden files like `.env`, `.gitignore`, `.bashrc` — these are critical in app directories
- **Using `ls -l` without `-h`** shows bytes (e.g., `1234567890`) which is hard to read; always add `-h`

### Best Practices
```bash
# Add to ~/.bashrc for convenience
alias ll='ls -lah'
alias lt='ls -lath'     # sorted by time
alias lS='ls -lahS'     # sorted by size

# Filter output with grep
ls -l /etc/ | grep nginx    # only show nginx-related entries
ls -l /var/log/ | grep "^-" # only files, not directories
```

---

## 🔹 `cd` — Change Directory

### What It Does Internally
`cd` is a **shell built-in** (not an external binary). It calls the `chdir()` system call which changes the process's current working directory. The shell also updates the `$PWD` and `$OLDPWD` environment variables.

### Key Usage
```bash
cd /var/log        # go to absolute path
cd nginx           # go to relative path (nginx subdir of current)
cd ..              # go up one level
cd ../..           # go up two levels
cd ~               # go to home directory ($HOME)
cd -               # go to previous directory ($OLDPWD) — very useful!
cd /               # go to filesystem root
```

```bash
$ pwd
# Output: /home/ec2-user

$ cd /etc/nginx/conf.d
$ pwd
# Output: /etc/nginx/conf.d

$ cd -
# Output: /home/ec2-user    ← went back to where we were
# The shell prints the directory it switched to

$ cd -
# Output: /etc/nginx/conf.d  ← back again (toggles between last two dirs)
# cd - is a toggle — extremely useful during debugging
```

### Real-World DevOps Scenario
**Debugging nginx configuration:**
```bash
cd /etc/nginx/conf.d/        # navigate to config directory
ls -lah                      # see what configs exist
cat myapp.conf               # read a specific config
cd -                         # instantly go back to where you were
```

### Common Mistakes
- **`cd` with no argument** goes to `$HOME`, NOT to `/` — many beginners expect root
- **`cd` in scripts** only affects the subshell running the script, not the parent shell that called it

---

## 🔹 `tree` — Directory Tree

### What It Does
Displays the directory and file structure in a visual tree format. Excellent for understanding project layout at a glance.

```bash
tree                      # current directory tree
tree /etc/nginx           # tree of specific path
tree -L 2                 # limit depth to 2 levels
tree -a                   # include hidden files
tree -d                   # directories only
tree --du                 # show disk usage per node
tree -L 3 > structure.txt # save tree to a file
```

```bash
$ tree -L 2 /etc/nginx/
# Output:
# /etc/nginx/
# ├── conf.d
# │   ├── default.conf    ← site config file
# │   └── ssl.conf
# ├── nginx.conf          ← main config
# └── sites-enabled
#     └── myapp.conf
#
# 3 directories, 4 files
# Explanation: Clear visual of nginx's config structure at 2 levels deep
```

---

## 🔹 `stat` — File Status

### What It Does Internally
`stat` calls the `stat()` system call which retrieves the inode information for a file. An inode contains all metadata EXCEPT the filename (the filename is stored in the directory entry). This gives you the complete picture of a file's state.

```bash
stat filename          # detailed file metadata
stat -f /mountpoint    # filesystem stats for the mount
```

```bash
$ stat /etc/passwd
# Output:
#   File: /etc/passwd
#   Size: 2345            Blocks: 8          IO Block: 4096   regular file
# Device: fd01h/64769d    Inode: 655363       Links: 1
# Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
# Access: 2026-04-17 08:00:01.000000000 +0000    ← atime: last READ
# Modify: 2026-04-10 14:22:10.000000000 +0000    ← mtime: last WRITE/CHANGE to content
# Change: 2026-04-10 14:22:10.000000000 +0000    ← ctime: last change to inode metadata
#  Birth: -
#
# KEY INSIGHT:
# atime = last Access time (when file was last read)
# mtime = last Modify time (when file CONTENT was last changed)
# ctime = last Change time (when inode METADATA was changed — permissions, owner, etc.)
# ctime is NOT creation time! Linux doesn't track file creation time (on most filesystems)
```

### 🎯 Interview Point
> Linux tracks **three** timestamps per file: `atime` (last access), `mtime` (last content modification), `ctime` (last inode/metadata change). There is **no native creation time** on ext4 (some newer filesystems like btrfs do track it). This confuses many engineers — `ctime` does NOT mean "creation time."

---

## 🔹 `touch` — Create Files / Update Timestamps

### What It Does Internally
If the file **doesn't exist**, `touch` creates it with zero bytes using `open()` with `O_CREAT` flag. If it **does exist**, `touch` calls `utimes()` to update its `atime` and `mtime` to the current time without modifying content.

```bash
touch newfile.txt               # create empty file (or update timestamps)
touch file1 file2 file3         # create multiple files at once
touch -t 202601010900 file.txt  # set specific timestamp: YYYYMMDDhhmm
touch -m file.txt               # only update modification time
touch -a file.txt               # only update access time
```

```bash
$ touch app.log
$ ls -lah app.log
# Output: -rw-r--r-- 1 ec2-user ec2-user 0 Apr 17 18:00 app.log
# Note the 0 size — file exists but is empty

$ touch -t 202601010900 deploy.log
$ stat deploy.log | grep Modify
# Output: Modify: 2026-01-01 09:00:00.000000000 +0000
# Explanation: We backdated the modification time — useful for testing time-based scripts
```

### Real-World DevOps Scenario
**Before starting an app that writes logs**, create placeholder log files so log rotation doesn't fail:
```bash
touch /var/log/myapp/app.log
touch /var/log/myapp/error.log
chown appuser:appuser /var/log/myapp/*.log
chmod 640 /var/log/myapp/*.log
```

---

## 🔹 `file` — Determine File Type

### What It Does Internally
`file` reads the **magic bytes** (first few bytes of the file) and compares them against a database (`/usr/share/misc/magic`). Every file format has a unique "magic number" signature. For example, ELF binaries start with `\x7fELF`, ZIP files start with `PK`, PNG starts with `\x89PNG`.

```bash
file filename           # identify file type
file -i filename        # show MIME type
file *                  # identify all files in directory
```

```bash
$ file /bin/ls
# Output: /bin/ls: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV)
# Explanation: This is a compiled binary (ELF = Executable and Linkable Format)

$ file script.sh
# Output: script.sh: Bourne-Again shell script, ASCII text executable
# Explanation: Shell script with bash shebang

$ file archive.tar.gz
# Output: archive.tar.gz: gzip compressed data, from Unix
# Explanation: It's gzip-compressed, regardless of what the extension says

$ file suspicious.bin
# Output: suspicious.bin: PE32+ executable (GUI) Intel 80386, for MS Windows
# ALERT: This is a Windows executable on a Linux server — suspicious!
```

### Real-World DevOps Scenario
**Security audit**: A file arrived with `.jpg` extension but it might be malicious:
```bash
file incoming_image.jpg
# Output: incoming_image.jpg: PHP script, ASCII text
# ALERT: It's not a real image — it's PHP code disguised as an image!
```

---

## 🔹 `cat` — Concatenate & Display

### What It Does Internally
`cat` reads from file(s) using `read()` system calls and writes to stdout using `write()`. It's extremely simple but very powerful when combined with redirection and pipes.

```bash
cat filename                    # display file contents
cat file1 file2                 # concatenate two files
cat file1 file2 > combined.txt  # combine and save
cat -n filename                 # show with line numbers
cat -A filename                 # show ALL characters (reveals Windows \r\n)
cat >> file.txt                 # append typed input to file (end with Ctrl+D)
cat /dev/null > app.log         # truncate/empty a file (zero bytes)
```

```bash
$ cat /etc/os-release
# Output:
# NAME="Ubuntu"
# VERSION="22.04.3 LTS (Jammy Jellyfish)"
# ID=ubuntu
# Explanation: Basic OS identification file

$ cat -n /etc/nginx/nginx.conf | head -5
# Output:
#      1  user www-data;
#      2  worker_processes auto;
#      3
#      4  error_log  /var/log/nginx/error.log notice;
#      5  pid        /run/nginx.pid;
# Explanation: -n adds line numbers — useful for referencing specific config lines

$ cat -A script.sh | head -3
# Output:
# #!/bin/bash^M$       ← ^M is Windows carriage return (\r)
# echo "Hello"^M$
# Explanation: Windows line endings detected! This will BREAK your bash script
# Fix: sed -i 's/\r//' script.sh  OR  dos2unix script.sh
```

### Common Mistakes
- **Using `cat` for large files** — opens the ENTIRE file in memory and floods your terminal. For files > 1MB, use `less`
- **`cat > file`** will **overwrite** the file. Use `cat >> file` to **append**
- **Useless Use of Cat (UUC)**: `cat file | grep pattern` should be `grep pattern file`

---

## 🔹 `less` / `more` — Paging

### What It Does
`less` opens a file in an **interactive pager** — it reads only the portion of the file needed for display. This is critical for large log files because it doesn't load the entire file into memory.

```bash
less filename                  # open file in pager
less +G filename               # open directly at the END
less +/ERROR filename          # open at first match of "ERROR"
less +F filename               # follow mode (like tail -f, live updates)
```

**Interactive Keys Inside `less`:**
| Key | Action |
|-----|--------|
| `Space` or `f` | Next page (forward) |
| `b` | Previous page (back) |
| `G` | Jump to END of file |
| `g` | Jump to BEGINNING |
| `/pattern` | Search forward for pattern |
| `?pattern` | Search backward |
| `n` | Next search match |
| `N` | Previous search match |
| `q` | Quit |
| `F` | Enter follow mode (live tail) |
| `=` | Show current position info |

```bash
$ less /var/log/syslog
# Opens the file — you can now scroll, search, navigate without loading all 500MB

$ less +G /var/log/nginx/access.log
# Opens directly at the end — useful for checking recent entries

$ less +/ERROR /var/log/app.log
# Opens at the first occurrence of "ERROR" — jump right to the problem
```

### 🎯 Interview Point
> **`less` vs `more`**: `more` is the older tool — it only scrolls **forward**. `less` can scroll forward AND backward, supports search, supports follow mode, and doesn't load the file into memory. The joke: **"less is more"** — `less` is actually more powerful than `more`.

---

## 🔹 `head` / `tail` — Line Display

### `head` — First N Lines
```bash
head filename          # first 10 lines (default)
head -n 20 filename    # first 20 lines
head -c 100 filename   # first 100 bytes
```

### `tail` — Last N Lines
```bash
tail filename              # last 10 lines (default)
tail -n 50 filename        # last 50 lines
tail -f filename           # FOLLOW mode: live stream new lines as they're added
tail -F filename           # follow with file re-open (handles log rotation)
tail -f -n 100 filename    # last 100 lines then follow live
```

```bash
$ head -n 5 /etc/passwd
# Output:
# root:x:0:0:root:/root:/bin/bash
# daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
# bin:x:2:2:bin:/bin:/usr/sbin/nologin
# sys:x:3:3:sys:/dev:/usr/sbin/nologin
# sync:x:4:65534:sync:/bin:/bin/sync
# Explanation: Shows first 5 user accounts defined in the system

$ tail -f /var/log/nginx/access.log
# Output streams live:
# 10.0.0.1 - - [17/Apr/2026:18:00:01 +0000] "GET /api/health HTTP/1.1" 200 45
# 10.0.0.1 - - [17/Apr/2026:18:00:02 +0000] "GET /api/users HTTP/1.1" 500 89
# ← New lines appear in real-time as nginx writes them
# Press Ctrl+C to stop following

$ tail -n 100 /var/log/app.log | grep ERROR
# Output:
# 2026-04-17 18:20:55 ERROR Database connection failed: timeout
# Explanation: Get last 100 lines and filter for errors only
```

### Real-World DevOps Scenario
**During production deployment**, monitor error log in one terminal:
```bash
# Terminal 1: Deploy
./deploy.sh v2.1.0

# Terminal 2: Monitor (always do this during deploys!)
tail -F /var/log/nginx/error.log | grep -E "error|crit|emerg"
# -F handles log rotation (when log gets rotated, tail -F re-opens the new file)
# tail -f would stop working after rotation — always use -F in production monitoring
```

### 🎯 Interview Point
> **`tail -f` vs `tail -F`**: `-f` follows the **file descriptor** — if the log gets rotated (file replaced), it keeps reading from the OLD file handle. `-F` follows the **filename** — it re-opens the file if it changes. **Always use `-F` in production log monitoring.**

---

## 🔹 `nano` / `vim` — Text Editors

### `nano` — Beginner-Friendly Editor
```bash
nano filename           # open file
nano +10 filename       # open at line 10
```
Key shortcuts displayed at the bottom:
- `Ctrl+S` — Save | `Ctrl+X` — Exit | `Ctrl+W` — Search | `Ctrl+K` — Cut line | `Ctrl+U` — Paste | `Alt+U` — Undo

### `vim` — Professional Modal Editor

**Vim has two primary modes:**
1. **Normal Mode** (default when you open) — for navigation, commands
2. **Insert Mode** — for typing text (enter with `i`, exit with `Esc`)

```bash
vim filename            # open file
vim +50 filename        # open at line 50
vim -R filename         # read-only mode (safe for viewing critical files)
vim -d file1 file2      # vimdiff (compare two files side by side)
```

**Essential Vim Commands:**
| Command | Mode | Action |
|---------|------|--------|
| `i` | Normal→Insert | Insert before cursor |
| `a` | Normal→Insert | Insert after cursor |
| `o` | Normal→Insert | New line below, insert |
| `Esc` | Insert→Normal | Return to normal mode |
| `:w` | Normal | Save |
| `:q` | Normal | Quit |
| `:wq` or `ZZ` | Normal | Save and quit |
| `:q!` | Normal | Quit WITHOUT saving |
| `dd` | Normal | Delete (cut) entire line |
| `yy` | Normal | Copy (yank) line |
| `p` | Normal | Paste below cursor |
| `/pattern` | Normal | Search forward |
| `:%s/old/new/g` | Normal | Replace ALL occurrences globally |
| `gg` | Normal | Go to first line |
| `G` | Normal | Go to last line |
| `nG` or `:n` | Normal | Go to line n |
| `u` | Normal | Undo |
| `Ctrl+R` | Normal | Redo |
| `:set number` | Normal | Show line numbers |

```bash
# Quick vim workflow for editing nginx config:
vim /etc/nginx/nginx.conf
# Navigate to worker_processes line: /worker_processes (search)
# Press n to find next match
# Press i to enter insert mode
# Make your change
# Press Esc to return to normal mode
# Type :wq to save and exit
```

### 🎯 Interview Point
> `vi` is guaranteed to be available on **any POSIX-compliant system** — even minimal containers, recovery environments, and old Unix systems. `vim` (Vi IMproved) adds syntax highlighting, undo history, split windows, and plugin support. When in doubt on any server: `vi` is always there.

---

## 🔹 `cmp` / `diff` — File Comparison

### `cmp` — Byte-Level Comparison
`cmp` compares files byte by byte. Returns 0 if identical, 1 if different.
```bash
cmp file1 file2            # find first difference
cmp -l file1 file2         # list ALL differing bytes
cmp -s file1 file2         # silent mode (use exit code in scripts)
```

```bash
$ cmp config.bak config.conf
# Output: config.bak config.conf differ: byte 145, line 8
# Explanation: First difference is at byte 145, which is on line 8

$ cmp -s file1 file2; echo $?
# Output: 0     ← files are identical (0 = success)
# OR:     1     ← files differ
# Useful in scripts: if cmp -s original copy; then echo "Identical"; fi
```

### `diff` — Line-Level Comparison
`diff` shows WHAT changed between two text files, line by line.
```bash
diff file1 file2           # standard diff format
diff -u file1 file2        # unified format (used by git, patches)
diff -y file1 file2        # side-by-side comparison
diff -r dir1 dir2          # recursive directory comparison
diff -i file1 file2        # ignore case differences
```

```bash
$ diff -u nginx.conf.bak nginx.conf
# Output:
# --- nginx.conf.bak  2026-04-10 10:00:00
# +++ nginx.conf      2026-04-17 18:00:00
# @@ -2,7 +2,7 @@
# -worker_processes 2;   ← line removed (in old file)
# +worker_processes 4;   ← line added (in new file)
#  
# Explanation: The - shows what was in the OLD file, + shows what's in NEW file
# This is the exact format git uses for showing changes
```

### Real-World DevOps Scenario
**Before applying a config change**, review what you're actually changing:
```bash
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak   # backup first
vim /etc/nginx/nginx.conf                             # make changes
diff /etc/nginx/nginx.conf.bak /etc/nginx/nginx.conf  # review exactly what changed
nginx -t && nginx -s reload                           # apply only if diff looks correct
```

### Summary — Core Linux Commands

**📌 5-Minute Recap:**
- **`pwd`** tells you where you are; **`cd`** moves you; **`ls`** shows what's around you
- **`stat`** reveals the full truth about a file (inode, timestamps, permissions) — `ctime` ≠ creation time
- **`touch`** creates empty files or updates timestamps — used for placeholder files and scripting
- **`cat`** is for small files; **`less`** is for large files — never `cat` a 500MB log
- **`tail -F`** (not `-f`) is the correct tool for live log monitoring in production
- **`vim`** is always available; `nano` is beginner-friendly; both are essential skills
- **`diff -u`** shows changes in the same format as `git diff` — fundamental for config management
- **`file`** reveals the TRUE type of a file regardless of extension — critical for security checks

**🎤 Interview-Ready Phrasing:**
> "Before running any destructive command, I always run `pwd` to confirm my location. For log monitoring, I use `tail -F` because it handles log rotation automatically. When editing production configs, I always use `vim -R` first to review before making changes."

---

# 2. Searching & Text Processing

## What Is This Section About?
Searching and text processing is where Linux truly shines. These tools let you find files, extract data, transform text, and analyze logs — all without any GUI or database. In DevOps, the ability to process text efficiently is a **superpower**.

## Why It Matters in Production
Every piece of data on a Linux system — logs, configs, metrics, reports — is text. Being able to quickly search, filter, extract, and transform that text is the difference between a 5-minute incident response and a 2-hour debugging session.

---

## 🔹 `grep` — Search Patterns

### What It Does Internally
`grep` reads files line by line and applies a regular expression (regex) test to each line. If the pattern matches, the line is printed. Internally, it uses highly optimized regex engines. `grep` uses `mmap()` for large files and can process gigabytes per second on modern hardware.

### Architecture Flow
```
grep "ERROR" /var/log/app.log
  └─► Open file → read line by line
        └─► For each line: apply regex "ERROR"
              └─► If match → write line to stdout
                    └─► If no match → skip
```

### Syntax & All Important Options
```bash
grep "pattern" file                # basic search
grep -i "pattern" file             # case-INsensitive
grep -r "pattern" /directory/      # recursive (search all files in dir)
grep -l "pattern" /dir/            # show only FILENAMES that match (not lines)
grep -n "pattern" file             # show LINE NUMBERS with matches
grep -v "pattern" file             # INVERT: show lines that DON'T match
grep -c "pattern" file             # COUNT matching lines (not the lines themselves)
grep -A 3 "pattern" file           # 3 lines AFTER match (context After)
grep -B 3 "pattern" file           # 3 lines BEFORE match (context Before)
grep -C 3 "pattern" file           # 3 lines both sides (Context)
grep -E "pat1|pat2" file           # Extended regex (OR logic) — same as egrep
grep -F "literal.string" file      # Fixed string (no regex) — fastest for literal search
grep -w "word" file                # match WHOLE WORD only
grep --color=auto "pattern" file   # highlight matches in color
grep -o "pattern" file             # show ONLY the matching part, not whole line
```

```bash
$ grep -n "ERROR" /var/log/app.log
# Output:
# 145: 2026-04-17 10:22:01 ERROR DB connection failed: timeout after 30s
# 203: 2026-04-17 11:15:44 ERROR Null pointer exception in UserService.java:127
# Explanation: -n shows which line number each ERROR is on — great for pinpointing

$ grep -i "error\|warn\|fatal" /var/log/nginx/error.log
# Output: matches ERROR, WARN, FATAL in any case (Error, Warning, Fatal, etc.)
# Explanation: \| is OR in basic regex; with -E you'd use |

$ grep -rl "database_host" /etc/
# Output:
# /etc/app/config.yml
# /etc/myservice/settings.conf
# Explanation: -r searches recursively, -l shows only filenames
# Useful for: finding where a config value appears across all config files

$ grep -C 3 "Out of memory" /var/log/syslog
# Output:
# Apr 17 03:14:55 server kernel: java invoked oom-killer: ...
# Apr 17 03:14:55 server kernel: Task in /docker/abc123 killed as result of limit of /docker/abc123
# Apr 17 03:14:56 server kernel: Out of memory: Kill process 5678 (java) score 800
# Apr 17 03:14:56 server kernel: Killed process 5678 (java) total-vm:4194304kB
# Apr 17 03:14:57 server kernel: oom_reaper: reaped process 5678 (java)
# Explanation: -C 3 shows 3 lines of context on each side — gives you the full picture

$ grep -c " 500 " /var/log/nginx/access.log
# Output: 23
# Explanation: There were 23 HTTP 500 errors — quick health metric

$ grep -v "^#" /etc/nginx/nginx.conf | grep -v "^$"
# Output: nginx.conf with comment lines and blank lines removed
# Explanation: -v "^#" removes comment lines, second -v "^$" removes empty lines
# Great for reading configs without all the noise
```

### Real-World DevOps Scenario
**Production incident — find all 5xx errors in the last hour from nginx:**
```bash
# Get current hour prefix (e.g., "17/Apr/2026:18")
HOUR_PREFIX=$(date '+%d/%b/%Y:%H')

grep "$HOUR_PREFIX" /var/log/nginx/access.log | grep " 5[0-9][0-9] "
# Output: all requests in the current hour that returned 5xx status codes
# This is your first step in any nginx production incident
```

### `grep` Variants
```bash
egrep "ERROR|WARN|FATAL" app.log   # Extended grep (same as grep -E)
fgrep "192.168.1.1" auth.log       # Fixed string grep (same as grep -F, fastest)
zgrep "CRITICAL" app.log.1.gz      # grep on COMPRESSED .gz files without decompressing
```

### 🎯 Interview Point
> `grep` vs `egrep` vs `fgrep`: `grep` uses **Basic Regular Expressions** (BRE) where `+`, `?`, `|` need backslash-escaping. `egrep` (= `grep -E`) uses **Extended Regular Expressions** where `+`, `?`, `|` work naturally. `fgrep` (= `grep -F`) treats the pattern as a **literal fixed string** with no regex — it's the fastest option when you don't need regex.

---

## 🔹 `find` — Search Files

### What It Does Internally
`find` performs a **real-time filesystem traversal** — it walks directory trees using `opendir()`/`readdir()`/`stat()` system calls. Unlike `locate`, it doesn't use a database so results are always current. It's slower than `locate` but accurate and supports complex criteria.

### Syntax & Key Options
```bash
find [path] [criteria] [action]

# Criteria:
find / -name "nginx.conf"           # by exact name
find / -iname "*.conf"              # case-insensitive name
find / -type f                      # files only
find / -type d                      # directories only
find / -type l                      # symbolic links only
find / -size +100M                  # files larger than 100MB
find / -size -1k                    # files smaller than 1KB
find / -mtime -7                    # modified in last 7 days
find / -mtime +30                   # modified more than 30 days ago
find / -newer reference_file        # newer than reference file
find / -perm 644                    # exact permission 644
find / -perm -4000                  # SUID bit set (security check)
find / -user username               # owned by specific user
find / -group groupname             # owned by specific group
find / -empty                       # empty files or directories

# Actions:
find / -name "*.log" -delete                    # delete found files
find / -name "*.conf" -exec cat {} \;           # run command on each
find / -name "*.conf" -exec grep -l "PROD" {} \; # find files containing "PROD"
find / -name "*.log" -print0 | xargs -0 rm      # safe delete (handles spaces in names)
```

```bash
$ find / -type f -size +500M 2>/dev/null
# Output:
# /var/log/app/old-debug.log
# /home/ec2-user/core.dump
# Explanation: 2>/dev/null hides "Permission denied" errors for dirs you can't access
# These are your disk space culprits — verify before deleting!

$ find /var/log/app/ -name "*.log" -mtime +30 -delete
# Explanation: Delete log files older than 30 days
# WARNING: Always test without -delete first to see what would be deleted:
find /var/log/app/ -name "*.log" -mtime +30   # dry run — see what would be deleted

$ find /etc -name "*.conf" -exec grep -l "PROD_DB" {} \;
# Output:
# /etc/app/config.yml
# /etc/myservice/database.conf
# Explanation: Finds all .conf files that contain the string "PROD_DB"
# Useful for: finding configs that point to production databases before an env change

$ find / -type f -perm /4000 2>/dev/null
# Output:
# /usr/bin/passwd
# /usr/bin/sudo
# /usr/bin/pkexec
# Explanation: SUID files run with the FILE OWNER's permissions (usually root)
# Security check: you should know every SUID binary on your server

$ find / -type f -printf "%s\t%p\n" 2>/dev/null | sort -rn | head -10
# Output:
# 2147483648    /var/log/app/debug.log    ← 2GB file!
# 1073741824    /home/user/downloads/iso
# Explanation: Find and rank files by size — first step when disk is full
```

### Real-World DevOps Scenario
**EC2 root partition at 95%** — immediate triage:
```bash
# Step 1: Which directory is biggest?
du -sh /* 2>/dev/null | sort -rh | head -5
# Output: 18G /var    ← found it

# Step 2: Drill into /var
du -sh /var/* 2>/dev/null | sort -rh | head -5
# Output: 15G /var/log  ← found it

# Step 3: Find the specific large file(s)
find /var/log -type f -size +100M -printf "%s\t%p\n" | sort -rn | head -10
# Output: 15032385536  /var/log/app/debug.log   ← 15GB debug log!

# Step 4: Investigate before deleting
tail -5 /var/log/app/debug.log   # is it still being written?
lsof /var/log/app/debug.log       # who has it open?

# Step 5: Truncate safely (don't delete if still open — freed space won't show!)
> /var/log/app/debug.log    # truncate to zero bytes while keeping file handle open
```

### 🎯 Interview Point
> `find` vs `locate`: `find` does a **live real-time scan** — always current but slower. `locate` uses a **pre-built database** (`/var/lib/mlocate`) — extremely fast but only as current as the last `updatedb` run. Use `find` for accuracy and complex queries; use `locate` for quick filename searches on stable filesystems.

---

## 🔹 `awk` — Pattern Processing Language

### What It Does Internally
`awk` reads input line by line, automatically splits each line into **fields** based on a separator (default: whitespace), then executes pattern-action rules. It's a complete programming language embedded in a single command.

### Core Concepts
```
Input line: "10.0.0.1 - alice [17/Apr/2026] GET /api 200 1234"
                $1         $2    $3      $4        $5   $6  $7  $8
                                           ↑ FS = space (default)

$0 = entire line
$1 = first field
NR = current line number
NF = number of fields in current line
FS = field separator (default: whitespace)
```

```bash
awk '{print $1}' file                  # print first field of each line
awk -F: '{print $1}' /etc/passwd       # use : as field separator
awk 'NR==5' file                       # print only line 5
awk '$3 > 100' file                    # print lines where field 3 > 100
awk '/pattern/ {print $2}' file        # print field 2 of lines matching pattern
awk 'BEGIN {print "start"} {print} END {print "end"}' file
```

```bash
$ awk -F: '{print $1, $7}' /etc/passwd
# Output:
# root /bin/bash
# daemon /usr/sbin/nologin
# ec2-user /bin/bash
# Explanation: Using : as delimiter, print username (field 1) and shell (field 7)

$ free -m | awk 'NR==2 { printf "Used: %dMB / Total: %dMB (%.1f%%)\n", $3, $2, $3/$2*100 }'
# Output: Used: 5100MB / Total: 7946MB (64.2%)
# Explanation: NR==2 selects the "Mem:" line, then formats memory stats with percentage

$ awk '{ sum += $5 } END { print "Total bytes:", sum }' <(ls -l /var/log/)
# Output: Total bytes: 2048576
# Explanation: Accumulates file sizes (column 5 of ls -l) and prints total at END

$ awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | awk '$1 > 1000 {print $2, $1}'
# Output:
# 192.168.1.105 4521
# 10.0.0.22 1203
# Explanation: Find IPs making more than 1000 requests — potential DDoS or scraper
```

### Real-World DevOps Scenario
**Disk alert automation** — check all partitions and alert if > 80%:
```bash
df -h | awk 'NR>1 { 
    gsub(/%/, "", $5)          # remove % sign from column 5
    if ($5+0 > 80) 
        print "ALERT: " $6 " is " $5 "% full"
}'
# Output:
# ALERT: / is 87% full
# ALERT: /var is 95% full
# This can be added to a cron job to email alerts
```

### 🎯 Interview Point
> `awk` has three special blocks: `BEGIN { }` runs **before** processing any input (good for initialization), the main `{ }` block runs for **every line**, and `END { }` runs **after** all input is processed (good for totals, summaries). This makes it perfect for generating reports from log files.

---

## 🔹 `sed` — Stream Editor

### What It Does Internally
`sed` reads input line by line into an internal **pattern space**, applies editing commands (substitute, delete, insert, etc.), then prints the result. It's a non-interactive, command-line text editor — perfect for scripted config changes.

### Key Operations
```bash
sed 's/old/new/' file              # substitute FIRST occurrence per line
sed 's/old/new/g' file             # substitute ALL occurrences (global)
sed 's/old/new/gi' file            # global, case-insensitive
sed -i 's/old/new/g' file          # in-place edit (modifies actual file)
sed -i.bak 's/old/new/g' file      # in-place with .bak backup
sed '5d' file                      # delete line 5
sed '/^#/d' file                   # delete lines starting with # (comments)
sed '/^$/d' file                   # delete blank lines
sed -n '10,20p' file               # print ONLY lines 10 to 20
sed '/pattern/a\new line here' file # append line AFTER pattern match
sed '/pattern/i\new line here' file # insert line BEFORE pattern match
```

```bash
$ sed -i.bak 's/db-old.company.com/db-new.company.com/g' /etc/app/config.yml
# Explanation:
# -i = in-place edit (modifies the real file)
# .bak = creates config.yml.bak as automatic backup BEFORE changing
# s/.../.../ = substitution
# g = global (all occurrences on each line)
# Result: /etc/app/config.yml now has new DB host; original saved as config.yml.bak

$ sed -n '100,200p' /var/log/app.log
# Output: lines 100 through 200 only
# Explanation: -n suppresses default output; p explicitly prints matched range
# Useful for: extracting a specific time window from a log file

$ sed '/^#/d; /^$/d' nginx.conf
# Output: nginx.conf content with NO comment lines and NO blank lines
# Explanation: Multiple commands separated by ;
# Very useful for reading configs cleanly

$ sed '/server_name/a\    return 301 https://$host$request_uri;' nginx.conf
# Explanation: After every line containing "server_name", insert a redirect rule
# Useful for adding HTTPS redirects to existing nginx configs
```

### Real-World DevOps Scenario
**Blue-green deployment** — switch nginx from blue environment to green:
```bash
# Before: upstream blue { server 10.0.1.10; }
# After:  upstream green { server 10.0.2.10; }

sed -i.bak 's/upstream_blue/upstream_green/g' /etc/nginx/conf.d/lb.conf
nginx -t                    # test config syntax first!
nginx -s reload             # apply change if test passes
# If issues: cp /etc/nginx/conf.d/lb.conf.bak /etc/nginx/conf.d/lb.conf && nginx -s reload
```

### 🎯 Interview Point
> The holy trinity of Linux text processing: **`grep` finds lines → `sed` transforms them → `awk` processes fields**. Combined in pipelines, these three tools can replace entire programs. Example: `grep "ERROR" app.log | awk '{print $4}' | sort | uniq -c | sort -rn` — finds errors, extracts error codes, and ranks by frequency.

---

## 🔹 `cut`, `sort`, `uniq`

### `cut` — Extract Fields/Columns
```bash
cut -d: -f1 /etc/passwd          # delimiter :, get field 1 (usernames)
cut -d' ' -f1 access.log         # space delimiter, get IPs from log
cut -c1-10 file                  # get characters 1 through 10
```

```bash
$ cut -d: -f1,3 /etc/passwd
# Output:
# root:0
# daemon:1
# ec2-user:1000
# Explanation: Get username (field 1) and UID (field 3) from passwd file
```

### `sort` — Sort Lines
```bash
sort file                        # alphabetical sort
sort -n file                     # numeric sort (treats numbers as numbers, not strings)
sort -r file                     # reverse sort
sort -u file                     # unique sort (remove exact duplicates while sorting)
sort -k2 file                    # sort by column 2
sort -t: -k3 -n /etc/passwd      # sort passwd by UID (field 3, numeric)
sort -rh du_output.txt           # reverse human-readable size sort (for du output)
```

```bash
$ sort -t: -k3 -n /etc/passwd | head -5
# Output:
# root:x:0:0:root:/root:/bin/bash      ← UID 0
# daemon:x:1:1:daemon:/usr/sbin:...    ← UID 1
# Explanation: Sorted numerically (-n) by UID field (field 3, delimiter :)
```

### `uniq` — Remove/Count Duplicates
**Important:** `uniq` only removes **adjacent** duplicates. Input MUST be sorted first.
```bash
sort file | uniq              # sort then remove duplicates
sort file | uniq -c           # count occurrences of each unique line
sort file | uniq -d           # show ONLY duplicate lines
sort file | uniq -u           # show ONLY lines that appear exactly ONCE
```

```bash
$ cat /var/log/nginx/access.log | cut -d' ' -f1 | sort | uniq -c | sort -rn | head -5
# Output:
#   4521 10.0.0.1
#   1203 192.168.1.50
#    892 203.0.113.99
#     42 10.0.0.5
# Explanation: The classic "top IPs hitting your server" one-liner
# cut extracts IP (field 1), sort prepares for uniq, uniq -c counts, sort -rn ranks by count
```

---

## 🔹 `xargs` / `tee`

### `xargs` — Build Commands from Input
`xargs` bridges a gap: many commands can't read from stdin. `xargs` converts stdin into command arguments.

```bash
command | xargs another_command
find . -name "*.log" | xargs rm -f
cat servers.txt | xargs -I{} ssh {} "uptime"   # {} is the placeholder
echo "a b c" | xargs -n1 echo                  # one arg per invocation
cat hosts.txt | xargs -P 5 -I{} ping -c1 {}    # 5 parallel processes
```

```bash
$ find /var/log -name "*.log" -mtime +30 | xargs rm -f
# Explanation: find generates list of old log files, xargs passes them to rm
# More efficient than: find ... -exec rm {} \;  (xargs batches multiple files per rm call)

$ cat server_list.txt | xargs -P 10 -I{} ssh {} "df -h /"
# Output: disk usage from 10 servers simultaneously
# Explanation: -P 10 = 10 parallel SSH connections, -I{} = replace {} with each server name
# This runs 10 SSH commands in parallel — dramatically faster than sequential
```

### `tee` — Write to File AND Display Simultaneously
`tee` acts like a T-junction in a pipe — data flows to BOTH stdout AND a file.

```bash
command | tee output.log             # display AND save to file
command | tee -a output.log          # display AND APPEND to file
command | tee file1 file2            # display AND save to multiple files
command | tee /dev/tty | next_cmd    # show on terminal AND pass to next command
```

```bash
$ ./deploy.sh | tee /var/log/deploy-$(date +%F).log
# Output: appears on screen AND gets saved to file simultaneously
# Explanation: You see the deployment progress AND have a permanent record
# Critical for production deployments — you always want a log

$ kubectl apply -f deployment.yaml | tee /var/log/k8s-deploy-$(date +%F).log
# Explanation: Apply k8s manifest, see output, AND save deployment record
```

---

## 🔹 `jq` / `yq` — JSON & YAML

### `jq` — JSON Processor
```bash
cat file.json | jq '.'                          # pretty-print JSON
cat file.json | jq '.key'                       # extract a key
cat file.json | jq '.items[0].name'             # nested access
cat file.json | jq '.items[] | .name'           # iterate array
cat file.json | jq 'select(.status == "error")' # filter by condition
```

```bash
$ aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
# Output:
# "i-0a1b2c3d4e5f"
# "i-0f1e2d3c4b5a"
# Explanation: Extract just instance IDs from the verbose AWS API response

$ kubectl get pods -o json | jq '.items[] | {name: .metadata.name, status: .status.phase}'
# Output:
# { "name": "nginx-abc123", "status": "Running" }
# { "name": "redis-def456", "status": "Pending" }
# Explanation: Extract name and status for each pod — much cleaner than full JSON
```

### `yq` — YAML Processor
```bash
yq '.metadata.name' deployment.yaml                    # read a value
yq -i '.spec.replicas = 3' deployment.yaml             # in-place update
yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' a.yaml b.yaml  # merge yamls
```

### Summary — Searching & Text Processing

**📌 5-Minute Recap:**
- **`grep`** is for finding lines; `-i` for case-insensitive, `-r` for recursive, `-v` for inverted, `-C n` for context
- **`find`** does real-time filesystem search with complex criteria; always test before using `-delete`
- **`awk`** is a full programming language for field-based processing; perfect for log analysis and reports
- **`sed`** transforms text streams; `-i.bak` for safe in-place edits; used heavily in CI/CD config updates
- **`cut | sort | uniq -c | sort -rn`** is the classic pipeline for frequency analysis (top IPs, error codes, etc.)
- **`xargs -P n`** enables parallel execution — run same command across 50 servers simultaneously
- **`tee`** is essential in deployments — always pipe deployment output through `tee` to save a log
- **`jq`** and `yq`** are mandatory tools for modern DevOps — AWS CLI, kubectl, terraform all output JSON/YAML

**🎤 Interview-Ready Phrasing:**
> "My go-to incident response pipeline is: `grep -C5 'ERROR' /var/log/app.log | head -50` to get context around errors, then `awk '{print $4}' | sort | uniq -c | sort -rn` to find the most frequent error types. For config changes, I always use `sed -i.bak` so there's an automatic backup."

---

# 3. User & Group Management

## What Is This Section About?
Linux is a **multi-user operating system**. Every process runs as a user. Every file is owned by a user and a group. User and group management is how you control **who can do what** on a Linux system. In production, this is a fundamental security and operational concern.

## Why It Matters in Production
Running applications as `root` is one of the most common security mistakes in DevOps. Proper user management means each service has its own user with minimum required permissions — the **principle of least privilege**.

---

## 🔹 `useradd` / `usermod`

### Internal Working
User information is stored in three key files:
- `/etc/passwd` — user account info (username, UID, GID, home, shell)
- `/etc/shadow` — encrypted passwords + expiry policy
- `/etc/group` — group definitions

```bash
# useradd — create user (low-level, non-interactive)
useradd -m -s /bin/bash username          # create with home dir and bash shell
useradd -m -s /bin/bash -G docker,sudo deployuser   # with secondary groups
useradd -r -s /sbin/nologin -M appservice  # system account (no login, no home)
# -r = system account (UID < 1000)
# -M = no home directory
# -s /sbin/nologin = cannot log in interactively

# usermod — modify existing user
usermod -aG docker ec2-user     # ADD to group (MUST use -a to append, not replace)
usermod -s /bin/zsh ec2-user    # change default shell
usermod -L username              # LOCK account (adds ! to password hash in shadow)
usermod -U username              # UNLOCK account
usermod -d /new/home username   # change home directory
```

```bash
$ useradd -m -s /bin/bash -c "Application Service User" -G docker appuser
$ id appuser
# Output: uid=1001(appuser) gid=1001(appuser) groups=1001(appuser),998(docker)
# Explanation: New user created with UID 1001, in their own group, plus docker group

$ usermod -aG sudo ec2-user
# CRITICAL NOTE: The -a flag means APPEND
# Without -a: usermod -G sudo ec2-user  ← REMOVES all other groups and only keeps sudo!
# With -a:    usermod -aG sudo ec2-user ← ADDS sudo to existing groups
# This is one of the most common and dangerous mistakes with usermod
```

### Real-World DevOps Scenario
**Provisioning a new EC2 instance** — never run apps as root:
```bash
# Create dedicated app user
useradd -m -s /bin/bash -c "MyApp Service User" appuser

# Create app directories with correct ownership
mkdir -p /opt/myapp /var/log/myapp
chown -R appuser:appuser /opt/myapp /var/log/myapp
chmod 750 /opt/myapp
chmod 770 /var/log/myapp

# Allow app to use docker
usermod -aG docker appuser

# Set password (or set up SSH key auth)
passwd appuser

# Verify
id appuser
# Output: uid=1001(appuser) gid=1001(appuser) groups=1001(appuser),998(docker)
```

---

## 🔹 `passwd`

```bash
passwd                     # change YOUR own password
passwd username            # change another user's password (as root)
passwd -l username         # LOCK account (disables password login)
passwd -u username         # UNLOCK account
passwd -e username         # EXPIRE password (forces change at next login)
passwd -S username         # show password STATUS
```

```bash
$ passwd -S ec2-user
# Output: ec2-user PS 2026-01-01 0 99999 7 -1 (Password set, SHA512 crypt.)
# Breakdown:
# ec2-user = username
# PS = Password Set (P=password, L=Locked, NP=No Password)
# 2026-01-01 = last change date
# 0 = min days before change allowed
# 99999 = max days before change required (~273 years = never expires)
# 7 = days before expiry to warn user
# -1 = days after expiry before account disabled (-1 = disabled)

$ passwd -l compromised_user
# Output: passwd: password expiry information changed.
# Explanation: Locks the account by adding ! before password hash in /etc/shadow
# User can no longer login, but their files and processes aren't affected
```

---

## 🔹 `groups` / `id`

```bash
groups                     # show YOUR groups
groups username            # show specific user's groups
id                         # show YOUR uid, gid, and all groups
id username                # show another user's IDs
```

```bash
$ id
# Output: uid=1000(ec2-user) gid=1000(ec2-user) groups=1000(ec2-user),998(docker),10(wheel),27(sudo)
# Breakdown:
# uid=1000 = User ID number (1000+ = regular user, 0 = root, 1-999 = system users)
# gid=1000 = PRIMARY group ID
# groups= = list of ALL groups this user belongs to
# docker, wheel, sudo = secondary groups (for additional permissions)

$ id root
# Output: uid=0(root) gid=0(root) groups=0(root)
# uid=0 ALWAYS means root, regardless of what the username is called
```

### 🎯 Interview Point
> `uid=0` means root. The username can be anything, but UID=0 = root-level privilege. This is why you should check `id` rather than trusting the username alone. Also: **a user doesn't need to re-login for `usermod -aG` group changes to take effect in new shells**, but existing shell sessions must `newgrp` or log out and back in.

---

## 🔹 `sudo` / `visudo`

### How `sudo` Works Internally
```
User types: sudo systemctl restart nginx
  └─► sudo binary executes (it has SUID bit set, runs as root)
        └─► Reads /etc/sudoers and /etc/sudoers.d/* files
              └─► Checks: is this user/group allowed to run this command?
                    └─► If YES → prompts for USER's password (not root's)
                          └─► On success → forks and executes command as root
                                └─► Logs entire event to /var/log/auth.log (or secure)
                    └─► If NO → logs failed attempt + exits with error
```

```bash
sudo command                        # run as root
sudo -u username command            # run as specific user
sudo -i                             # interactive root shell (loads root's environment)
sudo -s                             # root shell (keeps current environment)
sudo -l                             # list what you're allowed to sudo
sudo !!                             # re-run last command with sudo (very useful!)
```

```bash
$ sudo -l
# Output:
# User ec2-user may run the following commands on prod-server:
#     (ALL : ALL) ALL
# Explanation: This user can run ANY command as ANY user — effectively root access
# Better practice: restrict to specific commands

# Example of restricted sudoers entry (in /etc/sudoers.d/developer):
# developer ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx, /usr/bin/systemctl status nginx
# This user can only restart/check nginx, nothing else
```

### `visudo` — Safe sudoers Editing
```bash
visudo                                    # edit /etc/sudoers with syntax validation
visudo -f /etc/sudoers.d/myapp            # edit a specific sudoers file
```

**Why you MUST use `visudo` (never `vi /etc/sudoers`):**
- `visudo` **validates syntax before saving**
- A syntax error in `/etc/sudoers` with a regular editor = **permanent root lockout**
- Recovery requires booting into rescue/single-user mode
- `visudo` prevents this catastrophic mistake

### Real-World DevOps Scenario
**Principle of least privilege** — give a CI/CD service account only what it needs:
```bash
visudo -f /etc/sudoers.d/cicd-deploy
# Add this content:
cicd-user ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart myapp, \
                               /usr/bin/systemctl reload nginx, \
                               /usr/bin/systemctl status myapp
# Now cicd-user can only restart specific services, nothing else
```

---

## 🔹 `su` — Switch User

```bash
su username             # switch to user (keeps YOUR current environment vars)
su - username           # switch with FULL user environment (loads their .profile)
su -                    # switch to root with full root environment
su - -c "command"       # run single command as root
```

### 🎯 Interview Point
> `su username` vs `su - username`: Without `-`, you switch user but keep your current `$PATH`, `$HOME`, `$PWD`, etc. With `-`, you get a **full login shell** — their home directory, their PATH, their environment. When switching to root, **always use `su -`** to get the proper root environment. Using just `su` as root can lead to path issues where root commands aren't found.

### Summary — User & Group Management

**📌 5-Minute Recap:**
- **Never run applications as root** — create dedicated service accounts with `useradd -r -s /sbin/nologin`
- **`usermod -aG`** not `usermod -G` — the `-a` flag is critical; without it you lose all other groups
- **`uid=0` = root** — check `id` to verify actual privileges, not just username
- **`visudo` always** for sudoers edits — a syntax error in sudoers without visudo = permanent lockout
- **Principle of least privilege** — restrict `sudo` entries to specific commands, not `ALL`
- **`passwd -l`** to immediately lock a compromised account without deleting it
- **`sudo` logs everything** to `/var/log/auth.log` — essential for security auditing

---

# 4. Permissions & Ownership

## What Is This Section About?
Linux uses a discretionary access control model where every file and process has an **owner** and permissions define what **owner, group, and others** can do with each file. This is the core of Linux security.

---

## 🔹 `chmod` — Change Permissions

### Permission Architecture
```
File listing: -rwxr-xr--
              ││││││││││
              │└──┤ └──┤ └──┤
              │  u    g    o
              └── file type (- = file, d = dir, l = symlink)

Each group of 3 bits = rwx:
r = read    = 4
w = write   = 2  
x = execute = 1
- = no perm = 0

Examples:
rwx = 4+2+1 = 7
r-x = 4+0+1 = 5
r-- = 4+0+0 = 4
--- = 0
```

```bash
# Numeric (octal) mode:
chmod 755 script.sh          # rwxr-xr-x (owner=rwx, group=r-x, others=r-x)
chmod 644 config.txt         # rw-r--r-- (owner=rw-, group=r--, others=r--)
chmod 600 id_rsa             # rw------- (owner=rw-, no one else)
chmod 400 secret.key         # r-------- (owner=r only, no modification)
chmod 777 file               # rwxrwxrwx (everyone can do everything — dangerous!)

# Symbolic mode:
chmod u+x script.sh          # add execute for user (owner)
chmod go-w config             # remove write from group and others
chmod a+r file                # add read for ALL (user, group, others)
chmod u=rwx,g=rx,o=r file    # set explicit permissions

# Recursive:
chmod -R 755 /var/www/html/   # apply to directory and all contents
```

```bash
$ chmod 755 deploy.sh && ls -l deploy.sh
# Output: -rwxr-xr-x 1 ec2-user ec2-user 1024 Apr 17 deploy.sh
# Explanation:
# Owner (ec2-user): rwx = can read, write, execute
# Group: r-x = can read and execute, NOT write
# Others: r-x = can read and execute, NOT write
# This is correct for a deployment script that others need to run

$ chmod 600 ~/.ssh/id_rsa && ls -l ~/.ssh/id_rsa
# Output: -rw------- 1 ec2-user ec2-user 1679 Apr 17 id_rsa
# Explanation: Only owner can read/write. SSH REQUIRES this — it refuses to use 
# a private key that is too permissive. You'll get "Permissions too open" error.
```

**Common Permission Values Reference:**
| Mode | Symbolic | Description | Use Case |
|------|----------|-------------|----------|
| `644` | `-rw-r--r--` | Owner read/write, others read | Config files, HTML files |
| `755` | `-rwxr-xr-x` | Owner full, others read/execute | Scripts, binaries, directories |
| `700` | `-rwx------` | Owner only, full | Private scripts, SSH dir |
| `600` | `-rw-------` | Owner read/write only | SSH keys, password files |
| `400` | `-r--------` | Owner read-only | SSL private keys, secret files |
| `750` | `-rwxr-x---` | Owner full, group read/exec | Group-shared apps |
| `777` | `-rwxrwxrwx` | Everyone everything | ⚠️ NEVER in production |

### Special Permission Bits
```bash
# SUID (4xxx) — run as FILE OWNER, not the user who runs it
# Used by: /usr/bin/passwd (needs root to write /etc/shadow)
chmod 4755 binary         # or chmod u+s binary
ls -l /usr/bin/passwd
# Output: -rwsr-xr-x   ← the 's' in owner execute position = SUID

# SGID (2xxx) — run as FILE'S GROUP
# On directories: new files inherit the directory's group
chmod 2755 /shared/dir    # or chmod g+s /shared/dir

# Sticky Bit (1xxx) — on directories: only file owner can delete their own files
# Used on /tmp — you can create files, but can't delete other users' files
chmod 1777 /tmp           # or chmod +t /tmp
ls -ld /tmp
# Output: drwxrwxrwt   ← the 't' = sticky bit
```

### 🎯 Interview Point
> **Three special permission bits:**
> - **SUID** (`s` in owner execute): Binary runs as the FILE'S owner (not executor). `/usr/bin/passwd` uses SUID to write to `/etc/shadow` (which is root-owned).
> - **SGID** (`s` in group execute): On files = runs as file's group. On directories = new files inherit directory's group ownership.
> - **Sticky Bit** (`t` in others execute): On directories = users can only delete their OWN files (protects `/tmp`).

---

## 🔹 `chown` / `chgrp`

```bash
chown owner file                  # change owner
chown owner:group file            # change owner AND group
chown :group file                 # change only group
chown -R owner:group directory/   # recursive ownership change
```

```bash
$ chown -R nginx:nginx /var/www/html/
$ ls -lah /var/www/html/
# Output:
# -rw-r--r-- 1 nginx nginx 1024 Apr 17 index.html
# drwxr-xr-x 2 nginx nginx 4096 Apr 17 assets/
# Explanation: All files now owned by nginx user and group
# nginx process (running as nginx user) can now read and write these files

$ chown appuser:appuser /opt/myapp/config.yml
# Only the appuser can read their own config — other users can't see it
```

---

## 🔹 `umask`

### What It Does
`umask` defines which permission bits are **masked out** (removed) from newly created files and directories. It's a filter applied at file creation time.

```
How umask works:

New file default:    666 (rw-rw-rw-)
umask:             - 022 (----w--w-)
Result:              644 (rw-r--r--)

New directory default: 777 (rwxrwxrwx)
umask:               - 022
Result:                755 (rwxr-xr-x)
```

```bash
umask             # show current umask value
umask 022         # set umask (standard: others can read but not write)
umask 027         # more restrictive: group can read, others get nothing
umask 077         # very restrictive: only owner gets any access

# Make permanent for all users:
echo "umask 027" >> /etc/profile.d/security.sh
```

---

## 🔹 `getfacl` / `setfacl` — Access Control Lists

### What ACLs Do
Standard Linux permissions only allow ONE owner, ONE group, and ONE "other" category. **ACLs extend this** to allow specific users or groups to have different permissions on a file — without changing ownership.

```bash
getfacl filename                           # view all ACL entries
setfacl -m u:username:rwx filename        # grant user rwx
setfacl -m g:groupname:rx filename        # grant group rx
setfacl -x u:username filename            # remove user's ACL entry
setfacl -R -m u:username:rx /directory    # recursive
setfacl -b filename                       # remove ALL ACL entries
```

```bash
$ setfacl -m u:developer:rw /var/log/app/app.log
$ getfacl /var/log/app/app.log
# Output:
# # file: app.log
# # owner: appuser
# # group: appgroup
# user::rw-           ← owner's permissions
# user:developer:rw-  ← ACL entry: developer can read/write
# group::r--          ← group's permissions
# mask::rw-           ← maximum effective permissions for ACL entries
# other::---          ← others get nothing
#
# Explanation: The developer user can now read/write the log file
# WITHOUT changing the file's owner or group — clean and auditable
```

### Real-World DevOps Scenario
**Prometheus monitoring** needs to read an application log file without changing ownership:
```bash
setfacl -m u:prometheus:r /var/log/myapp/app.log
# Now prometheus can read the log, but ownership stays as appuser:appgroup
# This is cleaner than chown or adding prometheus to appgroup
```

---

## 🔹 `chattr` / `lsattr`

### What Extended Attributes Do
These are **kernel-level file attributes** that go beyond standard permissions. Even `root` cannot modify an immutable file — the attribute must be removed first.

```bash
chattr +i filename     # immutable: cannot be deleted, renamed, linked, or modified
chattr -i filename     # remove immutable flag
chattr +a filename     # append-only: can only add data, never overwrite or delete
chattr -a filename     # remove append-only flag
lsattr filename        # list extended attributes
lsattr -R /directory   # recursive list
```

```bash
$ chattr +i /etc/resolv.conf
$ rm /etc/resolv.conf
# Output: rm: cannot remove '/etc/resolv.conf': Operation not permitted
# Explanation: Even as root, you cannot delete an immutable file
# This is great for: DNS config on servers where cloud-init keeps overwriting it

$ lsattr /etc/resolv.conf
# Output: ----i----------- /etc/resolv.conf
# The 'i' flag confirms it's immutable

$ chattr +a /var/log/audit/audit.log
# Now audit.log can ONLY be appended to — no overwriting, no truncating
# Even if an attacker gets root, they can't erase the audit trail
```

### 🎯 Interview Point
> `chattr +i` makes a file **immutable even from root**. This is used to protect critical files like `/etc/passwd`, DNS configs, and audit logs. The attribute is stored in the filesystem inode and can only be changed by root with `chattr -i`. It's a defense-in-depth measure.

### Summary — Permissions & Ownership

**📌 5-Minute Recap:**
- **`chmod 755` for scripts/dirs, `chmod 644` for files, `chmod 600` for private keys** — know these cold
- **`777` is never acceptable in production** — it means everyone can modify and execute
- **SSH key permissions MUST be `600`** — SSH will refuse a private key that's too permissive
- **SUID, SGID, Sticky bit** are special cases: SUID for privilege escalation tools, sticky bit for `/tmp`
- **`setfacl`** when you need fine-grained access beyond owner/group/others model
- **`chattr +i`** for immutability — even root can't modify; used to protect critical system files
- **`umask 027`** in production environments prevents new files from being world-readable

---

# 5. Process & Job Management

## What Is This Section About?
Every running program on Linux is a **process**. Understanding how to view, control, signal, and manage processes is fundamental to DevOps work — especially when services misbehave, consume too many resources, or need to be safely restarted.

## Internal Architecture
```
User starts process → fork() → exec() → kernel assigns PID
  └─► Process added to kernel's process table
        └─► Scheduler assigns CPU time (based on priority/nice value)
              └─► Process runs in user space
                    └─► Makes system calls to access kernel resources
                          └─► Exits → parent must call wait() to clean up
```

---

## 🔹 `ps` — Process Status

### Key Flags and Their Meanings
```bash
ps aux               # all processes, all users, detailed (BSD style)
ps -ef               # all processes, full format (POSIX style, shows PPID)
ps -u username       # processes owned by specific user
ps -p 1234           # process with specific PID
ps aux --sort=-%mem  # sort by memory usage (highest first)
ps aux --sort=-%cpu  # sort by CPU usage (highest first)
ps -o pid,ppid,user,comm  # custom output columns
```

```bash
$ ps aux | head -5
# Output:
# USER    PID  %CPU %MEM    VSZ   RSS TTY STAT START   TIME COMMAND
# root      1   0.0  0.1 169984  7120 ?   Ss   Apr15   0:03 /usr/lib/systemd/systemd
# root      2   0.0  0.0      0     0 ?   S    Apr15   0:00 [kthreadd]
# nginx  1234   0.5  1.2  45000 12000 ?   S    10:00   0:15 nginx: worker process
# app    5678   2.1  8.0 850000 82000 ?   Sl   09:00   5:22 java -jar app.jar

# Column Breakdown:
# USER = who owns the process
# PID = Process ID (unique identifier for this process)
# %CPU = CPU utilization percentage
# %MEM = Physical memory utilization percentage
# VSZ = Virtual memory size in KB (includes memory not yet allocated)
# RSS = Resident Set Size — actual physical RAM in use (more meaningful than VSZ)
# TTY = terminal (?  = no terminal, daemon process)
# STAT = process state:
#   R = Running (actively using CPU right now)
#   S = Sleeping (waiting for an event, interruptible)
#   D = Uninterruptible sleep (waiting for I/O — CANNOT be killed with SIGKILL!)
#   Z = Zombie (finished but parent hasn't called wait() yet)
#   T = Stopped (paused, by Ctrl+Z or SIGSTOP)
#   I = Idle kernel thread
# START = when process started
# TIME = total CPU time consumed
# COMMAND = the command + arguments
```

### 🎯 Interview Point
> **`ps aux` vs `ps -ef`**: Both show all processes. `aux` is BSD-style (no dash), shows `%CPU`, `%MEM`, `VSZ`, `RSS`. `-ef` is POSIX-style (with dash), shows `PPID` (parent process ID) which is useful for understanding process relationships. Neither requires root — any user can see all processes.

---

## 🔹 `top` / `htop`

### `top` — Real-Time Process Monitor
```bash
top                  # launch interactive monitor
top -u username      # filter by user
top -p 1234,5678     # monitor specific PIDs
top -d 1             # update every 1 second (default is 3)
top -b -n 1          # batch mode: one snapshot, no interaction (for scripting/cron)
```

**Interactive keys inside `top`:**
| Key | Action |
|-----|--------|
| `P` | Sort by CPU usage |
| `M` | Sort by memory usage |
| `T` | Sort by running time |
| `1` | Toggle individual CPU core view |
| `k` | Kill a process (prompts for PID and signal) |
| `r` | Renice (change priority of a process) |
| `u` | Filter by username |
| `q` | Quit |
| `f` | Add/remove columns |

```bash
$ top -b -n 1 | head -20
# Output:
# top - 18:00:01 up 5 days, 3:22, load average: 0.52, 0.48, 0.45
# Tasks: 142 total,   2 running, 140 sleeping,  0 stopped,  0 zombie
# %Cpu(s): 15.2 us,  2.1 sy,  0.0 ni, 81.2 id,  1.5 wa,  0.0 hi,  0.0 si
# MiB Mem :   7946.8 total,   1234.5 free,   5100.2 used,   1612.1 buff/cache
# PID  USER    PR  NI    VIRT    RES    SHR S  %CPU  %MEM   TIME+ COMMAND
# 5678 appuser 20   0  850000  82000  12000 R  15.2   8.0   5:22.01 java
#
# Reading the header:
# "us" = user space CPU%, "sy" = kernel CPU%, "id" = idle%, "wa" = I/O wait%
# "wa" high = disk I/O bottleneck, NOT CPU bottleneck!
# Load average: 0.52, 0.48, 0.45 = last 1min, 5min, 15min
# On 4-core system: load 4.0 = 100% utilized; load > 4 = overloaded
```

### `htop` — Enhanced Monitor
```bash
htop                  # colorful, mouse-enabled, easier to use
htop -u username      # filter by user
```

`htop` shows CPU bars per core, memory bars, swap usage, and supports mouse-click killing. It's better for human use; `top -b` is better for scripting.

---

## 🔹 `kill` / `pkill`

### Signal Architecture
When you kill a process, you're sending a **signal** — a software interrupt. The process handles it based on its signal handlers (or the default kernel behavior).

```bash
kill PID              # send SIGTERM (15) — graceful shutdown request
kill -15 PID          # explicit SIGTERM — please shut down gracefully
kill -9 PID           # SIGKILL — force kill (kernel removes from process table)
kill -1 PID           # SIGHUP — reload configuration (nginx, sshd, etc.)
kill -l               # list all available signals
```

**Key Signal Reference:**
| Signal | Number | Meaning | Can Process Ignore? |
|--------|--------|---------|---------------------|
| SIGHUP | 1 | Hang up / reload config | Yes (can handle) |
| SIGINT | 2 | Ctrl+C interrupt | Yes (can handle) |
| SIGKILL | 9 | Force kill | **NO** — cannot be caught, blocked, or ignored |
| SIGTERM | 15 | Graceful terminate | Yes (can handle, do cleanup) |
| SIGSTOP | 19 | Pause process | **NO** — cannot be ignored |
| SIGCONT | 18 | Continue paused process | — |

```bash
$ kill -15 5678    # try graceful first
# Wait 5-10 seconds...
$ kill -9 5678     # force kill if graceful didn't work
# IMPORTANT: -9 is a last resort. It bypasses cleanup:
# - Open files may not be properly closed
# - Network connections may not be gracefully terminated
# - Temporary files may be left behind
# - Databases may be left in inconsistent state

$ kill -1 $(pgrep nginx)    # reload nginx config
# This sends SIGHUP to nginx master process
# nginx re-reads config without stopping — zero downtime reload
```

```bash
# pkill — kill by name (instead of PID)
pkill nginx                   # send SIGTERM to all processes named "nginx"
pkill -9 java                 # force kill all java processes
pkill -HUP nginx              # send SIGHUP (reload) to nginx
pkill -KILL -u baduser        # kill ALL processes owned by baduser
pkill -x "nginx"              # exact name match (vs pkill nginx which matches "nginx-worker" too)
```

### 🎯 Interview Point
> **`kill -9` vs `kill -15`**: Always try `kill -15` (SIGTERM) first — it allows the process to do cleanup (close files, flush buffers, graceful shutdown). `kill -9` (SIGKILL) is handled by the **kernel**, not the process — the process has no chance to clean up. Use `-9` only when the process is hung and not responding to SIGTERM.

---

## 🔹 `jobs` / `fg` / `bg`

```bash
# Concepts:
# Background job (&) = runs without blocking your terminal
# Foreground job = takes over your terminal
# Stopped job = paused (Ctrl+Z)

sleep 100 &          # start in background ([1] 12345 — job number, PID)
jobs                 # list all background/stopped jobs
fg                   # bring most recent background job to foreground
fg %1                # bring job number 1 to foreground
bg                   # resume most recently stopped job in background
bg %2                # resume job 2 in background
Ctrl+Z               # stop (pause) the currently running foreground job
```

```bash
$ sleep 100 &
# Output: [1] 12345   ← [job_number] PID

$ jobs
# Output:
# [1]+ Running    sleep 100 &
# [2]- Stopped    vim config.txt

$ fg %1
# Brings sleep 100 to foreground
# Press Ctrl+Z to stop it again
# Output: [1]+ Stopped   sleep 100

$ bg %1
# Resumes it in background
# Output: [1]+ sleep 100 &
```

---

## 🔹 `nohup`

### What It Does
`nohup` makes a process immune to the **SIGHUP signal** that's sent when you close a terminal. Normally, when you log out, the kernel sends SIGHUP to all processes in your session, killing them. `nohup` prevents this.

```bash
nohup command &                                  # run immune to hangup
nohup ./deploy.sh > /var/log/deploy.log 2>&1 &   # with explicit log file
echo "Process PID: $!"                           # $! captures the last background PID
```

```bash
$ nohup python3 app.py > /var/log/app.log 2>&1 &
# [1] 12345
# Output: nohup: ignoring input and appending output to 'nohup.out'
# (unless you redirect output explicitly as shown above)

# The & puts it in background
# Now you can safely close the terminal — app.py keeps running
# Find it later with: ps aux | grep app.py
# Or check PID: cat /var/log/app.log
```

### Real-World DevOps Scenario
```bash
# Start a multi-hour database migration that must survive SSH disconnection
nohup python3 db_migration.py \
  --source old-db.com \
  --target new-db.com \
  > /var/log/migration-$(date +%F).log 2>&1 &

echo "Migration started with PID: $!"
echo "Monitor with: tail -f /var/log/migration-$(date +%F).log"
```

---

## 🔹 `nice` / `renice`

### What Process Priority Means
Linux scheduler gives each process CPU time based on **priority**. The `nice` value ranges from **-20 (highest priority)** to **+19 (lowest priority)**. Default is 0. Think of it as "how nice to other processes" — a nicer process gives more CPU time to others.

```bash
nice -n 15 ./backup.sh          # run with low priority (nice to others)
nice -n -5 ./critical.sh        # run with higher priority (needs root for negative)
sudo nice -n -10 ./important    # root required for negative nice values

renice +10 -p 1234              # lower priority of RUNNING process
renice -5 -p 1234               # raise priority (requires root)
renice +15 -u username          # lower priority of ALL processes by a user
```

```bash
# Check nice value of a process:
ps -o pid,ni,comm -p 1234
# Output:
#  PID  NI COMMAND
# 1234  15 backup.sh   ← nice value is +15 (low priority)
```

### Real-World DevOps Scenario
Running a database backup during business hours — don't let it starve the app:
```bash
# Run backup at nice +15 so app processes always get CPU priority over the backup
nice -n 15 tar -czf /backup/db-$(date +%F).tar.gz /var/lib/mysql/
```

---

## 🔹 `lsof` — List Open Files

### What It Does
In Linux, **everything is a file** — regular files, directories, sockets, pipes, devices. `lsof` lists ALL open file descriptors for all processes. Invaluable for debugging "file in use" errors and "port already in use" situations.

```bash
lsof                         # ALL open files (huge output, pipe to grep)
lsof -p 1234                 # all files opened by PID 1234
lsof -u username             # all files opened by a user
lsof -i :80                  # processes using port 80
lsof -i tcp                  # all TCP connections
lsof -i 4                    # IPv4 only
lsof /path/to/file           # what processes have THIS file open
lsof +D /directory           # all files open within a directory
lsof -c nginx                # all files opened by processes named "nginx"
```

```bash
$ lsof -i :443
# Output:
# COMMAND  PID   USER   FD  TYPE  NODE NAME
# nginx   1234  nginx   6u  IPv4  TCP  *:https (LISTEN)
# Explanation: nginx is listening on port 443
# The 'u' in FD means read+write; 6 is the file descriptor number

$ lsof /var/log/app/app.log
# Output:
# COMMAND  PID     USER  FD TYPE  NODE NAME
# java    5678  appuser  20w REG  /var/log/app/app.log
# Explanation: The java process has app.log open for writing (w)
# If you delete this file, the process keeps writing to the DELETED file
# Free space won't show up until the process is restarted!
# Fix: truncate instead of delete: > /var/log/app/app.log

$ lsof -i :8080
# Error case: Address already in use
# Output: shows which process is on 8080 so you can kill it or change your app's port
```

### 🎯 Interview Point
> If `df -h` shows disk is full but `du -sh /*` doesn't account for all the space, a **deleted file that's still open** by a running process is likely the cause. `lsof | grep deleted` will find it. The file system space won't be released until the process closes the file handle. Solution: restart the process or truncate the file.

### Summary — Process & Job Management

**📌 5-Minute Recap:**
- **`ps aux --sort=-%mem`** finds memory hogs; **`ps -ef`** shows parent-child relationships
- **Always `kill -15` before `kill -9`** — give processes a chance to clean up
- **`kill -9` is the last resort** — it's handled by the kernel, processes get no cleanup chance
- **`D` state processes** cannot be killed even with `-9` — they're waiting for I/O at the kernel level
- **`Z` (zombie) processes** are dead but not reaped — kill the parent to clean them up
- **`nohup ... &`** for long-running jobs that must survive SSH disconnection
- **`nice -n 15`** for batch jobs during business hours — prevents them from impacting production
- **`lsof -i :port`** is the fastest way to find what's using a port in production

---

# 6. System Monitoring & Performance

## What Is This Section About?
System monitoring is how you understand what your Linux server is doing — how much CPU, memory, disk I/O, and network bandwidth is being used, and which processes are responsible. This is the foundation of performance engineering and incident response.

---

## 🔹 `iostat`

### What It Measures
`iostat` reports **CPU statistics** and **I/O statistics** for disks. From the `sysstat` package.

```bash
iostat 1 5              # report every 1 second, 5 times
iostat -x               # extended stats (most useful)
iostat -d /dev/sda 1    # specific device only
iostat -xz 1            # extended stats, omit zero-activity devices
```

```bash
$ iostat -x 1 3
# Output:
# Device   r/s   w/s  rKB/s  wKB/s  await  svctm  %util
# xvda    10.2  25.5  512.0 1024.0   5.21   0.84  45.2
# xvdb     0.5 150.0   20.0 6000.0  85.32   2.10  98.5  ← !
#
# Key columns:
# r/s, w/s = reads/writes per second (IOPS)
# rKB/s, wKB/s = KB read/written per second (throughput)
# await = average I/O wait time in milliseconds
#   - SSD: <1ms normal, <5ms acceptable, >10ms concerning
#   - HDD: <10ms normal, >20ms concerning
# %util = disk utilization percentage
#   - xvdb at 98.5% = disk is SATURATED = bottleneck!
#   - At 100%, no I/O requests can proceed immediately = queue builds up
```

### 🎯 Interview Point
> **`%util` near 100%** means the disk is saturated — the bottleneck. **High `await`** means I/O requests are waiting long. High CPU `wa` (I/O wait) in `top`/`iostat` means processes are blocked waiting for disk, NOT that the CPU is busy — this is a critical distinction.

---

## 🔹 `vmstat`

```bash
vmstat 1 5        # stats every 1 second, 5 times
vmstat -S M 1     # in megabytes
vmstat -d         # disk stats
vmstat -s         # summary totals
```

```bash
$ vmstat 1 5
# Output:
# procs ----memory---- ---swap-- ---io--- --system-- ------cpu-----
#  r  b  swpd  free  buff  cache  si so  bi   bo  in   cs us sy id wa
#  1  0     0 1200M 100M  2500M   0  0  12   25 500 1200 15  3 80  2
#
# Column meanings:
# r = processes waiting for CPU (run queue — if > number of CPUs, overloaded)
# b = processes in uninterruptible sleep (waiting for I/O)
# swpd = virtual memory used (swap) — if non-zero, you're using swap
# si/so = swap in/out KB/s — if consistently non-zero, SERIOUS memory pressure
# bi/bo = block input/output (disk reads/writes)
# us/sy/id/wa = user/system/idle/wait CPU percentages
```

### 🎯 Interview Point
> If `si` and `so` (swap in/out) are **constantly non-zero** in vmstat, the server is under memory pressure and actively swapping. This dramatically degrades performance because disk I/O is 1000x slower than RAM. Immediate actions: identify memory-heavy processes with `ps aux --sort=-%mem`, consider adding more RAM, or optimize application memory usage.

---

## 🔹 `sar` — System Activity Reporter

```bash
sar 1 5             # CPU stats every 1 second, 5 times
sar -r 1 5          # memory stats
sar -n DEV 1 5      # network stats per interface
sar -b 1 5          # I/O stats
sar -q 1 5          # run queue / load stats
sar -f /var/log/sa/sa17    # read HISTORICAL data from date 17
```

```bash
# Investigate last night's performance incident:
sar -r -f /var/log/sa/sa16 | grep "03:00\|04:00"
# Output shows memory utilization between 3am and 4am last night
# Perfect for post-incident analysis
```

---

## 🔹 `iotop` — Per-Process I/O Monitor

```bash
sudo iotop           # interactive I/O monitor
sudo iotop -o        # show only processes CURRENTLY doing I/O
sudo iotop -b -n 3   # batch mode, 3 iterations (for logging)
```

```bash
$ sudo iotop -o
# Output:
# Total DISK READ: 50.00 K/s | Total DISK WRITE: 200.00 M/s
# TID  PRIO  USER     DISK READ  DISK WRITE  COMMAND
# 5678  be/4  mysql     0.00 B/s  180.00 M/s  mysqld   ← heavy writer!
# 1234  be/4  appuser   50.00 K/s  20.00 M/s  java
#
# Explanation: MySQL is writing 180MB/s — that's why disk is saturated
```

---

## 🔹 `strace` — System Call Tracer

### What It Does
`strace` intercepts and records all **system calls** made by a process. System calls are the only way a user-space program interacts with the kernel (file operations, network, memory, etc.).

```bash
strace command                      # trace from start
strace -p PID                       # attach to running process
strace -e open,read,write command   # trace only specific syscalls
strace -f command                   # follow child processes too
strace -c command                   # summary: count and time of each syscall
strace -o /tmp/trace.txt command    # output to file
```

```bash
$ strace -e openat myapp 2>&1 | grep config
# Output:
# openat(AT_FDCWD, "/etc/app/config.yml", O_RDONLY) = -1 ENOENT (No such file)
# openat(AT_FDCWD, "/etc/app/config.json", O_RDONLY) = -1 ENOENT (No such file)
# Explanation: App is looking for config files that don't exist
# This is why it's failing — the config file is in the wrong location!

$ strace -c nginx 2>&1
# Output:
# % time   seconds  usecs/call   calls  syscall
#  45.32    0.001234        1    1234  read
#  30.12    0.000820        2     410  write
#   5.23    0.000142       14      10  openat
# Explanation: read() dominates — this process is I/O bound on reads
```

### Real-World DevOps Scenario
**App crashes with "permission denied" but you can't find which file:**
```bash
strace -e openat,read ./myapp 2>&1 | grep -E "EPERM|EACCES|ENOENT"
# Output:
# openat(AT_FDCWD, "/var/data/store", O_RDWR) = -1 EACCES (Permission denied)
# Now you know EXACTLY which file is causing the permission issue
```

---

## 🔹 `free`

```bash
free -h     # human-readable (MB, GB)
free -m     # in megabytes
free -g     # in gigabytes
free -s 2   # update every 2 seconds
```

```bash
$ free -h
# Output:
#               total   used   free  shared  buff/cache  available
# Mem:           7.8G   5.1G   234M    512M        2.4G       1.9G
# Swap:          2.0G   100M   1.9G
#
# CRITICAL INTERPRETATION:
# "free" column = completely unused RAM
# "buff/cache" = memory used by kernel for disk caching (can be reclaimed if needed)
# "available" = free + reclaimable cache = what apps CAN actually use
#
# NEW ENGINEERS MISTAKE: seeing "free: 234M" and panicking
# CORRECT VIEW: "available: 1.9G" = 1.9GB is available for new processes
# Linux intentionally uses all RAM for cache — "unused RAM is wasted RAM"
```

### 🎯 Interview Point
> The `available` column in `free -h` is the **real number to watch**, not `free`. Linux uses unused RAM as disk cache (faster reads). This cache is automatically reclaimed when apps need RAM. Alarming on `free` being low is a common mistake — look at `available` instead.

### Summary — System Monitoring & Performance

**📌 5-Minute Recap:**
- **CPU spike**: Use `top` → `P` to sort by CPU → identify process → `strace -p PID -c` to profile
- **Memory issue**: Check `free -h` (look at `available`), then `ps aux --sort=-%mem`, check swap with `vmstat`
- **Disk I/O bottleneck**: `iostat -x 1` → check `%util` and `await` per device → `iotop -o` for process-level
- **`wa%` in top is I/O wait** — processes blocked on disk, NOT CPU busy — very different problems
- **`sar` is for historical analysis** — can investigate incidents from yesterday with `-f` flag
- **`strace` is the ultimate debugging tool** — shows exactly what system calls an app is making
- **Swap `si/so` non-zero** = memory pressure crisis — find and fix memory-hungry processes immediately

---

# 7. Disk & Filesystem Management

## What Is This Section About?
Managing disks and filesystems is foundational infrastructure work. You'll add storage, format drives, mount filesystems, check usage, and troubleshoot space issues. Cloud engineers do this constantly with EBS volumes, persistent volumes, and NFS mounts.

---

## 🔹 `lsblk` / `blkid`

```bash
lsblk               # list block devices in tree format
lsblk -f            # include filesystem type and UUID
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT,UUID  # custom columns
```

```bash
$ lsblk
# Output:
# NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
# xvda     202:0    0   20G  0 disk
# ├─xvda1  202:1    0    1G  0 part /boot
# └─xvda2  202:2    0   19G  0 part /
# xvdb     202:16   0  100G  0 disk           ← unformatted new EBS volume
#
# Explanation: xvda is the root disk with boot and root partitions
# xvdb is attached but not yet partitioned or mounted — needs setup

$ blkid
# Output:
# /dev/xvda1: UUID="abc-123-def" TYPE="ext4" PARTUUID="xyz"
# /dev/xvda2: UUID="def-456-ghi" TYPE="xfs"
# Explanation: Shows UUID (stable across reboots) and filesystem type
# ALWAYS use UUID in /etc/fstab, not device names (device names can change on reboot!)
```

---

## 🔹 `fdisk` / `parted`

```bash
fdisk -l              # list all disk partitions
fdisk /dev/xvdb       # interactive partitioner for MBR disks
parted -l             # list with GPT/MBR info
parted /dev/xvdb mklabel gpt && parted /dev/xvdb mkpart primary ext4 0% 100%  # non-interactive
```

```bash
# Inside fdisk interactive mode:
# n = new partition
# p = primary partition
# 1 = partition number
# Return, Return = accept defaults (full disk)
# w = write partition table and exit
```

### Full EBS Volume Setup Workflow (AWS EC2):
```bash
# 1. See the new unpartitioned disk
lsblk
# xvdb  202:16  0  100G  0 disk

# 2. Create partition
fdisk /dev/xvdb    # n, p, 1, enter, enter, w

# 3. Notify kernel of new partition table
partprobe /dev/xvdb

# 4. Create filesystem
mkfs.ext4 /dev/xvdb1    # or mkfs.xfs for XFS

# 5. Create mount point
mkdir -p /data

# 6. Get UUID for fstab entry
UUID=$(blkid -s UUID -o value /dev/xvdb1)

# 7. Add to /etc/fstab (persistent mount)
echo "UUID=$UUID /data ext4 defaults 0 2" >> /etc/fstab

# 8. Mount it
mount /data

# 9. Verify
df -h /data
# Output: /dev/xvdb1  100G  61M  100G   1% /data
```

---

## 🔹 `mkfs` / `fsck`

```bash
mkfs.ext4 /dev/sdb1              # create ext4 filesystem
mkfs.xfs /dev/sdb1               # create XFS filesystem (preferred for large files)
mkfs.ext4 -L "mydata" /dev/sdb1  # with a label

fsck /dev/sdb1                   # check filesystem (must be UNMOUNTED)
fsck -y /dev/sdb1                # auto-answer yes to all repair questions
fsck -n /dev/sdb1                # dry run — check only, don't repair
```

### ⚠️ Critical Rule
**NEVER run `fsck` on a mounted filesystem.** This can corrupt data. Always unmount first, or run `fsck` from rescue/live boot mode.

---

## 🔹 `mount` / `umount`

```bash
mount /dev/sdb1 /mnt/data             # mount block device
mount -t nfs server:/share /mnt/nfs   # NFS mount
mount -o ro /dev/sdb1 /mnt            # read-only mount
mount -o remount,rw /                 # remount root as read-write (rescue mode)
mount | column -t                     # show all current mounts formatted nicely
umount /mnt/data                      # unmount
umount -l /mnt/data                   # lazy unmount (when "target is busy")
```

```bash
$ mount | grep "/data"
# Output: /dev/xvdb1 on /data type ext4 (rw,relatime)
# Explanation: Shows device, mountpoint, filesystem type, and options

# "Device or resource busy" error:
umount /mnt/data
# umount: /mnt/data: target is busy
lsof +D /mnt/data    # find what has files open there
# Output shows PID and process — kill it or exit that directory, then umount
```

---

## 🔹 `df` / `du`

### `df` — Disk Free Space
```bash
df -h          # human-readable sizes
df -h /        # specific mount point
df -i          # inode usage (CRITICAL — running out of inodes prevents new files!)
df -T          # show filesystem type
```

```bash
$ df -h
# Output:
# Filesystem      Size  Used Avail Use% Mounted on
# /dev/xvda1       20G   15G  4.2G  79% /
# /dev/xvdb1      100G   45G   55G  45% /data
# tmpfs           3.9G    0   3.9G   0% /dev/shm
#
# If Use% is 100% on / but du -sh doesn't account for it:
df -i /
# Output:
# Filesystem     Inodes  IUsed  IFree IUse% Mounted on
# /dev/xvda1    1310720 1310720     0  100% /    ← inodes exhausted!
# "No space left on device" error even though disk has GB free!
# Cause: millions of tiny files (often in /tmp or mail spools)
# Fix: find / -xdev -type f | wc -l  (find what's consuming inodes)
```

### `du` — Disk Usage
```bash
du -sh /path                  # total size of directory
du -sh *                      # size of each item in current directory
du -h --max-depth=1 /var      # one level deep under /var
du -sh /var/log/*              # size of each log directory
du -sh * | sort -rh | head -10 # top 10 largest items
```

```bash
$ du -sh /var/log/*
# Output:
# 4.0K  /var/log/auth.log
# 2.1G  /var/log/app.log    ← problem found!
# 100M  /var/log/nginx
# 
# Explanation: The app.log is 2.1GB — investigate and rotate/truncate
```

---

## 🔹 Swap Management

```bash
swapon --show             # show current swap devices
mkswap /swapfile          # prepare a file as swap
swapon /swapfile          # activate swap
swapoff /swapfile         # deactivate swap
```

### Real-World Scenario — Add Swap to RAM-Starved EC2:
```bash
# Create 4GB swap file
dd if=/dev/zero of=/swapfile bs=1G count=4 status=progress
# Output: 4294967296 bytes (4.3 GB) copied — shows progress

# Set correct permissions (swap file must be only root-accessible)
chmod 600 /swapfile

# Prepare as swap
mkswap /swapfile
# Output: Setting up swapspace version 1, size = 4 GiB

# Activate
swapon /swapfile

# Make permanent
echo "/swapfile none swap sw 0 0" >> /etc/fstab

# Verify
swapon --show
# Output:
# NAME      TYPE SIZE USED PRIO
# /swapfile file   4G   0B   -2
free -h   # Swap row now shows 4GB
```

### Summary — Disk & Filesystem Management

**📌 5-Minute Recap:**
- **`lsblk`** shows device tree; **`blkid`** shows UUIDs — always use UUID in `/etc/fstab`
- **Full workflow**: `fdisk` → `partprobe` → `mkfs` → `mkdir` → `blkid` → `/etc/fstab` → `mount`
- **`df -i`** for inode usage — "no space" with plenty of disk space = inode exhaustion
- **`du -sh * | sort -rh`** for finding what's consuming disk — drill down from root
- **Never `fsck` a mounted filesystem** — boot to rescue mode or unmount first
- **`resize2fs` after `growpart`** for expanding EBS volumes on AWS
- **Swap file** is a quick fix for RAM pressure — `dd if=/dev/zero` → `mkswap` → `swapon`

---

# 8. Compression & Archiving

## What Is This Section About?
Archiving combines multiple files into one; compression reduces file size. Both are essential for backups, deployments, and file transfers.

---

## 🔹 `tar`

### How tar Works
`tar` (Tape ARchive) was originally for writing to tape drives. Today it creates single archive files from multiple files/directories, optionally with compression.

**Memory trick for `tar` options: `-c`reate, e`-x`tract, `-t`able (list), `-v`erbose, `-f`ile**

```bash
# CREATE archives:
tar -cvf archive.tar files/              # create tar (no compression)
tar -czvf archive.tar.gz files/         # create + gzip compress (.tar.gz)
tar -cjvf archive.tar.bz2 files/        # create + bzip2 compress (.tar.bz2)
tar -cJvf archive.tar.xz files/         # create + xz compress (.tar.xz, best ratio)

# EXTRACT archives:
tar -xvf archive.tar                     # extract tar
tar -xzvf archive.tar.gz                 # extract gzip
tar -xvf archive.tar -C /target/dir/     # extract to specific directory

# LIST contents (without extracting):
tar -tvf archive.tar.gz

# Useful options:
tar --exclude='*.log' -czvf app.tar.gz /opt/app/    # exclude log files
tar --exclude='.git' -czvf code.tar.gz /opt/code/   # exclude .git directory
tar -czvf backup.tar.gz --newer-mtime="2026-04-01" /data/  # only newer than date
```

```bash
$ tar -czvf /backup/etc-$(date +%F).tar.gz /etc/
# Output:
# /etc/
# /etc/nginx/
# /etc/nginx/nginx.conf
# ... (listing each file as it's added)
# Explanation: Creates /backup/etc-2026-04-17.tar.gz with date in name

$ tar -tvf /backup/etc-2026-04-17.tar.gz | head -5
# Output:
# drwxr-xr-x root/root  0 2026-04-17 10:00 etc/
# -rw-r--r-- root/root 1234 2026-04-17 nginx.conf
# Explanation: Lists archive contents WITHOUT extracting — always verify before extract

$ tar -xzvf backup.tar.gz -C /restore/
# Extracts to /restore/ directory instead of current directory
# Explanation: -C changes directory before extracting — prevents accidentally extracting to /
```

---

## 🔹 `gzip` / `bzip2` / `xz`

### Compression Comparison
| Tool | Extension | Compression Speed | Compression Ratio | Best For |
|------|-----------|------------------|-------------------|----------|
| `gzip` | `.gz` | Fast | Moderate | General use, log archiving |
| `bzip2` | `.bz2` | Slower | Better | Source code, text |
| `xz` | `.xz` | Slowest | Best | Distribution packages |
| `lz4` | `.lz4` | Very fast | Low | Real-time compression |

```bash
gzip file.txt              # compress (replaces original with file.txt.gz)
gzip -k file.txt           # keep original file
gzip -d file.txt.gz        # decompress (same as gunzip)
gzip -9 file.txt           # maximum compression (slowest)
gzip -1 file.txt           # fastest compression (least compression)
gzip -l file.gz            # show compression ratio info
gunzip file.txt.gz         # decompress

bzip2 file.txt             # better compression than gzip but slower
bunzip2 file.txt.bz2

xz file.txt                # best compression ratio
xz -k file.txt             # keep original
unxz file.txt.xz
xz -9 file.txt             # maximum compression
```

---

## 🔹 `zip` / `7z`

```bash
zip archive.zip file1 file2     # create zip
zip -r archive.zip directory/   # recursive
zip -e secure.zip sensitive.txt # password encrypted
unzip archive.zip               # extract
unzip -l archive.zip            # list contents
unzip -t archive.zip            # test integrity

7z a archive.7z files/          # create 7zip (best compression)
7z e archive.7z                 # extract
7z a -p"password" secure.7z files/  # with password
```

---

## 🔹 `dd` — Low-Level Copy

### What It Does
`dd` (data duplicator) copies data at the **block level** — it is not filesystem-aware. It bypasses the filesystem entirely and works directly with raw bytes. This makes it uniquely powerful for disk imaging, wiping, swap file creation, and I/O benchmarking.

### Architecture Flow
```
dd if=/dev/sda of=/backup/disk.img
  └─► Open input file (if=) with read()
        └─► Read blocks of size bs= from input
              └─► Write blocks to output file (of=) with write()
                    └─► Repeat until count= reached or input exhausted
                          └─► No filesystem interpretation — pure raw bytes
```

### Syntax & Key Parameters
```bash
# Parameter meanings:
# if=  → input file  (source: device, file, /dev/zero, /dev/urandom, /dev/null)
# of=  → output file (destination: device, file)
# bs=  → block size (how many bytes to read/write at once: 512, 4K, 1M, 1G)
# count= → how many blocks to copy
# status=progress → show live progress (added in newer versions)
# oflag=direct → bypass OS write cache (important for accurate speed tests)
# oflag=sync  → sync after each write (ensures data is written to disk)
# conv=noerror → continue even if read errors occur (useful for bad disk recovery)
```

```bash
$ dd if=/dev/zero of=/tmp/testfile bs=1G count=1 oflag=direct
# Output:
# 1+0 records in
# 1+0 records out
# 1073741824 bytes (1.1 GB) copied, 2.456 s, 437 MB/s
# Explanation:
# "1+0 records in/out" = 1 full block transferred, 0 partial blocks
# 437 MB/s = disk write speed — this is your raw disk throughput benchmark
# oflag=direct bypasses OS cache so you measure REAL disk speed, not cache speed

$ dd if=/tmp/testfile of=/dev/null bs=1G
# Output:
# 1073741824 bytes (1.1 GB) copied, 0.421 s, 2.5 GB/s
# Explanation: Read speed is 2.5 GB/s — this is actually reading from page cache
# To test real disk read speed: drop caches first:
# echo 3 > /proc/sys/vm/drop_caches  (as root)
# Then run dd again

$ dd if=/dev/sda of=/backup/full-disk-$(date +%F).img bs=4M status=progress
# Output (live):
# 5368709120 bytes (5.4 GB) copied, 12 s, 447 MB/s
# Explanation: Creates a byte-for-byte image of /dev/sda
# This image captures EVERYTHING: partition table, bootloader, all partitions
# Can be restored with: dd if=full-disk.img of=/dev/sda bs=4M

$ dd if=/dev/urandom of=/dev/sdb bs=4M status=progress
# Explanation: Overwrites entire disk with random data
# This is a secure wipe — no data recovery possible
# /dev/urandom = kernel random number generator
# WARNING: This is irreversible and takes a long time on large disks

$ dd if=/dev/zero of=/swapfile bs=1G count=4 status=progress
# Output:
# 4294967296 bytes (4.3 GB) copied, 9.871 s, 435 MB/s
# Explanation: Creates a 4GB file of zeros = ready to be used as swap space
# Next steps: chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile
```

### ⚠️ The Most Dangerous Command in Linux
```bash
# CATASTROPHIC EXAMPLE — do NOT run:
dd if=/dev/sda of=/dev/sdb   # this is INTENDED: copy disk A to disk B

# ACCIDENTAL DISASTER — wrong argument order:
dd if=/dev/sdb of=/dev/sda   # this WIPES sda with contents of sdb!

# EVEN WORSE:
dd if=/dev/urandom of=/dev/sda   # this permanently destroys all data on sda

# SAFETY RULES:
# 1. Always double-check if= and of= before pressing Enter
# 2. Use status=progress so you can see what's happening
# 3. Test with a small count= first when unsure
# 4. Never run dd from memory or copy-paste — type it carefully every time
```

### Real-World DevOps Scenario
**Benchmarking a new EBS volume on AWS before putting it into production:**
```bash
# Step 1: Test raw write speed
dd if=/dev/zero of=/dev/xvdb bs=4M count=256 oflag=direct status=progress
# Output: 1073741824 bytes copied, 5.2 s, 207 MB/s
# For gp3 EBS: expect ~125-250 MB/s; io2: up to 1000 MB/s

# Step 2: Drop caches and test raw read speed
echo 3 > /proc/sys/vm/drop_caches
dd if=/dev/xvdb of=/dev/null bs=4M count=256 status=progress
# Output: 1073741824 bytes copied, 4.8 s, 224 MB/s

# Step 3: Compare to expected IOPS for instance type
# If speed is lower than expected, the volume type or instance limit may be wrong
```

---

## 🔹 `split`

### What It Does
`split` divides a large file into smaller pieces. Essential for transferring large files in parts, working around size limits, and parallel processing.

```bash
split -b 100M largefile.tar.gz part_          # split into 100MB chunks
split -l 1000 hugefile.txt chunk_             # split by line count (1000 lines each)
split -n 4 file parts_                        # split into exactly 4 equal parts
split --additional-suffix=.gz archive.tar.gz piece_  # keep original extension

# Reassemble:
cat part_* > restored_file.tar.gz             # concatenate in alphabetical order
# Verify integrity:
md5sum original.tar.gz
md5sum restored_file.tar.gz                   # should match exactly
```

```bash
$ split -b 500M large-backup.tar.gz backup_part_
$ ls -lah backup_part_*
# Output:
# -rw-r--r-- 1 ec2-user 500M Apr 17 backup_part_aa
# -rw-r--r-- 1 ec2-user 500M Apr 17 backup_part_ab
# -rw-r--r-- 1 ec2-user 234M Apr 17 backup_part_ac   ← last piece (smaller)
# Explanation: Files are named with alphabetical suffixes: aa, ab, ac, ad...
# Reassemble: cat backup_part_* > restored.tar.gz

# Real-world use: upload 5GB backup to S3 using multipart for reliability
split -b 500M backup.tar.gz backup_part_
for part in backup_part_*; do
    aws s3 cp "$part" "s3://mybucket/backups/$part"
    echo "Uploaded: $part"
done
```

### Summary — Compression & Archiving

**📌 5-Minute Recap:**
- **`tar -czvf`** creates, **`tar -xzvf`** extracts — the `z` flag means gzip compression
- **Always `tar -tvf`** to list contents before extracting — verify you're extracting what you think
- **Compression tradeoff**: `gzip` = fast; `bzip2` = better ratio; `xz` = best ratio but slowest
- **`dd`** works at the raw byte level — no filesystem awareness; perfect for disk imaging and wiping
- **`dd` is dangerous** — always verify `if=` and `of=` before running; wrong order destroys data
- **`status=progress`** in `dd` is essential — without it you have no feedback on a long operation
- **`split -b 500M`** for breaking large files into uploadable chunks; reassemble with `cat part_*`

---

# 9. Networking & Remote Access

## What Is This Section About?
Networking commands let you configure interfaces, test connectivity, transfer data, manage remote connections, analyze traffic, and troubleshoot network issues. In cloud environments, networking knowledge is critical — every microservice, database connection, and API call involves the network.

## Internal Architecture — Linux Network Stack
```
Application (curl, nginx, java)
  └─► Socket API (socket(), bind(), connect(), send(), recv())
        └─► Transport Layer: TCP / UDP
              └─► Network Layer: IP (routing, addressing)
                    └─► Link Layer: Ethernet frame
                          └─► Network Driver (e1000, virtio-net)
                                └─► Physical/Virtual NIC (eth0, ens3)
                                      └─► Wire / Virtual switch / VPC
```

---

## 🔹 `ip` / `ifconfig`

### `ip` — Modern Network Management (Preferred)
```bash
ip a                               # show ALL interfaces with IP addresses
ip -4 a                            # IPv4 addresses only
ip -6 a                            # IPv6 addresses only
ip a show eth0                     # specific interface details
ip link show                       # layer-2 link information (MAC, MTU, state)
ip route show                      # routing table
ip route add default via 10.0.1.1  # add default gateway
ip addr add 192.168.1.100/24 dev eth0  # add IP to interface
ip link set eth0 up                # bring interface up
ip link set eth0 down              # bring interface down
ip neigh show                      # ARP table (IP to MAC mappings)
ip netns list                      # list network namespaces (used by Docker)
```

```bash
$ ip a
# Output:
# 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
#     link/loopback 00:00:00:00:00:00
#     inet 127.0.0.1/8 scope host lo        ← loopback address
# 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 state UP
#     link/ether 02:ab:cd:ef:12:34 brd ff:ff:ff:ff:ff:ff  ← MAC address
#     inet 10.0.1.50/24 brd 10.0.1.255 scope global dynamic eth0  ← IP/subnet
#     inet6 fe80::ab:cdff:feef:1234/64 scope link  ← IPv6 link-local
#
# Reading this output:
# mtu 9001 = Maximum Transmission Unit (jumbo frames enabled on EC2)
# state UP = interface is active
# /24 = subnet mask (255.255.255.0) in CIDR notation
# scope global = routable from outside
# dynamic = IP assigned via DHCP (not static)

$ ip route show
# Output:
# default via 10.0.1.1 dev eth0 proto dhcp    ← default gateway for all traffic
# 10.0.1.0/24 dev eth0 proto kernel scope link ← local subnet (directly connected)
#
# Explanation: Any traffic not matching a specific route goes to 10.0.1.1 (gateway)
# Traffic to 10.0.1.0/24 goes directly out eth0 without a gateway
```

### `ifconfig` — Legacy (Still Common)
```bash
ifconfig                           # show all interfaces (legacy)
ifconfig eth0                      # specific interface
ifconfig eth0 up / down            # enable/disable
```

### 🎯 Interview Point
> `ifconfig` is from the deprecated `net-tools` package. `ip` from `iproute2` is the modern replacement. On any system from RHEL7/Ubuntu 16.04+, prefer `ip`. However, `ifconfig` still appears on older servers, embedded systems, and many exam questions — know both.

---

## 🔹 `ping` / `traceroute` / `mtr`

### `ping` — Test Basic Connectivity
```bash
ping hostname                   # continuous ping (Ctrl+C to stop)
ping -c 4 8.8.8.8              # send exactly 4 packets then stop
ping -c 4 -i 0.2 host          # send every 0.2 seconds (faster)
ping -s 1400 host              # test with large packet size (MTU testing)
ping -W 1 host                 # wait max 1 second per response
```

```bash
$ ping -c 3 8.8.8.8
# Output:
# PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
# 64 bytes from 8.8.8.8: icmp_seq=1 ttl=118 time=1.23 ms
# 64 bytes from 8.8.8.8: icmp_seq=2 ttl=118 time=1.15 ms
# 64 bytes from 8.8.8.8: icmp_seq=3 ttl=118 time=1.19 ms
# --- 8.8.8.8 ping statistics ---
# 3 packets transmitted, 3 received, 0% packet loss
# rtt min/avg/max/mdev = 1.15/1.19/1.23/0.033 ms
#
# Reading results:
# ttl=118 = Time To Live (starts at 128 for Windows, 64 for Linux)
#   each router hop decrements TTL by 1
#   118 means ~10 hops to reach 8.8.8.8
# time= = round-trip latency in milliseconds
# 0% packet loss = healthy connection
# mdev = mean deviation (jitter) — high value means inconsistent latency

# No response example:
$ ping -c 2 192.168.1.99
# Output:
# Request timeout for icmp_seq 0
# 2 packets transmitted, 0 received, 100% packet loss
# Could mean: host is down, ICMP blocked by firewall, or IP doesn't exist
```

### `traceroute` — Trace the Network Path
```bash
traceroute hostname              # trace route (uses UDP by default)
traceroute -n hostname           # numeric only (no DNS, faster)
traceroute -T hostname           # use TCP SYN (better for firewalled paths)
traceroute -p 80 hostname        # trace to specific port
```

```bash
$ traceroute 8.8.8.8
# Output:
# traceroute to 8.8.8.8 (8.8.8.8), 30 hops max
#  1  10.0.1.1     1.234 ms    ← your default gateway (router)
#  2  203.0.113.1  5.123 ms    ← ISP/cloud provider gateway
#  3  * * *                    ← firewall dropping traceroute packets (ICMP/UDP)
#  4  209.85.241.9 8.456 ms    ← Google network
#  5  8.8.8.8      9.123 ms    ← destination reached
#
# "* * *" means a router is not responding to traceroute probes
# This is NORMAL for many firewall-protected hops — doesn't mean the path is broken
# The fact that you reach 8.8.8.8 eventually proves the path works
```

### `mtr` — Real-Time Combined ping+traceroute
```bash
mtr hostname              # interactive real-time route analysis
mtr -n hostname           # no DNS lookups (faster)
mtr --report hostname     # single report output (good for sharing)
mtr -r -c 100 hostname    # 100-packet report
```

```bash
$ mtr --report 8.8.8.8
# Output:
# HOST: myserver               Loss%   Snt  Last   Avg  Best  Wrst StDev
#   1. 10.0.1.1                0.0%   100   1.2   1.2   1.1   1.5   0.1
#   2. 203.0.113.1             0.0%   100   5.1   5.2   4.9   8.1   0.5
#   3. ???                    100.0%  100   0.0   0.0   0.0   0.0   0.0  ← drops probes (normal)
#   4. 8.8.8.8                 0.0%   100   9.1   9.2   8.9  12.3   0.4
#
# Loss% column is the KEY insight:
# 100% loss at hop 3 but 0% loss at hop 4 = hop 3 drops probes but forwards traffic
# If you see 5% loss at hop 3 AND 5% loss at hop 4 = hop 3 has REAL packet loss
# mtr is the best tool for diagnosing intermittent network issues
```

### 🎯 Interview Point
> **`mtr` is superior to both `ping` and `traceroute`** for network diagnostics. It shows per-hop packet loss AND latency in real-time across 100+ packets. Key interpretation: **packet loss only matters at a hop if subsequent hops also show loss**. A hop showing 100% loss but the destination showing 0% loss means that hop simply doesn't respond to probes (firewall) but forwards traffic just fine.

---

## 🔹 `curl` / `wget`

### `curl` — Transfer Data to/from URLs
`curl` is the Swiss Army knife for HTTP operations in DevOps — API calls, health checks, file downloads, authentication testing.

```bash
curl URL                                         # GET request
curl -X POST URL -d '{"key":"value"}'            # POST with JSON body
curl -X POST URL -d "param=value"               # POST with form data
curl -H "Authorization: Bearer TOKEN" URL        # custom header
curl -H "Content-Type: application/json" URL     # content type header
curl -o filename URL                             # save to specific filename
curl -O URL                                      # save with original filename from URL
curl -L URL                                      # follow redirects (301/302)
curl -I URL                                      # HEAD request (headers only, no body)
curl -v URL                                      # verbose: show request + response headers
curl -s URL                                      # silent: no progress/errors
curl -f URL                                      # fail: return error on HTTP 4xx/5xx
curl --connect-timeout 5 URL                     # connection timeout in seconds
curl --max-time 30 URL                           # total timeout in seconds
curl -k URL                                      # ignore SSL certificate errors
curl -u user:pass URL                            # basic authentication
curl --retry 3 --retry-delay 2 URL              # retry on failure
```

```bash
$ curl -I https://google.com
# Output:
# HTTP/1.1 301 Moved Permanently
# Location: https://www.google.com/
# Content-Type: text/html
# Date: Fri, 17 Apr 2026 18:00:01 GMT
# Explanation: -I sends only a HEAD request — gets headers without downloading body
# 301 = permanent redirect to www.google.com
# Use -L to follow the redirect automatically

$ curl -o /dev/null -s -w "%{http_code}\n" http://localhost:8080/health
# Output: 200
# Explanation: -o /dev/null discards the body, -s silences progress output
# -w "%{http_code}" prints ONLY the HTTP status code
# This is the standard health check pattern in scripts and CI/CD pipelines

$ curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer eyJhbGc..." \
    -d '{"user":"alice","role":"admin"}' \
    https://api.example.com/users
# Output: {"id":123,"user":"alice","role":"admin","created":"2026-04-17"}
# Explanation: Full API call with headers, auth token, and JSON body
# This is how you interact with REST APIs from shell scripts
```

### Real-World DevOps Scenario
**CI/CD post-deployment health check:**
```bash
#!/bin/bash
set -e

APP_URL="http://localhost:8080"
MAX_RETRIES=10
SLEEP_BETWEEN=3

for i in $(seq 1 $MAX_RETRIES); do
    HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" \
                --connect-timeout 3 \
                --max-time 5 \
                "${APP_URL}/health")
    
    if [ "$HTTP_CODE" = "200" ]; then
        echo "Health check passed after $i attempts (HTTP $HTTP_CODE)"
        exit 0
    fi
    
    echo "Attempt $i/$MAX_RETRIES: HTTP $HTTP_CODE — waiting ${SLEEP_BETWEEN}s..."
    sleep $SLEEP_BETWEEN
done

echo "Health check FAILED after $MAX_RETRIES attempts"
exit 1
```

### `wget` — File Downloader
```bash
wget URL                                  # download file
wget -c URL                               # resume interrupted download
wget -O filename URL                      # save as specific name
wget --limit-rate=1m URL                  # limit download speed
wget -q URL                               # quiet mode
wget --user=user --password=pass URL      # authentication
wget -r -l2 --no-parent URL              # recursive download, 2 levels deep
```

```bash
$ wget -c https://releases.hashicorp.com/terraform/1.5.0/terraform_linux_amd64.zip
# Output:
# Connecting to releases.hashicorp.com...
# HTTP request sent, awaiting response... 200 OK
# Length: 22156245 (21M) [application/zip]
# Saving to: 'terraform_linux_amd64.zip'
# terraform_linux_amd64.zip  100%[================================>]  21.1M  5.00MB/s  in 4.2s
# Explanation: -c allows resuming if interrupted (reads Range header)
# Shows progress bar with speed and ETA by default
```

---

## 🔹 `ssh`

### How SSH Works Internally
```
Client (you)                          Server (remote)
    │                                       │
    ├─── TCP connection to port 22 ────────►│
    │◄── Server sends its host key ─────────┤
    │    (first time: add to known_hosts)   │
    ├─── Client verifies host key ──────────┤
    │    Key exchange (Diffie-Hellman)      │
    │◄──────── Encrypted channel ──────────►│
    │                                       │
    ├─── Authentication ────────────────────┤
    │    (password OR public key)           │
    │    For key auth:                      │
    │    Client proves it has private key   │
    │    that matches authorized_keys entry │
    │                                       │
    ├─── Encrypted shell session ──────────►│
```

```bash
ssh user@hostname                                   # basic connection
ssh -i ~/.ssh/key.pem ec2-user@54.1.2.3            # with private key file
ssh -p 2222 user@host                              # custom port (default is 22)
ssh -v user@host                                   # verbose (debug connection issues)
ssh user@host "command"                            # run single command, don't open shell
ssh user@host "df -h && free -h && uptime"         # run multiple commands
ssh -L 5432:rds.endpoint.com:5432 user@bastion -N  # local port forward (tunnel)
ssh -R 9090:localhost:3000 user@server             # remote port forward
ssh -D 1080 user@host                             # SOCKS5 proxy
ssh -N -f user@host -L 5432:rds:5432             # background tunnel (no shell)
```

### SSH Config File — Essential for Production
```bash
# ~/.ssh/config — define connection profiles

Host prod-web
    HostName 54.1.2.3
    User ec2-user
    IdentityFile ~/.ssh/prod-ec2-key.pem
    Port 22
    StrictHostKeyChecking yes

Host bastion
    HostName bastion.company.com
    User ubuntu
    IdentityFile ~/.ssh/bastion-key.pem
    ServerAliveInterval 60   # send keepalive every 60 seconds
    ServerAliveCountMax 3    # disconnect after 3 missed keepalives

Host internal-server
    HostName 10.0.1.50       # private IP — only reachable via bastion
    User ec2-user
    IdentityFile ~/.ssh/internal-key.pem
    ProxyJump bastion        # automatically hop through bastion host
```

```bash
# With config file:
ssh prod-web                  # instead of: ssh -i ~/.ssh/prod-ec2-key.pem ec2-user@54.1.2.3
ssh internal-server           # automatically jumps through bastion — no extra commands needed
```

```bash
$ ssh -L 5432:prod-db.cluster.us-east-1.rds.amazonaws.com:5432 ec2-user@bastion-host -N -f
# Explanation:
# -L 5432:rds-host:5432 = forward local port 5432 to rds-host:5432 via bastion
# -N = don't execute a remote command (tunnel only)
# -f = go to background after authentication
# After this: connect to "localhost:5432" to reach the private RDS database
# This is how DevOps engineers access private RDS from their laptops
```

### Common SSH Mistakes and Fixes
```bash
# Problem: "WARNING: UNPROTECTED PRIVATE KEY FILE!"
chmod 600 ~/.ssh/id_rsa
chmod 700 ~/.ssh/
# SSH refuses to use keys that are too permissive (readable by others)

# Problem: "Host key verification failed" (server changed)
ssh-keygen -R hostname          # remove old host key from known_hosts
# Or edit ~/.ssh/known_hosts and delete the offending line

# Problem: Connection keeps timing out
# Add to ~/.ssh/config:
ServerAliveInterval 30
ServerAliveCountMax 6
# Sends keepalive packets every 30 seconds — prevents idle disconnection
```

---

## 🔹 `scp` / `rsync`

### `scp` — Secure Copy
```bash
scp localfile user@host:/remote/path/          # upload file
scp user@host:/remote/file /local/path/        # download file
scp -r localdir/ user@host:/remote/path/       # recursive (directory)
scp -i ~/.ssh/key.pem file user@host:/path/    # with specific key
scp -P 2222 file user@host:/path/              # custom port (note: capital P)
scp -C file user@host:/path/                   # compress during transfer
scp -3 user1@host1:/path user2@host2:/path     # transfer between two remote servers
```

```bash
$ scp -i ~/.ssh/ec2-key.pem app-v2.tar.gz ec2-user@54.1.2.3:/opt/deployments/
# Output:
# app-v2.tar.gz    100%  45MB  8.9MB/s   00:05
# Explanation: Shows filename, progress (100%), total size, speed, and time taken

$ scp -r ec2-user@prod-server:/var/log/app/ /local/logs/incident-$(date +%F)/
# Output: downloads entire /var/log/app/ directory with recursive copy
# Explanation: Good for pulling logs from a server for offline analysis
```

### `rsync` — Efficient Synchronization
`rsync` is smarter than `scp` — it only transfers files that have changed (or the changed PARTS of files), making repeated transfers much faster.

```bash
rsync -avz source/ destination/                              # local sync
rsync -avz source/ user@host:/remote/                        # to remote
rsync -avz user@host:/remote/ /local/                        # from remote
rsync -avz --delete source/ destination/                     # mirror (delete extras in dest)
rsync -avz --dry-run source/ destination/                    # preview without transferring
rsync -avz --exclude='*.log' --exclude='.git' source/ dest/  # with exclusions
rsync -avzP source/ destination/                             # P = progress + resume
rsync -avz -e "ssh -i ~/.ssh/key.pem -p 2222" src/ user@host:/dst/  # custom SSH options
rsync -avz --bwlimit=10240 src/ dest/                       # limit bandwidth to 10 MB/s
```

**Option breakdown:**
```
-a  = archive mode: recursive + preserves permissions, ownership, timestamps, symlinks
-v  = verbose: show each file being transferred
-z  = compress data during transfer (saves bandwidth on slow links)
-P  = show progress per file + allow resuming interrupted transfers
--delete = delete files in destination that no longer exist in source (true mirror)
--dry-run = simulate without making any changes (always test first!)
```

```bash
$ rsync -avz --dry-run /opt/app/ ec2-user@prod-server:/opt/app/
# Output:
# sending incremental file list
# ./
# config/database.yml    ← only changed files shown
# bin/app-v2.jar         ← new binary
# Explanation: --dry-run shows EXACTLY what would be transferred without doing it
# Review this output before running without --dry-run

$ rsync -avz --delete /var/www/html/ ec2-user@server2:/var/www/html/
# Output:
# sending incremental file list
# deleting old_page.html   ← files in dest but not source are DELETED
# index.html
# about.html
# Explanation: --delete makes dest a PERFECT mirror of source
# WARNING: --delete will remove files from destination that don't exist in source
```

### Real-World DevOps Scenario
**Rolling deployment across multiple web servers:**
```bash
SERVERS=("web-01" "web-02" "web-03")

for server in "${SERVERS[@]}"; do
    echo "=== Syncing to $server ==="
    rsync -avz \
        --exclude='*.log' \
        --exclude='.git' \
        --delete \
        /opt/myapp/ \
        "deploy@${server}:/opt/myapp/"
    
    echo "Restarting app on $server..."
    ssh "deploy@${server}" "sudo systemctl restart myapp && systemctl is-active myapp"
done
```

---

## 🔹 `ss` / `netstat`

### `ss` — Socket Statistics (Modern)
`ss` is the modern, faster replacement for `netstat`. The flags are identical.

```bash
ss -tulpn              # TCP+UDP Listening ports with Process names, Numeric addresses
ss -t                  # TCP connections only
ss -u                  # UDP only
ss -l                  # listening sockets only
ss -a                  # all (listening + established)
ss -s                  # summary statistics
ss -p                  # show process using each socket
ss -n                  # numeric (don't resolve hostnames/ports to names)
ss state ESTABLISHED   # only established connections
ss -o                  # show connection timers
```

```bash
$ ss -tulpn
# Output:
# Netid  State   Recv-Q Send-Q  Local Address:Port  Peer Address:Port  Process
# tcp    LISTEN  0      128     0.0.0.0:22           0.0.0.0:*          users:(("sshd",pid=998))
# tcp    LISTEN  0      511     0.0.0.0:80           0.0.0.0:*          users:(("nginx",pid=1234))
# tcp    LISTEN  0      128     0.0.0.0:443          0.0.0.0:*          users:(("nginx",pid=1234))
# tcp    LISTEN  0      128     127.0.0.1:8080        0.0.0.0:*          users:(("java",pid=5678))
# udp    UNCONN  0      0       0.0.0.0:123          0.0.0.0:*          users:(("ntpd",pid=777))
#
# Reading the output:
# Recv-Q = bytes waiting to be received by the application (if high, app is slow processing)
# Send-Q = bytes waiting to be sent (if high, network is slow or receiver is slow)
# 0.0.0.0:80 = listening on ALL interfaces on port 80
# 127.0.0.1:8080 = listening ONLY on localhost (not exposed externally)
# This is important: 8080 on localhost is safe; 8080 on 0.0.0.0 is exposed to world

$ ss -s
# Output:
# Total: 142
# TCP:   12 (estab 5, closed 2, orphaned 0, timewait 2)
# UDP:   3
# Explanation: Quick overview of connection counts
# High timewait count = many connections being closed (normal for HTTP servers)
# High established + small timewait = persistent connections (keep-alive)
```

### `netstat` — Legacy (Still Widely Used)
```bash
netstat -tulpn             # same as ss -tulpn
netstat -an                # all connections, numeric
netstat -r                 # routing table
netstat -i                 # interface statistics
netstat -s                 # protocol statistics
```

### 🎯 Interview Point
> **`ss` is faster than `netstat`** because it reads directly from kernel structures via netlink socket rather than parsing `/proc/net/*` files. `netstat` comes from the deprecated `net-tools` package; `ss` comes from `iproute2`. The flags `-tulpn` work identically on both. In interviews and production, know both.

---

## 🔹 `tcpdump` / `nmap`

### `tcpdump` — Packet Capture
```bash
tcpdump -i eth0                         # capture all traffic on eth0
tcpdump -i eth0 port 80                 # only port 80 traffic
tcpdump -i eth0 host 10.0.0.1          # only traffic from/to specific host
tcpdump -i eth0 -w capture.pcap         # save raw packets to file
tcpdump -r capture.pcap                 # read and display saved pcap file
tcpdump -n -i eth0                      # no DNS resolution (numeric)
tcpdump -nn -i eth0                     # no DNS + no service name resolution
tcpdump -A -i eth0 port 80             # print packet payload as ASCII text
tcpdump -i eth0 'tcp port 80 and host 10.0.0.1'  # combined filter
tcpdump -i eth0 'src net 10.0.0.0/8'  # source network filter
```

```bash
$ tcpdump -nn -i eth0 port 443 -c 10
# Output:
# 18:00:01.123456 IP 10.0.0.5.52341 > 10.0.1.50.443: Flags [S], seq 123456789
# 18:00:01.123500 IP 10.0.1.50.443 > 10.0.0.5.52341: Flags [S.], seq 987654321
# 18:00:01.123520 IP 10.0.0.5.52341 > 10.0.1.50.443: Flags [.], ack 1
# Explanation: This is the TCP 3-way handshake:
# [S] = SYN (client initiates)
# [S.] = SYN-ACK (server responds)
# [.] = ACK (client acknowledges — connection established)
# -c 10 = capture only 10 packets then stop
# -nn = no hostname/port resolution (faster, clearer output)

# Real incident debugging:
$ tcpdump -i eth0 -A 'host service-b and port 8080' 2>/dev/null | grep -A3 "HTTP/1"
# Shows actual HTTP request/response bodies between microservices
```

### `nmap` — Network Scanner
```bash
nmap hostname                      # basic scan (most common ports)
nmap -p 1-65535 hostname           # all 65535 ports
nmap -p 22,80,443,8080 10.0.0.0/24 # specific ports across a subnet
nmap -sV hostname                  # service version detection
nmap -O hostname                   # OS detection (requires root)
nmap -A hostname                   # aggressive scan (OS + version + scripts)
nmap -sn 10.0.0.0/24              # ping scan — discover live hosts, no port scan
nmap --script vuln hostname        # run vulnerability detection scripts
nmap -oN output.txt hostname       # save output to file
```

```bash
$ nmap -p 1-65535 54.1.2.3
# Output:
# PORT     STATE  SERVICE
# 22/tcp   open   ssh
# 80/tcp   open   http
# 443/tcp  open   https
# 8080/tcp open   http-proxy  ← unexpected! Should this be open?
# Explanation: Port 8080 is open — is this intentional?
# If not, it's a security misconfiguration (maybe dev server exposed)
# Action: firewall-cmd or ufw rule to close 8080 to the public internet
```

---

## 🔹 `dig` / `nslookup`

### `dig` — DNS Query Tool (Preferred)
```bash
dig domain.com                  # A record (IPv4 address)
dig domain.com MX               # mail exchange records
dig domain.com TXT              # TXT records (SPF, DKIM, verification)
dig domain.com NS               # nameserver records
dig domain.com CNAME            # CNAME records
dig @8.8.8.8 domain.com         # query specific DNS server
dig +short domain.com           # output only the answer (no headers)
dig -x 1.2.3.4                  # reverse DNS lookup (IP to hostname)
dig +trace domain.com           # trace full DNS resolution chain
dig +nocmd +noall +answer domain.com  # cleanest output format
```

```bash
$ dig +short google.com
# Output:
# 142.250.195.46
# Explanation: Just the IP — cleanest format for scripting

$ dig google.com MX +short
# Output:
# 10 smtp.google.com.
# 20 alt1.aspmx.l.google.com.
# Explanation: Mail servers for google.com with priority (lower = preferred)

$ dig @8.8.8.8 myapp.example.com +short
# Output: 54.1.2.3
# Explanation: Querying Google's DNS (8.8.8.8) instead of local resolver
# Use this to check what the WORLD sees vs what your local DNS shows

$ dig +trace myapp.example.com
# Output: Shows every DNS server queried from root → TLD → authoritative
# Output shows: . (root) → .com. (TLD) → example.com. (authoritative) → answer
# Explanation: Useful for diagnosing DNS delegation issues

$ dig -x 8.8.8.8 +short
# Output: dns.google.
# Explanation: Reverse lookup — who owns this IP?
```

### Real-World DevOps Scenario
**After pointing a domain to a new load balancer, verify DNS propagation from multiple resolvers:**
```bash
for dns in 8.8.8.8 1.1.1.1 9.9.9.9 208.67.222.222; do
    result=$(dig @$dns myapp.example.com +short)
    echo "DNS $dns sees: $result"
done
# Output:
# DNS 8.8.8.8 sees: 54.1.2.3
# DNS 1.1.1.1 sees: 54.1.2.3
# DNS 9.9.9.9 sees: 203.0.113.5  ← still showing old IP!
# DNS 208.67.222.222 sees: 54.1.2.3
# Explanation: Most DNS servers are updated but 9.9.9.9 still has cached old IP
# The old record's TTL hasn't expired yet — wait and retry
```

### Summary — Networking & Remote Access

**📌 5-Minute Recap:**
- **`ip a`** for interface info, **`ip route`** for routing — replace `ifconfig` and `route` on modern systems
- **`mtr`** is the best network diagnostic tool — shows per-hop packet loss in real-time across many packets
- **`curl -o /dev/null -s -w "%{http_code}"`** is the standard health check pattern in CI/CD scripts
- **`ssh -L localport:remotehost:remoteport user@bastion`** — essential for accessing private databases
- **`rsync -avz --dry-run`** always before `rsync --delete` — preview before mirroring
- **`ss -tulpn`** to see listening ports and which processes own them — use `lsof -i :port` for more detail
- **`tail -f` on `tcpdump -w`** output + Wireshark offline is the debugging combination for complex network issues
- **`dig @8.8.8.8 domain +short`** to check DNS from outside your internal resolver — essential during deployments

---

# 10. Package Management

## What Is This Section About?
Package managers handle installing, upgrading, removing, and querying software packages. Different Linux distributions use different package managers. Understanding both Debian-based (apt, dpkg) and RPM-based (dnf, rpm) systems is essential for a cross-platform DevOps engineer.

---

## 🔹 `apt` — Debian/Ubuntu

### Internal Architecture
```
apt install nginx
  └─► Reads /etc/apt/sources.list + /etc/apt/sources.list.d/*
        └─► Downloads package metadata from repositories
              └─► Resolves dependencies automatically
                    └─► Downloads .deb packages to /var/cache/apt/archives/
                          └─► Calls dpkg to install each package
                                └─► Runs post-install scripts
```

```bash
apt update                         # refresh package INDEX from repositories
apt upgrade                        # upgrade all installed packages
apt full-upgrade                   # upgrade + allow adding/removing packages
apt install nginx                  # install package
apt install -y nginx curl git vim  # install multiple packages, auto-confirm
apt remove nginx                   # remove package (KEEP config files)
apt purge nginx                    # remove package AND its config files
apt autoremove                     # remove packages that are no longer needed
apt clean                          # clear downloaded package files cache
apt search keyword                 # search for packages by keyword
apt show nginx                     # detailed package information
apt list --installed               # show all installed packages
apt list --installed | grep nginx  # check if nginx is installed
apt-cache policy nginx             # show available versions and priority
apt-cache depends nginx            # show package dependencies
```

```bash
$ apt update
# Output:
# Get:1 http://security.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
# Get:2 http://archive.ubuntu.com/ubuntu jammy InRelease [270 kB]
# Fetched 8,532 kB in 3s (2,844 kB/s)
# Reading package lists... Done
# Explanation: Downloads the package INDEX (not the packages themselves)
# Always run apt update before apt install to get the latest package info

$ apt show nginx
# Output:
# Package: nginx
# Version: 1.18.0-6ubuntu14.4
# Installed-Size: 43.0 kB
# Depends: libpcre2-8-0, libssl3, zlib1g, nginx-common
# Conflicts: nginx-extras, nginx-light
# Homepage: https://nginx.net
# Description: small, powerful, scalable web/proxy server
# Explanation: Shows version, size, dependencies, conflicts before installing
```

### New Server Provisioning (Ubuntu):
```bash
# Best practice: update first, then install
apt update && apt upgrade -y

# Install common DevOps tools
apt install -y \
    nginx \
    curl \
    wget \
    git \
    vim \
    htop \
    tree \
    jq \
    unzip \
    net-tools \
    dnsutils \
    tcpdump

systemctl enable --now nginx
```

---

## 🔹 `dnf` / `yum` — RHEL/CentOS/Fedora

```bash
# dnf (RHEL8+, Fedora) — preferred modern tool
dnf update                      # update all packages
dnf update nginx                # update specific package
dnf install nginx               # install package
dnf install -y nginx curl git   # multiple packages, auto-confirm
dnf remove nginx                # remove package
dnf search keyword              # search packages
dnf info nginx                  # package details
dnf list installed              # list installed packages
dnf list available              # list available packages
dnf history                     # show all transaction history
dnf history undo last           # UNDO the last transaction (very useful!)
dnf provides /usr/sbin/nginx    # which package provides this file?
dnf repolist                    # list configured repositories
dnf clean all                   # clear all caches

# yum (RHEL7/CentOS7) — legacy
yum update
yum install nginx
yum remove nginx
yum list installed
yum provides /usr/sbin/nginx
```

```bash
$ dnf history
# Output:
# ID  | Command                   | Date and time    | Action(s)
#  5  | install nginx             | 2026-04-17 10:00 | Install
#  4  | update                    | 2026-04-16 09:00 | Upgrade
#  3  | install -y curl wget git  | 2026-04-15 14:00 | Install
#
# Explanation: Full audit trail of all package operations
# Each entry has an ID you can use to undo

$ dnf history undo 5
# Output: Undoes transaction 5 (the nginx install) — removes nginx
# Explanation: This is how you rollback a problematic package installation
```

---

## 🔹 `rpm` / `dpkg`

### `rpm` — RPM Package Manager (Red Hat)
```bash
rpm -ivh package.rpm            # install (verbose, with progress bar)
rpm -Uvh package.rpm            # upgrade (install if not present)
rpm -e packagename              # erase/remove
rpm -qa                         # query ALL installed packages
rpm -qa | grep nginx            # check if nginx is installed
rpm -ql nginx                   # list all FILES installed by nginx package
rpm -qf /usr/sbin/nginx         # which package installed this FILE?
rpm -qi nginx                   # query package information
rpm --verify nginx              # verify package files haven't been tampered with
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat  # import signing key
```

```bash
$ rpm -qf /usr/sbin/nginx
# Output: nginx-1.20.1-14.el9.x86_64
# Explanation: The nginx binary was installed by this specific package version
# Use case: "Who put this binary here?" → rpm -qf tells you exactly

$ rpm --verify nginx
# Output: (empty = package is intact)
# OR:
# S.5....T.  /usr/sbin/nginx
# Explanation: Flags indicate what changed:
# S = Size changed, 5 = MD5 checksum mismatch, T = mtime changed
# Non-empty output = file was modified after installation (potential tampering)
```

### `dpkg` — Debian Package Manager
```bash
dpkg -i package.deb             # install .deb file
dpkg -r packagename             # remove (keep config)
dpkg -P packagename             # purge (remove + config)
dpkg -l                         # list all installed packages
dpkg -l | grep nginx            # check if installed
dpkg -L nginx                   # list files installed by package
dpkg -S /usr/sbin/nginx         # which package owns this file?
dpkg --print-architecture       # show system architecture
dpkg --configure -a             # configure all unconfigured packages (fix broken)
```

```bash
$ dpkg -S /bin/ls
# Output: coreutils: /bin/ls
# Explanation: /bin/ls was installed by the coreutils package

$ dpkg -l | head -5
# Output:
# Desired=Unknown/Install/Remove/Purge/Hold
# Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
# ||/ Name        Version      Architecture Description
# +++-==========-============-============-==================================
# ii  adduser     3.129ubuntu7 all          add and remove users and groups
# Explanation: ii = installed, rc = removed but config remains, pn = purged
```

---

## 🔹 `snap` / `flatpak`

```bash
# snap — containerized packages from Canonical
snap find keyword          # search snap store
snap install package       # install
snap remove package        # remove
snap list                  # list installed snaps
snap refresh               # update all snaps
snap info package          # details and available channels

# flatpak — sandboxed applications (cross-distro)
flatpak install flathub org.gimp.GIMP
flatpak run org.gimp.GIMP
flatpak list
flatpak update
```

### Summary — Package Management

**📌 5-Minute Recap:**
- **Debian/Ubuntu**: `apt update` (refresh index) → `apt install` → `apt purge` (remove including configs)
- **RHEL/CentOS**: `dnf update` → `dnf install` → `dnf history undo` (rollback transactions)
- **`apt update` ≠ `apt upgrade`**: update refreshes the package INDEX; upgrade actually upgrades packages
- **`rpm -qf /path/to/file`** and **`dpkg -S /path/to/file`** — find which package owns a file
- **`dnf history undo`** — powerful rollback mechanism for RHEL-based systems
- **Always `apt update && apt upgrade -y`** when provisioning new servers before installing anything
- **`apt purge` vs `apt remove`**: `remove` keeps config files; `purge` removes everything cleanly

---

# 11. Services & Systemd

## What Is This Section About?
`systemd` is the init system and service manager for most modern Linux distributions (RHEL7+, Ubuntu 16.04+, Debian 8+). It manages services, defines boot order, handles system state, and collects logs. Understanding systemd is essential for running any production service.

## Internal Architecture
```
Kernel starts PID 1 = systemd
  └─► systemd reads unit files from:
        /lib/systemd/system/      (package-provided)
        /etc/systemd/system/      (admin overrides — these take priority)
        /run/systemd/system/      (runtime units)
  └─► Resolves dependencies (Wants=, Requires=, After=, Before=)
  └─► Starts units in parallel where possible
  └─► Monitors processes, restarts on failure (if configured)
  └─► Collects stdout/stderr into journal
```

---

## 🔹 `systemctl`

### Service Lifecycle Commands
```bash
systemctl start nginx           # start now (doesn't affect boot)
systemctl stop nginx            # stop now
systemctl restart nginx         # stop then start (brief downtime)
systemctl reload nginx          # reload config without restart (zero downtime)
systemctl status nginx          # show status, recent logs, PID, memory
systemctl enable nginx          # enable auto-start at boot
systemctl disable nginx         # disable auto-start at boot
systemctl enable --now nginx    # enable AND start immediately (one command)
systemctl disable --now nginx   # disable AND stop immediately
systemctl is-active nginx       # returns "active" or "inactive" (good for scripts)
systemctl is-enabled nginx      # returns "enabled" or "disabled"
systemctl is-failed nginx       # returns "failed" if service is in failed state
```

```bash
$ systemctl status nginx
# Output:
# ● nginx.service - A high performance web server and a reverse proxy server
#      Loaded: loaded (/lib/systemd/system/nginx.service; enabled; preset: enabled)
#      Active: active (running) since Fri 2026-04-17 10:00:01 UTC; 8h ago
#    Main PID: 1234 (nginx)
#       Tasks: 5 (limit: 4915)
#      Memory: 25.3M (peak: 28.1M)
#         CPU: 1.234s
#      CGroup: /system.slice/nginx.service
#              ├─1234 "nginx: master process /usr/sbin/nginx -g daemon off;"
#              ├─1235 "nginx: worker process"
#              └─1236 "nginx: worker process"
# Apr 17 10:00:01 server nginx[1234]: nginx: configuration file test is ok
# Apr 17 10:00:01 server systemd[1]: Started A high performance web server
#
# Reading the output:
# "enabled" in Loaded line = will start at boot
# "active (running)" = service is UP and healthy
# Main PID = the master process PID
# Memory: current memory usage + peak
# CGroup tree shows master and all worker processes
# Recent log lines shown at the bottom — first stop for debugging
```

```bash
# System-wide commands
systemctl list-units                  # list all loaded units
systemctl list-units --state=failed   # show only FAILED units (first check after boot issues)
systemctl list-unit-files             # list all unit files (enabled/disabled status)
systemctl daemon-reload               # reload unit file definitions (MUST run after editing unit files)
systemctl reset-failed                # clear failed state from all units
systemctl reset-failed nginx          # clear failed state for specific service

# System state
systemctl reboot
systemctl poweroff
systemctl rescue                      # enter rescue/single-user mode

# Targets (equivalent to runlevels)
systemctl isolate multi-user.target   # switch to multi-user (no GUI)
systemctl isolate graphical.target    # switch to GUI
systemctl get-default                 # show current default target
systemctl set-default multi-user.target  # set default target for next boot
```

### Creating a Custom Unit File
```bash
# /etc/systemd/system/myapp.service
[Unit]
Description=My Application Service
Documentation=https://company.com/docs
After=network.target postgresql.service    # start AFTER network and postgres are ready
Requires=postgresql.service               # if postgres fails, this fails too
Wants=redis.service                       # try to start redis, but ok if it fails

[Service]
Type=simple                               # process stays in foreground
User=appuser                              # run as this user (NOT root!)
Group=appgroup
WorkingDirectory=/opt/myapp
ExecStart=/opt/myapp/bin/server --config /etc/myapp/config.yml
ExecReload=/bin/kill -HUP $MAINPID       # how to reload config
ExecStop=/opt/myapp/bin/graceful-stop
Restart=always                            # always restart if it crashes
RestartSec=5                              # wait 5 seconds before restarting
StartLimitIntervalSec=60                  # within 60 seconds
StartLimitBurst=3                         # allow max 3 restarts (prevents restart loops)
StandardOutput=journal                    # send stdout to systemd journal
StandardError=journal                     # send stderr to systemd journal
Environment="APP_ENV=production"          # set environment variables
EnvironmentFile=/etc/myapp/env            # load env vars from file

[Install]
WantedBy=multi-user.target               # enable for normal multi-user boot

# After creating/editing:
systemctl daemon-reload                  # reload unit file definitions
systemctl enable --now myapp             # enable and start
systemctl status myapp                   # verify it's running
```

### 🎯 Interview Point
> **`restart` vs `reload`**: `restart` stops the service and starts it again — there is a brief moment with no service. `reload` sends a signal to the process (usually SIGHUP) to re-read its configuration WITHOUT stopping — zero downtime. For nginx, `systemctl reload nginx` is correct for config changes. `restart` is only needed when the binary itself changes (after `apt upgrade nginx`).

---

## 🔹 `journalctl`

### What It Does
`journalctl` queries the **systemd journal** — a binary log database that collects stdout/stderr from all services, kernel messages, boot messages, and more. It replaces reading multiple log files across `/var/log/`.

```bash
journalctl                                      # ALL logs from oldest to newest
journalctl -f                                   # follow (live tail ALL services)
journalctl -u nginx                             # logs for nginx service only
journalctl -u nginx -f                          # live tail nginx logs
journalctl -u nginx -n 50                       # last 50 lines for nginx
journalctl -u nginx --no-pager                  # don't use pager (good for grep)
journalctl -xe                                  # recent logs with explanation and context
journalctl -b                                   # logs from current boot only
journalctl -b -1                                # logs from PREVIOUS boot (before last reboot)
journalctl --since "1 hour ago"                 # last hour of logs
journalctl --since "2026-04-17 10:00"           # from specific time
journalctl --since "2026-04-17 10:00" --until "2026-04-17 12:00"  # time range
journalctl -p err                               # only ERROR level and above
journalctl -p warning..err                      # warning through error
journalctl -k                                   # kernel messages only (like dmesg)
journalctl --disk-usage                         # how much disk journal is using
journalctl --vacuum-size=500M                   # trim journal to 500MB
journalctl --vacuum-time=30d                    # delete logs older than 30 days
```

```bash
$ journalctl -u myapp -n 50 --no-pager
# Output:
# Apr 17 18:20:55 server myapp[5678]: INFO  Starting application on port 8080
# Apr 17 18:20:56 server myapp[5678]: INFO  Connected to database successfully
# Apr 17 18:21:10 server myapp[5678]: ERROR Database connection lost: timeout
# Apr 17 18:21:11 server systemd[1]: myapp.service: Main process exited, code=exited, status=1
# Apr 17 18:21:11 server systemd[1]: myapp.service: Failed with result 'exit-code'
# Apr 17 18:21:16 server systemd[1]: myapp.service: Scheduled restart job (restart)
# Apr 17 18:21:16 server myapp[5679]: INFO  Starting application on port 8080
# Explanation: Complete picture of the crash + auto-restart cycle
# systemd logged the failure AND the restart — all in one place

$ journalctl -p err --since "1 hour ago" | grep -v "audit"
# Output: only error-level messages from all services in last hour
# Excludes audit messages (can be noisy)
# Explanation: Quick system-wide error scan — first thing after an alert fires

$ journalctl --disk-usage
# Output: Archived and active journals take up 1.2G in the filesystem.
# Explanation: Journal is consuming 1.2GB of disk
$ journalctl --vacuum-size=200M
# Trims journal to 200MB by removing oldest entries
```

---

## 🔹 `service` (Legacy)

```bash
service nginx start
service nginx stop
service nginx restart
service nginx status
```

### 🎯 Interview Point
> On modern systemd systems, `service` is a **compatibility wrapper** that calls `systemctl` internally. It's kept for backward compatibility. Use `systemctl` in all new scripts and for manual operations — it provides more information and more control.

---

## 🔹 `logger`

```bash
logger "Deployment started: version 2.1.0"                    # log to syslog
logger -t deployment "Started by: $USER at $(date)"           # with custom tag
logger -p user.err "Critical error: failed to connect to DB"  # with priority
logger -p user.info "Health check: PASSED"
```

```bash
# After logging with logger:
$ journalctl -t deployment -n 5
# Output:
# Apr 17 18:00:01 server deployment[12345]: Started by: ec2-user at Fri Apr 17 18:00:01
# Apr 17 18:05:22 server deployment[12346]: Deploy completed successfully
# Explanation: Custom log entries appear in the journal with your tag
# Use this for: creating audit trails in deployment scripts
```

### Real-World DevOps Scenario
**Add structured logging to a deployment script:**
```bash
#!/bin/bash
set -euo pipefail

LOG_TAG="deploy-${APP_NAME}"
VERSION="${1:?Usage: deploy.sh <version>}"

logger -t "$LOG_TAG" "STARTED: deploying version $VERSION by $USER"

# ... deployment steps ...

logger -t "$LOG_TAG" "COMPLETED: version $VERSION deployed successfully"

# Now all deployment events are in systemd journal:
# journalctl -t "deploy-myapp" --since "today"
```

### Summary — Services & Systemd

**📌 5-Minute Recap:**
- **`systemctl status service`** is always the first command when a service has issues — shows state, PID, memory, and recent logs
- **`systemctl daemon-reload`** MUST be run after creating or editing unit files — otherwise changes are ignored
- **`enable` vs `start`**: `enable` makes it start at boot; `start` starts it NOW; `enable --now` does both
- **`restart` causes brief downtime; `reload` is zero-downtime** — use `reload` for config changes on nginx, httpd
- **`journalctl -u service -f`** for live debugging; **`-b -1`** for logs from previous boot (post-reboot analysis)
- **`Restart=always` in unit files** provides automatic recovery from crashes — essential for production
- **`journalctl --vacuum-size=500M`** prevents journal from consuming too much disk space

---

# 12. Scheduling

## What Is This Section About?
Scheduling tools let you run commands automatically at specific times or intervals. This is how you automate backups, log rotation, health checks, cleanup jobs, and any recurring task without manual intervention.

---

## 🔹 `cron` / `crontab`

### How cron Works Internally
```
crond daemon runs constantly in background
  └─► Every minute: reads /etc/crontab + /etc/cron.d/* + each user's crontab
        └─► For each job: check if current time matches the schedule
              └─► If match: fork() + exec() the command
                    └─► Run as the specified user
                          └─► Email output to user (if not redirected)
```

### Crontab Syntax
```
* * * * * command_to_run
│ │ │ │ │
│ │ │ │ └── Day of Week  (0-7, 0 and 7 = Sunday)
│ │ │ └──── Month        (1-12)
│ │ └────── Day of Month (1-31)
│ └──────── Hour         (0-23)
└────────── Minute       (0-59)

Special values:
*     = every value (every minute/hour/day)
*/5   = every 5 units (every 5 minutes, every 5 hours, etc.)
5,10  = at 5 AND 10
5-10  = range from 5 to 10
```

```bash
crontab -e          # edit current user's crontab (opens in $EDITOR)
crontab -l          # list current user's crontab
crontab -r          # REMOVE entire crontab (WARNING — no confirmation!)
crontab -u user -l  # list another user's crontab (as root)
crontab -u user -e  # edit another user's crontab (as root)
```

```bash
# Examples of crontab entries:

# Run backup at 2:30 AM every day
30 2 * * * /opt/app/backup.sh >> /var/log/backup.log 2>&1

# Run health check every 5 minutes
*/5 * * * * /opt/scripts/health-check.sh >> /var/log/health.log 2>&1

# Run report every Monday at 6 AM
0 6 * * 1 /opt/scripts/weekly-report.sh

# Run cleanup on first day of every month at midnight
0 0 1 * * /opt/scripts/monthly-cleanup.sh

# Run on weekdays (Monday-Friday) at 9 AM
0 9 * * 1-5 /opt/scripts/morning-report.sh

# Run every 30 minutes between 8 AM and 6 PM on weekdays
*/30 8-18 * * 1-5 /opt/scripts/sync.sh

# Special shorthand strings:
@reboot   /opt/app/start-on-reboot.sh     # runs once on every system boot
@daily    /opt/scripts/daily-cleanup.sh   # runs at midnight daily
@weekly   /opt/scripts/weekly-report.sh   # runs Sunday at midnight
@monthly  /opt/scripts/monthly-backup.sh  # runs 1st of month at midnight
@hourly   /opt/scripts/hourly-check.sh    # runs every hour at minute 0
```

### Critical Crontab Rules for Production
```bash
# RULE 1: Always use full absolute paths
# BAD:
30 2 * * * backup.sh          # cron has minimal PATH — backup.sh won't be found
# GOOD:
30 2 * * * /opt/scripts/backup.sh

# RULE 2: Always redirect output (or cron emails it to root, filling /var/spool/mail)
# BAD:
30 2 * * * /opt/scripts/backup.sh   # output goes to root's mailbox!
# GOOD:
30 2 * * * /opt/scripts/backup.sh >> /var/log/backup.log 2>&1
# ">>" = append (not overwrite), "2>&1" = redirect stderr to same file as stdout

# RULE 3: Set PATH explicitly if your script needs specific binaries
0 * * * * export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin && /opt/scripts/run.sh

# RULE 4: Test the script manually as the cron user first
sudo -u www-data /opt/scripts/cleanup.sh   # test as www-data user before scheduling

# RULE 5: Verify cron is running and your job is scheduled
systemctl status cron         # Ubuntu
systemctl status crond        # RHEL
crontab -l                    # verify your entry was saved
grep CRON /var/log/syslog     # Ubuntu: check cron execution logs
grep CRON /var/log/cron       # RHEL: check cron execution logs
```

### 🎯 Interview Point
> **`crontab -r` vs `crontab -e`**: The `r` key and `e` key are next to each other. Typing `crontab -r` when you meant `crontab -e` **silently deletes your entire crontab** with no confirmation prompt. This is a famously dangerous typo. Some engineers use `crontab -r` replacements that ask for confirmation. Always double-check before pressing Enter.

---

## 🔹 `at` / `batch`

### `at` — One-Time Scheduled Job
```bash
at 10:30                      # schedule job for 10:30 today
at 10:30 tomorrow             # schedule for tomorrow at 10:30
at now + 2 hours              # 2 hours from now
at now + 30 minutes           # 30 minutes from now
at 10:30 April 20             # specific date and time
atq                           # list pending at jobs
atrm 3                        # remove job number 3
at -l                         # same as atq — list jobs
```

```bash
$ at now + 5 minutes
# at> /opt/app/restart.sh
# at> logger "Scheduled restart executed"
# at> Ctrl+D                  ← press Ctrl+D to finish entering commands
# job 5 at Fri Apr 17 18:30:00 2026
# Output: job 5 = job ID, at the specified time

$ atq
# Output:
# 5    Fri Apr 17 18:30:00 2026 a ec2-user
# Explanation: Job 5 scheduled for 18:30 by ec2-user

$ atrm 5                      # cancel job 5 before it runs
```

### `batch` — Run When System Load Is Low
```bash
batch
> /opt/heavy-processing-script.sh
> Ctrl+D
# Runs the script automatically when system load average drops below 0.8
# Good for heavy batch jobs that shouldn't compete with production traffic
```

---

## 🔹 `anacron`

### What Makes anacron Different from cron
```
cron:    "Run at 2 AM exactly" — if machine is OFF at 2 AM, job is MISSED forever
anacron: "Run once per day" — if machine was off, run it on next startup
```

```bash
# /etc/anacrontab
# period   delay   job-identifier   command
# period = 1 (daily), 7 (weekly), 30 (monthly) — or @daily, @weekly, @monthly
# delay = minutes to wait after boot before running (prevents thundering herd)

1         5      daily.backup    /opt/scripts/daily-backup.sh
7         10     weekly.report   /opt/scripts/weekly-report.sh
30        15     monthly.clean   /opt/scripts/monthly-cleanup.sh

# Each job runs if it hasn't run within the 'period' days
# Timestamps stored in /var/spool/anacron/
```

### 🎯 Interview Point
> **`cron` vs `anacron`**: Use `cron` for jobs that must run at a **specific time** on servers that run 24/7 (web servers, databases). Use `anacron` for jobs that must run **at least once per period** on systems that aren't always on (developer laptops, periodic EC2 instances). `anacron` is what makes `cron.daily`, `cron.weekly`, `cron.monthly` directories work reliably.

---

## 🔹 systemd Timers

### Why Use systemd Timers Instead of cron?
- Logs to the journal (visible with `journalctl`)
- Can depend on other services
- Can be activated by events, not just time
- Better error handling and restart behavior

```bash
# Step 1: Create the service unit
# /etc/systemd/system/myapp-backup.service
[Unit]
Description=Daily backup of myapp

[Service]
Type=oneshot                          # run once and exit (not a daemon)
User=appuser
ExecStart=/opt/scripts/backup.sh
StandardOutput=journal
StandardError=journal

# Step 2: Create the timer unit
# /etc/systemd/system/myapp-backup.timer
[Unit]
Description=Daily backup timer for myapp
Requires=myapp-backup.service

[Timer]
OnCalendar=daily                      # run daily at midnight
# OnCalendar=*-*-* 02:30:00          # custom time: every day at 2:30 AM
# OnCalendar=Mon *-*-* 06:00:00      # every Monday at 6 AM
# OnBootSec=5min                     # 5 minutes after boot
Persistent=true                       # run missed executions on next boot (like anacron)
Unit=myapp-backup.service

[Install]
WantedBy=timers.target

# Step 3: Enable and start
systemctl daemon-reload
systemctl enable --now myapp-backup.timer
systemctl list-timers                  # verify it's scheduled
```

```bash
$ systemctl list-timers
# Output:
# NEXT                           LEFT      LAST                           PASSED  UNIT
# Sat 2026-04-18 00:00:00 UTC    5h 59min  Fri 2026-04-17 00:00:00 UTC   18h ago myapp-backup.timer
# Sat 2026-04-18 00:00:00 UTC    5h 59min  Fri 2026-04-17 00:00:00 UTC   18h ago logrotate.timer
# Explanation: Shows when each timer will NEXT run and when it LAST ran
# Much more informative than looking at crontab entries
```

### Summary — Scheduling

**📌 5-Minute Recap:**
- **Crontab format**: `Minute Hour DayOfMonth Month DayOfWeek command` — memorize this
- **Always use full paths in cron** — cron's `$PATH` is minimal; relative paths will not work
- **Always redirect output** in cron: `>> /var/log/job.log 2>&1` — prevents email flooding
- **`crontab -r` is dangerous** — deletes entire crontab silently; be very careful with it
- **`at now + 30 minutes`** for one-time scheduled tasks — great for scheduled restarts during maintenance windows
- **`anacron`** for jobs on non-24/7 systems — ensures missed jobs run on next boot
- **systemd timers** are the modern cron replacement — better logging, dependency handling, and missed job recovery

---

# 13. Shell Environment & Variables

## What Is This Section About?
The shell environment defines how your command-line session behaves — what commands are available, what your prompt looks like, what shortcuts you have, and how scripts behave. Mastering the shell environment makes you dramatically faster and more productive.

---

## 🔹 `export` / `env`

### How Environment Variables Work Internally
```
Shell process (bash PID 1000)
  └─► Has its own copy of environment variables (key=value pairs)
        └─► When you fork() a child process:
              └─► Child inherits a COPY of parent's environment
                    └─► export makes variables visible to child processes
                          └─► Unexported variables are LOCAL to current shell only
```

```bash
MY_VAR="hello"         # local shell variable (NOT visible to child processes)
export MY_VAR="hello"  # exported variable (visible to child processes)
export ANOTHER="world" # shorthand: declare and export in one line

# Verify what's exported:
env | grep MY_VAR        # shows exported variables
set | grep MY_VAR        # shows ALL variables (including local)

# Unset a variable:
unset MY_VAR

# Pass variable only to one command (doesn't change current shell):
DEBUG=true ./script.sh   # script sees DEBUG=true, your shell doesn't
```

```bash
# Real-world: AWS credential setup
export AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
export AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
export AWS_DEFAULT_REGION="ap-south-1"
aws s3 ls    # this aws call inherits all three variables automatically

# Verify in scripts:
if [ -z "$AWS_ACCESS_KEY_ID" ]; then
    echo "ERROR: AWS credentials not set"
    exit 1
fi
```

```bash
$ env
# Output (partial):
# PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# HOME=/home/ec2-user
# USER=ec2-user
# SHELL=/bin/bash
# TERM=xterm-256color
# LANG=en_US.UTF-8
# AWS_DEFAULT_REGION=ap-south-1
# Explanation: Shows ALL exported environment variables for current session

$ env -i PATH=/usr/bin /bin/bash    # start bash with EMPTY environment (except PATH)
# Explanation: -i = ignore inherited environment
# Useful for: testing scripts in a clean environment to find hidden dependencies
```

---

## 🔹 `alias`

```bash
alias ll='ls -lah'              # create alias
alias k='kubectl'               # short form for kubectl
alias tf='terraform'            # short form for terraform
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'  # always colorize grep output
alias df='df -h'                # always human-readable
alias du='du -sh'               # always summary human-readable
alias myip='curl -s ifconfig.me' # quick public IP check

unalias ll                      # remove alias for this session

# Make aliases PERMANENT — add to ~/.bashrc:
echo "alias ll='ls -lah'" >> ~/.bashrc
source ~/.bashrc                # reload immediately without logging out
```

```bash
$ alias
# Output (shows all current aliases):
# alias grep='grep --color=auto'
# alias k='kubectl'
# alias l='ls -CF'
# alias la='ls -A'
# alias ll='ls -alF'
# alias tf='terraform'
```

---

## 🔹 `.bashrc` / `.profile`

### When Each File Is Read
```
Login shell (SSH login, su -, console login):
  /etc/profile                 → system-wide settings for all users
  /etc/profile.d/*.sh          → modular system-wide settings
  ~/.bash_profile OR ~/.profile → per-user settings (run ONCE at login)
  ~/.bash_profile sources ~/.bashrc (by convention)

Non-login interactive shell (new terminal, subshell, tmux pane):
  /etc/bash.bashrc             → system-wide interactive settings
  ~/.bashrc                    → per-user interactive settings
```

```bash
# ~/.bashrc — sourced every time you open a terminal (non-login shell)
# Good for: aliases, functions, PS1 prompt, interactive settings

export EDITOR=vim
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %T "      # timestamp in history: "2026-04-17 18:00:01 command"

# Useful aliases
alias ll='ls -lah'
alias k='kubectl'
alias tf='terraform'
alias grep='grep --color=auto'
alias myip='curl -s ifconfig.me'

# Custom prompt with git branch
parse_git_branch() {
    git branch 2>/dev/null | grep '\*' | sed 's/* //'
}
export PS1='\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[33m\][$( parse_git_branch)]\[\033[0m\]\$ '
# Shows: user@hostname:/current/path[branch-name]$

# Function example (more powerful than aliases)
mkcd() { mkdir -p "$1" && cd "$1"; }  # create directory and cd into it
```

```bash
# ~/.profile — sourced at LOGIN (not every new terminal)
# Good for: PATH modifications, environment variables needed by all programs

export PATH="$PATH:/opt/myapp/bin:/usr/local/go/bin"
export JAVA_HOME="/usr/lib/jvm/java-17"
export KUBECONFIG="$HOME/.kube/config"
export GOPATH="$HOME/go"

# Source .bashrc from .profile (standard practice on Ubuntu)
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
```

### 🎯 Interview Point
> **`.bashrc` vs `.profile`**: `.bashrc` is sourced for **every interactive non-login shell** (new terminal, `bash` subshell). `.profile` is sourced **once at login**. Put aliases and functions in `.bashrc`. Put `PATH` modifications and environment variables in `.profile` (so they're available system-wide, not just in terminals). The key confusion: **SSH login sources `.profile`, opening a terminal in GUI sources `.bashrc`**.

---

## 🔹 `PATH`

```bash
echo $PATH
# Output: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/ec2-user/.local/bin

# How PATH is used:
# When you type "nginx", the shell searches each directory in $PATH left to right
# First match wins and is executed
# If not found in any directory: "command not found" error

# Add directory to PATH (current session only):
export PATH="$PATH:/opt/myapp/bin"

# Add permanently (add to ~/.bashrc or ~/.profile):
echo 'export PATH="$PATH:/opt/myapp/bin"' >> ~/.profile
source ~/.profile

# Prepend to PATH (new version takes priority over system version):
export PATH="/opt/newer-tool/bin:$PATH"
# Tools in /opt/newer-tool/bin are found BEFORE /usr/bin equivalents

# Debug "command not found":
which terraform           # is terraform in your PATH?
echo $PATH                # is the terraform directory in PATH?
ls /usr/local/bin/terraform  # does the binary actually exist?
```

---

## 🔹 `set` / `unset`

### Shell Flags That Matter in Scripts
```bash
set -e            # Exit immediately if ANY command returns non-zero exit code
set -u            # Treat undefined variables as errors (not silently empty)
set -o pipefail   # Pipeline fails if ANY command in the pipe fails
set -x            # Print each command before executing it (debug mode)
set +x            # Turn off debug mode
set -euo pipefail # The standard "strict mode" combination for production scripts
```

```bash
# Bad script (no strict mode — silently continues on errors):
#!/bin/bash
rm -rf /important/data    # if this fails, script continues!
deploy_app                 # may deploy with corrupted state

# Good script (strict mode — stops on first error):
#!/bin/bash
set -euo pipefail         # ALWAYS start production scripts with this!

rm -rf /important/data    # if this fails, entire script stops here
deploy_app                 # only runs if previous command succeeded

# set -x for debugging:
set -x
./failing_script.sh
# Output:
# + source /etc/app/config
# + export DB_HOST=localhost
# + connect_to_db localhost
# + psql -h localhost -U app mydb
# psql: error: connection refused
# Explanation: -x shows each command with + prefix before executing
# Now you can see EXACTLY which line fails and with what values
```

---

## 🔹 `history`

```bash
history                    # show all command history
history 20                 # last 20 commands
history | grep terraform   # search history for terraform commands

# History shortcuts (extremely useful):
!!                         # re-run the last command
!curl                      # re-run the most recent command starting with "curl"
!123                       # re-run command number 123 from history
!-2                        # re-run second-to-last command
sudo !!                    # re-run last command with sudo (forgot sudo!)
Ctrl+R                     # interactive reverse search through history

history -c                 # clear entire history (security: before capturing image)
```

```bash
$ history | grep kubectl | tail -10
# Output:
#  456  kubectl get pods -n production
#  457  kubectl describe pod nginx-abc123 -n production
#  458  kubectl logs nginx-abc123 -n production --previous
# Explanation: Find recent kubectl commands without retyping them
# Use !456 to re-run command 456

$ Ctrl+R, then type "kubectl get pods"
# (reverse-i-search)`kubectl get pods': kubectl get pods -n production
# Press Enter to run, or Right arrow to edit it first
```

### Summary — Shell Environment & Variables

**📌 5-Minute Recap:**
- **`export VAR=value`** makes variables visible to child processes; without `export` they're shell-local only
- **`set -euo pipefail`** at the top of every production script — prevents silent failures
- **`.bashrc`** for interactive settings (aliases, prompt); **`.profile`** for login settings (PATH, env vars)
- **`alias ll='ls -lah'`** in `.bashrc` — small efficiency gains add up to hours saved per year
- **`PATH` order matters** — directories earlier in PATH take precedence for command lookup
- **`Ctrl+R`** for reverse history search — fastest way to find and re-run previous commands
- **`sudo !!`** to re-run the last command with sudo — saves retyping long commands

---

# 14. Security & Access Control

## What Is This Section About?
Linux security is multi-layered — from firewall rules and SELinux policies to file encryption and immutable attributes. In production, security isn't optional — it's built into every decision.

---

## 🔹 SELinux

### What SELinux Does Internally
SELinux implements **Mandatory Access Control (MAC)** on top of Linux's standard permissions. Every process and file has a **security context label**. Access decisions are made based on policy rules that define which contexts can interact with which other contexts — NOT just based on user permissions.

```
Standard Linux (DAC): "Is the user alice allowed to read this file?"
SELinux (MAC):         "Is a process with httpd_t context allowed to read a file with httpd_sys_content_t context?"
SELinux applies EVEN IF the user is root!
```

```bash
getenforce                      # show current mode: Enforcing, Permissive, or Disabled
sestatus                        # detailed status including policy name and version
sestatus -v                     # very verbose

setenforce 0                    # switch to PERMISSIVE mode (logs but doesn't block)
setenforce 1                    # switch back to ENFORCING mode (blocks violations)
# Note: setenforce change is NOT persistent across reboots
# For permanent change: edit /etc/selinux/config and change SELINUX=enforcing
```

```bash
$ sestatus
# Output:
# SELinux status:                 enabled
# SELinuxfs mount:                /sys/fs/selinux
# SELinux mount point:            enforcing
# Loaded policy name:             targeted       ← "targeted" policy protects key services
# Current mode:                   enforcing
# Mode from config file:          enforcing
# Policy MLS status:              enabled
# Policy deny_unknown status:     allowed
# Memory protection checking:     actual (secure)
# Max kernel policy version:      33

# View SELinux context of a file:
$ ls -lZ /var/www/html/index.html
# Output: -rw-r--r--. root root system_u:object_r:httpd_sys_content_t:s0 index.html
# The :httpd_sys_content_t: part is the SELinux type label
# httpd (nginx/apache) can read files labeled httpd_sys_content_t
```

```bash
# Real-world SELinux troubleshooting:

# Problem: nginx can't read files in /webdata even though permissions are 755
ls -lZ /webdata/
# Output: unconfined_u:object_r:default_t:s0  ← wrong label! nginx can't read default_t

# Fix: Set correct SELinux context
semanage fcontext -a -t httpd_sys_content_t "/webdata(/.*)?"
restorecon -Rv /webdata   # apply the policy recursively
ls -lZ /webdata/
# Output: system_u:object_r:httpd_sys_content_t:s0  ← now nginx can read it

# If you're unsure if SELinux is the cause:
setenforce 0    # temporarily disable enforcement
# test your application — if it works now, SELinux was blocking it
setenforce 1    # RE-ENABLE (don't leave it disabled!)
# then fix the context properly with semanage/restorecon
```

### 🎯 Interview Point
> **Never permanently disable SELinux in production.** The correct response to "SELinux is blocking my app" is NOT `SELINUX=disabled` in `/etc/selinux/config`. Use `ausearch -m avc -ts recent` to find the denial, then use `semanage port/fcontext` to add the correct policy, and `restorecon` to apply it. Disabling SELinux removes a critical security layer.

---

## 🔹 AppArmor

```bash
# Ubuntu/Debian use AppArmor instead of SELinux

apparmor_status          # show AppArmor status and loaded profiles
aa-status                # same command

# Profiles are in /etc/apparmor.d/
aa-enforce /etc/apparmor.d/usr.sbin.nginx     # enforce profile
aa-complain /etc/apparmor.d/usr.sbin.nginx    # complain mode (log but don't block)
aa-disable /etc/apparmor.d/usr.sbin.nginx     # disable profile

# Check AppArmor denials:
grep apparmor /var/log/syslog | grep DENIED
journalctl | grep apparmor | grep DENIED
```

---

## 🔹 `ufw` — Uncomplicated Firewall (Ubuntu)

```bash
ufw status                     # show status and all rules
ufw status verbose             # more detailed status
ufw enable                     # enable firewall
ufw disable                    # disable firewall

# Rules:
ufw allow 22/tcp               # allow SSH
ufw allow 80/tcp               # allow HTTP
ufw allow 443/tcp              # allow HTTPS
ufw deny 3306                  # deny MySQL from anywhere
ufw allow from 10.0.0.0/8     # allow all from private subnet
ufw allow from 10.0.0.0/8 to any port 5432    # allow postgres from private subnet only
ufw deny from 192.168.1.50     # deny specific IP entirely

# Default policies (most important):
ufw default deny incoming       # deny all inbound unless explicitly allowed
ufw default allow outgoing      # allow all outbound

# Remove rules:
ufw delete allow 80/tcp
ufw delete 3                   # delete rule number 3 (see numbers with: ufw status numbered)

ufw reload                     # reload rules
ufw reset                      # reset all rules to default (CAREFUL!)
ufw logging on                 # enable logging to /var/log/ufw.log
```

### New Server Hardening with ufw:
```bash
# Order matters: set defaults first, then allow exceptions, then enable
ufw default deny incoming
ufw default allow outgoing
ufw allow from YOUR_IP to any port 22    # only allow SSH from your IP
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable                               # firewall is now active
ufw status verbose                       # verify rules are correct
```

---

## 🔹 `firewall-cmd` — firewalld (RHEL/CentOS)

```bash
firewall-cmd --state                                           # check if running
firewall-cmd --list-all                                        # show all rules in default zone
firewall-cmd --zone=public --list-all                         # specific zone
firewall-cmd --get-zones                                       # list all zones
firewall-cmd --get-default-zone                               # current default zone

# Add rules (--permanent makes them survive reboot):
firewall-cmd --permanent --add-service=http                   # allow HTTP
firewall-cmd --permanent --add-service=https                  # allow HTTPS
firewall-cmd --permanent --add-port=8080/tcp                  # allow port 8080
firewall-cmd --permanent --remove-port=8080/tcp               # remove port
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=10.0.0.0/8 port port=5432 protocol=tcp accept'  # complex rule

# MUST reload after --permanent changes:
firewall-cmd --reload

# Verify:
firewall-cmd --list-ports
firewall-cmd --list-services
```

---

## 🔹 `iptables`

### Architecture
```
Incoming packet
  └─► PREROUTING chain (NAT, DNAT)
        └─► Routing decision
              ├─► If for this machine: INPUT chain
              │     └─► Local process
              └─► If forwarded: FORWARD chain
                        └─► POSTROUTING chain (SNAT, masquerade)
Local process OUTPUT
  └─► OUTPUT chain
        └─► POSTROUTING chain
              └─► Network interface
```

```bash
iptables -L -n -v                  # list all rules with counters, numeric
iptables -L INPUT -n -v --line-numbers  # INPUT chain with line numbers

# Add rules:
iptables -A INPUT -p tcp --dport 22 -j ACCEPT      # allow SSH
iptables -A INPUT -p tcp --dport 80 -j ACCEPT      # allow HTTP
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT  # allow established
iptables -A INPUT -j DROP                           # drop everything else (MUST be last)

# Insert rule at specific position:
iptables -I INPUT 1 -s 10.0.0.0/8 -j ACCEPT       # insert at position 1

# Delete rules:
iptables -D INPUT -p tcp --dport 80 -j ACCEPT      # delete specific rule
iptables -D INPUT 3                                 # delete rule at line 3

# Save and restore:
iptables-save > /etc/iptables/rules.v4             # save current rules
iptables-restore < /etc/iptables/rules.v4          # restore saved rules

# Flush (clear all rules):
iptables -F        # flush ALL chains — DANGER: removes all rules including SSH allow
iptables -F INPUT  # flush only INPUT chain
```

### ⚠️ Critical Warning
```bash
# NEVER do this on a remote server without a safety net:
iptables -F     # this removes ALL rules including the SSH allow rule
                # you are now locked out of the server!

# Safe approach: set a timer to flush rules in case you get locked out
at now + 5 minutes
> iptables -F
> Ctrl+D
# Now make your iptables changes
# If you get locked out, iptables will auto-flush in 5 minutes and you can reconnect
# If everything works, cancel: atrm <job_number>
```

---

## 🔹 `openssl`

```bash
# Generate RSA private key:
openssl genrsa -out private.key 2048
openssl genrsa -aes256 -out private-encrypted.key 2048   # with passphrase

# Generate Certificate Signing Request (CSR):
openssl req -new -key private.key -out request.csr

# Generate self-signed certificate:
openssl req -new -x509 -key private.key -out certificate.pem -days 365

# View certificate details:
openssl x509 -in certificate.pem -text -noout

# Check certificate expiry date:
openssl x509 -in certificate.pem -noout -enddate
# Output: notAfter=Jun 30 00:00:00 2026 GMT

# Check remote server certificate:
echo | openssl s_client -connect myapp.example.com:443 2>/dev/null | \
    openssl x509 -noout -enddate
# Output: notAfter=Jun 30 00:00:00 2026 GMT

# Verify certificate matches private key:
openssl x509 -noout -modulus -in cert.pem | openssl md5
openssl rsa -noout -modulus -in private.key | openssl md5
# Both MD5 values must match — if they don't, the cert and key are mismatched

# Test HTTPS connection and view full certificate chain:
openssl s_client -connect myapp.com:443 -showcerts
```

### Real-World DevOps Scenario
**Automate SSL certificate expiry monitoring:**
```bash
#!/bin/bash
DOMAINS=("api.company.com" "app.company.com" "admin.company.com")
WARN_DAYS=30

for domain in "${DOMAINS[@]}"; do
    expiry=$(echo | openssl s_client -connect "${domain}:443" 2>/dev/null | \
             openssl x509 -noout -enddate | cut -d= -f2)
    
    expiry_epoch=$(date -d "$expiry" +%s)
    now_epoch=$(date +%s)
    days_left=$(( (expiry_epoch - now_epoch) / 86400 ))
    
    if [ $days_left -lt $WARN_DAYS ]; then
        echo "WARNING: $domain certificate expires in $days_left days ($expiry)"
    else
        echo "OK: $domain expires in $days_left days"
    fi
done
```

---

## 🔹 `gpg`

```bash
gpg --gen-key                          # generate key pair
gpg --list-keys                        # list all public keys in keyring
gpg --list-secret-keys                 # list private keys
gpg --export -a "Your Name" > mykey.pub  # export public key (share this)
gpg --import mykey.pub                 # import someone else's public key

# Encrypt file (recipient needs their private key to decrypt):
gpg -e -r "recipient@company.com" secrets.env
# Creates: secrets.env.gpg

# Decrypt file (you need your private key):
gpg -d secrets.env.gpg > secrets.env

# Sign a file (prove it came from you):
gpg --sign --armor release.tar.gz
# Creates: release.tar.gz.asc

# Verify signature:
gpg --verify release.tar.gz.asc release.tar.gz
```

---

## 🔹 Checksums

```bash
# SHA256 (most commonly used for software verification):
sha256sum file.tar.gz                          # compute hash
sha256sum -c checksums.sha256                  # verify multiple files from checksum file

# Generate checksum file:
sha256sum *.tar.gz > checksums.sha256

# MD5 (faster but weaker — don't use for security, only for quick integrity checks):
md5sum file.tar.gz

# Verify a downloaded binary (e.g., Terraform):
wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_SHA256SUMS
sha256sum -c terraform_1.5.0_SHA256SUMS
# Output: terraform_1.5.0_linux_amd64.zip: OK
# If you see: FAILED — the file is corrupted or tampered with!
```

---

## 🔹 `chroot`

```bash
chroot /mnt/rescue /bin/bash     # enter chroot environment with bash
chroot /mnt/rescue               # uses /bin/sh if bash not specified
```

### Full Rescue Mode Recovery with chroot:
```bash
# Boot from rescue disk/ISO, then:

# 1. Mount the broken system's root partition
mount /dev/sda1 /mnt

# 2. Mount virtual filesystems (needed for many repair tools)
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /dev /mnt/dev
mount --bind /dev/pts /mnt/dev/pts
mount --bind /run /mnt/run

# 3. Enter the chroot environment
chroot /mnt /bin/bash

# 4. Now you're "inside" the broken system — fix your issues:
passwd root                                      # reset root password
grub2-install /dev/sda                          # reinstall GRUB bootloader
grub2-mkconfig -o /boot/grub2/grub.cfg          # regenerate GRUB config
vim /etc/fstab                                  # fix bad fstab entry
dnf reinstall kernel                            # reinstall kernel

# 5. Exit and reboot
exit
umount -R /mnt                                  # unmount everything
reboot
```

### Summary — Security & Access Control

**📌 5-Minute Recap:**
- **Never disable SELinux permanently** — use `setenforce 0` for testing, then fix with `semanage`/`restorecon`
- **`ufw default deny incoming`** then explicitly allow — deny-all-by-default is the correct firewall posture
- **`iptables -F` can lock you out remotely** — always set an `at` job to clear rules as a safety net
- **`openssl s_client -connect domain:443`** to check remote certificate expiry — automate this in monitoring
- **`sha256sum -c`** to verify downloaded binaries before installing — security supply chain best practice
- **`chroot`** into a broken system from a rescue disk to repair without booting into the broken OS
- **`gpg -e -r`** to encrypt sensitive files before storing them in repos or S3

---

# 15. Logging & Auditing

## What Is This Section About?
Logs are the historical record of everything that happened on your system. In production, logs are how you diagnose problems, detect security incidents, prove compliance, and understand system behavior. Knowing how to efficiently navigate logs is a core DevOps skill.

---

## 🔹 `journalctl` (Extended Coverage)

*(Core mechanics covered in Services & Systemd section — additional patterns here)*

```bash
# Pattern: Debug a service that crashed overnight
journalctl -u myapp -b -1 --no-pager | grep -E "ERROR|FATAL|Exception"
# -b -1 = logs from previous boot (the boot before last reboot)
# Explanation: If the server rebooted at 3 AM, this shows what happened before the reboot

# Pattern: Correlate events across multiple services at a specific time
journalctl --since "2026-04-17 03:00" --until "2026-04-17 03:05"
# Explanation: See everything that happened across all services in that 5-minute window

# Pattern: Find OOM kills
journalctl -k | grep -i "oom\|killed process"
# -k = kernel messages only
# Explanation: OOM killer events are kernel messages, not service messages

# Pattern: Filter by priority levels
journalctl -p 0..3   # only emergency, alert, critical, error (most severe)
journalctl -p err    # error and above

# Pattern: Real-time monitoring across multiple services
journalctl -f -u nginx -u myapp -u postgres
# Explanation: Follow logs from three services simultaneously in one stream
```

---

## 🔹 `/var/log/syslog` and `/var/log/messages`

```bash
# Ubuntu/Debian: /var/log/syslog  (general system messages)
# RHEL/CentOS:   /var/log/messages (same purpose)

tail -f /var/log/syslog          # live follow all system messages
grep -i "error" /var/log/syslog | tail -50   # recent errors
grep "kernel" /var/log/syslog | grep -v "audit"  # kernel messages
grep "Apr 17" /var/log/syslog | grep "myapp"    # specific date and service

# Other important log files:
# /var/log/auth.log    (Ubuntu) — authentication, sudo, SSH
# /var/log/secure      (RHEL)   — same as auth.log
# /var/log/kern.log             — kernel messages
# /var/log/dpkg.log             — package install/remove events (Ubuntu)
# /var/log/dnf.log              — package install/remove events (RHEL)
# /var/log/cron                 — cron job execution events (RHEL)
# /var/log/nginx/access.log     — nginx access log
# /var/log/nginx/error.log      — nginx error log
```

```bash
# Check for brute force SSH attacks:
$ grep "Failed password" /var/log/auth.log | tail -20
# Output:
# Apr 17 18:00:01 server sshd[9876]: Failed password for root from 203.0.113.50 port 54321 ssh2
# Apr 17 18:00:02 server sshd[9877]: Failed password for root from 203.0.113.50 port 54322 ssh2
# Explanation: Same IP attempting many times = brute force attack
# Action: block with ufw/iptables or fail2ban

# Check who used sudo recently:
$ grep sudo /var/log/auth.log | tail -20
# Output:
# Apr 17 18:00:01 server sudo: ec2-user : TTY=pts/0 ; COMMAND=/usr/bin/systemctl restart nginx
# Explanation: Full audit trail of sudo usage with user, terminal, and exact command
```

---

## 🔹 `dmesg`

### What It Does
`dmesg` reads the kernel **ring buffer** — a circular buffer in memory where the kernel writes messages about hardware detection, driver events, filesystem mounting, OOM killer activity, and more.

```bash
dmesg                          # show all kernel messages (from boot to now)
dmesg -T                       # with human-readable timestamps
dmesg -H                       # human-readable + follow mode
dmesg | tail -20               # last 20 kernel messages
dmesg | grep -i "error\|fail"  # filter errors
dmesg | grep -i "oom"          # OOM killer events
dmesg | grep -i "eth\|ens\|enp"  # network interface events
dmesg | grep -i "nvme\|sda\|xvd"  # disk events
dmesg -C                       # clear ring buffer (requires root)
dmesg --level=err,crit         # only errors and critical messages
```

```bash
$ dmesg -T | grep -i "killed\|oom" | tail -5
# Output:
# [Fri Apr 17 03:14:56 2026] Out of memory: Kill process 5678 (java) score 800 or sacrifice child
# [Fri Apr 17 03:14:56 2026] Killed process 5678 (java) total-vm:4194304kB, anon-rss:3145728kB
# Explanation:
# score 800 = OOM score (higher = more likely to be killed)
# total-vm = total virtual memory the process had claimed
# anon-rss = physical anonymous memory it was actually using (3GB!)
# This java process was using 3GB of RAM and got OOM-killed
# Action: increase instance size, add swap, or tune JVM memory settings

$ dmesg -T | grep -i "disk error\|I/O error\|SCSI error"
# Output (if any):
# [Fri Apr 17 10:00:01 2026] blk_update_request: I/O error, dev sda, sector 12345
# Explanation: Hardware disk errors — urgent! Check disk health with smartctl
```

---

## 🔹 `auditd` — Linux Audit System

### What auditd Does
The Linux audit framework provides a complete audit trail of security-relevant events: file access, system calls, authentication, privilege use. It can answer "who did what, when, on which file."

```bash
# auditctl — configure audit rules
auditctl -l                              # list current audit rules
auditctl -w /etc/passwd -p wa -k passwd_watch    # watch passwd file for writes
auditctl -w /etc/sudoers -p rwa -k sudoers       # watch sudoers
auditctl -w /etc/ssh/sshd_config -p wa -k sshd_config  # watch SSH config
auditctl -a always,exit -F arch=b64 -S execve -k all_commands  # log ALL commands

# Permission flags:
# -p w = write, r = read, a = attribute change, x = execute

# ausearch — search audit logs
ausearch -m AVC                          # SELinux denials
ausearch -m USER_LOGIN -ts today         # login events today
ausearch -k passwd_watch                 # events matching our "passwd_watch" key
ausearch -ui 1001 -ts recent            # events for UID 1001, recently
ausearch -x /bin/su -ts today           # all su executions today
ausearch -f /etc/passwd                  # all accesses to /etc/passwd

# aureport — generate summary reports
aureport                                 # overall summary
aureport --auth                          # authentication report
aureport --failed                        # all failed events
aureport --login                         # login report
aureport --file                          # file access report
```

```bash
$ ausearch -k passwd_watch -ts today
# Output:
# ----
# time->Fri Apr 17 18:00:01 2026
# type=PROCTITLE msg=audit(1713362401.000:1234): proctitle=757365726D6F64002D6147006465766F7073006563322D75736572
# type=PATH msg=audit(1713362401.000:1234): item=0 name="/etc/passwd" inode=655363 dev=fd:01 mode=0100644 ouid=0 ogid=0
# type=SYSCALL msg=audit(1713362401.000:1234): arch=c000003e syscall=188 success=yes exit=0 a0=... comm="usermod" exe="/usr/sbin/usermod"
# Explanation: usermod command modified /etc/passwd at the specified time
# Can decode proctitle: echo 757365726d6f64... | xxd -r -p = "usermod -aG devops ec2-user"
```

---

## 🔹 `logrotate`

### What It Does
`logrotate` manages log file size by rotating (archiving old logs), compressing, and cleaning them up automatically. Without it, log files grow unboundedly and fill your disk.

```bash
logrotate /etc/logrotate.conf          # run logrotate manually
logrotate -d /etc/logrotate.conf       # dry run — show what WOULD happen without doing it
logrotate -f /etc/logrotate.conf       # FORCE rotation even if not due
logrotate -d /etc/logrotate.d/myapp    # test specific config
```

```bash
# /etc/logrotate.d/myapp — example configuration
/var/log/myapp/*.log {
    daily                  # rotate daily (alternatives: weekly, monthly, size 100M)
    rotate 14              # keep 14 rotated files (14 days of history)
    compress               # gzip old files (saves 80-90% disk space)
    delaycompress          # compress on second rotation (current rotation kept uncompressed)
    missingok              # don't error if log file is missing (app may not have started yet)
    notifempty             # skip rotation if log is empty
    create 0640 appuser appgroup   # create fresh log file with these permissions
    dateext                # add date to rotated filename (app.log-2026-04-17.gz)
    sharedscripts          # run postrotate script ONCE for all matched files
    postrotate
        # Tell the app to reopen its log file after rotation
        /usr/bin/kill -USR1 $(cat /var/run/myapp.pid 2>/dev/null) 2>/dev/null || true
    endscript
}
```

### Why `postrotate` matters
When logrotate renames `app.log` to `app.log-2026-04-17`, the application still has a file handle to the original inode. It keeps writing to the rotated file, not the new `app.log`. The `postrotate` script signals the app to close and reopen its log file.

---

## 🔹 `last` / `lastb`

```bash
last                          # successful login history (reads /var/log/wtmp)
last -n 20                    # last 20 logins
last -a                       # show hostname in last column
last reboot                   # show reboot history
last -F                       # full timestamps

lastb                         # failed login attempts (reads /var/log/btmp)
lastb -n 20                   # last 20 failed attempts
```

```bash
$ last -n 10
# Output:
# ec2-user pts/0  10.0.0.5   Fri Apr 17 10:00   still logged in
# root     pts/1  10.0.1.1   Thu Apr 16 14:22 - 15:00  (00:38)
# reboot   system boot  5.15.0-aws  Wed Apr 15 08:00   still running
# Explanation:
# "still logged in" = currently active session
# "(00:38)" = session lasted 38 minutes
# "system boot" lines show when the server rebooted

$ lastb | awk '{print $3}' | sort | uniq -c | sort -rn | head -5
# Output:
# 4521 203.0.113.50    ← this IP has 4521 failed SSH attempts!
#  892 198.51.100.22
# Explanation: Identifies attackers by counting failed login attempts per IP
# Action: block top IPs: ufw deny from 203.0.113.50
```

### Summary — Logging & Auditing

**📌 5-Minute Recap:**
- **`journalctl -u service -f`** for live debugging; **`-b -1`** for post-crash analysis
- **`dmesg -T | grep -i oom`** to find OOM killer events — explains mystery process kills
- **`grep "Failed password" /var/log/auth.log`** for SSH brute force detection
- **`auditd` with `-w /etc/passwd -p wa`** provides file-level access auditing for compliance
- **`logrotate` prevents disk-full incidents** — configure it for every application log
- **`postrotate` in logrotate** is critical for apps that keep file handles open (signal them to reopen)
- **`lastb | sort | uniq -c`** identifies IPs with most failed logins — first step in SSH attack investigation

---

# 16. System Information & OS Details

## What Is This Section About?
Understanding your system's hardware, OS version, CPU, memory, and configuration is essential before troubleshooting, capacity planning, or deciding whether a workload is right for an instance type.

---

## 🔹 `uname` / `arch`

```bash
uname -a       # ALL: kernel name, hostname, kernel version, build, arch, OS
uname -r       # kernel RELEASE version only
uname -m       # machine hardware name (x86_64, aarch64, armv7l)
uname -s       # OS name (Linux)
uname -n       # network node hostname
arch           # machine hardware architecture (same as uname -m)
```

```bash
$ uname -a
# Output:
# Linux ip-10-0-1-50 5.15.0-1031-aws #35-Ubuntu SMP Fri Jan 20 21:45:05 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
# Breakdown:
# Linux         = OS type
# ip-10-0-1-50  = hostname
# 5.15.0-1031-aws = kernel version (5.15.0 = main version, 1031-aws = AWS patch level)
# #35-Ubuntu SMP = build number, SMP = Symmetric Multi-Processing (multi-core support)
# x86_64        = hardware architecture
# GNU/Linux     = operating system

$ uname -r
# Output: 5.15.0-1031-aws
# Use case: checking if you need to reboot after a kernel update
# After: apt upgrade linux-image-* → if "uname -r" doesn't match latest installed → reboot needed
```

---

## 🔹 `lscpu` / `lshw`

```bash
lscpu           # detailed CPU architecture information
lscpu | grep -E "^CPU\(s\)|Thread|Core|Socket|Model name|MHz"  # key fields only
nproc           # just the count of available processors (simplest)
nproc --all     # total processors including offline
```

```bash
$ lscpu
# Output:
# Architecture:           x86_64
# CPU(s):                 4          ← total logical CPUs (cores × threads)
# Thread(s) per core:     2          ← hyperthreading is enabled
# Core(s) per socket:     2          ← 2 physical cores
# Socket(s):              1          ← 1 physical CPU socket
# NUMA node(s):           1
# Model name:             Intel(R) Xeon(R) Platinum 8259CL @ 2.50GHz
# CPU MHz:                2499.998
# L1d cache:              32K
# L2 cache:               1024K
# L3 cache:               36608K
#
# For Java thread pool sizing: use CPU(s) = 4 as base
# For CPU-intensive apps: Cores = 2 is the real parallel capacity
# L3 cache 36M: large enough for most JVM applications

$ lshw -short
# Output:
# H/W path   Device    Class      Description
# ========================================
# /0/0                  memory     8GiB System Memory
# /0/1                  processor  Intel Xeon Platinum 8259CL
# /0/100/1/0   xvda     disk       20GB Elastic Block Store
# /0/1/0/0     eth0     network    Elastic Network Adapter
# Explanation: Quick hardware inventory — useful for capacity assessment
```

---

## 🔹 `hostname` / `hostnamectl`

```bash
hostname                             # show current hostname
hostname -I                          # show all IP addresses
hostname -f                          # FQDN (fully qualified domain name)
hostnamectl                          # detailed info including virtualization type
hostnamectl set-hostname newname     # permanently change hostname
```

```bash
$ hostnamectl
# Output:
#    Static hostname: prod-web-01
#          Icon name: computer-vm
#            Chassis: vm
#         Machine ID: abc123def456789abc123def456789ab
#            Boot ID: xyz789012345678xyz789012345678xy
#     Virtualization: amazon       ← running on AWS!
#   Operating System: Ubuntu 22.04.3 LTS
#             Kernel: Linux 5.15.0-1031-aws
#       Architecture: x86-64
#
# Key info:
# Virtualization: amazon = this is an EC2 instance
# Operating System: for apt vs dnf decision, patch management, etc.
# Kernel: to check if kernel patches have been applied

# Change hostname permanently (survives reboot):
hostnamectl set-hostname prod-web-01
# Also update /etc/hosts to add: 127.0.0.1 prod-web-01
```

---

## 🔹 `timedatectl`

```bash
timedatectl                               # show current date/time/timezone/NTP status
timedatectl list-timezones                # show all available timezones
timedatectl list-timezones | grep Asia    # filter by region
timedatectl set-timezone Asia/Kolkata     # set timezone
timedatectl set-ntp true                  # enable NTP synchronization
timedatectl show                          # machine-readable format
```

```bash
$ timedatectl
# Output:
#                Local time: Fri 2026-04-17 18:00:01 IST
#            Universal time: Fri 2026-04-17 12:30:01 UTC
#                  RTC time: Fri 2026-04-17 12:30:01
#                 Time zone: Asia/Kolkata (IST, +0530)
# System clock synchronized: yes         ← NTP is working
#               NTP service: active
#           RTC in local TZ: no
#
# "System clock synchronized: yes" = NTP is keeping time accurate
# If "no" = time may drift, which causes SSL cert validation failures,
#           log correlation issues, and distributed system problems

# Fix wrong timezone on a new EC2 instance:
timedatectl set-timezone UTC   # AWS recommends UTC for all servers
# OR: timedatectl set-timezone America/New_York for specific region
timedatectl   # verify change took effect
```

---

## 🔹 `lsns` — List Namespaces

```bash
lsns                    # list all namespaces on the system
lsns -t net             # network namespaces only
lsns -t pid             # PID namespaces only
lsns -t mnt             # mount namespaces only
```

```bash
$ lsns -t net
# Output:
#         NS TYPE NPROCS   PID USER   COMMAND
# 4026531992 net    142     1 root   /usr/lib/systemd/systemd --switched-root
# 4026532500 net      2  5678 root   docker-proxy -proto tcp -host-ip 0.0.0.0
# 4026532510 net      3  5689 root   /pause                 ← Kubernetes pause container
#
# Explanation: Each Docker container has its own network namespace
# The pause container is Kubernetes's network container that holds the pod's network namespace
# lsns helps you understand which process is in which isolation boundary
```

### Summary — System Information & OS Details

**📌 5-Minute Recap:**
- **`uname -r`** for kernel version; **`cat /etc/os-release`** for distro version — essential for patching
- **`lscpu`** shows CPU count for thread pool sizing; **`nproc`** for quick core count in scripts
- **`hostnamectl`** shows virtualization type — confirms you're on AWS/GCP/bare metal
- **`timedatectl set-timezone UTC`** for servers — log correlation across systems requires consistent timezone
- **`timedatectl` NTP synchronized: yes** must be true — time drift causes SSL errors and distributed system issues
- **`lsns -t net`** for understanding container network isolation — maps processes to their network namespaces
- **`free -h`** watch the `available` column, not `free` — Linux caches aggressively and that's normal

---

# 17. Power & Boot Management

## What Is This Section About?
Controlling system power state and managing the boot process are critical operational skills — especially during maintenance windows, disaster recovery, and post-incident system restoration.

---

## 🔹 `shutdown` / `reboot`

```bash
# shutdown
shutdown now                    # immediate shutdown (halt)
shutdown -h now                 # halt now
shutdown -r now                 # reboot now
shutdown -h +10                 # shutdown in 10 minutes
shutdown -h 22:00               # shutdown at 10:00 PM
shutdown -r +5 "Maintenance reboot in 5 minutes"  # with broadcast message to users
shutdown -c                     # cancel a scheduled shutdown

# reboot
reboot                          # reboot immediately
reboot --force                  # force reboot if normal reboot hangs
systemctl reboot                # via systemd (preferred on systemd systems)

# poweroff
poweroff                        # power off immediately
systemctl poweroff              # via systemd

# halt
halt                            # stop the CPU (may not power off)
halt -p                         # halt and power off
```

```bash
$ shutdown -r +10 "Server rebooting in 10 minutes for kernel update"
# Output: Broadcast message to all logged-in users:
# "Server rebooting in 10 minutes for kernel update"
# Shutdown scheduled for Fri 2026-04-17 18:10:00 UTC, use 'shutdown -c' to cancel

$ wall "System maintenance starting in 5 minutes - please save your work"
# Sends message to all logged-in users' terminals (useful before shutdown)
```

---

## 🔹 GRUB

### What GRUB Does
GRUB2 (Grand Unified Bootloader version 2) is the first program that runs after BIOS/UEFI hands control to the disk. It:
1. Loads the Linux kernel from `/boot/`
2. Passes kernel parameters (like `quiet`, `ro`, `init=`)
3. Loads the initial RAM filesystem (`initramfs`)
4. Transfers control to the kernel

```bash
# Update GRUB config after changes:
update-grub                                           # Ubuntu/Debian
grub2-mkconfig -o /boot/grub2/grub.cfg               # RHEL/CentOS (legacy BIOS)
grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg      # RHEL/CentOS (UEFI)

# Install GRUB bootloader (from rescue mode):
grub2-install /dev/sda                               # legacy BIOS
grub2-install --target=x86_64-efi \
    --efi-directory=/boot/efi \
    --bootloader-id=grub                             # UEFI

# GRUB configuration file:
# /etc/default/grub — user-editable settings
# GRUB_TIMEOUT=5 — menu display time
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash" — kernel parameters
# After editing: run update-grub or grub2-mkconfig to apply
```

---

## 🔹 Rescue Mode

### When You Need Rescue Mode
- System won't boot (bad `/etc/fstab`, broken kernel, missing file)
- Root password lost
- GRUB bootloader corrupted
- Filesystem corruption
- Wrong runlevel/target configured

### Method 1: Single-User Mode via GRUB
```bash
# At GRUB menu, press 'e' to edit the boot entry
# Find the line starting with "linux" (or "linuxefi")
# At the end of that line, add one of:
    systemd.unit=rescue.target    # rescue mode (minimal services, root filesystem RW)
    systemd.unit=emergency.target # emergency mode (minimal, read-
