# Linux Interview – Practical Questions with Commands (Batch 1: Q1–Q10)

## Q1. How do you check the Linux OS version and kernel version?

### Typical question
“In an interview we might ask: how do you find the OS version and kernel version on a Linux machine?”

### Answer – step by step with commands

1. **Check kernel version**  
   - Command:  
     ```bash
     uname -r
     ```  
   - Explanation:  
     - `uname` prints system information.  
     - `-r` shows the kernel release (e.g., `5.15.0-91-generic`).  
     - Useful when checking driver compatibility, kernel bugs, etc.

2. **Check full kernel and architecture**  
   - Command:  
     ```bash
     uname -a
     ```  
   - Explanation:  
     - Shows kernel, hostname, date built, architecture (x86_64), etc.  
     - Quick snapshot of system basics.

3. **Check OS distribution and version**  
   - Common command (systemd distros):  
     ```bash
     cat /etc/os-release
     ```  
   - Explanation:  
     - Shows fields like `NAME="Ubuntu"` and `VERSION="22.04 LTS"`.  
     - Most modern distros ship `os-release` to identify themselves.[web:159]

---

## Q2. How do you check CPU, memory, and load on a Linux server?

### Typical question
“How do you quickly see if a Linux server is under CPU or memory pressure?”

### Answer – step by step with commands

1. **Check CPU and load with `uptime`**  
   - Command:  
     ```bash
     uptime
     ```  
   - Explanation:  
     - Shows current time, uptime, number of users, and load averages (1, 5, 15 minutes).  
     - High load averages compared to CPU core count may indicate CPU or I/O contention.[web:162]

2. **Use `top` or `htop` for live overview**  
   - Command:  
     ```bash
     top
     # or if installed:
     htop
     ```  
   - Explanation:  
     - Shows CPU usage per core, memory usage, and top processes.  
     - You can see which process is consuming CPU or RAM.

3. **Check memory usage directly**  
   - Command:  
     ```bash
     free -h
     ```  
   - Explanation:  
     - `-h` = human readable (MB/GB).  
     - Shows total, used, free, and cached memory.  
     - Distinguish between cached (can be reclaimed) vs truly used.

---

## Q3. How do you list files, show hidden files, and see detailed permissions?

### Typical question
“Explain how to list files in a directory and see details like size, owner, and permissions.”

### Answer – step by step with commands

1. **Basic listing**  
   - Command:  
     ```bash
     ls
     ```  
   - Explanation:  
     - Lists visible files/directories in the current directory.

2. **Show hidden files (starting with .)**  
   - Command:  
     ```bash
     ls -a
     ```  
   - Explanation:  
     - `-a` shows all files, including hidden ones like `.bashrc`, `.git`.

3. **Detailed listing with permissions and owners**  
   - Command:  
     ```bash
     ls -l
     ```  
   - Explanation:  
     - `-l` long format:  
       - First column: permissions (e.g., `-rwxr-xr--`).  
       - Next: link count, owner, group, size, date, name.

4. **Combine hidden + long listing**  
   - Command:  
     ```bash
     ls -la
     ```  
   - Explanation:  
     - Very common to check file metadata including hidden files.[web:162]

---

## Q4. How do you view file content and follow logs in real time?

### Typical question
“How do you inspect log files, including watching new lines as they are written?”

### Answer – step by step with commands

1. **View the whole file**  
   - Command:  
     ```bash
     cat /var/log/syslog
     ```  
   - Explanation:  
     - Prints entire file. Not ideal for very large logs but fine for small ones.

2. **View first or last lines**  
   - Commands:  
     ```bash
     head -n 20 /var/log/syslog
     tail -n 20 /var/log/syslog
     ```  
   - Explanation:  
     - `head` shows first lines; `tail` shows last lines.  
     - Useful when logs are huge.

3. **Follow log in real time**  
   - Command:  
     ```bash
     tail -f /var/log/syslog
     ```  
   - Explanation:  
     - `-f` (follow) prints new lines as they are appended.  
     - Common for debugging services while reproducing issues.

4. **Better paging for navigation**  
   - Command:  
     ```bash
     less /var/log/syslog
     ```  
   - Explanation:  
     - `less` lets you scroll up/down, search (`/pattern`), and exit with `q`.

---

## Q5. How do you find files by name or by content?

### Typical question
“You know a file exists somewhere, or you need to find which file contains a string. What do you do?”

### Answer – step by step with commands

1. **Find by name with `find`**  
   - Command:  
     ```bash
     find /var/log -name "syslog*"
     ```  
   - Explanation:  
     - Searches `/var/log` and subdirectories for files whose name matches `syslog*`.  
     - Very powerful but can be slow on big trees.[web:162]

2. **Find by content with `grep`**  
   - Command:  
     ```bash
     grep -R "ERROR" /var/log
     ```  
   - Explanation:  
     - `-R` recursively searches files under `/var/log`.  
     - Prints lines containing “ERROR”.  
     - Use `-i` for case‑insensitive search.

3. **Combine both (find then grep)**  
   - Command:  
     ```bash
     find /var/log -name "*.log" -exec grep -H "timeout" {} \;
     ```  
   - Explanation:  
     - `find` selects `.log` files.  
     - `-exec` runs `grep` on each file (`{}` placeholder).  
     - `-H` prints filenames along with matching lines.

---

## Q6. How do you manage file permissions (read/write/execute, chmod) as a beginner?

### Typical question
“How do you give a script execute permission or change who can read a file?”

### Answer – step by step with commands

1. **View permissions**  
   - Command:  
     ```bash
     ls -l script.sh
     ```  
   - Example output:  
     `-rw-r--r-- 1 user user 123 Jan  1 12:00 script.sh`  
   - Explanation:  
     - First 10 characters `-rw-r--r--` split into:  
       - `-` = regular file.  
       - `rw-` = owner: read + write.  
       - `r--` = group: read.  
       - `r--` = others: read.

2. **Add execute permission for owner**  
   - Command:  
     ```bash
     chmod u+x script.sh
     ```  
   - Explanation:  
     - `u` = user/owner, `+x` = add execute.  
     - New permissions: `-rwxr--r--`.

3. **Set permissions using numbers (e.g., 750)**  
   - Command:  
     ```bash
     chmod 750 script.sh
     ```  
   - Explanation:  
     - 7 = rwx (owner), 5 = r-x (group), 0 = --- (others).  
     - Good for scripts that only owner and group should run.

