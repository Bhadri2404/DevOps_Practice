

---

# 📋 Table of Contents
1. [Core Linux Commands](#core-linux-commands)
2. [Searching & Text Processing](#searching--text-processing)
3. [User & Group Management](#user--group-management)
4. [Permissions & Ownership](#permissions--ownership)
5. [Process & Job Management](#process--job-management)
6. [System Monitoring & Performance](#system-monitoring--performance)
7. [Disk & Filesystem Management](#disk--filesystem-management)
8. [Compression & Archiving](#compression--archiving)
9. [Networking & Remote Access](#networking--remote-access)
10. [Package Management](#package-management)
11. [Services & Systemd](#services--systemd)
12. [Scheduling (Cron, at, anacron)](#scheduling)
13. [Shell Environment & Variables](#shell-environment--variables)
14. [Security & Access Control](#security--access-control)
15. [Logging & Auditing](#logging--auditing)
16. [System Information & OS Details](#system-information--os-details)
17. [Power & Boot Management](#power--boot-management)
18. [File Transfer & Sharing](#file-transfer--sharing)
19. [Virtualization & Containers](#virtualization--containers)
20. [Developer Tools](#developer-tools)
21. [Troubleshooting & Recovery](#troubleshooting--recovery)
22. [Fun & Miscellaneous](#fun--miscellaneous)
23. [🔥 Interview Preparation](#-interview-preparation)

---

# 1. Core Linux Commands

---

## 🔹 `pwd` — Print Working Directory

### 1️⃣ What It Does
Prints the full absolute path of your current directory. It tells you exactly "where you are" in the filesystem.

### 2️⃣ Syntax
```bash
pwd
pwd -P   # resolve symlinks, show physical path
```

### 3️⃣ Important Options
| Option | Description |
|--------|-------------|
| `-P` | Show physical path (no symlinks) |
| `-L` | Show logical path (default, follows symlinks) |

### 4️⃣ Real-Time DevOps Scenario
When connected via SSH to an EC2 instance and navigating deep into `/var/log/nginx/`, always confirm your location before running destructive commands like `rm`.

### 5️⃣ Examples & Output
```bash
$ pwd
/home/ec2-user

$ cd /var/log/nginx && pwd
/var/log/nginx

$ pwd -P
/data/real-path   # when /data is a symlink
```

### 6️⃣ Common Mistakes
- Forgetting to run `pwd` before `rm -rf *` — always confirm location first.
- Using relative paths in shell scripts — always use `$(pwd)` or absolute paths.

### 7️⃣ Best Practices
- In shell scripts use: `SCRIPT_DIR=$(pwd)` to record current directory.
- Always `pwd` after `cd` on a new server to confirm your location.

### 🎯 Interview Point
> `pwd` uses the `$PWD` environment variable. You can also read it as `echo $PWD`.

---

## 🔹 `ls` — List Directory Contents

### 1️⃣ What It Does
Lists files and directories in the current or specified location. One of the most used commands in Linux.

### 2️⃣ Syntax
```bash
ls [options] [path]
```

### 3️⃣ Important Options
| Option | Description |
|--------|-------------|
| `-l` | Long listing: permissions, owner, size, date |
| `-a` | Show hidden files (starting with `.`) |
| `-h` | Human-readable file sizes (KB, MB) |
| `-t` | Sort by modification time (newest first) |
| `-r` | Reverse sort order |
| `-R` | Recursive listing of all subdirectories |
| `-S` | Sort by file size |
| `-i` | Show inode numbers |
| `--color` | Color output by file type |

### 4️⃣ Real-Time DevOps Scenario
Before deploying an app on EC2, check the `/var/www/html/` directory to verify correct files exist and permissions are right:
```bash
ls -lah /var/www/html/
```

### 5️⃣ Examples & Output
```bash
$ ls -lah /etc/nginx/
total 64K
drwxr-xr-x  6 root root 4.0K Apr 10 10:00 .
drwxr-xr-x 98 root root 4.0K Apr 10 09:00 ..
-rw-r--r--  1 root root 1.5K Apr 10 10:00 nginx.conf
drwxr-xr-x  2 root root 4.0K Apr 10 10:00 conf.d

$ ls -lt /var/log/    # newest logs first
$ ls -lS /var/log/    # largest files first
```

### 6️⃣ Common Mistakes
- Forgetting `-a` to see hidden config files like `.env`, `.bashrc`.
- Using `ls -l` without `-h` gives byte sizes, hard to read.

### 7️⃣ Best Practices
- Use `alias ll='ls -lah'` in `.bashrc` for convenience.
- Combine with `grep`: `ls -l /etc/ | grep nginx` to filter results.

### 🎯 Interview Point
> `ls -l` shows permissions in format `rwxrwxrwx` — first 3 bits = owner, middle = group, last = others.

---

## 🔹 `cd` — Change Directory

### 1️⃣ What It Does
Navigates between directories. Foundation of filesystem traversal.

### 2️⃣ Syntax
```bash
cd [directory]
cd ..        # go up one level
cd ~         # go to home directory
cd -         # go to previous directory
cd /         # go to root
```

### 3️⃣ Examples & Output
```bash
$ cd /var/log
$ pwd
/var/log

$ cd -
/home/ec2-user    # returns to previous dir

$ cd ~
$ pwd
/home/ec2-user
```

### 4️⃣ Real-Time DevOps Scenario
When debugging nginx issues:
```bash
cd /etc/nginx/conf.d/
ls -lah
cat default.conf
```

### 5️⃣ Common Mistakes
- `cd` without argument goes to `$HOME`, not `/`.
- Running `cd` in a script doesn't change the caller's directory — use subshells carefully.

---

## 🔹 `tree` — Display Directory Tree

### 1️⃣ What It Does
Shows directory and file structure in a visual tree format. Great for understanding project structure.

### 2️⃣ Syntax
```bash
tree [options] [path]
```

### 3️⃣ Important Options
| Option | Description |
|--------|-------------|
| `-L 2` | Limit depth to 2 levels |
| `-a` | Show hidden files |
| `-d` | Show directories only |
| `--du` | Show disk usage per directory |

### 4️⃣ Examples & Output
```bash
$ tree -L 2 /etc/nginx/
/etc/nginx/
├── conf.d
│   └── default.conf
├── nginx.conf
└── sites-enabled
    └── app.conf

$ tree -d /var/www/
```

### 5️⃣ Real-Time DevOps Scenario
Before handing over a project, use `tree -L 3 > structure.txt` to document the directory layout.

---

## 🔹 `stat` — File/Filesystem Status

### 1️⃣ What It Does
Shows detailed metadata about a file: inode, permissions, size, access/modify/change times.

### 2️⃣ Syntax
```bash
stat filename
stat -f /mount/point   # filesystem info
```

### 3️⃣ Examples & Output
```bash
$ stat /etc/passwd
  File: /etc/passwd
  Size: 2345      Blocks: 8   IO Block: 4096
Access: (0644/-rw-r--r--)  Uid: (0/root) Gid: (0/root)
Access: 2026-04-17 08:00:01
Modify: 2026-04-10 14:22:10
Change: 2026-04-10 14:22:10
```

### 4️⃣ Real-Time DevOps Scenario
Verify if a deployment config file was recently modified using `stat /etc/app/config.yml` — check the `Modify` time.

### 🎯 Interview Point
> `stat` shows **3 timestamps**: `atime` (last access), `mtime` (last modified), `ctime` (last status change — not creation time).

---

## 🔹 `touch` — Create Empty File / Update Timestamps

### 1️⃣ What It Does
Creates a new empty file if it doesn't exist. If it exists, updates its access and modification timestamps.

### 2️⃣ Syntax
```bash
touch filename
touch -t 202601010000 filename   # set specific timestamp
touch file1 file2 file3          # multiple files
```

### 3️⃣ Examples & Output
```bash
$ touch app.log
$ ls -lah app.log
-rw-r--r-- 1 ec2-user ec2-user 0 Apr 17 18:00 app.log

$ touch -t 202601010900 deploy.log
$ stat deploy.log | grep Modify
Modify: 2026-01-01 09:00:00
```

### 4️⃣ Real-Time DevOps Scenario
Create placeholder log files before starting an application so log rotation doesn't fail:
```bash
touch /var/log/myapp/app.log
chown appuser:appuser /var/log/myapp/app.log
```

---

## 🔹 `file` — Determine File Type

### 1️⃣ What It Does
Identifies the type of a file regardless of its extension. Uses magic bytes to detect the actual type.

### 2️⃣ Syntax
```bash
file filename
file -i filename   # show MIME type
```

### 3️⃣ Examples & Output
```bash
$ file /bin/ls
/bin/ls: ELF 64-bit LSB executable, x86-64

$ file script.sh
script.sh: Bourne-Again shell script, ASCII text executable

$ file archive.tar.gz
archive.tar.gz: gzip compressed data
```

### 4️⃣ Real-Time DevOps Scenario
When a file arrives with wrong extension, `file suspicious.bin` reveals its true type before executing it.

---

## 🔹 `basename` & `dirname`

### 1️⃣ What They Do
- `basename` — extracts filename from a full path
- `dirname` — extracts directory portion from a full path

### 2️⃣ Syntax
```bash
basename /path/to/file.txt        # → file.txt
basename /path/to/file.txt .txt   # → file (strip extension)
dirname /path/to/file.txt         # → /path/to
```

### 3️⃣ Examples & Output
```bash
$ basename /var/log/nginx/access.log
access.log

$ dirname /var/log/nginx/access.log
/var/log/nginx

$ basename /opt/app/deploy.sh .sh
deploy
```

### 4️⃣ Real-Time DevOps Scenario
In deployment scripts:
```bash
SCRIPT_DIR=$(dirname "$0")
LOG_FILE=$(basename "$0" .sh).log
```

---

## 🔹 `cat` — Concatenate & Display Files

### 1️⃣ What It Does
Displays file contents to stdout. Can concatenate multiple files. One of the most used commands.

### 2️⃣ Syntax
```bash
cat filename
cat file1 file2 > combined.txt
cat -n filename          # show line numbers
cat -A filename          # show all chars including ^M (Windows line endings)
```

### 3️⃣ Examples & Output
```bash
$ cat /etc/os-release
NAME="Ubuntu"
VERSION="22.04.3 LTS"

$ cat -n /etc/nginx/nginx.conf | head -20
     1  user www-data;
     2  worker_processes auto;

$ cat /dev/null > app.log   # truncate/empty a log file
```

### 4️⃣ Real-Time DevOps Scenario
Quickly view a config file: `cat /etc/nginx/nginx.conf` or combine multiple SQL migration files: `cat migration_*.sql > all_migrations.sql`.

### 5️⃣ Common Mistakes
- Using `cat` for large files — use `less` instead.
- `cat > file` will overwrite — use `cat >> file` to append.

---

## 🔹 `tac` — Reverse cat

### 1️⃣ What It Does
Displays file contents in reverse order (last line first). Useful for reading logs from bottom up.

### 2️⃣ Syntax
```bash
tac filename
tac access.log | head -20   # last 20 log lines
```

### 3️⃣ Examples & Output
```bash
$ echo -e "line1\nline2\nline3" | tac
line3
line2
line1
```

---

## 🔹 `less` — View Files Page by Page (Scrollable)

### 1️⃣ What It Does
Opens a file for interactive, scrollable reading. Does NOT load entire file into memory — great for large log files.

### 2️⃣ Syntax
```bash
less filename
less +F filename     # follow mode (like tail -f)
```

### 3️⃣ Important Keys Inside `less`
| Key | Action |
|-----|--------|
| `Space` | Next page |
| `b` | Previous page |
| `G` | Go to end |
| `g` | Go to beginning |
| `/pattern` | Search forward |
| `n` | Next search match |
| `q` | Quit |
| `F` | Follow (live tail) |

### 4️⃣ Examples & Output
```bash
$ less /var/log/syslog
$ less +G /var/log/nginx/access.log    # open at end
$ less +/ERROR /var/log/app.log        # open at first ERROR match
```

### 4️⃣ Real-Time DevOps Scenario
Reviewing a 500MB log file on an EC2 instance — never use `cat`. Always use `less /var/log/app.log` to avoid flooding the terminal.

---

## 🔹 `more` — View File Page by Page (Simpler)

### 1️⃣ What It Does
Similar to `less` but simpler — only scrolls forward. Legacy tool. Use `less` in most cases.

### 2️⃣ Syntax
```bash
more filename
command | more
```

---

## 🔹 `head` — Show First N Lines

### 1️⃣ What It Does
Displays the first lines of a file. Default is 10 lines.

### 2️⃣ Syntax
```bash
head filename
head -n 20 filename   # first 20 lines
head -c 100 filename  # first 100 bytes
```

### 3️⃣ Examples & Output
```bash
$ head -n 5 /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin

$ head -c 50 /var/log/app.log
2026-04-17 10:00:01 INFO Application started
```

### 4️⃣ Real-Time DevOps Scenario
Verify top of a config file after editing: `head -20 /etc/nginx/nginx.conf`

---

## 🔹 `tail` — Show Last N Lines

### 1️⃣ What It Does
Shows the last lines of a file. The `-f` flag is critical for **live log monitoring** in production.

### 2️⃣ Syntax
```bash
tail filename
tail -n 50 filename        # last 50 lines
tail -f filename           # follow (live stream)
tail -f -n 100 filename    # last 100 + follow
```

### 3️⃣ Examples & Output
```bash
$ tail -f /var/log/nginx/error.log
2026-04-17 18:22:01 [error] 502 Bad Gateway upstream...

$ tail -n 100 /var/log/app.log | grep ERROR
2026-04-17 18:20:55 ERROR Database connection failed
```

### 4️⃣ Real-Time DevOps Scenario
During a production deployment, always open a second terminal with:
```bash
tail -f /var/log/nginx/access.log | grep "500\|502\|503"
```

### 🎯 Interview Point
> `tail -f` keeps the file handle open. `tail -F` will re-open the file if it gets rotated — always use `-F` in production monitoring scripts.

---

## 🔹 `nl` — Number Lines

### 1️⃣ What It Does
Displays a file with line numbers. Useful for referencing specific lines in configs.

### 2️⃣ Syntax
```bash
nl filename
nl -ba filename   # number all lines including blank
```

### 3️⃣ Examples & Output
```bash
$ nl /etc/hosts
     1  127.0.0.1   localhost
     2  ::1         localhost ip6-localhost
```

---

## 🔹 `strings` — Extract Readable Text from Binary

### 1️⃣ What It Does
Extracts human-readable strings from binary files or executables. Used in debugging and security analysis.

### 2️⃣ Syntax
```bash
strings binaryfile
strings -n 8 binaryfile   # min string length 8
```

### 3️⃣ Examples & Output
```bash
$ strings /usr/bin/nginx | grep version
nginx version: nginx/1.24.0

$ strings malware.bin | grep http
http://bad-domain.com/payload
```

### 4️⃣ Real-Time DevOps Scenario
When investigating a suspicious binary on a server, use `strings` to see embedded URLs, credentials, or error messages.

---

## 🔹 `od` — Octal Dump

### 1️⃣ What It Does
Displays file content in octal, hex, ASCII or other formats. Useful for debugging binary data.

### 2️⃣ Syntax
```bash
od -c filename     # character view
od -x filename     # hex view
od -An -tx1 file   # hex without address
```

### 3️⃣ Examples & Output
```bash
$ echo "Hello" | od -c
0000000   H   e   l   l   o  \n
0000006

$ echo "ABC" | od -x
0000000 4241 0a43
```

---

## 🔹 `nano` — Simple Terminal Text Editor

### 1️⃣ What It Does
A beginner-friendly, simple terminal editor. No modes (unlike vim). Great for quick edits.

### 2️⃣ Syntax
```bash
nano filename
nano +10 filename    # open at line 10
```

### 3️⃣ Key Shortcuts
| Shortcut | Action |
|----------|--------|
| `Ctrl+S` | Save |
| `Ctrl+X` | Exit |
| `Ctrl+W` | Search |
| `Ctrl+K` | Cut line |
| `Ctrl+U` | Paste |
| `Alt+U` | Undo |

### 4️⃣ Real-Time DevOps Scenario
Quick edit of crontab or nginx config:
```bash
nano /etc/nginx/sites-available/myapp.conf
```

---

## 🔹 `vi` / `vim` — Advanced Terminal Text Editor

### 1️⃣ What It Does
Powerful modal text editor available on virtually every Linux system. Two main modes: **Normal** and **Insert**.

### 2️⃣ Syntax
```bash
vim filename
vim +50 filename     # open at line 50
vim -R filename      # read-only
```

### 3️⃣ Essential Commands
| Command | Action |
|---------|--------|
| `i` | Enter insert mode |
| `Esc` | Return to normal mode |
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` | Paste |
| `:/pattern` | Search |
| `:%s/old/new/g` | Global replace |
| `gg` | Go to first line |
| `G` | Go to last line |
| `u` | Undo |

### 4️⃣ Real-Time DevOps Scenario
Edit a Kubernetes deployment YAML on a remote server where only `vi` is available:
```bash
vim /etc/kubernetes/manifests/kube-apiserver.yaml
```

### 5️⃣ Common Mistakes
- Forgetting to press `Esc` before saving — type `:wq` while in insert mode accidentally.
- Always use `vim -R` for read-only viewing of critical config files.

### 🎯 Interview Point
> `vi` is always available on any POSIX-compliant system. `vim` (Vi IMproved) has syntax highlighting, undo history, and plugins.

---

## 🔹 `emacs` — Feature-Rich Text Editor

### 1️⃣ What It Does
A powerful editor with GUI and terminal modes. Includes built-in shell, file manager, and email client.

### 2️⃣ Syntax
```bash
emacs filename
emacs -nw filename   # terminal mode (no window)
```

### 3️⃣ Key Shortcuts
| Shortcut | Action |
|----------|--------|
| `Ctrl+X Ctrl+S` | Save |
| `Ctrl+X Ctrl+C` | Quit |
| `Ctrl+S` | Search |
| `Alt+%` | Find and replace |

---

## 🔹 `hexdump` / `hd` — Hex Display

### 1️⃣ What It Does
Displays file contents in hexadecimal, decimal, octal, or ASCII. Useful for inspecting binary files.

### 2️⃣ Syntax
```bash
hexdump filename
hexdump -C filename    # hex + ASCII side by side
hd filename            # alias for hexdump -C
```

### 3️⃣ Examples & Output
```bash
$ echo "Hello" | hexdump -C
00000000  48 65 6c 6c 6f 0a     |Hello.|
00000006
```

### 4️⃣ Real-Time DevOps Scenario
Verify magic bytes of a downloaded binary to confirm it's not corrupted:
```bash
hexdump -C /usr/local/bin/app | head -2
```

---

## 🔹 `xxd` — Hex Dump / Binary Conversion

### 1️⃣ What It Does
Creates hex dumps OR converts hex back to binary. More powerful than `hexdump` for reverse operations.

### 2️⃣ Syntax
```bash
xxd filename
xxd -r hexfile > binary   # reverse: hex → binary
xxd -p filename            # plain hex output
```

### 3️⃣ Examples & Output
```bash
$ echo "DevOps" | xxd
00000000: 4465 764f 7073 0a   DevOps.

$ echo "4465764f7073" | xxd -r -p
DevOps
```

---

## 🔹 `col` / `colrm` — Column Formatting

### 1️⃣ What They Do
- `col` — filters reverse line feeds, cleans man page output
- `colrm` — removes specific columns from text

### 2️⃣ Syntax
```bash
man ls | col -b > ls-help.txt    # clean man page to text
cut -d: -f1 /etc/passwd | colrm 1 3   # remove cols 1-3
```

---

## 🔹 `clear` — Clear Terminal Screen

```bash
clear
# or shortcut: Ctrl+L
```

---

## 🔹 `reset` — Reset Terminal

### 1️⃣ What It Does
Fully resets terminal state. Use when terminal is garbled after `cat`-ing a binary file.

```bash
reset
```

### 4️⃣ Real-Time DevOps Scenario
After accidentally `cat`-ing a binary file corrupts your terminal output, `reset` restores it.

---

## 🔹 `sleep` — Pause Execution

### 1️⃣ What It Does
Pauses script execution for a specified duration. Critical in automation scripts.

### 2️⃣ Syntax
```bash
sleep 5        # 5 seconds
sleep 2m       # 2 minutes
sleep 1h       # 1 hour
```

### 3️⃣ Examples
```bash
# Wait for service to start before health check
systemctl start myapp
sleep 5
curl http://localhost:8080/health

# In deployment script
echo "Deploying..."
deploy_app
sleep 10
check_health
```

---

## 🔹 `yes` — Repeat Output

### 1️⃣ What It Does
Continuously outputs a string (default: `y`) until stopped. Useful to auto-confirm prompts.

### 2️⃣ Syntax
```bash
yes | apt-get install nginx    # auto-confirm installs
yes "no" | some-command        # auto-answer "no"
```

### 4️⃣ Real-Time DevOps Scenario
In automated provisioning scripts where interactive confirmation can't be avoided.

---

## 🔹 `rev` — Reverse Lines

```bash
$ echo "DevOps" | rev
spOveD

$ rev filename    # reverse each line in file
```

---

## 🔹 `cmp` — Compare Files Byte by Byte

### 1️⃣ What It Does
Compares two files byte by byte. Returns the position of the first difference. Used for binary comparison.

### 2️⃣ Syntax
```bash
cmp file1 file2
cmp -l file1 file2    # list all differing bytes
```

### 3️⃣ Examples & Output
```bash
$ cmp config.bak config.conf
config.bak config.conf differ: byte 145, line 8

$ cmp -s file1 file2; echo $?
0    # 0 = identical, 1 = different
```

### 4️⃣ Real-Time DevOps Scenario
Verify that a copied config file on another server is byte-identical to the original:
```bash
scp server1:/etc/app.conf /tmp/app.conf.remote
cmp /etc/app.conf /tmp/app.conf.remote
```

---

## 🔹 `comm` — Compare Two Sorted Files

### 1️⃣ What It Does
Compares two **sorted** files line by line and shows lines unique to each file or common to both.

### 2️⃣ Syntax
```bash
comm file1 file2
comm -12 file1 file2   # only common lines
comm -23 file1 file2   # only in file1
comm -13 file1 file2   # only in file2
```

### 3️⃣ Examples
```bash
$ comm -12 <(sort servers_old.txt) <(sort servers_new.txt)
# Shows servers in both lists

$ comm -23 <(sort all_users.txt) <(sort active_users.txt)
# Shows users only in all_users (i.e., inactive)
```

---

# 2. Searching & Text Processing

---

## 🔹 `grep` — Search Patterns in Files

### 1️⃣ What It Does
Searches for text patterns using regular expressions. One of the most powerful and used commands in DevOps.

### 2️⃣ Syntax
```bash
grep [options] pattern file
grep pattern file1 file2
command | grep pattern
```

### 3️⃣ Important Options
| Option | Description |
|--------|-------------|
| `-i` | Case-insensitive search |
| `-r` | Recursive (search all files in dir) |
| `-l` | Show only filenames with matches |
| `-n` | Show line numbers |
| `-v` | Invert — show lines NOT matching |
| `-c` | Count matching lines |
| `-A n` | Show n lines after match |
| `-B n` | Show n lines before match |
| `-C n` | Show n lines around match |
| `-E` | Extended regex (same as `egrep`) |
| `-F` | Fixed string (no regex, same as `fgrep`) |
| `-w` | Match whole word only |
| `--color` | Highlight matches |

### 4️⃣ Examples & Output
```bash
# Find all ERROR lines in app log
$ grep -n "ERROR" /var/log/app.log
145: 2026-04-17 10:22 ERROR DB connection failed

# Case-insensitive search
$ grep -i "error\|warn" /var/log/nginx/error.log

# Recursive search in config directory
$ grep -rl "database_host" /etc/
/etc/app/config.yml
/etc/myservice/settings.conf

# Show 3 lines of context around match
$ grep -C 3 "Out of memory" /var/log/syslog

# Count 500 errors in nginx access log
$ grep -c " 500 " /var/log/nginx/access.log
23
```

### 5️⃣ Real-Time DevOps Scenario
During a production incident, find all 5xx errors in the last hour from nginx logs:
```bash
grep "$(date '+%d/%b/%Y:%H')" /var/log/nginx/access.log | grep " 5[0-9][0-9] "
```

### 6️⃣ Common Mistakes
- `grep "string"` is case-sensitive by default — use `-i` when unsure.
- Using basic regex when you need extended — use `-E` for `+`, `|`, `()`.
- `grep -r` on `/` can be very slow — always specify a directory.

### 🎯 Interview Point
> `grep` vs `egrep` vs `fgrep`: `grep` uses basic regex, `egrep` (`grep -E`) uses extended regex (supports `+`,`?`,`|`), `fgrep` (`grep -F`) treats pattern as literal string (fastest).

---

## 🔹 `egrep` — Extended grep

```bash
egrep "ERROR|WARN|FATAL" /var/log/app.log
# Same as: grep -E "ERROR|WARN|FATAL" /var/log/app.log
```

---

## 🔹 `fgrep` — Fixed String grep

```bash
fgrep "192.168.1.1" /var/log/auth.log
# Searches for literal string, no regex interpretation
# Same as: grep -F "192.168.1.1"
```

---

## 🔹 `zgrep` — grep on Compressed Files

### 1️⃣ What It Does
Runs grep on `.gz` compressed files without decompressing first. Critical for searching archived logs.

### 2️⃣ Syntax
```bash
zgrep "pattern" file.gz
zgrep -i "error" /var/log/syslog.1.gz
```

### 3️⃣ Examples
```bash
$ zgrep "CRITICAL" /var/log/app.log.1.gz
2026-04-10 03:15 CRITICAL: Disk full on /dev/sda1
```

### 4️⃣ Real-Time DevOps Scenario
Search last week's compressed log archive for a specific error without unpacking it:
```bash
zgrep "OOM killer" /var/log/syslog-*.gz
```

---

## 🔹 `find` — Search Files & Directories

### 1️⃣ What It Does
Searches for files and directories based on name, type, size, permissions, modification time, and more. Extremely powerful.

### 2️⃣ Syntax
```bash
find [path] [expression]
```

### 3️⃣ Important Options
| Option | Description |
|--------|-------------|
| `-name "pattern"` | Find by name (case-sensitive) |
| `-iname "pattern"` | Find by name (case-insensitive) |
| `-type f` | Files only |
| `-type d` | Directories only |
| `-type l` | Symlinks only |
| `-size +100M` | Files larger than 100MB |
| `-mtime -7` | Modified in last 7 days |
| `-mtime +30` | Modified more than 30 days ago |
| `-perm 644` | Find by exact permission |
| `-user username` | Find files owned by user |
| `-exec cmd {} \;` | Execute command on each found file |
| `-delete` | Delete found files |
| `-maxdepth n` | Limit search depth |

### 4️⃣ Examples & Output
```bash
# Find large files filling disk
$ find / -type f -size +500M 2>/dev/null
/var/log/app/old-debug.log
/home/ec2-user/core.dump

# Find files modified in last 24 hours
$ find /var/www -type f -mtime -1

# Find files with 777 permissions (security risk)
$ find / -type f -perm 777 2>/dev/null

# Delete old log files > 30 days
$ find /var/log/app/ -name "*.log" -mtime +30 -delete

# Find and archive old files
$ find /backup/ -mtime +7 -exec gzip {} \;

# Find configs containing a keyword
$ find /etc -name "*.conf" -exec grep -l "PROD_DB" {} \;
```

### 5️⃣ Real-Time DevOps Scenario
EC2 root partition filling up. Find what's consuming space:
```bash
find / -type f -size +100M -printf "%s\t%p\n" 2>/dev/null | sort -n | tail -20
```

### 6️⃣ Common Mistakes
- Using `find -exec rm -rf {} \;` without testing first — always run without `-delete` first to preview.
- Not redirecting `2>/dev/null` hides permission errors in output.

### 🎯 Interview Point
> `find` searches in real-time (not a database). Use `locate` for speed. Use `find` for accuracy and complex queries.

---

## 🔹 `locate` — Fast File Search

### 1️⃣ What It Does
Finds files using a pre-built database (`/var/lib/mlocate`). Much faster than `find` but not always up to date.

### 2️⃣ Syntax
```bash
locate filename
locate -i filename      # case-insensitive
locate "*.conf" | grep nginx
```

### 3️⃣ Examples
```bash
$ locate nginx.conf
/etc/nginx/nginx.conf
/usr/share/doc/nginx/nginx.conf.example

$ locate -c ".log"    # count matching files
4521
```

### 4️⃣ Common Mistakes
- `locate` won't find files created after last `updatedb` run.
- Always run `updatedb` first on a new server before using `locate`.

---

## 🔹 `updatedb` — Update locate Database

```bash
sudo updatedb         # update the locate database
sudo updatedb -v      # verbose
```

### 4️⃣ Real-Time DevOps Scenario
After deploying new configs, run `sudo updatedb` so `locate` can find them instantly.

---

## 🔹 `which` — Find Command Path

```bash
$ which nginx
/usr/sbin/nginx

$ which python3
/usr/bin/python3
```

### 4️⃣ Real-Time DevOps Scenario
Before running a script, confirm which version of Python is being used: `which python` vs `which python3`.

---

## 🔹 `whereis` — Find Binary, Source & Man Pages

```bash
$ whereis nginx
nginx: /usr/sbin/nginx /etc/nginx /usr/share/man/man8/nginx.8.gz

$ whereis python3
python3: /usr/bin/python3 /usr/lib/python3
```

### 🎯 Interview Point
> `which` shows only the executable path. `whereis` shows binary, source code, and man pages.

---

## 🔹 `type` — Show Command Type

```bash
$ type ls
ls is aliased to 'ls --color=auto'

$ type cd
cd is a shell builtin

$ type nginx
nginx is /usr/sbin/nginx
```

---

## 🔹 `cut` — Extract Columns/Fields from Text

### 1️⃣ What It Does
Extracts specific columns or fields from text. Works on character positions or delimiters.

### 2️⃣ Syntax
```bash
cut -d 'delimiter' -f field_number file
cut -c 1-10 file    # characters 1 to 10
```

### 3️⃣ Examples & Output
```bash
# Extract usernames from /etc/passwd
$ cut -d: -f1 /etc/passwd
root
daemon
ec2-user

# Extract IP addresses from access log (field 1)
$ cut -d' ' -f1 /var/log/nginx/access.log | sort | uniq -c | sort -rn | head -10

# Get first 10 characters of each line
$ cut -c1-10 /etc/hosts
127.0.0.1
::1
```

### 4️⃣ Real-Time DevOps Scenario
Extract a list of all listening ports from `ss` output:
```bash
ss -tulpn | awk 'NR>1' | cut -d: -f2 | cut -d' ' -f1 | sort -u
```

---

## 🔹 `sort` — Sort Lines of Text

### 1️⃣ What It Does
Sorts lines alphabetically, numerically, or by specific fields.

### 2️⃣ Syntax
```bash
sort file
sort -n file          # numeric sort
sort -r file          # reverse
sort -u file          # unique (remove duplicates)
sort -k2 file         # sort by column 2
sort -t: -k3 -n file  # sort /etc/passwd by UID
```

### 3️⃣ Examples & Output
```bash
# Find top 10 IPs hitting your server
$ cut -d' ' -f1 /var/log/nginx/access.log | sort | uniq -c | sort -rn | head -10
   1523 192.168.1.105
    892 10.0.0.22
    445 203.0.113.99

# Sort process list by memory usage
$ ps aux | sort -k4 -rn | head -10
```

---

## 🔹 `uniq` — Remove Duplicate Lines

### 1️⃣ What It Does
Removes or reports duplicate **adjacent** lines. Must be used on sorted input.

### 2️⃣ Syntax
```bash
sort file | uniq
sort file | uniq -c    # count occurrences
sort file | uniq -d    # show only duplicates
sort file | uniq -u    # show only unique lines
```

### 3️⃣ Examples & Output
```bash
$ cat access.log | cut -d' ' -f1 | sort | uniq -c | sort -rn
   4521 10.0.0.1
   1203 192.168.1.50
     42 203.0.113.5
```

### 4️⃣ Real-Time DevOps Scenario
Find duplicate cron jobs or duplicate user entries across server inventory files.

---

## 🔹 `join` — Join Two Files on Common Field

```bash
join file1 file2                 # join on first field
join -t: -1 1 -2 1 file1 file2  # custom delimiter, fields
```

---

## 🔹 `paste` — Merge Files Side by Side

```bash
$ paste file1 file2
# Merges corresponding lines with tab separator

$ paste -d, names.txt ages.txt
Alice,30
Bob,25

$ paste -s file    # serial paste (all in one line)
```

---

## 🔹 `wc` — Word/Line/Character Count

### 1️⃣ What It Does
Counts lines, words, and characters in a file or input.

### 2️⃣ Syntax
```bash
wc filename
wc -l filename   # lines only
wc -w filename   # words only
wc -c filename   # bytes
wc -m filename   # characters
```

### 3️⃣ Examples & Output
```bash
$ wc -l /var/log/nginx/access.log
145283 /var/log/nginx/access.log

$ grep "ERROR" app.log | wc -l
47

$ ls /etc/*.conf | wc -l
32
```

### 4️⃣ Real-Time DevOps Scenario
Check how many 500 errors occurred:
```bash
grep " 500 " /var/log/nginx/access.log | wc -l
```

---

## 🔹 `tr` — Translate or Delete Characters

### 1️⃣ What It Does
Translates, deletes, or squeezes characters from input. Works on character-by-character basis.

### 2️⃣ Syntax
```bash
tr [options] SET1 [SET2]
echo "text" | tr 'a-z' 'A-Z'   # lowercase to uppercase
echo "text" | tr -d ' '         # delete spaces
echo "text" | tr -s ' '         # squeeze multiple spaces
```

### 3️⃣ Examples & Output
```bash
$ echo "hello world" | tr 'a-z' 'A-Z'
HELLO WORLD

$ echo "path:to:file" | tr ':' '\n'
path
to
file

$ cat config.txt | tr -d '\r'   # remove Windows carriage returns
```

### 4️⃣ Real-Time DevOps Scenario
Fix Windows line endings in a script file uploaded to Linux:
```bash
cat script.sh | tr -d '\r' > script_fixed.sh
```

---

## 🔹 `xargs` — Build Commands from Input

### 1️⃣ What It Does
Takes input from stdin and builds command arguments from it. Bridges pipes with commands that don't read stdin.

### 2️⃣ Syntax
```bash
command | xargs another_command
find . -name "*.log" | xargs rm
echo "file1 file2" | xargs ls -lah
```

### 3️⃣ Examples & Output
```bash
# Delete all .log files older than 30 days
$ find /var/log -name "*.log" -mtime +30 | xargs rm -f

# Check each config file syntax
$ find /etc/nginx -name "*.conf" | xargs nginx -t

# Pass multiple args with -I
$ cat server_list.txt | xargs -I{} ssh {} "uptime"

# Limit args per command with -n
$ echo "a b c d" | xargs -n2 echo
a b
c d
```

### 4️⃣ Real-Time DevOps Scenario
Run a health check command on 50 servers listed in a file:
```bash
cat servers.txt | xargs -P 10 -I{} ssh {} "systemctl status nginx"
```

### 🎯 Interview Point
> `-P n` runs n parallel processes — great for bulk operations across many servers.

---

## 🔹 `tee` — Write to File AND Display

### 1️⃣ What It Does
Reads from stdin and writes to both stdout AND a file simultaneously. Like a T-junction in a pipe.

### 2️⃣ Syntax
```bash
command | tee outputfile
command | tee -a outputfile    # append mode
command | tee file1 file2      # write to multiple files
```

### 3️⃣ Examples & Output
```bash
# Deploy and log output simultaneously
$ ./deploy.sh | tee /var/log/deploy-$(date +%F).log

# Check nginx config and save output
$ nginx -T | tee /tmp/nginx-config-dump.txt

# Run apt upgrade and save output
$ apt-get upgrade -y | tee /tmp/upgrade.log
```

### 4️⃣ Real-Time DevOps Scenario
During production deployments, always tee output to a log file so you have a record:
```bash
kubectl apply -f deployment.yaml | tee /var/log/k8s-deploy.log
```

---

## 🔹 `awk` — Pattern Scanning & Processing Language

### 1️⃣ What It Does
A powerful text-processing language that processes files line by line. Ideal for structured data, columns, and reports. Named after its creators: Aho, Weinberger, Kernighan.

### 2️⃣ Syntax
```bash
awk 'pattern { action }' file
awk -F: '{ print $1 }' /etc/passwd    # custom field separator
awk 'NR==5' file                       # print line 5
awk '$3 > 100' file                    # conditional
```

### 3️⃣ Key Variables
| Variable | Description |
|----------|-------------|
| `$0` | Entire line |
| `$1, $2...` | Fields 1, 2... |
| `NR` | Current line number |
| `NF` | Number of fields |
| `FS` | Field separator (default: space) |
| `RS` | Record separator |

### 4️⃣ Examples & Output
```bash
# Print usernames and shells from /etc/passwd
$ awk -F: '{ print $1, $7 }' /etc/passwd
root /bin/bash
ec2-user /bin/bash

# Print memory usage from free command
$ free -m | awk 'NR==2 { printf "Used: %dMB / Total: %dMB\n", $3, $2 }'
Used: 1024MB / Total: 4096MB

# Sum column 5 (file sizes) from ls output
$ ls -l | awk '{ sum += $5 } END { print "Total:", sum, "bytes" }'
Total: 2048576 bytes

# Find IPs that hit server more than 1000 times
$ awk '{ print $1 }' /var/log/nginx/access.log | sort | uniq -c | awk '$1 > 1000 { print $2 }'
```

### 5️⃣ Real-Time DevOps Scenario
Parse disk usage and alert if any partition is over 80%:
```bash
df -h | awk 'NR>1 { gsub(/%/,"",$5); if ($5+0 > 80) print "ALERT:", $6, "is", $5"% full" }'
```

### 🎯 Interview Point
> `awk` processes line by line and splits into fields. It supports `BEGIN` (runs before processing) and `END` (runs after processing) blocks.

---

## 🔹 `gawk` / `mawk` — AWK Variants

```bash
gawk    # GNU awk — full-featured, supports POSIX + extensions
mawk    # Lightweight awk — faster for simple processing
```

---

## 🔹 `sed` — Stream Editor

### 1️⃣ What It Does
Performs text transformations on files or streams: substitute, delete, insert, append. Processes line by line.

### 2️⃣ Syntax
```bash
sed 's/old/new/' file           # substitute first occurrence per line
sed 's/old/new/g' file          # substitute all occurrences
sed -i 's/old/new/g' file       # in-place edit
sed -i.bak 's/old/new/g' file   # in-place with backup
sed '5d' file                   # delete line 5
sed '/pattern/d' file           # delete lines matching pattern
sed -n '10,20p' file            # print lines 10 to 20
```

### 3️⃣ Examples & Output
```bash
# Replace DB host in config
$ sed -i.bak 's/db-old.example.com/db-new.example.com/g' /etc/app/config.yml

# Remove comment lines
$ sed '/^#/d' nginx.conf > nginx-clean.conf

# Add a line after pattern
$ sed '/server_name/a\    return 301 https://$host$request_uri;' nginx.conf

# Extract lines 100-200 from log
$ sed -n '100,200p' /var/log/app.log

# Remove blank lines
$ sed '/^$/d' config.txt
```

### 4️⃣ Real-Time DevOps Scenario
During a blue-green deployment, update the load balancer config to switch upstream:
```bash
sed -i 's/upstream_blue/upstream_green/g' /etc/nginx/conf.d/lb.conf
nginx -s reload
```

### 5️⃣ Common Mistakes
- Always use `-i.bak` to create a backup when editing in place.
- Forgetting `/g` flag only replaces the first occurrence per line.

### 🎯 Interview Point
> `grep` finds lines, `sed` transforms them, `awk` processes fields. Use all three together for powerful pipelines.

---

## 🔹 `diff` — Show File Differences

### 1️⃣ What It Does
Compares two files line by line and shows what changed. Foundation of patch/version control.

### 2️⃣ Syntax
```bash
diff file1 file2
diff -u file1 file2    # unified format (used by git)
diff -y file1 file2    # side by side
diff -r dir1 dir2      # recursive directory diff
```

### 3️⃣ Examples & Output
```bash
$ diff nginx.conf.bak nginx.conf
< worker_processes 2;
***
> worker_processes 4;

$ diff -u config.old config.new
--- config.old  2026-04-10
+++ config.new  2026-04-17
-db_host=old.server.com
+db_host=new.server.com
```

### 4️⃣ Real-Time DevOps Scenario
Before applying a config change, diff the current vs new config:
```bash
diff /etc/nginx/nginx.conf.bak /etc/nginx/nginx.conf
```

---

## 🔹 `sdiff` — Side-by-Side Diff

```bash
sdiff file1 file2
sdiff -w 120 file1 file2   # set width
```

---

## 🔹 `iconv` — Character Encoding Conversion

```bash
iconv -f UTF-8 -t ASCII//TRANSLIT input.txt -o output.txt
iconv -l    # list all supported encodings
```

### 4️⃣ Real-Time DevOps Scenario
When a legacy application can't handle UTF-8 characters in config files, convert them:
```bash
iconv -f UTF-8 -t ISO-8859-1 input.txt -o output.txt
```

---

## 🔹 `recode` — Text Encoding Converter

```bash
recode UTF-8..ASCII input.txt
```

---

## 🔹 `pr` — Format Text for Printing

```bash
pr -n filename          # add line numbers
pr -h "Title" filename  # add header
pr -2 filename          # 2-column format
```

---

## 🔹 `jq` — Parse & Process JSON

### 1️⃣ What It Does
Command-line JSON processor. Essential for working with APIs, Kubernetes output, AWS CLI responses.

### 2️⃣ Syntax
```bash
cat file.json | jq '.'           # pretty print
cat file.json | jq '.key'        # extract key
cat file.json | jq '.items'   # first array element
```

### 3️⃣ Examples & Output
```bash
# Pretty print AWS CLI output
$ aws ec2 describe-instances | jq '.'

# Extract instance IDs
$ aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
"i-0a1b2c3d4e5f"
"i-0f1e2d3c4b5a"

# Get pod names from kubectl JSON output
$ kubectl get pods -o json | jq '.items[].metadata.name'
"nginx-pod-abc123"
"redis-pod-def456"
```

### 4️⃣ Real-Time DevOps Scenario
Parse AWS CloudWatch metrics response:
```bash
aws cloudwatch get-metric-statistics --metric-name CPUUtilization \
  --namespace AWS/EC2 ... | jq '.Datapoints[] | {time: .Timestamp, cpu: .Average}'
```

---

## 🔹 `yq` — Parse & Process YAML

```bash
yq '.metadata.name' deployment.yaml
yq -i '.spec.replicas = 3' deployment.yaml   # in-place edit
yq eval '.' config.yaml                      # pretty print
```

### 4️⃣ Real-Time DevOps Scenario
Update replicas in a Kubernetes deployment file during CI/CD:
```bash
yq -i ".spec.replicas = ${NEW_REPLICAS}" k8s/deployment.yaml
```

---

## 🔹 `fold` — Wrap Long Lines

```bash
fold -w 80 longfile.txt          # wrap at 80 chars
fold -w 80 -s longfile.txt       # wrap at word boundary
```

---

## 🔹 `expand` / `unexpand` — Tab/Space Conversion

```bash
expand file.txt           # tabs → spaces
unexpand -a file.txt      # spaces → tabs
```

---

# 3. User & Group Management

---

## 🔹 `useradd` — Create New User

### 1️⃣ What It Does
Creates a new user account with specified settings. Low-level, non-interactive.

### 2️⃣ Syntax
```bash
useradd [options] username
```

### 3️⃣ Important Options
| Option | Description |
|--------|-------------|
| `-m` | Create home directory |
| `-s /bin/bash` | Set default shell |
| `-g groupname` | Primary group |
| `-G group1,group2` | Secondary groups |
| `-u 1500` | Specific UID |
| `-c "Full Name"` | Comment/description |
| `-e 2026-12-31` | Account expiry date |
| `-d /custom/home` | Custom home directory |

### 4️⃣ Examples & Output
```bash
# Create deployment user
$ useradd -m -s /bin/bash -G docker,sudo deployuser
$ id deployuser
uid=1001(deployuser) gid=1001(deployuser) groups=1001(deployuser),27(sudo),998(docker)

# Create service account (no login)
$ useradd -r -s /sbin/nologin -M appservice
# -r = system account, -M = no home dir
```

### 5️⃣ Real-Time DevOps Scenario
On a new EC2 instance, create a dedicated user for running the app (never run apps as root):
```bash
useradd -m -s /bin/bash -c "Application Service User" appuser
passwd appuser
usermod -aG sudo appuser
```

### 6️⃣ Common Mistakes
- Not using `-m` means no home directory is created.
- Forgetting to set a password after `useradd`.

---

## 🔹 `adduser` — Interactive User Creation (Debian/Ubuntu)

```bash
adduser newusername
# Interactively asks for password, full name, etc.
```

---

## 🔹 `passwd` — Set/Change Password

```bash
passwd username          # change user's password (as root)
passwd                   # change own password
passwd -l username       # lock account
passwd -u username       # unlock account
passwd -e username       # force password change on next login
passwd -S username       # show password status
```

### 3️⃣ Examples
```bash
$ passwd -S ec2-user
ec2-user PS 2026-01-01 0 99999 7 -1 (Password set, SHA512 crypt.)

$ passwd -l baduser      # lock out a compromised account immediately
```

---

## 🔹 `usermod` — Modify Existing User

```bash
usermod -aG docker ec2-user     # add to group (important: use -a to APPEND)
usermod -s /bin/zsh ec2-user    # change shell
usermod -L username              # lock account
usermod -U username              # unlock account
usermod -d /new/home username   # change home directory
```

### 4️⃣ Real-Time DevOps Scenario
Grant an existing user Docker access:
```bash
usermod -aG docker ec2-user
# User must log out and back in for group change to take effect
```

### 5️⃣ Common Mistakes
> ⚠️ **CRITICAL**: `usermod -G docker user` REPLACES all groups. Always use `usermod -aG` (append) to ADD a group without removing existing ones.

---

## 🔹 `userdel` — Delete User

```bash
userdel username          # delete user (keep home dir)
userdel -r username       # delete user AND home directory
```

### 5️⃣ Common Mistakes
- Deleting a user while their processes are still running. Kill all processes first:
```bash
pkill -KILL -u username
userdel -r username
```

---

## 🔹 `groupadd` / `groupdel` — Manage Groups

```bash
groupadd devops           # create group
groupadd -g 2000 devops   # with specific GID
groupdel devops           # delete group
```

---

## 🔹 `gpasswd` — Manage Group Membership

```bash
gpasswd -a username groupname    # add user to group
gpasswd -d username groupname    # remove user from group
gpasswd -A username groupname    # make user group admin
```

---

## 🔹 `groups` — List User's Groups

```bash
$ groups
ec2-user adm wheel sudo docker

$ groups ec2-user
ec2-user : ec2-user wheel
```

---

## 🔹 `id` — Display User/Group IDs

```bash
$ id
uid=1000(ec2-user) gid=1000(ec2-user) groups=1000(ec2-user),998(docker),10(wheel)

$ id root
uid=0(root) gid=0(root) groups=0(root)
```

### 🎯 Interview Point
> `uid=0` always means root, regardless of username. `sudo` gives you effective `uid=0`.

---

## 🔹 `whoami` — Current User

```bash
$ whoami
ec2-user
```

---

## 🔹 `who` — Show Logged-In Users

```bash
$ who
ec2-user pts/0    2026-04-17 10:00 (203.0.113.5)
root     pts/1    2026-04-17 11:00 (10.0.0.5)
```

---

## 🔹 `w` — Who Is Logged In & What They're Doing

```bash
$ w
 18:00:01 up 5 days,  3:00,  2 users,  load average: 0.10, 0.05, 0.01
USER     TTY    FROM        LOGIN@  IDLE  JCPU  PCPU WHAT
ec2-user pts/0  10.0.0.5   10:00   0.00s 0.05s 0.01s bash
```

---

## 🔹 `last` — Login History

```bash
$ last
ec2-user pts/0  10.0.0.5  Fri Apr 17 10:00   still logged in
root     pts/1  10.0.1.1  Thu Apr 16 14:22 - 15:00 (00:38)
```

### 4️⃣ Real-Time DevOps Scenario
After a security incident, check who logged in recently:
```bash
last | head -20
last -n 20 -a    # show hostname
```

---

## 🔹 `lastlog` — Last Login of All Users

```bash
$ lastlog
Username     Port  From         Latest
root         pts/0 10.0.0.1     Fri Apr 17 09:00
ec2-user     pts/1 10.0.0.5     Fri Apr 17 10:00
nobody                          **Never logged in**
```

---

## 🔹 `faillog` — Failed Login Attempts

```bash
faillog -u username    # show for specific user
faillog -a             # show all users
```

---

## 🔹 `finger` — User Information

```bash
finger username
finger -l username    # long format
```

---

## 🔹 `su` — Switch User

```bash
su username          # switch to user (keep environment)
su - username        # switch to user (load user's environment)
su -                 # switch to root
su - -c "command"    # run command as root
```

### 5️⃣ Common Mistakes
- `su username` keeps your current environment variables. `su - username` loads the target user's full environment — always use `su -` for root.

---

## 🔹 `sudo` — Execute Command as Root

### 1️⃣ What It Does
Executes a command with elevated (root) privileges. Logs all usage to `/var/log/auth.log` or `/var/log/secure`.

### 2️⃣ Syntax
```bash
sudo command
sudo -u username command    # run as different user
sudo -i                     # interactive root shell
sudo -l                     # list allowed commands
sudo -s                     # shell as root
sudo !!                     # re-run last command with sudo
```

### 3️⃣ Examples
```bash
$ sudo systemctl restart nginx
$ sudo -u appuser /opt/app/start.sh
$ sudo -l
User ec2-user may run the following commands on server:
    (ALL : ALL) ALL
```

### 4️⃣ Real-Time DevOps Scenario
Grant a developer sudo access for only specific commands (principle of least privilege):
```bash
# /etc/sudoers.d/devuser
devuser ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx, /usr/bin/systemctl status nginx
```

### 🎯 Interview Point
> All sudo commands are logged. Audit with: `grep sudo /var/log/auth.log`

---

## 🔹 `visudo` — Safely Edit sudoers File

### 1️⃣ What It Does
Opens `/etc/sudoers` with syntax validation. If you have a syntax error in sudoers and save it, you can lock yourself out — `visudo` prevents this.

```bash
visudo                               # edit /etc/sudoers
visudo -f /etc/sudoers.d/myfile      # edit specific file
```

### 5️⃣ Common Mistakes
> ⚠️ NEVER edit `/etc/sudoers` with a regular editor (`vi /etc/sudoers`). A syntax error = complete lockout. Always use `visudo`.

---

## 🔹 `chage` — Password Expiry Management

```bash
chage -l username          # show current settings
chage -M 90 username       # max password age: 90 days
chage -m 7 username        # min password age: 7 days
chage -W 14 username       # warn 14 days before expiry
chage -E 2026-12-31 user   # set account expiry
```

---

## 🔹 `expiry` — Show Account Expiry Info

```bash
expiry -c    # check if expired (exit code 1 if expired)
```

---

## 🔹 `logname` — Print Login Name

```bash
$ logname
ec2-user
```

---

## 🔹 `tty` — Show Terminal

```bash
$ tty
/dev/pts/0
```

---

## 🔹 `users` — Show Logged-In Users (One Line)

```bash
$ users
ec2-user root ec2-user
```

---

## 🔹 `write` — Send Message to User Terminal

```bash
write username pts/1
Hello, please log off.
^D      # Ctrl+D to send
```

---

## 🔹 `wall` — Broadcast Message to All Users

```bash
$ wall "System will reboot in 10 minutes for maintenance"
Broadcast from ec2-user (pts/0):
System will reboot in 10 minutes for maintenance
```

---

## 🔹 `mesg` — Control Terminal Write Permission

```bash
mesg n    # disable others from writing to your terminal
mesg y    # enable
mesg      # show current status
```

---

## 🔹 `pkill -KILL -u user` — Kill All User Processes

```bash
pkill -KILL -u baduser      # kill all processes of baduser
pkill -9 -u developer       # force kill
```

### 4️⃣ Real-Time DevOps Scenario
Before deleting a compromised user account, kill all their processes first:
```bash
pkill -KILL -u compromised_user
userdel -r compromised_user
```

---

# 4. Permissions & Ownership

---

## 🔹 `chmod` — Change File Permissions

### 1️⃣ What It Does
Changes read, write, execute permissions for owner, group, and others.

### 2️⃣ Permission Basics
-rwxr-xr--
|||||||||||
|└──┬───┘└──┬──┘└──┬─┘
| owner group others
| file type: - = file, d = dir, l = symlink

text

| Symbol | Octal | Meaning |
|--------|-------|---------|
| `r` | 4 | Read |
| `w` | 2 | Write |
| `x` | 1 | Execute |

### 3️⃣ Syntax
```bash
chmod [options] mode file
chmod 755 script.sh          # octal
chmod u+x script.sh          # add execute for owner
chmod go-w file              # remove write from group and others
chmod a+r file               # add read for all
chmod -R 755 /var/www/html   # recursive
```

### 4️⃣ Common Permission Values
| Mode | Description | Use Case |
|------|-------------|----------|
| `644` | rw-r--r-- | Regular files |
| `755` | rwxr-xr-x | Scripts, binaries |
| `700` | rwx------ | Private scripts |
| `600` | rw------- | SSH keys, passwords |
| `400` | r-------- | Read-only keys |
| `777` | rwxrwxrwx | ⚠️ Never in prod |

### 5️⃣ Examples & Output
```bash
$ chmod 755 deploy.sh
$ ls -l deploy.sh
-rwxr-xr-x 1 ec2-user ec2-user 1024 Apr 17 deploy.sh

$ chmod 600 ~/.ssh/id_rsa
$ ls -l ~/.ssh/id_rsa
-rw------- 1 ec2-user ec2-user 1679 Apr 17 id_rsa

# Fix SSH key permissions (required)
$ chmod 700 ~/.ssh/
$ chmod 600 ~/.ssh/authorized_keys
```

### 6️⃣ Common Mistakes
- Setting `777` on web directories — security vulnerability.
- SSH will refuse to connect if private key is not `600`.
- Using `chmod 755 -R /` by mistake — catastrophic.

### 🎯 Interview Point
> Special permissions: SUID (4xxx) runs as file owner, SGID (2xxx) runs as file group, Sticky bit (1xxx) on directories prevents deletion by non-owners (used on `/tmp`).

---

## 🔹 `chown` — Change File Owner

### 1️⃣ What It Does
Changes the owner and/or group of a file or directory.

### 2️⃣ Syntax
```bash
chown owner file
chown owner:group file
chown :group file           # change only group
chown -R owner:group dir/   # recursive
```

### 3️⃣ Examples & Output
```bash
$ chown nginx:nginx /var/www/html/index.html
$ ls -l /var/www/html/
-rw-r--r-- 1 nginx nginx 1024 Apr 17 index.html

# Fix ownership after copying files as root
$ chown -R ec2-user:ec2-user /home/ec2-user/

# Give app service ownership of its directory
$ chown -R appuser:appuser /opt/myapp/
```

### 4️⃣ Real-Time DevOps Scenario
After deploying files as root via CI/CD, fix ownership:
```bash
chown -R www-data:www-data /var/www/myapp/
chmod -R 750 /var/www/myapp/
```

---

## 🔹 `chgrp` — Change Group Ownership

```bash
chgrp developers /opt/project/
chgrp -R developers /opt/project/
```

---

## 🔹 `umask` — Default Permission Mask

### 1️⃣ What It Does
Sets the default permissions that are **removed** from new files/directories.

### 2️⃣ How It Works
New file base: 666 (rw-rw-rw-)
umask: - 022
Result: 644 (rw-r--r--)

New dir base: 777
umask: - 022
Result: 755

text

### 3️⃣ Syntax
```bash
umask           # show current umask
umask 022       # set umask
umask 027       # more restrictive (files: 640, dirs: 750)
```

### 4️⃣ Real-Time DevOps Scenario
For a web server application user, set umask to 027 so new files are not world-readable:
```bash
echo "umask 027" >> /etc/profile.d/app.sh
```

---

## 🔹 `getfacl` / `setfacl` — Access Control Lists

### 1️⃣ What They Do
ACLs provide fine-grained permissions beyond owner/group/others. Allow specific users/groups to have different permissions.

### 2️⃣ Syntax
```bash
getfacl filename                          # view ACL
setfacl -m u:username:rwx filename       # grant user rwx
setfacl -m g:groupname:rx filename       # grant group rx
setfacl -x u:username filename           # remove user's ACL
setfacl -R -m u:username:rx /directory   # recursive
setfacl -b filename                      # remove all ACLs
```

### 3️⃣ Examples & Output
```bash
$ setfacl -m u:developer:rw /var/log/app/app.log
$ getfacl /var/log/app/app.log
# file: app.log
# owner: appuser
# group: appgroup
user::rw-
user:developer:rw-     ← extra ACL entry
group::r--
mask::rw-
other::---
```

### 4️⃣ Real-Time DevOps Scenario
Give a monitoring user read access to an app log without changing file ownership:
```bash
setfacl -m u:prometheus:r /var/log/app/app.log
```

---

## 🔹 `lsattr` / `chattr` — Extended File Attributes

### 1️⃣ What They Do
- `lsattr` — shows extended attributes (immutable, append-only, etc.)
- `chattr` — sets extended attributes

### 2️⃣ Syntax
```bash
lsattr filename
chattr +i filename     # make immutable (cannot delete/modify even as root)
chattr -i filename     # remove immutable flag
chattr +a filename     # append-only
```

### 3️⃣ Examples & Output
```bash
$ chattr +i /etc/passwd
$ chattr +i /etc/shadow
$ lsattr /etc/passwd
----i----------- /etc/passwd

$ rm /etc/passwd
rm: cannot remove '/etc/passwd': Operation not permitted
```

### 4️⃣ Real-Time DevOps Scenario
Protect critical system files from accidental modification — even by root:
```bash
chattr +i /etc/resolv.conf    # prevent DNS changes
chattr +a /var/log/audit.log  # allow append only, not overwrite
```

### 🎯 Interview Point
> `chattr +i` makes a file immutable — even `root` cannot delete or modify it until the attribute is removed. Great for security hardening.

---

## 🔹 `getcap` / `setcap` — File Capabilities

### 1️⃣ What They Do
Linux capabilities allow granting specific root-like privileges to binaries without full SUID root.

### 2️⃣ Syntax
```bash
getcap /usr/bin/ping        # show capabilities
setcap cap_net_bind_service+ep /usr/bin/node   # allow binding to port < 1024
setcap -r /path/to/binary   # remove capabilities
```

### 3️⃣ Examples
```bash
$ getcap /usr/bin/ping
/usr/bin/ping = cap_net_raw+ep

# Allow node to bind port 80 without root
$ setcap cap_net_bind_service+ep /usr/local/bin/node
```

---

## 🔹 `lssec` / `chsec` — SELinux Security Attributes

```bash
lssec -f /etc/passwd                   # show SELinux attributes
chsec -f /etc/passwd -s seclevel       # change security level
```

---

## 🔹 `faillock` — Track/Lock Failed Logins

```bash
faillock --user username         # show failed attempts for user
faillock --reset --user username # reset lockout
```

---

## 🔹 `test` — Evaluate Expressions

### 1️⃣ What It Does
Evaluates conditions in shell scripts. Returns 0 (true) or 1 (false).

### 2️⃣ Syntax
```bash
test -f filename         # is a regular file?
test -d directory        # is a directory?
test -r filename         # is readable?
test -x filename         # is executable?
test -z "$var"           # is string empty?
test "$a" -eq "$b"       # numeric equality
[ -f filename ]          # shorthand for test
[[ -f filename ]]        # bash extended test
```

### 3️⃣ Examples
```bash
# In deployment script
if [ -f /opt/app/deploy.lock ]; then
    echo "Deployment already running"
    exit 1
fi

if [ ! -d /var/log/app ]; then
    mkdir -p /var/log/app
fi
```

---

## 🔹 `install` — Copy Files with Attributes

### 1️⃣ What It Does
Copies files and sets permissions, ownership, and timestamps in one command. Commonly used in Makefiles and deployment scripts.

### 2️⃣ Syntax
```bash
install -m 755 source dest
install -m 644 -o nginx -g nginx config.conf /etc/nginx/conf.d/
install -d -m 755 /opt/myapp/logs    # create directory
```

### 3️⃣ Examples
```bash
# Install binary with correct permissions
$ install -m 755 myapp /usr/local/bin/myapp

# Install config file with specific ownership
$ install -m 640 -o appuser -g appgroup app.conf /etc/app/
```

---

# 5. Process & Job Management

---

## 🔹 `ps` — Process Status

### 1️⃣ What It Does
Displays information about running processes. `ps aux` is the most used combination in Linux.

### 2️⃣ Syntax
```bash
ps aux           # all processes, all users, detailed
ps -ef           # full format listing
ps -u username   # processes by user
ps -p 1234       # process by PID
```

### 3️⃣ `ps aux` Column Meanings
| Column | Meaning |
|--------|---------|
| `USER` | Process owner |
| `PID` | Process ID |
| `%CPU` | CPU usage |
| `%MEM` | Memory usage |
| `VSZ` | Virtual memory size |
| `RSS` | Physical memory used |
| `STAT` | Status (R=running, S=sleeping, Z=zombie, D=disk wait) |
| `COMMAND` | Command name |

### 4️⃣ Examples & Output
```bash
$ ps aux | head -5
USER    PID  %CPU %MEM    VSZ   RSS TTY STAT START   TIME COMMAND
root      1   0.0  0.1 169984  7120 ?   Ss   Apr15   0:03 /usr/lib/systemd/systemd
nginx  1234   0.5  1.2  45000 12000 ?   S    10:00   0:15 nginx: worker process
app    5678   2.1  8.0 850000 82000 ?   Sl   09:00   5:22 java -jar app.jar

# Find specific process
$ ps aux | grep nginx
nginx  1234  0.0  0.1 nginx: master process

# Sort by memory usage
$ ps aux --sort=-%mem | head -10

# Sort by CPU usage
$ ps aux --sort=-%cpu | head -10
```

### 5️⃣ Real-Time DevOps Scenario
App is consuming too much memory on EC2. Find the culprit:
```bash
ps aux --sort=-%mem | head -10
```

### 🎯 Interview Point
> `ps aux` vs `ps -ef`: Both show all processes. `aux` is BSD-style (no dash), `-ef` is POSIX-style. `ps -ef` shows PPID (parent PID), `ps aux` shows `%CPU` and `%MEM`.

---

## 🔹 `top` — Interactive Process Monitor

### 1️⃣ What It Does
Real-time, interactive view of running processes and system resource usage. Updates every 3 seconds by default.

### 2️⃣ Syntax
```bash
top
top -u username     # filter by user
top -p 1234         # monitor specific PID
top -d 1            # update every 1 second
top -b -n 1         # batch mode (non-interactive, for scripting)
```

### 3️⃣ Interactive Keys
| Key | Action |
|-----|--------|
| `k` | Kill process (enter PID) |
| `r` | Renice (change priority) |
| `P` | Sort by CPU |
| `M` | Sort by memory |
| `T` | Sort by time |
| `1` | Show individual CPU cores |
| `q` | Quit |
| `f` | Add/remove columns |
| `u` | Filter by user |

### 4️⃣ Examples & Output
```bash
top - 18:00:01 up 5 days,  load average: 0.52, 0.48, 0.45
Tasks: 142 total,  2 running, 140 sleeping
%Cpu(s): 15.2 us,  2.1 sy,  0.0 ni, 81.2 id
MiB Mem :   7946.8 total,   1234.5 free,   5100.2 used
PID  USER    %CPU %MEM  COMMAND
1234 nginx    8.5  2.1  nginx
5678 java    15.2 22.0  java -jar app.jar
```

### 5️⃣ Real-Time DevOps Scenario
CPU spike on production EC2 — identify the process:
```bash
top -b -n 1 | head -20    # one-time snapshot for alerting
```

---

## 🔹 `htop` — Enhanced Interactive Monitor

### 1️⃣ What It Does
Improved version of `top` with color, horizontal scrolling, mouse support, and easier process management.

```bash
htop
htop -u username    # filter by user
htop -p 1234,5678   # specific PIDs
```

### 4️⃣ Real-Time DevOps Scenario
`htop` shows CPU usage per core. Great for identifying if a Node.js app is maxing a single core on a multi-core EC2 instance.

---

## 🔹 `atop` — Advanced System Monitor

```bash
atop              # real-time monitor with disk, network, process
atop -r /var/log/atop/atop_20260417   # replay historical data
```

### 🎯 Interview Point
> `atop` records historical performance data (when daemon is running). You can replay a past performance incident with `atop -r`.

---

## 🔹 `glances` — Cross-Platform System Monitor

```bash
glances
glances -w         # web server mode (browser access)
glances --export influxdb   # export to InfluxDB
```

---

## 🔹 `pgrep` — Find Process IDs by Name

```bash
$ pgrep nginx
1234
1235

$ pgrep -l nginx          # show process name too
1234 nginx

$ pgrep -u ec2-user       # all processes by user
$ pgrep -a "java"         # full command line
```

---

## 🔹 `pkill` — Kill Processes by Name

```bash
pkill nginx               # SIGTERM to all nginx processes
pkill -9 nginx
Prepared using Claude Sonnet 4.6
continue to generate for next sections now
Continuing from where we left off — here are all remaining sections:

text
# (Continuing from Process & Job Management...)

pkill -KILL -u username    # kill all processes of a user
pkill -HUP nginx           # send reload signal (SIGHUP)
4️⃣ Real-Time DevOps Scenario
Gracefully reload nginx after config change:

bash
pkill -HUP nginx
# or
nginx -s reload
🔹 kill — Send Signal to Process by PID
1️⃣ What It Does
Sends a signal to a process. Default signal is SIGTERM (15) — graceful shutdown.

2️⃣ Syntax
bash
kill PID
kill -15 PID      # SIGTERM — graceful stop
kill -9 PID       # SIGKILL — force kill (cannot be caught)
kill -1 PID       # SIGHUP — reload config
kill -l           # list all signals
3️⃣ Signal Reference
Signal	Number	Meaning
SIGHUP	1	Reload config (graceful)
SIGINT	2	Ctrl+C (interrupt)
SIGKILL	9	Force kill (cannot ignore)
SIGTERM	15	Graceful terminate
SIGSTOP	19	Pause process
4️⃣ Examples
bash
$ kill -15 5678        # graceful shutdown
$ kill -9 5678         # force kill if graceful doesn't work
$ kill -1 $(pgrep nginx)   # reload nginx
5️⃣ Common Mistakes
Using kill -9 immediately without trying kill -15 first. SIGKILL does not allow cleanup — open files/sockets may be left in bad state.

Killing the wrong PID — always ps aux | grep processname to confirm PID before killing.

🎯 Interview Point
kill -9 cannot be caught, blocked, or ignored by the process. kill -15 can be caught, so the process can do cleanup.

🔹 killall — Kill All Processes by Name
bash
killall nginx
killall -9 java
killall -u username       # kill all processes of a user by name match
🔹 jobs — List Background Jobs
bash
$ jobs
[1]- Running    sleep 100 &
[2]+ Stopped    vim file.txt
🔹 fg / bg — Foreground / Background Jobs
bash
fg              # bring most recent background job to foreground
fg %1           # bring job 1 to foreground
bg              # resume paused job in background
bg %2           # resume job 2 in background

# Workflow:
$ sleep 100 &   # start in background
$ Ctrl+Z        # suspend foreground job
$ bg            # resume it in background
$ fg            # bring back to foreground
🔹 disown — Remove Job from Shell
bash
disown          # disown most recent job
disown -h %1    # keep running even after terminal closes
disown -a       # disown all jobs
4️⃣ Real-Time DevOps Scenario
Started a long backup job and need to close terminal:

bash
./backup.sh &
disown -h %1
exit   # job continues running
🔹 nohup — Run Command Immune to Hangup
1️⃣ What It Does
Runs a command that continues after you log out. Output goes to nohup.out by default.

2️⃣ Syntax
bash
nohup command &
nohup ./deploy.sh > /var/log/deploy.log 2>&1 &
3️⃣ Examples
bash
$ nohup python3 app.py > app.log 2>&1 &
[1] 12345
$ exit
# Process 12345 continues running

$ nohup ./long_backup.sh &
nohup: ignoring input and appending output to 'nohup.out'
4️⃣ Real-Time DevOps Scenario
Start a database migration that takes hours — use nohup so it survives SSH disconnection:

bash
nohup python3 migrate.py > /var/log/migration.log 2>&1 &
echo "Migration PID: $!"
🔹 setsid — Start Process in New Session
bash
setsid command         # detach from terminal session
setsid -w command      # wait for it to complete
🔹 nice — Start Process with Priority
1️⃣ What It Does
Starts a command with a specified "niceness" (priority). Range is -20 (highest priority) to +19 (lowest priority). Default is 0.

2️⃣ Syntax
bash
nice -n 10 command       # run with low priority (nice +10)
nice -n -5 command       # run with high priority (needs root for negative)
3️⃣ Examples
bash
# Run backup with low priority so it doesn't impact app
$ nice -n 15 tar -czf /backup/app.tar.gz /opt/app/

# Run critical process with high priority
$ sudo nice -n -10 ./critical-process.sh
🎯 Interview Point
Lower nice value = higher priority. Negative values require root. A CPU-intensive batch job should always use nice +15 to avoid affecting production services.

🔹 renice — Change Priority of Running Process
bash
renice +10 -p 1234        # lower priority of PID 1234
renice -5 -p 1234         # raise priority (requires root)
renice +15 -u username    # lower priority of all user's processes
🔹 uptime — System Uptime & Load
bash
$ uptime
 18:00:01 up 5 days, 3:22, 2 users, load average: 0.52, 0.48, 0.45

$ uptime -p
up 5 days, 3 hours, 22 minutes
🎯 Interview Point
Load average: 3 numbers represent 1-min, 5-min, 15-min averages. On a 4-core server, load of 4.0 = 100% utilized. Load > number of CPUs = overloaded.

🔹 watch — Repeat Command at Intervals
1️⃣ What It Does
Runs a command repeatedly at a set interval and shows the output full-screen. Useful for monitoring.

2️⃣ Syntax
bash
watch command
watch -n 2 command          # every 2 seconds
watch -d command            # highlight differences
watch -n 1 'df -h'          # monitor disk every second
3️⃣ Examples
bash
# Monitor disk usage live
$ watch -n 5 df -h

# Watch pod status during Kubernetes deployment
$ watch -n 2 kubectl get pods

# Monitor service connections
$ watch -n 1 'ss -tulpn | grep :80'
🔹 time — Measure Execution Time
bash
$ time ./script.sh
real    0m5.231s    # wall clock time
user    0m3.100s    # CPU time in user space
sys     0m0.820s    # CPU time in kernel space
4️⃣ Real-Time DevOps Scenario
Benchmark a database query script:

bash
time python3 db_query.py
🔹 timeout — Kill Command After Time Limit
bash
timeout 30 ./script.sh         # kill after 30 seconds
timeout 5m curl http://api/    # timeout after 5 minutes
timeout -s KILL 10 command     # send SIGKILL after 10s
4️⃣ Real-Time DevOps Scenario
Health check in CI/CD that must not hang:

bash
timeout 10 curl -f http://localhost:8080/health || exit 1
🔹 mpstat — CPU Usage Per Processor
bash
mpstat 1 5        # stats every 1 second, 5 times
mpstat -P ALL     # show all CPU cores
Output
text
CPU  %usr %sys %idle
all  15.2  2.1  81.2
0    28.4  3.1  68.5
1     2.0  1.1  96.9
🔹 pidstat — Per-Process CPU/Memory Stats
bash
pidstat 1 5               # every 1 second, 5 iterations
pidstat -u -p 1234        # CPU stats for PID 1234
pidstat -r -p 1234        # memory stats for PID 1234
pidstat -d                # disk I/O per process
🔹 pstree — Process Tree
bash
$ pstree
systemd─┬─sshd───sshd───bash───pstree
        ├─nginx─┬─nginx
        │       └─nginx
        └─java───{threads}

$ pstree -p          # show PIDs
$ pstree -u          # show users
$ pstree 1234        # tree from specific PID
🔹 lsof — List Open Files
1️⃣ What It Does
Lists all open files and the processes using them. In Linux, "everything is a file" — this includes sockets, pipes, devices.

2️⃣ Syntax
bash
lsof                          # all open files (huge output)
lsof -p PID                   # files opened by specific process
lsof -u username              # files by user
lsof -i :80                   # processes using port 80
lsof -i tcp                   # all TCP connections
lsof /path/to/file            # who has this file open
lsof +D /directory            # all files in directory
3️⃣ Examples & Output
bash
# Who is using port 443?
$ lsof -i :443
COMMAND   PID   USER   FD  TYPE  NODE NAME
nginx    1234   nginx  6u  IPv4  TCP  *:https (LISTEN)

# What files does nginx have open?
$ lsof -p 1234 | head -10
nginx  1234 nginx  txt  REG  /usr/sbin/nginx
nginx  1234 nginx  mem  REG  /lib/x86_64-linux-gnu/libc.so.6

# Find what has a log file open (before deletion)
$ lsof /var/log/app/app.log
4️⃣ Real-Time DevOps Scenario
Port 8080 is "already in use" error:

bash
lsof -i :8080
# Shows which process is using port 8080
kill -9 <PID>
🔹 vmstat — Virtual Memory Statistics
bash
$ vmstat 1 5
procs ----memory---- ---swap-- ---io--- --system-- ------cpu-----
 r  b  swpd  free  buff  cache  si so  bi  bo  in  cs us sy id
 2  0     0 1234M  100M  2048M   0  0  12  25 500 300 15  3 80
Column	Meaning
r	Processes waiting for CPU
b	Processes in uninterruptible sleep
si/so	Swap in/out (if non-zero, memory issue!)
us/sy/id	User/System/Idle CPU%
🎯 Interview Point
If si and so (swap in/out) are constantly non-zero, your server is under memory pressure — add RAM or optimize app.

🔹 pidof — Get PID of Running Program
bash
$ pidof nginx
1234 1235 1236

$ pidof sshd
998
6. System Monitoring & Performance
🔹 iostat — CPU & I/O Statistics
bash
iostat 1 5              # every 1 second, 5 times
iostat -x               # extended stats (await, util)
iostat -d /dev/sda 1    # specific device
Output (Extended)
text
Device  r/s  w/s  rKB/s  wKB/s  await  %util
sda    10.2 25.5  512.0 1024.0   5.21  45.2
🎯 Interview Point
%util near 100% = disk is a bottleneck. await is average I/O wait time in milliseconds — high values indicate slow disk.

🔹 dstat — Real-Time System Stats
bash
dstat                    # all stats
dstat -cdngy 1           # CPU, disk, net, page, system
dstat --top-cpu          # show top CPU process
dstat --top-mem          # show top memory process
🔹 sar — System Activity Reporter
bash
sar 1 5                  # CPU every 1 second, 5 times
sar -r 1 5               # memory stats
sar -n DEV 1 5           # network stats
sar -b 1 5               # I/O stats
sar -f /var/log/sa/sa17  # read historical data from file
4️⃣ Real-Time DevOps Scenario
Investigate a performance issue that occurred last night:

bash
sar -r -f /var/log/sa/sa16 | grep "03:00\|04:00"
🔹 iotop — Real-Time I/O Usage Per Process
bash
sudo iotop              # interactive I/O monitor
sudo iotop -o           # show only active processes
sudo iotop -b -n 3      # batch mode, 3 iterations
4️⃣ Real-Time DevOps Scenario
Disk is 100% utilized and slowing everything — find the culprit:

bash
sudo iotop -o -P
🔹 iftop — Network Bandwidth Per Connection
bash
sudo iftop
sudo iftop -i eth0    # specific interface
sudo iftop -n         # no DNS resolution
🔹 nethogs — Network Usage Per Process
bash
sudo nethogs
sudo nethogs eth0
4️⃣ Real-Time DevOps Scenario
Bandwidth bill spiked on AWS. Find which process is sending most traffic:

bash
sudo nethogs eth0
🔹 strace — Trace System Calls
1️⃣ What It Does
Traces all system calls made by a process. Invaluable for debugging crashes, permission issues, and performance problems.

2️⃣ Syntax
bash
strace command
strace -p PID                  # attach to running process
strace -e open,read command    # trace specific calls
strace -o /tmp/trace.txt command   # output to file
strace -c command              # count/summary
strace -f command              # follow child processes
3️⃣ Examples
bash
# Debug why app can't open config file
$ strace -e openat myapp 2>&1 | grep "config"
openat(AT_FDCWD, "/etc/app/config.yml", O_RDONLY) = -1 ENOENT

# Find all files an app reads on startup
$ strace -e openat,read java -jar app.jar 2>&1 | grep "openat"

# Profile system call usage
$ strace -c nginx
% time   calls  errors syscall
 45.3    1234      0   read
 30.1     890      5   write
4️⃣ Real-Time DevOps Scenario
App crashes with "permission denied" but you can't find which file:

bash
strace -e openat ./myapp 2>&1 | grep "EPERM\|EACCES\|ENOENT"
🔹 perf — Performance Analysis Tool
bash
perf top                    # real-time CPU profiling
perf stat command           # run and show CPU stats
perf record -g ./app        # record performance data
perf report                 # display recorded data
🔹 free — Memory Usage
1️⃣ What It Does
Displays total, used, free, and cached memory.

2️⃣ Syntax
bash
free -h     # human-readable (GB/MB)
free -m     # in megabytes
free -g     # in gigabytes
free -s 2   # update every 2 seconds
3️⃣ Examples & Output
bash
$ free -h
              total  used  free  shared  buff/cache  available
Mem:           7.8G  5.1G  234M    512M        2.4G       1.9G
Swap:          2.0G  100M  1.9G
🎯 Interview Point
available memory is the most important column — it shows how much memory is actually available for new processes (includes reclaimable cache). free being low is normal in Linux; check available.

7. Disk & Filesystem Management
🔹 lsblk — List Block Devices
bash
$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    0   20G  0 disk
├─sda1   8:1    0    1G  0 part /boot
├─sda2   8:2    0    2G  0 part [SWAP]
└─sda3   8:3    0   17G  0 part /

$ lsblk -f      # show filesystem type and UUID
$ lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT
🔹 blkid — Block Device Attributes
bash
$ blkid
/dev/sda1: UUID="abc-123" TYPE="ext4" PARTUUID="xyz"
/dev/sda2: UUID="def-456" TYPE="swap"

$ blkid /dev/sda1    # specific device
4️⃣ Real-Time DevOps Scenario
Before adding to /etc/fstab, get the UUID (safer than device name):

bash
blkid /dev/sdb1
# /etc/fstab entry using UUID is stable across reboots
UUID=abc-123 /data ext4 defaults 0 2
🔹 fdisk — Partition Management (MBR)
bash
fdisk -l              # list all partitions
fdisk /dev/sdb        # interactive partition editor
Interactive Commands Inside fdisk
Key	Action
n	New partition
d	Delete partition
p	Print partition table
w	Write & exit
q	Quit without saving
t	Change partition type
4️⃣ Real-Time DevOps Scenario
Adding a new EBS volume to EC2:

bash
fdisk /dev/xvdb    # create partition
mkfs.ext4 /dev/xvdb1
mkdir /data
mount /dev/xvdb1 /data
echo "UUID=$(blkid -s UUID -o value /dev/xvdb1) /data ext4 defaults 0 2" >> /etc/fstab
🔹 parted — Advanced Partitioning (GPT + MBR)
bash
parted /dev/sdb                     # interactive
parted /dev/sdb mklabel gpt         # create GPT label
parted /dev/sdb mkpart primary ext4 0% 100%   # create partition
parted -l                           # list all partitions
🔹 cfdisk / sfdisk — Partition Editors
bash
cfdisk /dev/sdb    # curses-based interactive partitioner
sfdisk -l          # scriptable, list partitions
sfdisk /dev/sdb < partition-layout.txt   # script-driven
🔹 mkfs — Create Filesystem
bash
mkfs.ext4 /dev/sdb1          # ext4 filesystem
mkfs.xfs /dev/sdb1           # XFS filesystem
mkfs.vfat /dev/sdb1          # FAT32
mkfs -t ext4 /dev/sdb1       # explicit type
mkfs.ext4 -L "mydata" /dev/sdb1   # with label
🔹 fsck — Filesystem Check & Repair
bash
fsck /dev/sdb1               # check filesystem
fsck -y /dev/sdb1            # auto-repair without prompts
fsck -n /dev/sdb1            # dry run (check only)
fsck -t ext4 /dev/sdb1       # specify type
5️⃣ Common Mistakes
Never run fsck on a mounted filesystem — always unmount first or do it in rescue mode.

🔹 tune2fs — Tune ext Filesystem
bash
tune2fs -l /dev/sda1                   # list properties
tune2fs -L "rootfs" /dev/sda1          # set label
tune2fs -c 0 -i 0 /dev/sda1           # disable auto fsck
tune2fs -m 1 /dev/sda1                # reduce reserved space to 1%
🔹 resize2fs — Resize ext Filesystem
bash
resize2fs /dev/sda1         # resize to fill partition
resize2fs /dev/sda1 10G     # resize to specific size
4️⃣ Real-Time DevOps Scenario
After expanding an AWS EBS volume:

bash
# 1. Expand partition
growpart /dev/xvda 1
# 2. Resize filesystem
resize2fs /dev/xvda1
# 3. Verify
df -h /
🔹 mount / umount — Mount/Unmount Filesystems
bash
mount /dev/sdb1 /mnt/data            # mount device
mount -t nfs server:/share /mnt/nfs  # NFS mount
mount -o ro /dev/sdb1 /mnt           # read-only mount
mount -o remount,rw /                # remount root as rw
mount | column -t                    # show all mounts nicely
umount /mnt/data                     # unmount
umount -f /mnt/data                  # force unmount
umount -l /mnt/data                  # lazy unmount
5️⃣ Common Mistakes
umount: target is busy — use lsof +D /mnt/data to find what's using it.

🔹 df — Disk Free Space
1️⃣ What It Does
Shows disk space usage of all mounted filesystems.

2️⃣ Syntax
bash
df -h           # human-readable
df -h /         # specific filesystem
df -i           # inode usage (important! running out of inodes = no new files)
df -T           # show filesystem type
3️⃣ Examples & Output
bash
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/xvda1       20G   15G  4.2G  79% /
/dev/xvdb1      100G   45G   55G  45% /data
tmpfs           3.9G  0    3.9G   0% /dev/shm

$ df -i /
Filesystem     Inodes  IUsed  IFree IUse% Mounted on
/dev/xvda1    1310720  85000 1225720   7% /
4️⃣ Real-Time DevOps Scenario
EC2 disk showing "No space left on device" but df -h shows space available — check inodes:

bash
df -i /
# If IUse% is 100%, you've run out of inodes (often caused by millions of small temp files)
🔹 du — Disk Usage of Files/Directories
1️⃣ What It Does
Shows how much disk space files and directories consume.

2️⃣ Syntax
bash
du -sh /path          # total size, human-readable
du -sh *              # size of each item in current dir
du -h --max-depth=1   # one level deep
du -a /path           # all files
du -sh /var/log/*     # each log directory
3️⃣ Examples & Output
bash
$ du -sh /var/log/*
4.0K  /var/log/auth.log
2.1G  /var/log/app.log    ← problem!
100M  /var/log/nginx

$ du -sh * | sort -rh | head -10    # find top 10 largest
2.1G app.log
500M nginx
100M audit
4️⃣ Real-Time DevOps Scenario
Root partition at 95% on EC2. Find what's consuming disk:

bash
du -sh /* 2>/dev/null | sort -rh | head -10
du -sh /var/* 2>/dev/null | sort -rh
du -sh /var/log/* 2>/dev/null | sort -rh
🔹 findmnt — Find Mounted Filesystems
bash
findmnt                    # show all mounts as tree
findmnt /data              # info about specific mount
findmnt -t ext4            # filter by type
findmnt --verify           # verify /etc/fstab
🔹 quota / edquota / repquota — Disk Quotas
bash
quota -u username          # show user's disk quota
edquota -u username        # edit user quota
repquota -a                # report all quotas on all filesystems
🔹 swapon / swapoff / mkswap — Swap Management
bash
swapon --show              # show swap usage
swapon /dev/sda2           # enable swap partition
swapoff /dev/sda2          # disable swap
mkswap /dev/sdb2           # prepare partition as swap
mkswap -f /swapfile        # prepare file as swap
4️⃣ Real-Time DevOps Scenario
EC2 running out of RAM — add a swap file temporarily:

bash
dd if=/dev/zero of=/swapfile bs=1G count=4    # create 4GB swap file
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap sw 0 0" >> /etc/fstab
🔹 wipefs — Wipe Filesystem Signatures
bash
wipefs -a /dev/sdb      # wipe all filesystem signatures
wipefs -n /dev/sdb      # dry run
🔹 partprobe — Reload Partition Table
bash
partprobe /dev/sdb      # notify kernel of partition changes
partprobe               # reload all disks
4️⃣ Real-Time DevOps Scenario
After running fdisk to create partitions, run partprobe instead of rebooting:

bash
fdisk /dev/sdb
partprobe /dev/sdb
lsblk
🔹 losetup — Loop Device Management
bash
losetup -f disk.img          # attach disk image to loop device
losetup -l                   # list loop devices
losetup -d /dev/loop0        # detach
🔹 cryptsetup — Encrypted Block Devices (LUKS)
bash
cryptsetup luksFormat /dev/sdb1         # format as LUKS
cryptsetup open /dev/sdb1 myenc         # open/decrypt
mkfs.ext4 /dev/mapper/myenc             # create filesystem
mount /dev/mapper/myenc /mnt/secure     # mount
cryptsetup close myenc                  # close/lock
8. Compression & Archiving
🔹 tar — Tape Archive
1️⃣ What It Does
Archives multiple files into a single .tar file. Can optionally compress using gzip, bzip2, or xz.

2️⃣ Key Options Mnemonic: create/extract verbose file
bash
tar -cvf archive.tar files/        # create archive
tar -xvf archive.tar               # extract archive
tar -tvf archive.tar               # list contents
tar -czvf archive.tar.gz files/    # create gzip compressed
tar -xzvf archive.tar.gz           # extract gzip
tar -cjvf archive.tar.bz2 files/   # create bzip2
tar -cJvf archive.tar.xz files/    # create xz
tar -xvf archive.tar -C /target/   # extract to specific dir
3️⃣ Option Reference
Option	Meaning
-c	Create
-x	Extract
-t	List
-v	Verbose
-f	File (archive name)
-z	gzip compress
-j	bzip2 compress
-J	xz compress
-C dir	Change to directory
-p	Preserve permissions
4️⃣ Examples & Output
bash
# Backup /etc directory
$ tar -czvf /backup/etc-$(date +%F).tar.gz /etc/
/etc/
/etc/nginx/
/etc/nginx/nginx.conf

# Extract to specific location
$ tar -xzvf backup.tar.gz -C /restore/

# List without extracting
$ tar -tvf backup.tar.gz
-rw-r--r-- root/root 1234 2026-04-17 nginx.conf

# Exclude directory
$ tar --exclude=/proc --exclude=/sys -czvf backup.tar.gz /
5️⃣ Real-Time DevOps Scenario
Before a major deployment, backup the application directory:

bash
tar -czvf /backup/app-pre-deploy-$(date +%Y%m%d-%H%M%S).tar.gz /opt/app/
🔹 tar --exclude — Archive with Exclusions
bash
tar --exclude='*.log' --exclude='.git' -czvf app.tar.gz /opt/app/
tar --exclude-from=exclude.txt -czvf backup.tar.gz /data/
🔹 gzip / gunzip — gzip Compression
bash
gzip file.txt            # compress (replaces original)
gzip -k file.txt         # keep original
gzip -d file.txt.gz      # decompress (same as gunzip)
gzip -9 file.txt         # maximum compression
gzip -l file.txt.gz      # show compression ratio
gunzip file.txt.gz       # decompress
🔹 bzip2 / bunzip2 — bzip2 Compression
bash
bzip2 file.txt           # better compression than gzip, slower
bzip2 -k file.txt        # keep original
bunzip2 file.txt.bz2     # decompress
bzip2 -d file.txt.bz2    # decompress
🔹 xz / unxz — xz Compression (Highest Ratio)
bash
xz file.txt              # highest compression ratio
xz -k file.txt           # keep original
xz -d file.txt.xz        # decompress
unxz file.txt.xz         # decompress
xz -9 file.txt           # maximum compression
🔹 zip / unzip — ZIP Archives
bash
zip archive.zip file1 file2    # create zip
zip -r archive.zip directory/  # recursive (include directory)
zip -e secure.zip file.txt     # password encrypt
unzip archive.zip              # extract
unzip archive.zip -d /target/  # extract to dir
unzip -l archive.zip           # list contents
unzip -t archive.zip           # test integrity
🔹 7z — 7-Zip Compression
bash
7z a archive.7z files/          # create
7z e archive.7z                 # extract
7z l archive.7z                 # list
7z x archive.7z -o/target/      # extract with full paths
7z a -p"password" secure.7z files/   # with password
🔹 rar / unrar — RAR Format
bash
rar a archive.rar files/        # create
unrar e archive.rar             # extract
unrar l archive.rar             # list
unrar x archive.rar /target/    # extract with structure
🔹 split / csplit — Split Files
bash
split -b 100M largefile.tar.gz part_     # split into 100MB chunks
split -l 1000 hugefile.txt chunk_        # split by 1000 lines
cat part_* > restored.tar.gz             # reassemble

csplit file.txt /PATTERN/ {*}            # split at pattern
4️⃣ Real-Time DevOps Scenario
Upload a 5GB backup to S3 using multipart — split it first:

bash
split -b 500M backup.tar.gz backup_part_
for f in backup_part_*; do
  aws s3 cp $f s3://mybucket/backup/
done
🔹 dd — Low-Level Copy / Conversion
1️⃣ What It Does
Copies data at block level. Used for disk imaging, creating files of specific size, wiping disks.

2️⃣ Syntax
bash
dd if=input of=output [options]
3️⃣ Examples
bash
# Create a 4GB swap file
dd if=/dev/zero of=/swapfile bs=1G count=4

# Backup entire disk to image
dd if=/dev/sda of=/backup/disk.img bs=4M status=progress

# Restore disk from image
dd if=/backup/disk.img of=/dev/sda bs=4M status=progress

# Test disk write speed
dd if=/dev/zero of=/tmp/testfile bs=1G count=1 oflag=direct
# Test disk read speed
dd if=/tmp/testfile of=/dev/null bs=1G

# Wipe a disk securely
dd if=/dev/urandom of=/dev/sdb bs=4M status=progress
5️⃣ Common Mistakes
⚠️ EXTREMELY DANGEROUS: Swapping if and of will wipe your source disk. Always double-check of= target. Use status=progress to monitor. There is NO undo.

🔹 rsnapshot / borg / restic — Backup Tools
bash
# rsnapshot - incremental backups using rsync
rsnapshot daily          # run daily backup
rsnapshot -t daily       # test/dry run

# borg - deduplicating backup
borg init --encryption=repokey /backup/borg-repo
borg create /backup/borg-repo::backup-{now} /home /etc
borg list /backup/borg-repo
borg extract /backup/borg-repo::backup-2026-04-17

# restic - modern backup tool
restic init --repo /backup/restic-repo
restic backup /opt/app/ --repo /backup/restic-repo
restic snapshots --repo /backup/restic-repo
restic restore latest --target /restore/ --repo /backup/restic-repo
🔹 compress / uncompress — Legacy Unix Compression
bash
compress file.txt         # creates file.txt.Z
uncompress file.txt.Z     # decompress
9. Networking & Remote Access
🔹 ip — Modern Network Management
1️⃣ What It Does
The modern replacement for ifconfig. Shows and manages network interfaces, routing, addresses, and neighbors.

2️⃣ Syntax
bash
ip a                      # show all interfaces and IPs
ip addr show eth0         # specific interface
ip link show              # link layer info
ip route show             # routing table
ip route add default via 192.168.1.1    # add default route
ip addr add 192.168.1.100/24 dev eth0   # add IP
ip link set eth0 up/down                # enable/disable interface
ip neigh show             # ARP table
ip netns list             # list network namespaces
3️⃣ Examples & Output
bash
$ ip a
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 state UP
    inet 10.0.1.50/24 brd 10.0.1.255 scope global dynamic eth0

$ ip route show
default via 10.0.1.1 dev eth0
10.0.1.0/24 dev eth0 proto kernel scope link
🔹 ip a — Show All IP Addresses
bash
ip a                       # all interfaces
ip -4 a                    # IPv4 only
ip -6 a                    # IPv6 only
ip a show eth0             # specific interface
🔹 ifconfig — Legacy Network Configuration
bash
ifconfig                   # show all interfaces
ifconfig eth0              # specific interface
ifconfig eth0 up/down      # enable/disable
ifconfig eth0 192.168.1.10 netmask 255.255.255.0   # set IP
🎯 Interview Point
ifconfig is deprecated. Use ip commands on modern systems. But ifconfig still appears on many servers and exams.

🔹 ethtool — Ethernet Settings
bash
ethtool eth0                   # show settings
ethtool -i eth0                # driver info
ethtool -S eth0                # statistics
ethtool -s eth0 speed 1000 duplex full   # set speed
🔹 iwconfig / iwlist — Wireless Interface Config
bash
iwconfig                   # show wireless interfaces
iwconfig wlan0             # specific wireless interface
iwlist wlan0 scan          # scan for WiFi networks
🔹 ping — Test Network Connectivity
bash
ping hostname/IP
ping -c 4 8.8.8.8         # send exactly 4 packets
ping -i 0.5 host          # interval 0.5 seconds
ping -s 1400 host         # packet size 1400 bytes
ping -t 64 host           # TTL 64
3️⃣ Examples & Output
bash
$ ping -c 3 8.8.8.8
PING 8.8.8.8: 56 data bytes
64 bytes from 8.8.8.8: icmp_seq=0 ttl=118 time=1.23 ms
64 bytes from 8.8.8.8: icmp_seq=1 ttl=118 time=1.15 ms
--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss
rtt min/avg/max = 1.15/1.19/1.23 ms
4️⃣ Real-Time DevOps Scenario
After a deployment, verify EC2 instances can reach the RDS database:

bash
ping -c 3 mydb.cluster.us-east-1.rds.amazonaws.com
🔹 traceroute — Trace Network Path
bash
traceroute hostname
traceroute -n hostname      # no DNS resolution (faster)
traceroute -T hostname      # use TCP instead of UDP
3️⃣ Examples & Output
bash
$ traceroute 8.8.8.8
1  10.0.1.1       1.2 ms
2  203.0.113.1    5.1 ms
3  * * *          (firewall dropping packets)
4  8.8.8.8        12.3 ms
4️⃣ Real-Time DevOps Scenario
High latency between EC2 and RDS — use traceroute to find where the slowdown occurs.

🔹 mtr — Combined ping + traceroute
bash
mtr hostname           # interactive real-time route analysis
mtr -n hostname        # no DNS
mtr --report hostname  # generate one-time report
mtr -r -c 100 host     # 100-packet report
🎯 Interview Point
mtr is the best tool for diagnosing intermittent network issues. It shows packet loss PER HOP in real-time.

🔹 curl — Transfer Data to/from URLs
1️⃣ What It Does
Transfers data using HTTP, HTTPS, FTP, and more. Essential DevOps tool for API calls, health checks, and downloading files.

2️⃣ Key Options
bash
curl URL                          # GET request
curl -X POST URL -d "data"        # POST request
curl -H "Authorization: Bearer TOKEN" URL    # custom header
curl -o filename URL              # save to file
curl -O URL                       # save with original name
curl -L URL                       # follow redirects
curl -I URL                       # headers only (HEAD request)
curl -v URL                       # verbose (debug)
curl -s URL                       # silent mode
curl -f URL                       # fail on HTTP error
curl --connect-timeout 5 URL      # connection timeout
3️⃣ Examples & Output
bash
# Health check
$ curl -f http://localhost:8080/health
{"status":"ok","uptime":12345}

# POST JSON to API
$ curl -X POST -H "Content-Type: application/json" \
  -d '{"key":"value"}' http://api.example.com/endpoint

# Download file
$ curl -O https://example.com/app-v2.tar.gz

# Check response code only
$ curl -o /dev/null -s -w "%{http_code}" http://localhost:8080/
200

# Test with custom DNS
$ curl --resolve app.example.com:443:10.0.1.50 https://app.example.com/
4️⃣ Real-Time DevOps Scenario
CI/CD pipeline health check after deployment:

bash
response=$(curl -s -o /dev/null -w "%{http_code}" http://app:8080/health)
if [ "$response" != "200" ]; then
    echo "Health check failed: HTTP $response"
    exit 1
fi
🔹 wget — Download Files
bash
wget URL                          # download file
wget -c URL                       # resume interrupted download
wget -O filename URL              # save as specific name
wget -b URL                       # background download
wget --limit-rate=1m URL          # limit speed to 1MB/s
wget -r -np URL                   # recursive download
wget --user=user --password=pass URL   # with authentication
3️⃣ Examples
bash
$ wget -c https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip

$ wget -O /tmp/kubectl https://dl.k8s.io/release/v1.28.0/bin/linux/amd64/kubectl
🔹 scp — Secure Copy over SSH
bash
scp file user@host:/remote/path      # local → remote
scp user@host:/remote/file /local/   # remote → local
scp -r directory/ user@host:/path/   # recursive
scp -i ~/.ssh/key.pem file user@host:/path/  # with key
scp -P 2222 file user@host:/path/    # custom port
3️⃣ Examples
bash
# Upload deployment package to EC2
$ scp -i ~/.ssh/ec2-key.pem app.tar.gz ec2-user@54.1.2.3:/opt/deployments/

# Download logs from remote server
$ scp -r ec2-user@server:/var/log/app/ /local/logs/
🔹 rsync — Efficient File Synchronization
1️⃣ What It Does
Synchronizes files efficiently — only transfers changed portions (delta sync). Better than scp for repeated transfers.

2️⃣ Syntax
bash
rsync -avz source/ dest/                       # local sync
rsync -avz source/ user@host:/remote/          # to remote
rsync -avz user@host:/remote/ local/           # from remote
rsync --delete source/ dest/                   # delete extra files in dest
rsync --dry-run source/ dest/                  # test without transferring
rsync -avz --exclude='*.log' source/ dest/     # exclude pattern
rsync -avz -e "ssh -i ~/.ssh/key.pem" src/ user@host:/dst/   # custom SSH key
3️⃣ Option Reference
Option	Meaning
-a	Archive (recursive + preserve permissions, links, times)
-v	Verbose
-z	Compress during transfer
-P	Show progress + resume partial
--delete	Delete files in dest not in source
--dry-run	Simulate without making changes
4️⃣ Examples
bash
# Deploy website files
$ rsync -avz --delete /var/www/html/ ec2-user@server:/var/www/html/

# Backup to S3-mounted drive
$ rsync -avz --delete /opt/app/ /mnt/s3-backup/app/

# Sync configs between servers
$ rsync -avz /etc/nginx/ ec2-user@server2:/etc/nginx/
🔹 ssh — Secure Shell
1️⃣ What It Does
Securely connects to remote servers with encrypted communication. Essential for all remote server management.

2️⃣ Syntax
bash
ssh user@hostname
ssh -i ~/.ssh/key.pem user@host       # with private key
ssh -p 2222 user@host                 # custom port
ssh -L 8080:localhost:80 user@host    # local port forwarding
ssh -R 9090:localhost:3000 user@host  # remote port forwarding
ssh -D 1080 user@host                 # SOCKS proxy
ssh -N -f user@host -L ...           # background tunnel
3️⃣ Examples
bash
# Connect to EC2 instance
$ ssh -i ~/.ssh/ec2-key.pem ec2-user@54.1.2.3

# SSH tunnel — access RDS from local machine
$ ssh -L 5432:mydb.rds.amazonaws.com:5432 ec2-user@bastion-host -N

# Run command without interactive session
$ ssh ec2-user@server "df -h && free -h && uptime"

# SSH config (~/.ssh/config)
Host myserver
    HostName 54.1.2.3
    User ec2-user
    IdentityFile ~/.ssh/ec2-key.pem
    Port 22
4️⃣ Real-Time DevOps Scenario
Access an internal RDS database from your laptop via an EC2 bastion host:

bash
ssh -L 5432:prod-db.cluster.rds.amazonaws.com:5432 ec2-user@bastion -N -f
psql -h localhost -p 5432 -U dbuser mydb
5️⃣ Common Mistakes
SSH key must be chmod 600 — SSH refuses connection if permissions are too open.

Use ~/.ssh/config to avoid long ssh commands — reduces human error.

🔹 sftp — Secure FTP over SSH
bash
sftp user@host
# Inside sftp:
# put localfile remotepath
# get remotefile localpath
# ls, cd, mkdir, rm all work
🔹 ftp — File Transfer Protocol (Insecure)
bash
ftp hostname
# Use sftp or scp instead in production
🔹 telnet — Remote Connection (Insecure)
bash
telnet hostname 80     # test port connectivity (common use)
# NEVER use for actual remote login — not encrypted
4️⃣ Real-Time DevOps Scenario
Test if a port is open (safe use of telnet):

bash
telnet db.server.com 5432
# If it connects, the port is open
# If "Connection refused", port is closed/firewalled
🔹 nc / netcat — Network Swiss Army Knife
bash
nc -zv hostname 80             # test port (verbose)
nc -zv hostname 80-100         # test port range
nc -l -p 1234                  # listen on port 1234
echo "test" | nc host 1234     # send data
nc -l 1234 > received.txt      # receive file
nc host 1234 < file.txt        # send file
3️⃣ Examples
bash
# Test if port is open
$ nc -zv 10.0.1.50 5432
Connection to 10.0.1.50 5432 port [tcp/postgresql] succeeded!

# Simple HTTP request
$ echo -e "GET / HTTP/1.0\r\n\r\n" | nc example.com 80
🔹 dig — DNS Query Tool
bash
dig domain.com                  # A record
dig domain.com MX               # mail records
dig domain.com TXT              # TXT records
dig @8.8.8.8 domain.com         # use specific DNS server
dig +short domain.com           # IP only
dig -x 1.2.3.4                  # reverse lookup
dig +trace domain.com           # full DNS resolution trace
3️⃣ Examples & Output
bash
$ dig +short google.com
142.250.195.46

$ dig google.com MX +short
10 smtp.google.com.

$ dig @8.8.8.8 myapp.example.com
# ANSWER SECTION:
myapp.example.com. 300 IN A 54.1.2.3
4️⃣ Real-Time DevOps Scenario
After pointing a domain to a new load balancer, verify DNS propagation:

bash
dig @8.8.8.8 myapp.com +short
dig @1.1.1.1 myapp.com +short
🔹 nslookup — DNS Lookup (Legacy)
bash
nslookup domain.com
nslookup domain.com 8.8.8.8     # use specific DNS
🔹 host — Simple DNS Lookup
bash
$ host google.com
google.com has address 142.250.195.46
$ host 8.8.8.8
8.8.8.8.in-addr.arpa domain name pointer dns.google.
🔹 arp — ARP Table Management
bash
arp -n              # show ARP table (IP to MAC mapping)
arp -d 192.168.1.1  # delete ARP entry
arp -s 192.168.1.1 aa:bb:cc:dd:ee:ff   # add static entry
🔹 route — IP Routing Table
bash
route -n                                      # show routing table (numeric)
route add default gw 192.168.1.1             # add default gateway
route add -net 10.0.0.0/8 gw 192.168.1.254  # add network route
route del default                             # delete default route
🔹 ss — Socket Statistics (Modern netstat)
1️⃣ What It Does
Displays socket/network connection info. Faster and more detailed than netstat. The modern replacement.

2️⃣ Syntax
bash
ss -tulpn         # TCP/UDP Listening sockets with Process names, Numeric
ss -s             # summary statistics
ss -t             # TCP connections only
ss -u             # UDP only
ss state ESTABLISHED   # only established connections
ss -o             # show timers
3️⃣ Examples & Output
bash
$ ss -tulpn
Netid  State   Recv-Q Send-Q  Local Address:Port  Peer Address:Port Process
tcp    LISTEN  0      128     0.0.0.0:22           0.0.0.0:*     users:(("sshd",pid=998))
tcp    LISTEN  0      511     0.0.0.0:80           0.0.0.0:*     users:(("nginx",pid=1234))
tcp    LISTEN  0      128     0.0.0.0:443          0.0.0.0:*     users:(("nginx",pid=1234))

$ ss -s
Total: 142
TCP:   12 (estab 5, closed 2, orphaned 0, timewait 2)
🔹 netstat — Network Statistics (Legacy)
bash
netstat -tulpn          # listening ports with process names
netstat -an             # all connections, numeric
netstat -r              # routing table
netstat -i              # interface statistics
netstat -s              # protocol statistics
🎯 Interview Point
ss is the modern replacement for netstat (net-tools package). Both -tulpn flags work identically on both: -t=TCP, -u=UDP, -l=Listening, -p=Process, -n=Numeric.

🔹 tcpdump — Packet Capture
bash
tcpdump -i eth0                  # capture on eth0
tcpdump -i eth0 port 80          # capture port 80 traffic
tcpdump -i eth0 host 10.0.0.1   # capture for specific host
tcpdump -i eth0 -w capture.pcap  # save to file
tcpdump -r capture.pcap          # read pcap file
tcpdump -n -i eth0               # no DNS resolution
tcpdump 'tcp port 80 and host 10.0.0.1'   # combined filter
4️⃣ Real-Time DevOps Scenario
Diagnose API communication issue between microservices:

bash
tcpdump -i eth0 -A 'host service-b and port 8080' | grep -A 5 "HTTP"
🔹 tshark — Command-Line Wireshark
bash
tshark -i eth0                   # capture on interface
tshark -r capture.pcap           # read pcap file
tshark -R "http" -r file.pcap    # filter by protocol
🔹 nmap — Network Scanner
bash
nmap hostname                    # basic port scan
nmap -p 1-65535 hostname         # all ports
nmap -sV hostname                # service version detection
nmap -O hostname                 # OS detection
nmap -A hostname                 # aggressive scan (all)
nmap -p 22,80,443 10.0.0.0/24   # specific ports, subnet
nmap --script vuln hostname      # vulnerability scan
4️⃣ Real-Time DevOps Scenario
Verify security group rules on a new EC2 instance — confirm only expected ports are open:

bash
nmap -p 1-65535 your-ec2-ip
# Should only show 22 (SSH), 80 (HTTP), 443 (HTTPS)
🔹 arping — ARP Ping
bash
arping -I eth0 192.168.1.1    # ARP request to check MAC/IP
arping -c 3 192.168.1.1       # send 3 requests
🔹 bridge / brctl — Network Bridge Management
bash
bridge link show               # show bridge links
brctl show                     # show bridges (legacy)
brctl addbr br0                # create bridge
brctl addif br0 eth0           # add interface to bridge
🔹 vconfig — VLAN Management (Legacy)
bash
vconfig add eth0 10            # create VLAN 10 interface
vconfig rem eth0.10            # remove VLAN interface
🔹 ip netns — Network Namespaces
bash
ip netns list                              # list namespaces
ip netns add myns                          # create namespace
ip netns exec myns ip a                    # run command in namespace
ip netns exec myns ping 8.8.8.8           # network in namespace
4️⃣ Real-Time DevOps Scenario
Docker uses network namespaces for container isolation. Inspect a container's network namespace:

bash
ip netns list   # shows Docker container namespaces
🔹 socat — Bidirectional Data Streams
bash
socat TCP-LISTEN:1234,fork TCP:dest:1234   # TCP relay/proxy
socat STDIO TCP:host:80                     # connect to TCP port
socat -d -d PTY,raw,echo=0 PTY,raw,echo=0  # virtual serial ports
🔹 bmon — Bandwidth Monitor
bash
bmon                # interactive bandwidth monitor per interface
bmon -p eth0        # specific interface
🔹 ping6 / traceroute6 — IPv6 Tools
bash
ping6 ::1                   # ping IPv6 loopback
ping6 2001:db8::1           # ping IPv6 address
traceroute6 ipv6.google.com  # trace IPv6 route
🔹 netstat -tulpn / ss -tulpn — Listening Ports
These are the go-to commands for checking what's listening on your server:

bash
ss -tulpn
netstat -tulpn

# Find what's using a specific port
ss -tulpn | grep :8080
lsof -i :8080
10. Package Management
🔹 apt — Package Manager (Debian/Ubuntu)
bash
apt update                      # refresh package list
apt upgrade                     # upgrade all packages
apt install nginx               # install package
apt remove nginx                # remove (keep config)
apt purge nginx                 # remove + delete config
apt autoremove                  # remove unused dependencies
apt search keyword              # search packages
apt show nginx                  # package details
apt list --installed            # show installed packages
apt-get dist-upgrade            # full system upgrade
4️⃣ Real-Time DevOps Scenario
Provision a new Ubuntu EC2:

bash
apt update && apt upgrade -y
apt install -y nginx curl wget git vim htop
systemctl enable --now nginx
🔹 apt-get — Lower-Level Package Manager
bash
apt-get update
apt-get install -y nginx        # non-interactive (-y)
apt-get remove nginx
apt-get clean                   # clear package cache
apt-get autoremove
🔹 apt-cache — Query Package Info
bash
apt-cache search nginx         # search packages
apt-cache show nginx           # detailed package info
apt-cache policy nginx         # show versions available
apt-cache depends nginx        # show dependencies
🔹 dpkg — Low-Level .deb Package Manager
bash
dpkg -i package.deb            # install .deb file
dpkg -r packagename            # remove
dpkg -l                        # list all installed packages
dpkg -l | grep nginx           # filter
dpkg -S /usr/sbin/nginx        # which package owns this file?
dpkg --print-architecture      # show system architecture
3️⃣ Examples
bash
$ dpkg -S /bin/ls
coreutils: /bin/ls

$ dpkg -l | grep -i docker
ii  docker-ce    24.0.5   amd64  Docker CE
🔹 snap — Universal Linux Packages
bash
snap install packagename        # install
snap remove packagename         # remove
snap list                       # list installed snaps
snap refresh                    # update all snaps
snap find keyword               # search
🔹 yum — Package Manager (RHEL/CentOS Legacy)
bash
yum update                      # update all
yum install nginx               # install
yum remove nginx                # remove
yum search keyword              # search
yum info nginx                  # package info
yum list installed              # list installed
yum clean all                   # clean cache
yum provides /usr/sbin/nginx    # which package provides file?
🔹 dnf — Modern RPM Package Manager (RHEL8+/Fedora)
bash
dnf update                      # update all
dnf install nginx               # install
dnf remove nginx                # remove
dnf search keyword              # search
dnf info nginx                  # package info
dnf list installed              # list installed
dnf history                     # transaction history
dnf history undo last           # undo last transaction
dnf module list                 # show module streams
dnf module enable nginx:1.20    # enable specific version stream
4️⃣ Real-Time DevOps Scenario
Provision a new RHEL8/CentOS8 EC2:

bash
dnf update -y
dnf install -y nginx curl wget git vim
systemctl enable --now nginx
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
🔹 rpm — RPM Package Manager
bash
rpm -ivh package.rpm            # install verbose with progress
rpm -Uvh package.rpm            # upgrade
rpm -e packagename              # erase/remove
rpm -qa                         # query all installed packages
rpm -ql nginx                   # list files in package
rpm -qf /usr/sbin/nginx         # which package owns this file?
rpm -qi nginx                   # package information
rpm --verify nginx               # verify package integrity
🔹 zypper — openSUSE Package Manager
bash
zypper refresh                  # refresh repos
zypper update                   # update all
zypper install nginx            # install
zypper remove nginx             # remove
zypper search keyword           # search
🔹 flatpak — Sandboxed Application Manager
bash
flatpak install flathub org.gimp.GIMP
flatpak run org.gimp.GIMP
flatpak list
flatpak update
🔹 yumdownloader — Download RPM Without Installing
bash
yumdownloader nginx                 # download RPM only
yumdownloader --resolve nginx       # download with dependencies
yumdownloader --destdir /tmp nginx  # save to specific dir
🔹 lsb_release -a — Show Linux Distribution Info
bash
$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.3 LTS
Release:        22.04
Codename:       jammy

$ cat /etc/os-release     # alternative
NAME="Amazon Linux"
VERSION="2"
11. Services & Systemd
🔹 systemctl — Service & System Control
1️⃣ What It Does
The primary tool for controlling systemd services, units, targets, and system state on modern Linux.

2️⃣ Service Management
bash
systemctl start nginx           # start service
systemctl stop nginx            # stop service
systemctl restart nginx         # restart
systemctl reload nginx          # reload config without restart
systemctl status nginx          # show status + recent logs
systemctl enable nginx          # auto-start on boot
systemctl disable nginx         # remove from boot
systemctl is-active nginx       # check if running
systemctl is-enabled nginx      # check if boot-enabled
systemctl mask nginx            # prevent start entirely
systemctl unmask nginx          # allow start again
3️⃣ System State
bash
systemctl list-units            # list all loaded units
systemctl list-units --failed   # show failed units
systemctl list-unit-files       # list all unit files
systemctl daemon-reload         # reload unit files after editing
systemctl reboot                # reboot
systemctl poweroff              # power off
systemctl isolate multi-user.target    # change runlevel
systemctl rescue                # switch to rescue mode
systemctl default               # switch to default target
systemctl reboot --firmware-setup   # boot into BIOS/UEFI
4️⃣ Examples & Output
bash
$ systemctl status nginx
● nginx.service - A high performance web server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled)
   Active: active (running) since Fri 2026-04-17 10:00:00 UTC; 8h ago
  Process: 1234 ExecStart=/usr/sbin/nginx
 Main PID: 1234 (nginx)
    Tasks: 5 (limit: 4915)
   Memory: 25.3M
      CPU: 1.234s
   CGroup: /system.slice/nginx.service
           ├─1234 nginx: master process
           ├─1235 nginx: worker process
           └─1236 nginx: worker process

$ systemctl list-units --failed
  UNIT                    LOAD   ACTIVE SUB    DESCRIPTION
● myapp.service           loaded failed failed  My Application
5️⃣ Real-Time DevOps Scenario
After deployment, restart app and verify it's running:

bash
systemctl restart myapp
sleep 3
systemctl is-active myapp || { journalctl -u myapp -n 50; exit 1; }
🎯 Interview Point
Difference between restart and reload: restart stops and starts the service (downtime). reload sends SIGHUP to re-read config without stopping (zero downtime for nginx).

🔹 service — Legacy Service Control (SysV)
bash
service nginx start
service nginx stop
service nginx restart
service nginx status
🎯 Interview Point
On systemd systems, service is a wrapper that calls systemctl. Use systemctl in modern scripts.

🔹 chkconfig — SysV Service Auto-Start (Legacy RHEL)
bash
chkconfig nginx on              # enable at all runlevels
chkconfig nginx off             # disable
chkconfig --list nginx          # show runlevel config
🔹 journalctl — Systemd Journal Logs
1️⃣ What It Does
Views logs collected by systemd's journal. Replaces reading /var/log/syslog for systemd services.

2️⃣ Key Usage
bash
journalctl                       # all logs (oldest first)
journalctl -f                    # follow (live tail)
journalctl -u nginx              # logs for specific service
journalctl -u nginx -f           # follow nginx logs
journalctl -u nginx -n 50        # last 50 lines
journalctl -xe                   # recent logs with context + errors
journalctl --since "1 hour ago"  # last hour
journalctl --since "2026-04-17 10:00" --until "2026-04-17 12:00"
journalctl -p err                # only error level and above
journalctl -p err..emerg        # error to emergency
journalctl -b                    # logs since last boot
journalctl -b -1                 # logs from previous boot
journalctl --disk-usage          # see how much disk journal uses
journalctl --vacuum-size=500M    # trim journal to 500MB
3️⃣ Examples & Output
bash
$ journalctl -u nginx -n 20 --no-pager
Apr 17 10:00:01 server nginx[1234]: nginx: the configuration file syntax is ok
Apr 17 10:00:01 server nginx[1234]: nginx: configuration file test is successful

$ journalctl -xe | grep -i "failed\|error"
Apr 17 18:22:01 server systemd[1]: myapp.service: Main process exited, code=exited, status=1/FAILURE
4️⃣ Real-Time DevOps Scenario
Service just crashed — immediate diagnosis:

bash
journalctl -u myapp -n 100 --no-pager | tail -30
journalctl -xe | grep -A 5 "myapp"
🔹 logger — Write to System Log
bash
logger "Deployment started by CI/CD at $(date)"
logger -t myapp "Application health check passed"
logger -p user.err "Critical: database connection failed"
4️⃣ Real-Time DevOps Scenario
Log deployment events to syslog for audit trail:

bash
logger -t deployment "Deploy started: version $VERSION by $USER"
./deploy.sh
logger -t deployment "Deploy completed: version $VERSION"
12. Scheduling
🔹 cron & crontab — Scheduled Jobs
1️⃣ What It Does
cron is the daemon that runs scheduled tasks. crontab edits the schedule.

2️⃣ Crontab Format
text
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7, 0=Sunday)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
3️⃣ Syntax
bash
crontab -e          # edit current user's crontab
crontab -l          # list current crontab
crontab -r          # remove crontab (⚠️ careful!)
crontab -u user -e  # edit another user's crontab (root)
4️⃣ Examples
bash
# Every day at 2:30 AM
30 2 * * * /opt/app/backup.sh >> /var/log/backup.log 2>&1

# Every 5 minutes
*/5 * * * * /opt/health-check.sh

# Every Monday at 6 AM
0 6 * * 1 /opt/app/weekly-report.sh

# First day of month at midnight
0 0 1 * * /opt/app/monthly-cleanup.sh

# Every weekday at 9 AM
0 9 * * 1-5 /opt/scripts/morning-report.sh

# Every minute (testing)
* * * * * echo "test" >> /tmp/cron-test.log
5️⃣ Cron Special Strings
bash
@reboot   /opt/app/start.sh    # on every reboot
@daily    /opt/app/backup.sh   # once a day (midnight)
@hourly   /opt/scripts/check.sh
@weekly   /opt/scripts/weekly.sh
@monthly  /opt/scripts/monthly.sh
5️⃣ Common Mistakes
Cron runs with minimal environment — always use full paths in scripts.

Redirect output: command >> /var/log/cron.log 2>&1 or cron emails failures.

crontab -r deletes the ENTIRE crontab — many people run this thinking it means edit.

🎯 Interview Point
Cron logs are in /var/log/cron (RHEL) or /var/log/syslog (Ubuntu). Check: grep CRON /var/log/syslog

🔹 at — One-Time Scheduled Job
bash
at 10:30                         # schedule at 10:30 today
at 10:30 tomorrow                # schedule for tomorrow
at now + 2 hours                 # 2 hours from now
at 10:30 April 20                # specific date
atq                              # list pending at jobs
atrm 3                           # remove job 3
3️⃣ Example
bash
$ at now + 5 minutes
at> /opt/app/restart.sh
at> Ctrl+D
job 5 at Fri Apr 17 18:30:00 2026
🔹 batch — Run Job When Load Is Low
bash
batch
> /opt/heavy-script.sh
> Ctrl+D
# Runs when system load drops below 0.8
🔹 anacron — Periodic Jobs for Non-24/7 Systems
bash
# /etc/anacrontab
# period  delay  job-identifier  command
1         5      daily.jobs      /etc/cron.daily/
7         10     weekly.jobs     /etc/cron.weekly/
🎯 Interview Point
cron requires the system to be running at the exact scheduled time. anacron catches up missed jobs after the system boots — used for laptops and non-always-on servers.

🔹 systemd-run — Transient Systemd Service/Timer
bash
systemd-run --on-calendar="*-*-* 02:00" /opt/backup.sh   # timer
systemd-run --scope --uid=appuser /opt/app/start.sh       # run as user
🔹 systemd timers — Cron Alternative with systemd
bash
# Create /etc/systemd/system/myapp-backup.timer
[Unit]
Description=Daily backup timer

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target

systemctl enable --now myapp-backup.timer
systemctl list-timers              # list all timers
🔹 watch — Repeat Command at Intervals
(Covered in Process Management section — runs command every N seconds in terminal)

bash
watch -n 5 "df -h && free -h"
watch -n 2 kubectl get pods
13. Shell Environment & Variables
🔹 echo — Print to Terminal
bash
echo "Hello World"
echo $VARIABLE
echo -e "line1\nline2"      # enable escape sequences
echo -n "no newline"        # suppress newline
echo "text" >> file.txt     # append to file
🔹 printf — Formatted Print
bash
printf "Name: %s\tAge: %d\n" "Alice" 30
printf "%-20s %s\n" "Server:" "prod-01"
printf "%05d\n" 42           # → 00042
🔹 read — Read User Input
bash
read varname                   # read into variable
read -p "Enter password: " -s password    # silent (for passwords)
read -t 10 answer              # timeout after 10 seconds
read -a array                  # read into array
3️⃣ Example
bash
#!/bin/bash
read -p "Deploy to production? [y/N]: " answer
if [[ "$answer" != "y" ]]; then
    echo "Deployment cancelled"
    exit 0
fi
🔹 history — Command History
bash
history                       # show all history
history 20                    # last 20 commands
history | grep curl           # search history
!123                          # re-run command #123
!!                            # re-run last command
!curl                         # re-run last curl command
Ctrl+R                        # reverse search history
history -c                    # clear history
4️⃣ Real-Time DevOps Scenario
Find what commands were run before a production issue:

bash
history | grep "kubectl\|helm\|terraform" | tail -20
🔹 alias / unalias — Command Shortcuts
bash
alias ll='ls -lah'
alias k='kubectl'
alias tf='terraform'
alias gs='git status'
alias ..='cd ..'
alias grep='grep --color=auto'

unalias ll              # remove alias

# Make permanent — add to ~/.bashrc
echo "alias ll='ls -lah'" >> ~/.bashrc
source ~/.bashrc
🔹 export — Set Environment Variables
bash
export VARIABLE=value              # set and export to child processes
export PATH=$PATH:/usr/local/bin   # add to PATH
export AWS_REGION=us-east-1
export KUBECONFIG=~/.kube/config

# Show all exported variables
export -p | grep AWS
4️⃣ Real-Time DevOps Scenario
Set AWS credentials for a script:

bash
export AWS_ACCESS_KEY_ID=AKIA...
export AWS_SECRET_ACCESS_KEY=...
export AWS_DEFAULT_REGION=us-east-1
aws s3 ls
🔹 env — Display/Modify Environment
bash
env                              # show all environment variables
env | grep AWS                   # filter
env -u VARIABLE command          # run command without a variable
env VAR=value command            # run with extra variable
🔹 set — Shell Options & Variables
bash
set                   # show all variables and functions
set -e                # exit on any error (use in scripts!)
set -u                # treat undefined variables as errors
set -x                # print each command before executing (debug mode)
set -o pipefail       # catch errors in pipelines
set +x                # turn off debug mode
4️⃣ Best Practice for Shell Scripts
bash
#!/bin/bash
set -euo pipefail      # always start scripts with this!
# -e = exit on error
# -u = error on undefined variable
# -o pipefail = catch pipeline failures
🔹 unset — Remove Variable/Function
bash
unset VARIABLE_NAME
unset -f function_name    # remove function
🔹 .bashrc — Non-Login Shell Config
bash
# ~/.bashrc is
Prepared using Claude Sonnet 4.6
please generate for next sections
Continuing from .bashrc — here are all remaining sections through the final Interview Preparation chapter:

text
# (Continuing from Shell Environment...)

## 🔹 `.bashrc` — Non-Login Shell Config

### 1️⃣ What It Does
Executed every time you open a new **interactive non-login shell** (new terminal window, `bash` command). Place aliases, functions, and env variables here.

```bash
# ~/.bashrc — common additions for DevOps engineers
export EDITOR=vim
export HISTSIZE=10000
export HISTTIMEFORMAT="%F %T "     # add timestamp to history

alias ll='ls -lah'
alias k='kubectl'
alias tf='terraform'
alias ..='cd ..'
alias grep='grep --color=auto'
alias myip='curl -s ifconfig.me'

# Custom prompt with git branch
parse_git_branch() {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}
PS1='\u@\h:\w[\$(parse_git_branch)]\$ '

# Load after editing
source ~/.bashrc
```

---

## 🔹 `.profile` — Login Shell Config

### 1️⃣ What It Does
Executed once on **login** (SSH login, `su -`). Sets environment variables and PATH modifications that persist for the entire session.

```bash
# ~/.profile
export PATH=$PATH:/usr/local/bin:/opt/myapp/bin
export JAVA_HOME=/usr/lib/jvm/java-17
export KUBECONFIG=$HOME/.kube/config
export AWS_DEFAULT_REGION=ap-south-1

# Source .bashrc from .profile
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
```

### 🎯 Interview Point
> `.bashrc` = every new terminal. `.profile` = once at login. `/etc/profile` = system-wide login. `/etc/bash.bashrc` = system-wide interactive shell.

---

## 🔹 `PATH` — Executable Search Path

```bash
echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Add to PATH permanently
echo 'export PATH=$PATH:/opt/myapp/bin' >> ~/.bashrc
source ~/.bashrc

# Temporarily add
export PATH=$PATH:/opt/scripts

# Check which binary will be used
which terraform
```

### 🎯 Interview Point
> When you type a command, the shell searches each directory in `$PATH` left to right. First match wins. That's why order matters — `/usr/local/bin` before `/usr/bin` means locally installed tools take precedence.

---

## 🔹 `which` — Show Full Path of Command

```bash
$ which nginx
/usr/sbin/nginx

$ which python3
/usr/bin/python3

$ which terraform
/usr/local/bin/terraform
```

---

## 🔹 `type` — Describe How Command Is Interpreted

```bash
$ type ls
ls is aliased to 'ls --color=auto'

$ type cd
cd is a shell builtin

$ type nginx
nginx is /usr/sbin/nginx

$ type if
if is a shell keyword
```

---

## 🔹 `hash` — Cache Command Locations

```bash
hash              # show cached command locations
hash -r           # clear cache (use after installing new binary)
hash nginx        # cache specific command
```

### 4️⃣ Real-Time DevOps Scenario
After installing a new version of terraform in `/usr/local/bin`:
```bash
hash -r           # clear location cache
which terraform   # now points to new location
```

---

## 🔹 `basename` & `dirname`
*(Covered in Core Commands section)*

---

## 🔹 `command` — Execute Bypassing Aliases/Functions

```bash
command ls             # runs /bin/ls, ignoring alias
command -v nginx       # like which — find command path
command -V nginx       # verbose version
```

### 4️⃣ Real-Time DevOps Scenario
In a script where `ls` might be aliased:
```bash
if command -v docker &>/dev/null; then
    echo "Docker is installed"
fi
```

---

## 🔹 `eval` — Evaluate and Execute String as Command

```bash
eval "echo Hello"              # evaluates and runs
cmd="ls -lah /var/log"
eval $cmd

# Common use: load SSH agent
eval $(ssh-agent -s)
eval $(aws sts assume-role ... | jq ...)
```

### 5️⃣ Common Mistakes
> ⚠️ Never `eval` untrusted input — it executes arbitrary code. Major security risk.

---

## 🔹 `exec` — Replace Shell with Command

```bash
exec bash              # replace current shell with new bash
exec > /var/log/output.log 2>&1    # redirect all output of script
exec 3> /tmp/myfile    # open file descriptor 3
```

### 4️⃣ Real-Time DevOps Scenario
Redirect all output in a script to a log file:
```bash
#!/bin/bash
exec > /var/log/deploy.log 2>&1
echo "All output goes to log now"
```

---

## 🔹 `sleep`
*(Covered in Core Commands section)*

---

# 14. Security & Access Control

---

## 🔹 `getenforce` / `setenforce` / `sestatus` — SELinux Control

### 1️⃣ What SELinux Does
Security-Enhanced Linux enforces mandatory access control policies. Common on RHEL/CentOS.

```bash
getenforce                    # show current mode: Enforcing/Permissive/Disabled
sestatus                      # detailed SELinux status
sestatus -v                   # verbose

setenforce 0                  # temporarily set to Permissive (troubleshooting)
setenforce 1                  # back to Enforcing
```

### 3️⃣ Examples & Output
```bash
$ getenforce
Enforcing

$ sestatus
SELinux status:           enabled
SELinuxfs mount:          /sys/fs/selinux
SELinux mount point:      enforcing
Policy version:           33
Policy from config file:  targeted
```

### 4️⃣ Real-Time DevOps Scenario
App can't write to `/var/data` even though file permissions are correct — SELinux is blocking it:
```bash
# Check SELinux denials
ausearch -m avc -ts recent
# Temporarily disable to confirm SELinux is the cause
setenforce 0
# Test app — if it works now, SELinux is the issue
# Fix properly with semanage or restorecon — don't leave in Permissive!
setenforce 1
```

### 🎯 Interview Point
> **Never permanently disable SELinux in production.** Instead, use `setenforce 0` for testing, then fix the policy with `semanage` or `chcon`.

---

## 🔹 `semanage` — Manage SELinux Policy

```bash
# Allow nginx to use port 8080
semanage port -a -t http_port_t -p tcp 8080

# List allowed HTTP ports
semanage port -l | grep http

# Set file context
semanage fcontext -a -t httpd_sys_content_t "/webdata(/.*)?"
restorecon -Rv /webdata
```

---

## 🔹 `apparmor_status` / `aa-status` — AppArmor Status (Ubuntu)

```bash
apparmor_status
aa-status                     # same command
aa-status | grep enforce      # show enforced profiles
```

---

## 🔹 `ufw` — Uncomplicated Firewall (Ubuntu)

```bash
ufw status                    # show status and rules
ufw enable                    # enable firewall
ufw disable                   # disable
ufw allow 22                  # allow SSH
ufw allow 80/tcp              # allow HTTP
ufw allow 443/tcp             # allow HTTPS
ufw deny 3306                 # deny MySQL from outside
ufw allow from 10.0.0.0/8 to any port 5432   # allow specific subnet
ufw delete allow 80           # remove rule
ufw reload                    # reload rules
ufw reset                     # reset all rules
```

### 4️⃣ Real-Time DevOps Scenario
Harden a new Ubuntu EC2 — allow only SSH, HTTP, HTTPS:
```bash
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable
ufw status verbose
```

---

## 🔹 `firewall-cmd` — firewalld (RHEL/CentOS)

```bash
firewall-cmd --state                               # check if running
firewall-cmd --list-all                            # list all rules
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --remove-service=http --permanent
firewall-cmd --reload                              # apply permanent rules
firewall-cmd --list-ports                          # show open ports
```

### 4️⃣ Real-Time DevOps Scenario
Open port 8080 for a new app on RHEL:
```bash
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload
firewall-cmd --list-ports    # verify
```

---

## 🔹 `iptables` — Low-Level Packet Filtering

```bash
iptables -L -n -v               # list all rules with counters
iptables -A INPUT -p tcp --dport 80 -j ACCEPT    # allow port 80
iptables -A INPUT -p tcp --dport 22 -j ACCEPT    # allow SSH
iptables -A INPUT -j DROP                         # drop all other input
iptables -D INPUT -p tcp --dport 80 -j ACCEPT    # delete rule
iptables -F                                       # flush all rules (careful!)
iptables -P INPUT DROP                            # default DROP policy
iptables-save > /etc/iptables/rules.v4            # save rules
iptables-restore < /etc/iptables/rules.v4         # restore rules
```

### 5️⃣ Common Mistakes
> ⚠️ `iptables -F` flushes ALL rules instantly — if you only have an SSH allow rule and flush it, you will be locked out of the server.

---

## 🔹 `nft` — Modern nftables

```bash
nft list ruleset               # show all rules
nft add rule ip filter input tcp dport 80 accept
nft list tables
nft flush ruleset              # clear all rules (careful!)
```

---

## 🔹 `tripwire` / `aide` — File Integrity Monitoring

```bash
# AIDE - Advanced Intrusion Detection Environment
aide --init                    # initialize baseline database
aide --check                   # check against baseline
aide --update                  # update database

# Tripwire
tripwire --init                # initialize policy
tripwire --check               # check for changes
```

### 4️⃣ Real-Time DevOps Scenario
Run `aide --check` weekly via cron to detect unauthorized file changes on production servers.

---

## 🔹 `getcap` / `setcap` — File Capabilities
*(Covered in Permissions section)*

---

## 🔹 `lssec` / `chsec` — SELinux File Attributes

```bash
lssec -f /etc/passwd -s seclevel    # show security level
chsec -f /etc/passwd -s seclevel -a "value"  # set attribute
```

---

## 🔹 `faillock` — Track Failed Login Attempts

```bash
faillock                           # show all failed attempts
faillock --user ec2-user           # specific user
faillock --reset --user ec2-user   # unlock user
```

### 4️⃣ Real-Time DevOps Scenario
A user is locked out after too many failed SSH attempts:
```bash
faillock --user devuser            # confirm lockout
faillock --reset --user devuser    # unlock
```

---

## 🔹 `gpg` / `gpg2` — Encryption & Signing

```bash
gpg --gen-key                          # generate key pair
gpg --list-keys                        # list public keys
gpg --list-secret-keys                 # list private keys
gpg -e -r "recipient" file.txt         # encrypt file
gpg -d file.txt.gpg                    # decrypt file
gpg --sign file.txt                    # sign file
gpg --verify file.txt.sig              # verify signature
gpg --export -a "keyname" > key.pub    # export public key
gpg --import key.pub                   # import public key
```

### 4️⃣ Real-Time DevOps Scenario
Encrypt sensitive config files before committing to a repo:
```bash
gpg -e -r ops-team@company.com secrets.env
# Commit secrets.env.gpg instead of secrets.env
```

---

## 🔹 `openssl` — SSL/TLS Toolkit

```bash
# Generate private key
openssl genrsa -out private.key 2048

# Generate self-signed certificate
openssl req -new -x509 -key private.key -out cert.pem -days 365

# View certificate details
openssl x509 -in cert.pem -text -noout

# Check certificate expiry
openssl x509 -in cert.pem -noout -enddate

# Test SSL connection
openssl s_client -connect example.com:443

# Check remote cert expiry
echo | openssl s_client -connect example.com:443 2>/dev/null | \
  openssl x509 -noout -enddate

# Encrypt a file
openssl enc -aes-256-cbc -salt -in file.txt -out file.enc -k password

# Decrypt
openssl enc -d -aes-256-cbc -in file.enc -out file.txt -k password
```

### 4️⃣ Real-Time DevOps Scenario
Check when your production SSL certificate expires:
```bash
echo | openssl s_client -connect yourapp.com:443 2>/dev/null | \
  openssl x509 -noout -enddate
notAfter=Jun 30 00:00:00 2026 GMT
```

---

## 🔹 `sha256sum` / `md5sum` / `shasum` — File Checksums

```bash
sha256sum file.tar.gz                      # compute SHA256
sha256sum -c checksum.sha256               # verify against checksum file
echo "hash  filename" | sha256sum -c       # inline verify

md5sum file.tar.gz                         # compute MD5
md5sum -c md5sums.txt                      # verify

shasum -a 256 file                         # SHA256 (macOS compatible)
shasum -a 512 file                         # SHA512
```

### 4️⃣ Real-Time DevOps Scenario
Before installing Terraform binary, verify integrity:
```bash
sha256sum terraform_1.5.0_linux_amd64.zip
# Compare with hash from Hashicorp's website
```

---

## 🔹 `chroot` — Change Root Directory

```bash
chroot /mnt/rescue /bin/bash    # enter chroot environment
chroot /mnt/newroot             # uses /bin/sh by default
```

### 4️⃣ Real-Time DevOps Scenario
System won't boot — boot from rescue disk and chroot in to repair:
```bash
mount /dev/sda1 /mnt
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /dev /mnt/dev
chroot /mnt /bin/bash
# Now repair grub, fix /etc/fstab, reset password, etc.
```

---

# 15. Logging & Auditing

---

## 🔹 `journalctl`
*(Full coverage in Services & Systemd section)*

---

## 🔹 `logrotate` — Log Rotation

### 1️⃣ What It Does
Automatically rotates, compresses, and manages log files to prevent them from filling disk.

```bash
logrotate /etc/logrotate.conf           # run manually
logrotate -d /etc/logrotate.conf        # dry run (debug)
logrotate -f /etc/logrotate.conf        # force rotation
```

### 2️⃣ Config Example
```bash
# /etc/logrotate.d/myapp
/var/log/myapp/*.log {
    daily               # rotate daily
    rotate 14           # keep 14 rotations
    compress            # gzip old logs
    delaycompress       # compress on second rotation
    missingok           # don't error if log missing
    notifempty          # don't rotate empty files
    create 0640 appuser appgroup   # create new log with permissions
    postrotate
        systemctl reload myapp
    endscript
}
```

### 4️⃣ Real-Time DevOps Scenario
App log growing to 10GB on EC2 — set up logrotate:
```bash
# Create /etc/logrotate.d/myapp (above config)
logrotate -d /etc/logrotate.d/myapp   # test first
logrotate -f /etc/logrotate.d/myapp   # force run
```

---

## 🔹 `/var/log/syslog` and `/var/log/messages`

```bash
# Ubuntu/Debian — general system messages
tail -f /var/log/syslog
grep "kernel" /var/log/syslog
grep "error" /var/log/syslog | tail -50

# RHEL/CentOS
tail -f /var/log/messages
grep -i "error\|warn" /var/log/messages
```

---

## 🔹 `dmesg` — Kernel Ring Buffer

```bash
dmesg                          # show kernel messages
dmesg -T                       # with human-readable timestamps
dmesg | grep -i "error\|fail"  # filter errors
dmesg | grep -i "oom"          # OOM killer events
dmesg | grep -i "eth\|ens\|disk"   # hardware messages
dmesg --level=err,crit         # only errors
dmesg -C                       # clear ring buffer (root)
```

### 3️⃣ Examples & Output
```bash
$ dmesg -T | tail -20
[Fri Apr 17 10:00:01 2026] EXT4-fs (xvda1): recovery complete
[Fri Apr 17 10:00:05 2026] eth0: renamed from veth3a1b2c

$ dmesg | grep -i "oom"
[14523.621] Out of memory: Kill process 5678 (java) score 800 or sacrifice child
```

### 4️⃣ Real-Time DevOps Scenario
App process was randomly killed — check if OOM killer was responsible:
```bash
dmesg -T | grep -i "killed process\|oom"
```

---

## 🔹 `auditctl` / `ausearch` / `aureport` — Linux Audit System

```bash
# auditctl — configure audit rules
auditctl -l                              # list current rules
auditctl -w /etc/passwd -p wa -k passwd_changes   # watch passwd file
auditctl -w /etc/sudoers -p rwa -k sudoers_watch  # watch sudoers
auditctl -a always,exit -F arch=b64 -S execve -k commands   # log all commands

# ausearch — search audit logs
ausearch -m avc                          # SELinux denials
ausearch -m USER_LOGIN -ts today         # today's logins
ausearch -k passwd_changes               # events matching key
ausearch -ui 1001                        # events for UID 1001
ausearch -x /bin/su                      # events for specific command

# aureport — generate reports
aureport                                 # summary report
aureport --auth                          # authentication events
aureport --failed                        # failed events
aureport --login                         # login report
aureport --tty                           # TTY keystrokes (if logged)
```

### 4️⃣ Real-Time DevOps Scenario
Security team asks: "Who deleted files in /etc/ in the last 24 hours?"
```bash
auditctl -w /etc/ -p wa -k etc_changes
ausearch -k etc_changes -ts today | grep "SYSCALL\|PROCTITLE"
```

---

## 🔹 `logger` — Write Custom Log Messages
*(Covered in Services section)*

---

## 🔹 `last` / `lastb` — Login History

```bash
last                          # successful logins
last -n 20                    # last 20 logins
last reboot                   # reboot history
lastb                         # failed login attempts (bad logins)
lastb -n 20                   # last 20 failed attempts
```

### 4️⃣ Real-Time DevOps Scenario
Security audit — check for brute force attacks:
```bash
lastb | awk '{print $3}' | sort | uniq -c | sort -rn | head -10
# Shows IPs with most failed login attempts
```

---

## 🔹 `journalctl -xe` — Extended Journal Debugging

```bash
journalctl -xe                          # recent logs with context
journalctl -xe | grep -i "failed"       # filter failures
journalctl -xe -u myapp                 # for specific service
```

---

# 16. System Information & OS Details

---

## 🔹 `uname` — System Information

```bash
uname -a              # all info: kernel, hostname, arch, OS
uname -r              # kernel version only
uname -m              # machine hardware (x86_64, aarch64)
uname -s              # OS name
uname -n              # hostname
```

### 3️⃣ Examples
```bash
$ uname -a
Linux ip-10-0-1-50 5.15.0-1031-aws #35-Ubuntu SMP x86_64 GNU/Linux

$ uname -r
5.15.0-1031-aws

$ uname -m
x86_64
```

---

## 🔹 `arch` — Machine Architecture

```bash
$ arch
x86_64
```

---

## 🔹 `dpkg --print-architecture`

```bash
$ dpkg --print-architecture
amd64
```

---

## 🔹 `cat /etc/os-release` — OS Info

```bash
$ cat /etc/os-release
NAME="Ubuntu"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 22.04.3 LTS"
VERSION_ID="22.04"
```

---

## 🔹 `hostname` / `hostnamectl` — Hostname Management

```bash
hostname                          # show current hostname
hostname -I                       # show all IPs
hostname -f                       # fully qualified domain name (FQDN)
hostnamectl                       # detailed hostname info
hostnamectl set-hostname newname  # permanently change hostname
```

### 3️⃣ Examples
```bash
$ hostnamectl
   Static hostname: prod-web-01
         Icon name: computer-vm
           Chassis: vm
        Machine ID: abc123def456
           Boot ID: xyz789
    Virtualization: amazon
  Operating System: Ubuntu 22.04.3 LTS
            Kernel: Linux 5.15.0-1031-aws
      Architecture: x86-64
```

---

## 🔹 `lscpu` — CPU Architecture Details

```bash
$ lscpu
Architecture:   x86_64
CPU(s):         4
Thread(s) per core: 2
Core(s) per socket: 2
Socket(s):      1
NUMA node(s):   1
Vendor ID:      GenuineIntel
Model name:     Intel(R) Xeon(R) Platinum 8259CL @ 2.50GHz
CPU MHz:        2499.998
Cache L3:       36608K
```

### 4️⃣ Real-Time DevOps Scenario
Before sizing a Java application's thread pool, check available CPU cores:
```bash
lscpu | grep "^CPU(s):"
nproc                    # even simpler — just prints core count
```

---

## 🔹 `lsusb` — List USB Devices

```bash
lsusb               # list USB devices
lsusb -v            # verbose
lsusb -t            # tree format
```

---

## 🔹 `lspci` — List PCI Devices

```bash
lspci               # list PCI devices (GPU, NIC, etc.)
lspci -v            # verbose
lspci | grep -i "ethernet\|network"
lspci | grep -i "vga\|nvidia\|amd"
```

---

## 🔹 `lshw` — Detailed Hardware Info

```bash
lshw                         # full hardware info
lshw -short                  # summary
lshw -class network          # network devices
lshw -class storage          # storage devices
lshw -html > hardware.html   # export as HTML
```

---

## 🔹 `dmidecode` — BIOS/Hardware Info

```bash
dmidecode                            # all DMI info
dmidecode -t memory                  # RAM info
dmidecode -t processor               # CPU info
dmidecode -t bios                    # BIOS version
dmidecode | grep -i "product\|vendor\|serial"
```

### 4️⃣ Real-Time DevOps Scenario
Find EC2 instance type and serial from within the instance:
```bash
dmidecode | grep -i "product name"
# Amazon EC2 r5.xlarge
```

---

## 🔹 `hwclock` — Hardware Clock

```bash
hwclock                   # show hardware clock
hwclock --show            # explicit show
hwclock --systohc         # sync system time → hardware clock
hwclock --hctosys         # sync hardware clock → system time
```

---

## 🔹 `timedatectl` — System Time/Date/Timezone

```bash
timedatectl                              # show current settings
timedatectl list-timezones               # list all timezones
timedatectl set-timezone Asia/Kolkata    # set timezone
timedatectl set-ntp true                 # enable NTP sync
timedatectl set-time "2026-04-17 18:00:00"   # manually set time
```

### 3️⃣ Examples
```bash
$ timedatectl
               Local time: Fri 2026-04-17 18:00:01 IST
           Universal time: Fri 2026-04-17 12:30:01 UTC
                 RTC time: Fri 2026-04-17 12:30:01
                Time zone: Asia/Kolkata (IST, +0530)
System clock synchronized: yes
              NTP service: active
```

### 4️⃣ Real-Time DevOps Scenario
New EC2 launched with wrong timezone — fix it:
```bash
timedatectl set-timezone Asia/Kolkata
timedatectl    # verify
```

---

## 🔹 `uptime -p`

```bash
$ uptime -p
up 5 days, 3 hours, 22 minutes

$ uptime
 18:00:01 up 5 days, 3:22,  2 users,  load average: 0.52, 0.48, 0.45
```

---

## 🔹 `free -m` / `free -g`

```bash
$ free -m                    # memory in MB
              total  used  free  available
Mem:           7946  5100  1234       1912
Swap:          2047   100  1947

$ free -g                    # memory in GB
              total  used  free  available
Mem:              7     4     1          1
```

---

## 🔹 `inxi` — Comprehensive System Info

```bash
inxi -F               # full system info
inxi -N               # network info
inxi -D               # disk info
inxi -C               # CPU info
```

---

## 🔹 `lsns` — List Namespaces

```bash
$ lsns
        NS TYPE  NPROCS   PID USER     COMMAND
4026531835 cgroup    130     1 root     /usr/lib/systemd/systemd
4026531836 pid       128     1 root     /usr/lib/systemd/systemd
4026532500 net         2  5678 root     docker: nginx
```

### 4️⃣ Real-Time DevOps Scenario
Inspect network namespaces used by Docker containers:
```bash
lsns -t net
```

---

## 🔹 `numactl` — NUMA Node Management

```bash
numactl --hardware            # show NUMA topology
numactl --show                # show current policy
numactl --cpunodebind=0 ./app # bind app to NUMA node 0
```

---

## 🔹 `taskset` — CPU Affinity

```bash
taskset -c 0,1 ./app          # run app on CPU 0 and 1
taskset -p PID                # show current CPU affinity of process
taskset -cp 0,1 PID           # set affinity for running process
```

### 4️⃣ Real-Time DevOps Scenario
Pin a latency-sensitive Java app to specific CPUs to avoid cache thrashing:
```bash
taskset -c 2,3 java -jar latency-sensitive-app.jar
```

---

## 🔹 `blkid`
*(Covered in Disk Management section)*

---

# 17. Power & Boot Management

---

## 🔹 `shutdown` — Shutdown/Reboot

```bash
shutdown now                  # immediate shutdown
shutdown -h now               # halt now
shutdown -r now               # reboot now
shutdown -h +10               # shutdown in 10 minutes
shutdown -h 22:00             # shutdown at 10 PM
shutdown -r +5 "Rebooting for updates"   # with message
shutdown -c                   # cancel scheduled shutdown
```

---

## 🔹 `reboot` — Restart System

```bash
reboot                        # immediate reboot
reboot --force                # force if normal fails
systemctl reboot              # via systemd
```

---

## 🔹 `halt` — Halt System

```bash
halt                          # stop CPU (may not power off)
halt -p                       # halt and power off
systemctl halt                # via systemd
```

---

## 🔹 `poweroff` — Power Off System

```bash
poweroff                      # power off immediately
systemctl poweroff            # via systemd
```

---

## 🔹 `init` — SysV Runlevel Change

```bash
init 0            # shutdown
init 1            # single-user (rescue)
init 3            # multi-user without GUI
init 5            # multi-user with GUI
init 6            # reboot
```

---

## 🔹 `runlevel` — Show Current Runlevel

```bash
$ runlevel
N 5              # N = previous, 5 = current
```

---

## 🔹 `telinit` — Change Runlevel (Legacy SysV)

```bash
telinit 3         # switch to runlevel 3
telinit 1         # switch to single-user
```

---

## 🔹 `grub2-install` — Install GRUB Bootloader

```bash
grub2-install /dev/sda               # install GRUB to MBR
grub2-install --target=x86_64-efi --efi-directory=/boot/efi   # UEFI
```

### 4️⃣ Real-Time DevOps Scenario
System can't boot after a disk copy — reinstall GRUB from rescue mode:
```bash
mount /dev/sda1 /mnt
chroot /mnt
grub2-install /dev/sda
grub2-mkconfig -o /boot/grub2/grub.cfg
exit
reboot
```

---

## 🔹 `update-grub` — Regenerate GRUB Config

```bash
update-grub               # Ubuntu/Debian
grub2-mkconfig -o /boot/grub2/grub.cfg   # RHEL/CentOS
```

---

## 🔹 `fsck -y /dev/sdX` — Filesystem Check & Auto-Repair

```bash
fsck -y /dev/sda1          # check and auto-repair ext4
fsck -t xfs /dev/sdb1      # check XFS partition
```

---

## 🔹 Rescue Mode — System Recovery

```bash
# Boot to rescue mode via systemd
systemctl rescue                         # if system is running

# From GRUB — edit boot entry:
# Add: systemd.unit=rescue.target
# or:  init=/bin/bash (for emergency shell)

# From rescue disk:
mount /dev/sda1 /mnt
chroot /mnt
# Now repair passwd, grub, fstab, etc.
```

---

# 18. File Transfer & Sharing

---

## 🔹 `scp -r` — Recursive Secure Copy

```bash
scp -r /local/dir/ user@host:/remote/dir/
scp -r user@host:/remote/dir/ /local/dir/
scp -i key.pem -r /local/dir/ ec2-user@host:/path/
```

---

## 🔹 `rsync -avz` — Archive + Verbose + Compressed Sync

```bash
rsync -avz /source/ /destination/
rsync -avz --progress /local/ user@remote:/remote/
rsync -avz --delete /source/ /dest/    # mirror (delete extras)
rsync -avz --dry-run /source/ /dest/   # test first
```

---

## 🔹 `curl -O` — Download with Original Filename

```bash
curl -O https://example.com/terraform.zip
curl -O https://example.com/app-v2.tar.gz
```

---

## 🔹 `wget -c` — Resume Download

```bash
wget -c https://example.com/largefile.tar.gz
# -c resumes if partially downloaded
```

---

## 🔹 `nc` File Transfer

```bash
# Receiver (listen):
nc -l -p 1234 > received_file.tar.gz

# Sender:
nc receiver_host 1234 < file.tar.gz
```

---

## 🔹 `python3 -m http.server 8080` — Simple HTTP Server

```bash
# Serve current directory over HTTP
python3 -m http.server 8080
python3 -m http.server 8080 --bind 0.0.0.0

# Then from another machine:
curl http://server-ip:8080/filename
wget http://server-ip:8080/filename
```

### 4️⃣ Real-Time DevOps Scenario
Need to quickly transfer a file between two EC2 instances without S3:
```bash
# On source machine:
python3 -m http.server 9000

# On destination:
wget http://source-ip:9000/app.tar.gz
```

---

## 🔹 NFS — Network File System

```bash
# nfs-utils package
# Server side:
echo "/data 10.0.0.0/8(rw,sync,no_subtree_check)" >> /etc/exports
exportfs -ra
systemctl enable --now nfs-server

# Client side:
mount -t nfs server:/data /mnt/nfs
mount | grep nfs

# Persistent via /etc/fstab:
server:/data /mnt/nfs nfs defaults 0 0
```

---

## 🔹 Samba / `smbclient` / `mount.cifs` — Windows File Sharing

```bash
# Connect to SMB share
smbclient //server/share -U username

# Mount SMB share
mount.cifs //server/share /mnt/smb -o username=user,password=pass

# List shares
smbclient -L //server -U username
```

---

# 19. Virtualization & Containers

---

## 🔹 `virsh` — KVM/QEMU VM Management

```bash
virsh list --all               # list all VMs
virsh start vmname             # start VM
virsh shutdown vmname          # graceful shutdown
virsh destroy vmname           # force stop
virsh suspend vmname           # pause VM
virsh resume vmname            # resume
virsh snapshot-create-as vmname snap1   # create snapshot
virsh snapshot-revert vmname snap1      # revert to snapshot
virsh dumpxml vmname           # export VM config
```

---

## 🔹 `virt-install` — Create New KVM VM

```bash
virt-install \
  --name myvm \
  --ram 2048 \
  --vcpus 2 \
  --disk path=/var/lib/libvirt/images/myvm.qcow2,size=20 \
  --cdrom /iso/ubuntu-22.04.iso \
  --os-type linux \
  --graphics none \
  --console pty,target_type=serial
```

---

## 🔹 `qemu-img` — Disk Image Management

```bash
qemu-img create -f qcow2 disk.qcow2 20G    # create disk image
qemu-img info disk.qcow2                   # show info
qemu-img convert -f raw -O qcow2 disk.raw disk.qcow2   # convert format
qemu-img resize disk.qcow2 +10G            # resize image
```

---

## 🔹 `docker` — Container Management

```bash
# Images
docker images                              # list images
docker pull nginx:latest                   # pull image
docker build -t myapp:v1 .                 # build from Dockerfile
docker rmi image_id                        # remove image
docker image prune                         # remove unused images

# Containers
docker ps                                  # running containers
docker ps -a                               # all containers
docker run -d -p 80:80 --name web nginx    # run detached
docker run -it ubuntu:22.04 /bin/bash      # interactive
docker stop container_id                   # stop
docker start container_id                  # start
docker restart container_id
docker rm container_id                     # remove
docker logs -f container_id                # follow logs
docker exec -it container_id /bin/bash     # exec into container

# Networks & Volumes
docker network ls
docker volume ls
docker inspect container_id

# Cleanup
docker system prune -a                     # clean everything unused
```

### 4️⃣ Real-Time DevOps Scenario
Debug a crashing container:
```bash
docker logs --tail 100 mycontainer
docker inspect mycontainer | jq '..State'
docker exec -it mycontainer /bin/sh
```

---

## 🔹 `podman` — Daemonless Container Manager

```bash
podman pull nginx
podman run -d -p 80:80 nginx
podman ps
podman logs container_id
podman exec -it container_id bash
podman stop container_id
```

### 🎯 Interview Point
> `podman` is rootless by default — containers run without root daemon. It's a drop-in replacement for Docker with `alias docker=podman`. Preferred in RHEL8+ environments.

---

## 🔹 `ctr` — containerd CLI

```bash
ctr images pull docker.io/library/nginx:latest
ctr containers list
ctr tasks list
ctr run docker.io/library/nginx:latest mycontainer
```

---

## 🔹 `crictl` — CRI Container Runtime CLI (Kubernetes)

```bash
crictl ps                     # list containers
crictl images                 # list images
crictl logs container_id      # container logs
crictl inspect container_id   # inspect container
crictl pods                   # list pods
```

### 4️⃣ Real-Time DevOps Scenario
Kubernetes node troubleshooting — container runtime not accessible via kubectl:
```bash
crictl ps --name nginx
crictl logs <container-id>
```

---

## 🔹 `lxc` / `lxd` — Linux Containers

```bash
# lxd
lxc launch ubuntu:22.04 mycontainer      # create and start
lxc list                                  # list containers
lxc exec mycontainer -- bash              # get shell
lxc stop mycontainer                      # stop
lxc delete mycontainer                    # delete
lxc snapshot mycontainer snap1            # snapshot
```

---

# 20. Developer Tools

---

## 🔹 `gcc` — GNU C/C++ Compiler

```bash
gcc -o output source.c              # compile C
gcc -o output source.c -lm          # link math library
gcc -g -o output source.c           # with debug symbols
g++ -o output source.cpp            # compile C++
gcc --version
```

---

## 🔹 `make` — Build Automation

```bash
make                     # build using Makefile (default target)
make install             # install
make clean               # clean build files
make -j4                 # parallel build with 4 jobs
make -f custom.mk        # use specific Makefile
make test                # run tests
```

### 4️⃣ Real-Time DevOps Scenario
Compile nginx from source with custom modules:
```bash
./configure --with-http_ssl_module
make -j$(nproc)
make install
```

---

## 🔹 `cmake` — Cross-Platform Build Generator

```bash
cmake .                          # generate Makefile
cmake -DCMAKE_BUILD_TYPE=Release .
cmake --build .                  # build
cmake --build . --target install
```

---

## 🔹 `ldd` — Shared Library Dependencies

```bash
$ ldd /usr/sbin/nginx
    linux-vdso.so.1 (0x00007ffd...)
    libpcre2-8.so.0 => /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0
    libssl.so.3 => /usr/lib/x86_64-linux-gnu/libssl.so.3
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6
```

### 4️⃣ Real-Time DevOps Scenario
App crashes with "library not found" — check what's missing:
```bash
ldd ./myapp | grep "not found"
# libcustom.so.1 => not found   ← this needs to be installed/linked
```

---

## 🔹 `strace` — System Call Tracer
*(Covered in System Monitoring section)*

---

## 🔹 `ltrace` — Library Call Tracer

```bash
ltrace ./myapp                   # trace library calls
ltrace -e malloc,free ./myapp    # trace specific calls
ltrace -c ./myapp                # summary count
```

---

## 🔹 `gdb` — GNU Debugger

```bash
gdb ./myapp                      # start debugger
gdb ./myapp core                 # analyze core dump
gdb --args ./myapp arg1 arg2     # with arguments

# Inside gdb:
# run            — start execution
# break main     — set breakpoint
# next / step    — step through code
# print var      — print variable
# backtrace      — show call stack
# quit           — exit
```

### 4️⃣ Real-Time DevOps Scenario
App crashed and left a core dump — analyze it:
```bash
gdb /opt/myapp/bin/myapp /tmp/core.12345
(gdb) backtrace
# Shows the stack trace at point of crash
```

---

## 🔹 `perf` — Performance Profiling
*(Covered in System Monitoring section)*

---

## 🔹 `git` — Version Control System

```bash
git init                          # initialize repo
git clone URL                     # clone repository
git status                        # show working tree status
git add .                         # stage all changes
git commit -m "message"           # commit
git push origin main              # push to remote
git pull                          # fetch + merge
git branch                        # list branches
git checkout -b feature/new       # create and switch branch
git merge branch-name             # merge branch
git log --oneline                 # compact log
git diff                          # show unstaged changes
git stash                         # stash changes temporarily
git stash pop                     # restore stashed changes
git revert HEAD                   # undo last commit safely
git reset --hard HEAD~1           # undo commit (dangerous — loses changes)
git tag v1.0.0                    # create tag
```

### 4️⃣ Real-Time DevOps Scenario
Rollback a bad deployment by reverting the last commit in CI/CD:
```bash
git revert HEAD --no-edit
git push origin main
# CI/CD auto-deploys the revert
```

---

## 🔹 `svn` — Subversion (Centralized VCS)

```bash
svn checkout URL /local/path      # checkout
svn update                        # update working copy
svn commit -m "message"           # commit
svn status                        # show changes
svn log                           # show log
svn diff                          # show changes
```

---

## 🔹 `patch` — Apply Diff Patches

```bash
patch -p1 < fix.patch             # apply patch
patch -p0 < fix.patch
patch --dry-run -p1 < fix.patch   # test first
patch -R -p1 < fix.patch          # reverse/undo patch
```

---

# 21. Troubleshooting & Recovery

---

## 🔹 `journalctl -xe`
*(Fully covered in Logging section)*

---

## 🔹 `systemctl rescue` — Rescue Mode

```bash
systemctl rescue                  # enter rescue mode (minimal services)
# Or add to kernel boot line: systemd.unit=rescue.target
```

---

## 🔹 `grub2-install` / `update-grub`
*(Covered in Power & Boot section)*

---

## 🔹 `chroot` for Recovery
*(Covered in Security section)*

---

## 🔹 `fsck -y /dev/sdX`
*(Covered in Disk Management section)*

---

## 🔹 Rescue Mode — Full Recovery Workflow

```bash
# 1. Boot from rescue ISO or recovery mode in GRUB
# 2. Mount root filesystem
mount /dev/sda1 /mnt

# 3. Mount required virtual filesystems
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /dev /mnt/dev

# 4. chroot into system
chroot /mnt

# 5. Now perform repairs:
passwd root                       # reset root password
grub2-install /dev/sda            # reinstall GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
vim /etc/fstab                    # fix bad fstab entry
fsck -y /dev/sda2                 # repair filesystem

# 6. Exit and reboot
exit
umount -l /mnt
reboot
```

---

# 22. Fun & Miscellaneous

---

## 🔹 `cowsay` — ASCII Cow Message

```bash
$ cowsay "Deploy Successful!"
 ____________________
< Deploy Successful! >
 --------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

cowsay -f tux "Linux rocks"     # use Tux (penguin) instead
```

---

## 🔹 `fortune` — Random Quotes

```bash
$ fortune
"The best way to predict the future is to invent it." - Alan Kay

fortune | cowsay    # combine for fun!
```

---

## 🔹 `sl` — Steam Locomotive (Mistyped ls)

```bash
$ sl
# A train animation runs across your terminal
# Teach yourself not to mistype ls!
```

---

## 🔹 `yes`
*(Covered in Core Commands section)*

---

## 🔹 `rev`
*(Covered in Core Commands section)*

---

## 🔹 `cal` / `ncal` — Calendar

```bash
$ cal
     April 2026
Su Mo Tu We Th Fr Sa
          1  2  3  4
 5  6  7  8  9 10 11
...

$ cal 12 2026        # December 2026
$ ncal               # alternate format with week numbers
$ ncal -w            # with week numbers
```

---

## 🔹 `date` — Show/Set Date & Time

```bash
date                             # current date/time
date +"%Y-%m-%d"                 # formatted: 2026-04-17
date +"%Y-%m-%d %H:%M:%S"        # with time
date +%s                         # Unix epoch timestamp
date -d "yesterday"              # yesterday
date -d "next monday"            # next Monday
date -d @1713350400              # convert epoch to readable
date -s "2026-04-17 18:00:00"    # set date (root)
```

### 4️⃣ Real-Time DevOps Scenario
Name backup files with timestamp:
```bash
tar -czf backup-$(date +%Y%m%d-%H%M%S).tar.gz /opt/app/
```

---

## 🔹 `timedatectl`
*(Covered in System Information section)*

---

## 🔹 `figlet` — ASCII Text Banner

```bash
$ figlet "DevOps"
  ____              ___
 |  _ \  _____   _/ _ \ _ __  ___
 | | | |/ _ \ \ / / | | | '_ \/ __|
 | |_| |  __/\ V /| |_| | |_) \__ \
 |____/ \___| \_/  \___/| .__/|___/
                        |_|
```

---

## 🔹 `toilet` — Colorful ASCII Banners

```bash
toilet -f bigmono12 "DEPLOY"
toilet --gay "Success"          # rainbow colors
```

---

# 23. 🔥 Interview Preparation

---

## Q1: Difference Between Hard Link and Soft Link?

| | Hard Link | Soft Link (Symlink) |
|--|-----------|---------------------|
| Points to | Inode directly | File path/name |
| Cross filesystem | ❌ No | ✅ Yes |
| Works for directories | ❌ No | ✅ Yes |
| If original deleted | Still works | Breaks (dangling link) |
| inode number | Same as original | Different |
| Command | `ln file hardlink` | `ln -s file symlink` |

```bash
ln /etc/nginx/nginx.conf /tmp/nginx-hard        # hard link
ln -s /etc/nginx/nginx.conf /tmp/nginx-soft     # soft link
ls -i /etc/nginx/nginx.conf /tmp/nginx-hard     # same inode number
```

---

## Q2: What Happens When Linux Boots?

1. **BIOS/UEFI** — POST (Power-On Self Test), finds boot device
2. **Bootloader (GRUB2)** — loads kernel from `/boot/`
3. **Kernel loads** — initializes hardware, mounts root filesystem
4. **initramfs** — temporary filesystem for early boot tasks
5. **systemd (PID 1)** — first process, reads unit files
6. **Targets** — starts services in order up to `default.target`
7. **Login** — getty starts, user logs in

---

## Q3: How to Troubleshoot High CPU?

```bash
# Step 1: Identify high CPU processes
top         # sort by CPU with 'P'
htop        # visual, easier

# Step 2: Find exact process
ps aux --sort=-%cpu | head -10

# Step 3: Check if it's a specific thread
top -H -p PID       # show threads of process

# Step 4: Profile system calls
strace -p PID -c    # count system calls

# Step 5: Check load average and CPU stats
uptime
mpstat 1 5

# Step 6: Check if it's I/O wait (not CPU)
iostat 1 5          # high wa% = I/O bound, not CPU bound

# Step 7: Check logs for root cause
journalctl -u service-name -n 100
```

---

## Q4: How to Find Large Files?

```bash
# Find files > 100MB
find / -type f -size +100M 2>/dev/null

# Find top 10 largest files
find / -type f -printf "%s\t%p\n" 2>/dev/null | sort -rn | head -10

# Find large directories
du -sh /* 2>/dev/null | sort -rh | head -10
du -sh /var/* | sort -rh

# Quick overview
df -h       # which partition is full?
du -sh /var/log/* | sort -rh | head -10   # drill down
```

---

## Q5: How to Check Open Ports?

```bash
# Modern (preferred)
ss -tulpn

# Legacy
netstat -tulpn

# Check specific port
ss -tulpn | grep :8080
lsof -i :8080

# Scan all ports
nmap -p 1-65535 localhost

# From outside (test firewall)
nmap -p 22,80,443 your-server-ip
```

---

## Q6: How to Find Which Process Is Using a Port?

```bash
# Method 1 — ss
ss -tulpn | grep :80
# tcp LISTEN 0 128 0.0.0.0:80 ... users:(("nginx",pid=1234))

# Method 2 — lsof
lsof -i :80
# COMMAND PID USER FD TYPE  NODE NAME
# nginx  1234 root  6u IPv4  TCP *:http (LISTEN)

# Method 3 — fuser
fuser 80/tcp
# 80/tcp: 1234

# Then get process details
ps aux | grep 1234
```

---

## Q7: Difference Between `grep`, `awk`, and `sed`?

| Tool | Purpose | Best For |
|------|---------|----------|
| `grep` | Search/filter lines | Finding lines matching pattern |
| `awk` | Field processing language | Extracting/calculating columns |
| `sed` | Stream editor | Substituting/transforming text |

```bash
# grep — find lines with "ERROR"
grep "ERROR" app.log

# awk — print field 3 (e.g., IP from log)
awk '{print $3}' app.log

# sed — replace old with new in file
sed 's/old_host/new_host/g' config.conf
```

### Combined Power Example:
```bash
# Find ERROR lines, extract the error code (field 5), sort by frequency
grep "ERROR" app.log | awk '{print $5}' | sort | uniq -c | sort -rn
```

---

## Q8: How to Secure a Linux Server?

```bash
# 1. Update system
apt update && apt upgrade -y   # or: dnf update -y

# 2. Disable root SSH login
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# 3. Set up SSH key-based auth only
# 4. Configure firewall
ufw default deny incoming
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable

# 5. Fail2ban — block brute force
apt install fail2ban -y
systemctl enable --now fail2ban

# 6. Remove unused services
systemctl list-units --state=active
systemctl disable --now telnet cups bluetooth

# 7. Set up unattended security updates
apt install unattended-upgrades -y

# 8. Audit file permissions
find / -perm 777 -type f 2>/dev/null
find / -perm -4000 2>/dev/null    # SUID files

# 9. Lock down /tmp
# Add to /etc/fstab:
# tmpfs /tmp tmpfs defaults,nodev,nosuid,noexec 0 0

# 10. Enable SELinux / AppArmor
getenforce     # should be "Enforcing"

# 11. Configure password policy
chage -M 90 -m 7 -W 14 username

# 12. Protect immutable files
chattr +i /etc/passwd /etc/shadow /etc/gshadow
```

---

## Q9: How to Debug a Service That Won't Start?

```bash
# Step 1: Check status
systemctl status myapp

# Step 2: View recent logs
journalctl -u myapp -n 50 --no-pager

# Step 3: Check for extended errors
journalctl -xe | grep myapp

# Step 4: Test the binary manually
/opt/myapp/bin/myapp --config /etc/myapp/config.yml

# Step 5: Check file permissions
ls -lah /opt/myapp/
ls -lah /etc/myapp/config.yml

# Step 6: Check listening port conflict
ss -tulpn | grep :8080

# Step 7: Check SELinux
ausearch -m avc -ts recent | grep myapp

# Step 8: Check unit file syntax
systemd-analyze verify /etc/systemd/system/myapp.service
```

---

## Q10: Difference Between Process States?

| State | Code | Meaning |
|-------|------|---------|
| Running | `R` | Actively using CPU |
| Sleeping | `S` | Waiting for event (interruptible) |
| Disk Sleep | `D` | Waiting for I/O (cannot be killed!) |
| Zombie | `Z` | Finished but parent hasn't reaped it |
| Stopped | `T` | Paused (Ctrl+Z or SIGSTOP) |

```bash
ps aux | awk '$8 == "Z" {print}'    # find zombie processes
ps aux | awk '$8 == "D" {print}'    # find D-state (I/O blocked)
```

---

## Q11: What Is the Difference Between `/etc/profile`, `.bashrc`, and `.profile`?

| File | When Executed | Scope |
|------|--------------|-------|
| `/etc/profile` | Every user login | System-wide |
| `/etc/bash.bashrc` | Every interactive shell | System-wide |
| `~/.profile` | User login shell | Per user |
| `~/.bashrc` | Every interactive non-login shell | Per user |
| `~/.bash_profile` | User login (overrides `.profile` if exists) | Per user |

---

## Q12: How to Redirect Output in Linux?

```bash
command > file           # stdout to file (overwrite)
command >> file          # stdout to file (append)
command 2> error.log     # stderr to file
command 2>&1             # redirect stderr to stdout
command > out.log 2>&1   # both stdout and stderr to file
command &> out.log       # shorthand for both
command > /dev/null      # discard stdout
command 2>/dev/null      # discard stderr
command &>/dev/null      # discard all output
command1 | command2      # pipe stdout to next command
```

---

## Q13: What Is a Zombie Process? How to Fix It?

A zombie process has **finished executing** but its parent has not called `wait()` to read its exit status. It stays in the process table as `Z` state.

```bash
# Find zombies
ps aux | grep ' Z '

# Fix: Kill parent process (it will clean up zombies)
ps -o ppid= -p <zombie-pid>   # find parent PID
kill -s SIGCHLD <parent-pid>  # ask parent to reap children
# If that fails:
kill -9 <parent-pid>          # force kill parent
```

---

## Q14: How Does `sudo` Work Internally?

1. User runs `sudo command`
2. `sudo` reads `/etc/sudoers` (and `/etc/sudoers.d/`)
3. Checks if user/group is allowed to run that command
4. Prompts for **user's own password** (not root's)
5. If authorized, forks and executes command as target user (default: root)
6. Logs the action to `/var/log/auth.log` or `/var/log/secure`

---

## Q15: How to Check and Manage Disk I/O Performance?

```bash
# Real-time I/O per process
sudo iotop -o

# Overall I/O stats
iostat -x 1 5

# Check if I/O is causing slowness
vmstat 1 5     # wa column = I/O wait %

# Find which process has most disk I/O
pidstat -d 1 5

# Check disk queue depth
iostat -x | awk 'NR>3 {print $1, "util:", $NF"%", "await:", $10"ms"}'
```

---

## 🏆 Pro DevOps One-Liners (Cheat Sheet)

```bash
# Find top 10 memory-hungry processes
ps aux --sort=-%mem | awk 'NR<=11{printf "%-10s %-8s %-8s %s\n",$1,$2,$4,$11}'

# Monitor all failed systemd services
watch -n 5 'systemctl list-units --state=failed'

# Get disk usage sorted by size (all partitions)
df -h | sort -k5 -rn

# List all open network connections with process names
ss -tulpn | column -t

# Find which files changed in last 10 minutes
find /etc /opt /var -newer /tmp/timestamp -type f 2>/dev/null

# Check SSL cert expiry for all your domains
for domain in app1.com app2.com api.com; do
  expiry=$(echo | openssl s_client -connect $domain:443 2>/dev/null | \
    openssl x509 -noout -enddate | cut -d= -f2)
  echo "$domain: $expiry"
done

# Kill all processes of a user
ps aux | awk '/username/ {print $2}' | xargs kill -9

# Tail multiple log files simultaneously
tail -f /var/log/nginx/error.log /var/log/app/app.log

# Find failed SSH login attempts and top offending IPs
grep "Failed password" /var/log/auth.log | awk '{print $11}' | \
  sort | uniq -c | sort -rn | head -10

# Check all running cron jobs
for user in $(cut -f1 -d: /etc/passwd); do
  crontab -u $user -l 2>/dev/null | grep -v "^#" | \
    awk -v u=$user 'NF{print u": "$0}'
done

# One-line system health snapshot
echo "=== $(hostname) | $(date) ===" && \
  uptime && echo && \
  free -h | grep Mem && echo && \
  df -h | grep -v tmpfs && echo && \
  ss -s | grep TCP
```

---

## 📌 Practice Recommendations

### Cloud Practice
```bash
# AWS Free Tier EC2
aws ec2 run-instances --image-id ami-0abcdef1234 \
  --instance-type t2.micro \
  --key-name my-key

# Oracle Cloud (always-free tier)
# Azure Free Tier — B1s VM
# GCP Free Tier — e2-micro
```

### Local Practice
```bash
# Docker (instant Linux environment)
docker run -it ubuntu:22.04 /bin/bash
docker run -it centos:7 /bin/bash

# VirtualBox / VMware with Ubuntu/CentOS
# WSL2 on Windows
```

### Practice Path
1. **Week 1**: Core commands, file operations, permissions
2. **Week 2**: Process management, system monitoring
3. **Week 3**: Networking, SSH, curl/wget
4. **Week 4**: Package management, systemctl, journalctl
5. **Week 5**: Shell scripting, awk, sed, grep pipelines
6. **Week 6**: Security, cron, advanced troubleshooting

```bash
# Always explore with:
man command          # full manual
command --help       # quick help
tldr command         # simplified examples (install: apt install tldr)
info command         # GNU info pages
```

---