---

## Q7. How do you check disk usage and find which directories consume the most space?

### Typical question
“Disk is almost full. How do you find out what’s using space?”

### Answer – step by step with commands

1. **Check filesystem usage with `df`**  
   - Command:  
     ```bash
     df -h
     ```  
   - Explanation:  
     - `-h` shows sizes in human‑readable units.  
     - Displays mounted filesystems, used/available space, and mount points.[web:162]

2. **Check directory sizes with `du`**  
   - Command (e.g., for `/var`):  
     ```bash
     du -sh /var/*
     ```  
   - Explanation:  
     - `-s` = summary, `-h` = human readable.  
     - Shows size of each immediate subdirectory under `/var`.

3. **Drill down into biggest directory**  
   - Command:  
     ```bash
     du -sh /var/log/*
     ```  
   - Explanation:  
     - Identify which sub‑directory or log file is huge.  
     - Then you can rotate, compress, or delete safe old files.

---

## Q8. How do you see running processes and kill a specific process safely?

### Typical question
“How do you find a misbehaving process and stop it?”

### Answer – step by step with commands

1. **View current processes with `ps`**  
   - Command:  
     ```bash
     ps aux | head
     ```  
   - Explanation:  
     - `a` = all users, `u` = user‑oriented format, `x` = include processes without TTY.  
     - Shows PID, CPU%, MEM%, command, etc.

2. **Search for a particular process**  
   - Command:  
     ```bash
     ps aux | grep nginx
     ```  
   - Explanation:  
     - Filters output for “nginx”.  
     - Identify PID(s) from first column.

3. **Kill process gracefully**  
   - Command:  
     ```bash
     kill <PID>
     ```  
   - Explanation:  
     - Sends SIGTERM by default, asking process to exit cleanly.

4. **Force kill if necessary**  
   - Command:  
     ```bash
     kill -9 <PID>
     ```  
   - Explanation:  
     - SIGKILL (9) stops process immediately.  
     - Use only when normal kill doesn’t work; process can’t clean up.

---

## Q9. How do you manage services (start/stop/status) on a systemd‑based Linux?

### Typical question
“How do you start or check status of services like nginx, sshd, etc.?”

### Answer – step by step with commands

1. **Check service status**  
   - Command:  
     ```bash
     sudo systemctl status nginx
     ```  
   - Explanation:  
     - Shows whether nginx is `active (running)` or `inactive`, plus logs summary.

2. **Start/stop/restart service**  
   - Commands:  
     ```bash
     sudo systemctl start nginx
     sudo systemctl stop nginx
     sudo systemctl restart nginx
     ```  
   - Explanation:  
     - Basic lifecycle management: start, stop, restart (reload config).

3. **Enable service at boot**  
   - Command:  
     ```bash
     sudo systemctl enable nginx
     ```  
   - Explanation:  
     - Makes nginx start automatically when the system boots.

---

## Q10. How do you check which users are logged in and the system’s login history?

### Typical question
“As an admin, how do you see who is currently logged in and who logged in recently?”

### Answer – step by step with commands

1. **See current logged‑in users**  
   - Command:  
     ```bash
     w
     ```  
   - Explanation:  
     - Shows logged‑in users, what they are doing, and system load.[web:162]

2. **Simpler list: `who`**  
   - Command:  
     ```bash
     who
     ```  
   - Explanation:  
     - Lists each logged‑in user with TTY and login time.

3. **View login history**  
   - Command:  
     ```bash
     last
     ```  
   - Explanation:  
     - Shows last logins, reboots, and timestamps.  
     - Good for auditing access patterns.

  # Linux Interview – Practical Questions with Commands (Batch 2: Q11–Q20)

## Q11. How do you create a new user, set a password, and add them to a group?

### Typical question
“As an admin, how do you create a user and give them proper group membership?”

### Answer – step by step with commands

1. **Create a user**  
   - Command:  
     ```bash
     sudo useradd -m devuser
     ```  
   - Explanation:  
     - `useradd` creates a new user.  
     - `-m` creates the home directory (e.g., `/home/devuser`).  
     - By default, it sets shell and UID/GID based on system config.

2. **Set the password for the user**  
   - Command:  
     ```bash
     sudo passwd devuser
     ```  
   - Explanation:  
     - Prompts you to type and confirm the new password.  
     - Password is hashed and stored in `/etc/shadow`.

3. **Add user to an existing group (e.g., docker)**  
   - Command:  
     ```bash
     sudo usermod -aG docker devuser
     ```  
   - Explanation:  
     - `usermod` modifies user settings.  
     - `-aG` = append to supplementary group(s).  
     - After this, `devuser` is part of `docker` group (needs re‑login to take effect).

---

## Q12. How do you switch users and run commands as another user?

### Typical question
“How do you become another user or run a command as root using sudo?”

### Answer – step by step with commands

1. **Switch to another user’s shell**  
   - Command:  
     ```bash
     su - devuser
     ```  
   - Explanation:  
     - `su -` starts a login shell as `devuser` (you need their password or root).  
     - `-` loads that user’s environment variables and profile.

2. **Run a single command as another user**  
   - Command (as root):  
     ```bash
     su - devuser -c "whoami"
     ```  
   - Explanation:  
     - `-c` executes the given command and then exits.  
     - Helps test what another user sees without fully switching.

3. **Use sudo to run as root**  
   - Command:  
     ```bash
     sudo whoami
     ```  
   - Explanation:  
     - If your user is in sudoers, `sudo` will prompt for your password and run the command as root.  
     - `whoami` will print `root`.

---

## Q13. How do you check which groups a user belongs to?

### Typical question
“How do you verify that a user is in the right groups (e.g., docker, sudo)?”

### Answer – step by step with commands

1. **Use `id` for a user**  
   - Command:  
     ```bash
     id devuser
     ```  
   - Explanation:  
     - Shows UID, primary GID, and supplementary groups for `devuser`.  
     - Example: `groups=1001(devuser) 999(docker)`.

2. **Use `groups` command**  
   - Commands:  
     ```bash
     groups
     groups devuser
     ```  
   - Explanation:  
     - Without argument: groups for current user.  
     - With username: groups for that user.

3. **Common troubleshooting**  
   - If `devuser` can’t run docker but is in `docker` group, they may need to log out and back in for group membership to apply.

---

## Q14. How do you configure SSH key‑based authentication and disable password SSH login?

### Typical question
“For production, we use SSH keys. How do you set that up and harden SSH access?”

### Answer – step by step with commands

1. **Generate an SSH key pair on your local machine**  
   - Command:  
     ```bash
     ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
     ```  
   - Explanation:  
     - Creates a private key `~/.ssh/id_rsa` and public key `~/.ssh/id_rsa.pub`.  
     - Use a passphrase for extra security.

2. **Copy the public key to the remote server user**  
   - Command:  
     ```bash
     ssh-copy-id devuser@server
     ```  
   - Explanation:  
     - Appends your public key to `~devuser/.ssh/authorized_keys` on the server.  
     - After this, you can SSH without typing the account password (but maybe key passphrase).

3. **Disable password authentication (on the server)**  
   - Edit SSH config:  
     ```bash
     sudo vi /etc/ssh/sshd_config
     ```  
   - Set/ensure:  
     ```text
     PasswordAuthentication no
     ```  
   - Then reload SSH:  
     ```bash
     sudo systemctl reload sshd
     ```  
   - Explanation:  
     - This prevents password logins, forcing key‑based auth.  
     - Important: ensure key works before disabling passwords.

---

## Q15. How do you check which ports are open on a Linux server from the server itself?

### Typical question
“How do you see what services are listening on which ports locally?”

### Answer – step by step with commands

1. **Use `ss` to list listening sockets**  
   - Command:  
     ```bash
     sudo ss -lntp
     ```  
   - Explanation:  
     - `-l` = listening, `-n` = numeric, `-t` = TCP, `-p` = show process.  
     - Output shows local address:port and associated process (PID/program name).[web:162]

2. **Include UDP ports if needed**  
   - Command:  
     ```bash
     sudo ss -lunp
     ```  
   - Explanation:  
     - `-u` switches to UDP.  
     - Useful for DNS servers, syslog, etc.

3. **Filter by port**  
   - Command:  
     ```bash
     sudo ss -lntp | grep ':80 '
     ```  
   - Explanation:  
     - Quickly check if something is listening on port 80.

---

## Q16. How do you check and control file ownership (chown) in Linux?

### Typical question
“How do you change the owner/group of a file or directory?”

### Answer – step by step with commands

1. **Check current owner and group**  
   - Command:  
     ```bash
     ls -l /var/www/html/index.html
     ```  
   - Explanation:  
     - Output shows owner and group (e.g., `root root` or `www-data www-data`).

2. **Change owner of a single file**  
   - Command:  
     ```bash
     sudo chown www-data /var/www/html/index.html
     ```  
   - Explanation:  
     - Changes owner to `www-data` but keeps current group.

3. **Change owner and group recursively for a directory**  
   - Command:  
     ```bash
     sudo chown -R www-data:www-data /var/www/html
     ```  
   - Explanation:  
     - `-R` = recursive.  
     - Sets owner to `www-data` and group to `www-data` for all files inside.  
     - Very common for web roots, app directories.

---

## Q17. How do you schedule a cron job to run a script every day at 2 AM?

### Typical question
“How do you set a recurring task (like a backup script) using cron?”

### Answer – step by step with commands

1. **Open user’s crontab**  
   - Command:  
     ```bash
     crontab -e
     ```  
   - Explanation:  
     - Opens the current user’s cron file in default editor.  
     - Each line defines a schedule and a command.

2. **Add a line for daily 2 AM run**  
   - Example entry:  
     ```text
     0 2 * * * /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1
     ```  
   - Explanation:  
     - Minute Hour DayOfMonth Month DayOfWeek Command.  
     - `0 2 * * *` = at 02:00 every day.  
     - Redirects stdout/stderr to a log file.

3. **Verify cron is running**  
   - Command:  
     ```bash
     sudo systemctl status cron
     # or on some distros:
     sudo systemctl status crond
     ```  
   - Explanation:  
     - Confirms the cron daemon is active.

---

## Q18. How do you check and manage environment variables in Linux?

### Typical question
“As a DevOps engineer, how do you view and set environment variables for your shell or a specific command?”

### Answer – step by step with commands

1. **View all current env variables**  
   - Command:  
     ```bash
     env
     ```  
   - Explanation:  
     - Prints all environment variables (e.g., `PATH`, `HOME`, `USER`, etc.).

2. **View a specific variable**  
   - Command:  
     ```bash
     echo $PATH
     echo $JAVA_HOME
     ```  
   - Explanation:  
     - `$VAR` syntax expands variable value.

3. **Set variable for current shell session**  
   - Command:  
     ```bash
     export APP_ENV=prod
     ```  
   - Explanation:  
     - `export` makes `APP_ENV` available to child processes of this shell.

4. **Set variable only for a single command**  
   - Command:  
     ```bash
     APP_ENV=prod python app.py
     ```  
   - Explanation:  
     - Sets `APP_ENV` only for that command’s environment, doesn’t persist in shell.

---

## Q19. How do you check which commands a user is allowed to run with sudo?

### Typical question
“As an SRE, how do you see what a particular user can do via sudo?”

### Answer – step by step with commands

1. **Use `sudo -l` as that user**  
   - Command:  
     ```bash
     sudo -l
     ```  
   - Explanation:  
     - Lists commands the current user is allowed (or not allowed) to run via sudo, as defined in `/etc/sudoers` or included files.

2. **Check /etc/sudoers (read‑only)**  
   - Command:  
     ```bash
     sudo cat /etc/sudoers
     sudo ls /etc/sudoers.d/
     ```  
   - Explanation:  
     - Shows global sudo configuration and additional policy files.  
     - Never edit `/etc/sudoers` directly with plain `vi`; use `visudo`.

3. **Edit sudo rules safely**  
   - Command:  
     ```bash
     sudo visudo
     ```  
   - Explanation:  
     - `visudo` does syntax checking before saving, preventing broken sudo config.

---

## Q20. How do you investigate why a system is slow (basic Linux troubleshooting workflow)?

### Typical question
“System is slow. As a beginner admin, what commands do you run first, and in what order?”

### Answer – high‑level step‑by‑step sequence

1. **Check CPU, load, and memory**  
   - Commands:  
     ```bash
     uptime
     top
     free -h
     ```  
   - Explanation:  
     - `uptime` shows if load is very high.  
     - `top` shows top CPU/memory consumers.  
     - `free -h` reveals if swapping is happening or memory is exhausted.

2. **Check disk space and I/O**  
   - Commands:  
     ```bash
     df -h
     iostat -x 1 5   # if sysstat is installed
     ```  
   - Explanation:  
     - `df -h` ensures no filesystem is 100% full.  
     - `iostat` shows disk busy time and I/O wait; high values indicate disk bottlenecks.

3. **Check number of processes and zombie/defunct processes**  
   - Commands:  
     ```bash
     ps aux | wc -l
     ps aux | grep defunct
     ```  
   - Explanation:  
     - Too many processes or many zombies can signal issues.

4. **Check system logs for errors**  
   - Commands:  
     ```bash
     sudo journalctl -p err -n 50
     # or
     sudo tail -n 50 /var/log/syslog
     ```  
   - Explanation:  
     - Look for recurring errors, OOM kills, service crashes.

5. **DevOps narrative in interview**  
   - Describe that you first look at CPU/mem/disk basics, then I/O and logs, then correlate with recent deploys or config changes.
# Linux Interview – Practical Questions with Commands (Batch 3: Q21–Q30)

## Q21. How do you check system logs for recent errors on a Linux server?

### Typical question
“Something is failing, how do you quickly look for recent system errors?”

### Answer – step by step with commands

1. **On systemd systems, use `journalctl` for recent errors**  
   - Command:  
     ```bash
     sudo journalctl -p err -n 50
     ```  
   - Explanation:  
     - `-p err` = priority “error” and above (err, crit, alert, emerg).  
     - `-n 50` = last 50 log entries.  
     - Good first look for system‑level problems (services failing, kernel errors).

2. **Follow the journal in real time**  
   - Command:  
     ```bash
     sudo journalctl -f
     ```  
   - Explanation:  
     - `-f` = follow, like `tail -f`.  
     - Watch logs live while reproducing an issue (e.g., starting a service).

3. **Classic log files under /var/log**  
   - Commands (common ones):  
     ```bash
     ls /var/log
     sudo tail -n 50 /var/log/syslog
     # or on some distros:
     sudo tail -n 50 /var/log/messages
     ```  
   - Explanation:  
     - `syslog` / `messages` often contain general system events.  
     - Application‑specific logs may live under `/var/log/<app>/`.

---

## Q22. How do you troubleshoot a service that fails to start with systemd?

### Typical question
“A service (like nginx, sshd, custom app) won’t start. What is your step‑by‑step approach?”

### Answer – step by step with commands

1. **Check service status**  
   - Command:  
     ```bash
     sudo systemctl status myservice
     ```  
   - Explanation:  
     - Shows active/inactive status and the last few log lines.  
     - Often shows a clear error message (missing file, bad config, permission error).

2. **Check detailed logs for that unit**  
   - Command:  
     ```bash
     sudo journalctl -u myservice -n 50
     ```  
   - Explanation:  
     - `-u myservice` filters logs by unit.  
     - `-n 50` shows the last 50 log lines.  
     - Look for stack traces, port binding errors, missing env vars, etc.

3. **Validate configuration (if the service has a config test)**  
   - Examples:  
     ```bash
     sudo nginx -t        # NGINX config test
     sudo apachectl configtest
     ```  
   - Explanation:  
     - Many services offer a config test that prints syntax or validation errors.  
     - Fix config, then run `systemctl restart` again.

---

## Q23. How do you check which services are enabled at boot on a systemd system?

### Typical question
“How do you see which services will start automatically when the system boots?”

### Answer – step by step with commands

1. **List enabled services**  
   - Command:  
     ```bash
     systemctl list-unit-files --type=service | grep enabled
     ```  
   - Explanation:  
     - Shows unit files of type service that are `enabled`.  
     - These are configured to start at boot.

2. **Check if a specific service is enabled**  
   - Command:  
     ```bash
     systemctl is-enabled nginx
     ```  
   - Explanation:  
     - Prints `enabled`, `disabled`, or `static`.  
     - `enabled` means it will start at boot (subject to dependencies).

3. **Enable/disable at boot**  
   - Commands:  
     ```bash
     sudo systemctl enable nginx
     sudo systemctl disable nginx
     ```  
   - Explanation:  
     - `enable` adds symlinks so it starts at boot.  
     - `disable` removes them.

---

## Q24. How do you check disk usage per filesystem and per directory?

### Typical question
“Disk is filling up; how do you find where space is used?”

### Answer – step by step with commands

1. **Check filesystem usage**  
   - Command:  
     ```bash
     df -h
     ```  
   - Explanation:  
     - `-h` shows human readable sizes (G/M).  
     - You see `% Used` for each mount point (e.g., `/`, `/var`, `/home`).  
     - Quickly spot which filesystem is nearly full.

2. **Check which directories are big (first level)**  
   - Command:  
     ```bash
     du -sh /* 2>/dev/null
     ```  
   - Explanation:  
     - `du` summarizes space used by each directory under root.  
     - `-s` summary, `-h` human readable.  
     - `2>/dev/null` hides permission errors.

3. **Drill down into heavy directory**  
   - Example: if `/var` is large:  
     ```bash
     du -sh /var/* 2>/dev/null
     ```  
   - Explanation:  
     - Helps find if `/var/log`, `/var/lib/docker`, or something else is consuming space.  
     - Then investigate those subdirectories.

---

## Q25. How do you find and delete large files safely when disk is almost full?

### Typical question
“Disk is 100% full. How do you quickly find large files and clean up safely?”

### Answer – step by step with commands

1. **Find top 10 largest files under a path**  
   - Command:  
     ```bash
     sudo find / -type f -printf '%s %p\n' 2>/dev/null | sort -nr | head -n 10
     ```  
   - Explanation:  
     - `-printf '%s %p\n'` prints size (bytes) and path.  
     - Sort descending, show biggest 10.  
     - Useful to quickly identify giant files.

2. **Investigate before deleting**  
   - For suspected log:  
     ```bash
     ls -lh /var/log/huge.log
     ```  
   - Explanation:  
     - Check owner, group, and last modification time.  
     - Ensure it’s safe to truncate or rotate (not critical data).

3. **Truncate a log file instead of deleting**  
   - Command:  
     ```bash
     sudo truncate -s 0 /var/log/huge.log
     ```  
   - Explanation:  
     - Sets file size to 0 but keeps file and inode in place (important if a process has it open).  
     - Safer than `rm` for logs a running process is writing to.

---

## Q26. How do you check inode usage and why does it matter?

### Typical question
“Disk space is available, but you still can’t create new files. How do you check inodes?”

### Answer – step by step with commands

1. **Check inode usage per filesystem**  
   - Command:  
     ```bash
     df -i
     ```  
   - Explanation:  
     - Similar to `df -h` but for inodes.  
     - Shows total inodes, used, and free per filesystem.  
     - If `%Iused` is 100%, you can’t create new files even if space remains.

2. **Find directories with many small files**  
   - Command:  
     ```bash
     sudo find /var -xdev -type d -exec sh -c 'echo "{}"; ls -1 "{}" | wc -l' \; 2>/dev/null | head
     ```  
   - Explanation (high level):  
     - For each directory under `/var`, counts the number of immediate entries.  
     - Helps find directories filled with thousands of tiny files.

3. **Cleanup strategy**  
   - Remove or archive old tiny files (e.g., temp files, cache directories) to free inodes.  
   - Possibly adjust app behavior to avoid creating too many small files.

---

## Q27. How do you check which process keeps a deleted file’s space from being freed?

### Typical question
“Disk still full even after deleting a large log file. Why? How do you check?”

### Answer – step by step with commands

1. **Use `lsof` to list deleted files still open**  
   - Command:  
     ```bash
     sudo lsof | grep '(deleted)'
     ```  
   - Explanation:  
     - Shows processes that still hold file descriptors to deleted files.  
     - If a process holds a deleted large file open, space is not freed until process closes it or exits.

2. **Identify big deleted file handles**  
   - You can grep for “deleted” and check the size or path shown.  
   - Explanation:  
     - Look for log files or temp files that were removed but still in use.

3. **Fix**  
   - Restart the offending service:  
     ```bash
     sudo systemctl restart <service>
     ```  
   - Explanation:  
     - When process restarts, it releases the file descriptor, and the filesystem frees space.

---

## Q28. How do you check and change the default runlevel/boot target in systemd?

### Typical question
“How do you see which target (multi‑user, graphical) the system boots into, and change it?”

### Answer – step by step with commands

1. **Check current default target**  
   - Command:  
     ```bash
     systemctl get-default
     ```  
   - Explanation:  
     - Common values: `multi-user.target` (no GUI), `graphical.target` (with GUI).  

2. **Set a new default target**  
   - Command:  
     ```bash
     sudo systemctl set-default multi-user.target
     ```  
   - Explanation:  
     - Sets system to boot into multi‑user (non‑graphical) mode by default.  
     - Useful for servers where GUI is not needed.

3. **Change current target without reboot (optional)**  
   - Command:  
     ```bash
     sudo systemctl isolate multi-user.target
     ```  
   - Explanation:  
     - Switches to that target immediately (e.g., exit GUI to console mode).

---

## Q29. How do you check open files and file descriptor limits for a process?

### Typical question
“App hits ‘too many open files’ error. How do you debug it?”

### Answer – step by step with commands

1. **Check system‑wide file descriptor limits**  
   - Command:  
     ```bash
     ulimit -n
     ```  
   - Explanation:  
     - Shows current shell’s limit on open files.  
     - Apps started from this shell inherit that limit unless overridden.

2. **Check current open files for a PID**  
   - Command:  
     ```bash
     sudo ls /proc/<PID>/fd | wc -l
     ```  
   - Explanation:  
     - Counts how many file descriptors the process is using.  
     - If close to limit, process may hit errors.

3. **Adjust limits (high level)**  
   - Usually done via `/etc/security/limits.conf` or systemd unit (`LimitNOFILE=`).  
   - Then restart the service to pick up new limits.

---

## Q30. How do you approach “Linux server is unresponsive over SSH” at a high level?

### Typical question
“SSH hangs or times out; server seems unresponsive. What steps do you think through?”

### Answer – high‑level step‑by‑step reasoning

1. **Check basic network reachability from another machine**  
   - Commands:  
     ```bash
     ping -c 3 server-ip
     nc -vz server-ip 22
     ```  
   - Explanation:  
     - If ping/nc fail → network/firewall/SG/VPC issue.  
     - If port 22 is open but SSH still not working, it might be auth or resource issue.

2. **Check SSH daemon state (if you have console/other access)**  
   - Commands (on server via console/IPMI/cloud serial):  
     ```bash
     sudo systemctl status sshd
     sudo journalctl -u sshd -n 50
     ```  
   - Explanation:  
     - Verify sshd is running and not crashing.  
     - Logs may show rate limiting, auth failures, or config errors.

3. **Check system resource exhaustion**  
   - On console:  
     ```bash
     top
     df -h
     ```  
   - Explanation:  
     - If CPU is 100% or RAM is completely used, server may be too slow to respond.  
     - If disk is 100% full, SSH might fail to log in or write to home directories.

4. **Cloud context**  
   - Check cloud console for instance health, network ACLs, and security groups.  
   - Possibly use a “serial console” feature when SSH is completely dead.

# Linux Interview – Practical Questions with Commands (Batch 4: Q31–Q40)

## Q31. How do you run a command in the background and bring it back to the foreground?

### Typical question
“As a Linux user, how do you run long‑running commands without blocking your terminal?”

### Answer – step by step with commands

1. **Start a command in the background using `&`**  
   - Command:  
     ```bash
     long_running_script.sh &
     ```  
   - Explanation:  
     - `&` tells the shell to run the command in the background.  
     - Shell prints a job ID like `[1] 12345` where 12345 is the PID.

2. **See background jobs in the current shell**  
   - Command:  
     ```bash
     jobs
     ```  
   - Explanation:  
     - Lists jobs started from this shell (`[1]`, `[2]`, etc.).  
     - Shows their state (Running, Stopped).

3. **Bring a job to the foreground**  
   - Command:  
     ```bash
     fg %1
     ```  
   - Explanation:  
     - `%1` refers to job ID `[1]`.  
     - `fg` attaches the job back to the current terminal.

4. **Send a running foreground process to background (CTRL+Z + bg)**  
   - Steps:  
     - Press `Ctrl+Z` to suspend the process.  
     - Then run:  
       ```bash
       bg %1
       ```  
   - Explanation:  
     - `Ctrl+Z` stops the process; `bg` resumes it in background.

---

## Q32. How do you monitor processes over time and find which one suddenly spikes CPU?

### Typical question
“How do you keep an eye on processes and identify CPU hogs?”

### Answer – step by step with commands

1. **Use `top` for live view**  
   - Command:  
     ```bash
     top
     ```  
   - Explanation:  
     - Shows CPU, memory, load, and processes sorted by CPU by default.  
     - You can press `P` to sort by CPU, `M` to sort by memory.

2. **Use `htop` for a nicer interface (if installed)**  
   - Command:  
     ```bash
     htop
     ```  
   - Explanation:  
     - Interactive, colorized output with CPU bars.  
     - You can search (`/`), filter, and kill processes from inside.

3. **Use `ps` for snapshot and grep**  
   - Command:  
     ```bash
     ps aux --sort=-%cpu | head
     ```  
   - Explanation:  
     - Shows top CPU consumers at the moment.  
     - Useful in scripts or when you just need a quick snapshot.

---

## Q33. How do you send signals (TERM, KILL, HUP) to a process and what do they mean?

### Typical question
“In Linux, what is a signal and how do you use signals like TERM, KILL, and HUP?”

### Answer – step by step with commands

1. **View available signals**  
   - Command:  
     ```bash
     kill -l
     ```  
   - Explanation:  
     - Lists all signals (e.g., `1) SIGHUP 2) SIGINT 9) SIGKILL 15) SIGTERM`).

2. **Send SIGTERM (graceful stop)**  
   - Command:  
     ```bash
     kill -TERM <PID>
     # or just:
     kill <PID>
     ```  
   - Explanation:  
     - Asks the process to terminate gracefully (cleanup, save data, close files).  
     - Default signal for `kill` is SIGTERM.

3. **Send SIGKILL (force kill)**  
   - Command:  
     ```bash
     kill -KILL <PID>
     # or:
     kill -9 <PID>
     ```  
   - Explanation:  
     - Immediately kills the process; cannot be caught or ignored.  
     - Use only when SIGTERM doesn’t work.

4. **Send SIGHUP (often used to reload configs)**  
   - Command:  
     ```bash
     kill -HUP <PID>
     ```  
   - Explanation:  
     - Traditionally “hangup”, now often used to tell daemons to reload configuration.  
     - For some services, this equals `reload`.

---

## Q34. How do you see per‑process memory usage and identify memory hogs?

### Typical question
“How do you find which processes are consuming the most memory?”

### Answer – step by step with commands

1. **Use `top` sorted by memory**  
   - Command:  
     ```bash
     top
     ```  
   - Then press `M` inside `top`.  
   - Explanation:  
     - Sorts processes by memory usage.  
     - Look at `%MEM` and `RES` (resident memory).

2. **Use `ps` to list processes by memory usage**  
   - Command:  
     ```bash
     ps aux --sort=-%mem | head
     ```  
   - Explanation:  
     - Shows processes in descending order of memory consumption.  
     - `RSS` column (resident set size) shows memory in KB.

3. **Check total memory and swap**  
   - Command:  
     ```bash
     free -h
     ```  
   - Explanation:  
     - If swap is heavily used, memory is likely overcommitted, leading to slowness.

---

## Q35. How do you find which process is using a specific file or port?

### Typical question
“You want to know which process has a file or port open. What do you use?”

### Answer – step by step with commands

1. **Check which process uses a specific file**  
   - Command:  
     ```bash
     sudo lsof /var/log/syslog
     ```  
   - Explanation:  
     - `lsof` = list open files.  
     - Shows process name and PID that have `/var/log/syslog` open.

2. **Check which process is using a port**  
   - Command:  
     ```bash
     sudo lsof -i :8080
     ```  
   - Explanation:  
     - Lists processes with sockets on TCP/UDP port 8080.  
     - Useful when “port already in use” errors occur.

3. **Alternative via `ss`**  
   - Command:  
     ```bash
     sudo ss -lntp | grep ':8080 '
     ```  
   - Explanation:  
     - Shows listening process on port 8080 as well, including PID.

---

## Q36. How do you create, extract, and list tar archives (with and without compression)?

### Typical question
“How do you archive logs or configs using tar, and how do you restore them?”

### Answer – step by step with commands

1. **Create a tar archive (no compression)**  
   - Command:  
     ```bash
     tar cf logs.tar /var/log
     ```  
   - Explanation:  
     - `c` = create, `f` = filename.  
     - Packages `/var/log` folder into `logs.tar`.

2. **Create a compressed tar archive (gzip)**  
   - Command:  
     ```bash
     tar czf logs.tar.gz /var/log
     ```  
   - Explanation:  
     - `z` = gzip compression.  
     - Produces a smaller `logs.tar.gz` file.

3. **List contents of an archive**  
   - Command:  
     ```bash
     tar tf logs.tar.gz
     ```  
   - Explanation:  
     - `t` = list, `f` = file.  
     - Shows which files are inside without extracting.

4. **Extract an archive**  
   - Command:  
     ```bash
     tar xzf logs.tar.gz -C /tmp/restore
     ```  
   - Explanation:  
     - `x` = extract, `z` = decompress, `f` = file.  
     - `-C` sets directory where contents will be extracted.

---

## Q37. How do you check which packages are installed and see details (Debian/Ubuntu)?

### Typical question
“On a Debian/Ubuntu system, how do you list installed packages and show package info?”

### Answer – step by step with commands

1. **List all installed packages**  
   - Command:  
     ```bash
     dpkg -l
     ```  
   - Explanation:  
     - Shows package name, version, and brief description.  
     - You can pipe to `grep` to find specific packages.

2. **Filter for a specific package**  
   - Command:  
     ```bash
     dpkg -l | grep nginx
     ```  
   - Explanation:  
     - Helps check if `nginx` is installed and which version.

3. **Show detailed info for a package**  
   - Command:  
     ```bash
     apt show nginx
     ```  
   - Explanation:  
     - Shows version, dependencies, description, and repository info.

---

## Q38. How do you update packages safely on a Debian/Ubuntu server?

### Typical question
“How do you perform system updates safely with apt?”

### Answer – step by step with commands

1. **Update package index**  
   - Command:  
     ```bash
     sudo apt update
     ```  
   - Explanation:  
     - Refreshes local list of available packages from configured repos.  
     - Needed before installing/upgrading to see latest versions.

2. **Upgrade installed packages**  
   - Command:  
     ```bash
     sudo apt upgrade
     ```  
   - Explanation:  
     - Upgrades packages to latest versions that do not require removing others.  
     - Review the list before confirming.

3. **Full upgrade (optional, more aggressive)**  
   - Command:  
     ```bash
     sudo apt full-upgrade
     ```  
   - Explanation:  
     - Can install/remove packages to complete the upgrade.  
     - Use with more caution, especially on production.

---

## Q39. How do you check kernel messages, especially for hardware or driver issues?

### Typical question
“Where do you look for kernel‑level messages like disk errors, NIC errors, or OOM kills?”

### Answer – step by step with commands

1. **Use `dmesg` to view kernel ring buffer**  
   - Command:  
     ```bash
     dmesg | less
     ```  
   - Explanation:  
     - Shows messages from kernel since boot: hardware detection, driver logs, errors.

2. **Filter for errors or warnings**  
   - Command:  
     ```bash
     dmesg | grep -i error
     dmesg | grep -i fail
     ```  
   - Explanation:  
     - Helps spot disk errors, NIC issues, or other failures quickly.

3. **On systemd, view kernel messages via journal**  
   - Command:  
     ```bash
     sudo journalctl -k
     ```  
   - Explanation:  
     - `-k` filters journal entries to only kernel messages.  
     - Easier to use for persistent logs than `dmesg` alone.

---

## Q40. How do you summarize your Linux troubleshooting approach in an interview?

### Typical question
“Overall, what is your approach to troubleshooting issues on a Linux server?”

### Answer – structured, step by step

1. **Start with basics**  
   - Check health:  
     ```bash
     uptime
     top
     free -h
     df -h
     ```  
   - Explanation:  
     - Quickly see CPU, load, memory, and disk usage.

2. **Check processes and services**  
   - Commands:  
     ```bash
     ps aux | head
     sudo systemctl status <service>
     ```  
   - Explanation:  
     - Identify runaway processes, crashed services, or misconfigured systemd units.

3. **Check logs and journal**  
   - Commands:  
     ```bash
     sudo journalctl -p err -n 50
     sudo journalctl -u <service> -n 50
     ```  
   - Explanation:  
     - Look for error messages related to the failing component.

4. **Check network connectivity**  
   - Commands:  
     ```bash
     ip addr
     ip route
     ping -c 3 <target>
     nc -vz <target> <port>
     ```  
   - Explanation:  
     - Ensure correct IP, routes, and open ports.

5. **Iterate and narrow down**  
   - Based on evidence, dive deeper into application logs, config files, or specific subsystems (disk, memory, network).  
   - Document steps and findings for an eventual RCA.

# Linux Interview – Practical Questions with Commands (Batch 5: Q41–Q50)

## Q41. How do you check which services start at boot and disable a problematic one temporarily?

### Typical question
“On a Linux server, a service is causing issues at boot. How do you see what’s enabled and disable one?”

### Answer – step by step

1. **List services and their enablement state**
   - Command:
     ```bash
     systemctl list-unit-files --type=service
     ```
   - Explanation:
     - Shows each service and whether it is `enabled`, `disabled`, `static`, etc.
     - Focus on `enabled` services – they start automatically at boot.

2. **Check a specific service’s boot state**
   - Command:
     ```bash
     systemctl is-enabled myservice
     ```
   - Explanation:
     - Tells you directly if `myservice` is set to start at boot.

3. **Disable the service so it doesn’t start on next boot**
   - Command:
     ```bash
     sudo systemctl disable myservice
     ```
   - Explanation:
     - Removes the symlinks that start it at boot.
     - You can still start it manually with `systemctl start` when needed.

---

## Q42. How do you boot a Linux system into a rescue/emergency mode conceptually?

### Typical question
“Server won’t boot properly. At a high level, how would you get into rescue mode to troubleshoot?”

### Answer – conceptual steps (no exact GRUB syntax needed in interview)

1. **Interrupt boot loader**
   - At boot, access GRUB menu (often by pressing `Esc` or `Shift`).
   - Choose the kernel entry and edit it (e.g., press `e` in GRUB).

2. **Append single/emergency mode parameter**
   - In the kernel command line, append something like `single`, `rescue`, or `systemd.unit=rescue.target`.
   - This instructs systemd to boot into a minimal environment.

3. **Boot into rescue shell**
   - Boot the system with modified parameters.
   - You get a root shell with minimal services:
     - Can inspect `/var/log`, fix `fstab`, repair configs, etc.

4. **Explain usage in interview**
   - Mention it’s useful when:
     - `/etc/fstab` is broken,
     - critical services prevent normal boot,
     - you need to reset root password or fix network configs.

---

## Q43. How do you check if SELinux or AppArmor is enabled and how to temporarily relax enforcement?

### Typical question
“On RHEL/Ubuntu, security modules might block apps. How do you check SELinux/AppArmor state?”

### Answer – step by step

1. **Check SELinux status (RHEL/CentOS/Fedora)**
   - Command:
     ```bash
     sestatus
     ```
   - Explanation:
     - Shows if SELinux is `enforcing`, `permissive`, or `disabled`.

2. **Temporarily set SELinux to permissive (runtime only)**
   - Command:
     ```bash
     sudo setenforce 0
     ```
   - Explanation:
     - Changes `enforcing` → `permissive` without reboot.
     - Violations are logged but not blocked (useful for debugging).
     - Not persistent across reboot; permanent change is in `/etc/selinux/config`.

3. **Check AppArmor status (Ubuntu)**
   - Command:
     ```bash
     sudo aa-status
     ```
   - Explanation:
     - Shows which AppArmor profiles are loaded and in enforce/complain mode.

4. **Interview angle**
   - Emphasize:
     - Don’t blindly disable SELinux/AppArmor in production.
     - Use logs (`/var/log/audit/audit.log` for SELinux) to adjust policies.

---

## Q44. How do you check and harden SSH configuration (a few basics)?

### Typical question
“What are some basic SSH hardening steps and how do you check them?”

### Answer – step by step

1. **Check SSH config file**
   - Command:
     ```bash
     sudo grep -E 'PermitRootLogin|PasswordAuthentication' /etc/ssh/sshd_config
     ```
   - Explanation:
     - `PermitRootLogin` controls direct root SSH.
     - `PasswordAuthentication` controls password vs key‑based auth.

2. **Hardening suggestions**
   - In `/etc/ssh/sshd_config`:
     ```text
     PermitRootLogin no
     PasswordAuthentication no
     ```
   - Explanation:
     - Disable direct root login (use sudo).
     - Disable password auth to force key‑based authentication.

3. **Reload SSH daemon**
   - Command:
     ```bash
     sudo systemctl reload sshd
     ```
   - Explanation:
     - Applies changes without dropping existing connections.

4. **Interview note**
   - Mention:
     - Enforce strong key algorithms.
     - Restrict SSH by security groups/VPN, use bastion or SSM instead of direct internet access.

---

## Q45. How do you check which users can run commands as root via sudo?

### Typical question
“How do you see who has sudo rights, and what exactly they can run?”

### Answer – step by step

1. **As a given user, list their sudo privileges**
   - Command:
     ```bash
     sudo -l
     ```
   - Explanation:
     - Prompts for user’s password.
     - Lists allowed (and forbidden) commands via sudo.

2. **Inspect sudo configuration (read‑only)**
   - Command:
     ```bash
     sudo cat /etc/sudoers
     sudo ls /etc/sudoers.d
     ```
   - Explanation:
     - Show main sudoers file and any drop‑in files under `/etc/sudoers.d`.
     - Actual policies are often split into multiple files.

3. **Edit sudoers safely**
   - Command:
     ```bash
     sudo visudo
     ```
   - Explanation:
     - Opens sudoers with syntax checking.
     - Prevents invalid config that could lock out sudo on the system.

---

## Q46. How do you check and set system‑wide limits (like max open files) for services?

### Typical question
“An app hits `Too many open files`. How do you raise limits properly?”

### Answer – step by step

1. **Check current limits for your shell**
   - Command:
     ```bash
     ulimit -n
     ```
   - Explanation:
     - Shows max open file descriptors for the current session.

2. **Set limits in `/etc/security/limits.conf`**
   - Example lines:
     ```text
     myuser soft nofile 4096
     myuser hard nofile 8192
     ```
   - Explanation:
     - `soft` is the default for the user; `hard` is the maximum.
     - Takes effect on next login of that user (PAM session).

3. **For systemd services, set `LimitNOFILE`**
   - In service unit file (override):
     ```bash
     sudo systemctl edit myservice
     ```
     Then add:
     ```text
     [Service]
     LimitNOFILE=8192
     ```
   - Explanation:
     - Overrides FD limit for that service.
     - Reload daemon and restart service:
       ```bash
       sudo systemctl daemon-reload
       sudo systemctl restart myservice
       ```

---

## Q47. How do you verify and fix a misconfigured `/etc/fstab` entry that prevents mounting at boot?

### Typical question
“Wrong fstab entry causes boot issues or failed mount. How do you handle it?”

### Answer – step by step

1. **Check current `/etc/fstab`**
   - Command:
     ```bash
     cat /etc/fstab
     ```
   - Explanation:
     - Lists filesystems to mount at boot.
     - Wrong device, UUID, or options can break mounting.

2. **Test all fstab mounts without reboot**
   - Command:
     ```bash
     sudo mount -a
     ```
   - Explanation:
     - Attempts to mount all filesystems listed in fstab.
     - If there is an error, it will show now instead of at next boot.

3. **Fix or comment out problematic entry**
   - Edit with:
     ```bash
     sudo vi /etc/fstab
     ```
   - Explanation:
     - Correct device/UUID or mount options.
     - Temporarily comment out with `#` if device is not always available.

4. **Retest**
   - Run `mount -a` again to ensure no errors.

---

## Q48. How do you check boot logs to see what happened during startup?

### Typical question
“System boot is slow or failing. Where do you see boot messages on systemd systems?”

### Answer – step by step

1. **Use `journalctl` with `-b` to show logs from current boot**
   - Command:
     ```bash
     sudo journalctl -b
     ```
   - Explanation:
     - Shows journal entries since the last boot.
     - Scroll/search with `/pattern` via pager.

2. **Show logs from previous boot**
   - Command:
     ```bash
     sudo journalctl -b -1
     ```
   - Explanation:
     - Useful when the system rebooted and you want to see what happened just before.

3. **Filter boot logs by priority or unit**
   - Command:
     ```bash
     sudo journalctl -b -p err
     sudo journalctl -b -u myservice
     ```
   - Explanation:
     - `-p err` shows only errors.  
     - `-u myservice` shows only logs for that service during this boot.

---

## Q49. How do you check for and terminate runaway processes that hog CPU or memory?

### Typical question
“Server is overloaded; one process is consuming everything. How do you find and stop it safely?”

### Answer – step by step

1. **Identify resource hog using `top` or `ps`**
   - Commands:
     ```bash
     top      # then sort by CPU/MEM
     ps aux --sort=-%cpu | head
     ps aux --sort=-%mem | head
     ```
   - Explanation:
     - Shows PIDs and command names for top consumers.

2. **Check whether it’s safe to terminate**
   - Look at:
     - What the process is (e.g., `java`, `postgres`, `mysqld`).  
     - Whether it’s critical or can be restarted quickly.

3. **Terminate gracefully, then force if needed**
   - Commands:
     ```bash
     sudo kill <PID>          # SIGTERM
     # if still stuck:
     sudo kill -9 <PID>       # SIGKILL
     ```
   - Explanation:
     - First try graceful stop.
     - Use `-9` only as last resort; it doesn’t allow cleanup.

4. **Restart the service through systemd if it’s a managed service**
   - Command:
     ```bash
     sudo systemctl restart <service>
     ```

---

## Q50. In an interview, how would you summarize your Linux skills for a DevOps/SRE role?

### Typical question
“Give a quick overview of your Linux comfort level and day‑to‑day tasks.”

### Answer – structured talking points

1. **System basics**
   - Comfortable with:
     - Navigating filesystem (`cd`, `ls`, `find`, `grep`).  
     - Checking resources (`top`, `free`, `df`, `du`).

2. **Process and service management**
   - Using:
     - `ps`, `ss`, `lsof` to inspect processes and sockets.  
     - `systemctl` to manage services and debug failures.

3. **Logs and troubleshooting**
   - Using:
     - `journalctl`, `/var/log/*`, `dmesg` to find errors.  
     - `tail -f` and `grep` for live debugging.

4. **Access and security**
   - Working with:
     - Users, groups, permissions, `sudo`.  
     - SSH keys, basic hardening (no root login, no password SSH).

5. **Narrate a concrete incident**
   - Describe one real situation:
     - Symptom → commands used to debug → root cause → fix → what you automated or documented afterward.

