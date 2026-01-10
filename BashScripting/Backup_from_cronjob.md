# How to Set Up a Cron Job in Ubuntu Linux Server

This guide explains how to schedule a cron job on an Ubuntu server to automate tasks, such as taking periodic backups.

## 1. Open the Terminal

Use SSH to connect to your server if you are working remotely.

## 2. Edit the Crontab

Run the following command to open the crontab editor for the current user:

```bash
crontab -e
```

- The first time you run this command, it may ask you to select an editor (like nano or vim). Choose your preferred editor (nano is beginner-friendly).

## 3. Add Your Cron Job

Scroll to the bottom of the file and add your cron job. For example, to run the backup script every minute, add:

```
* * * * * tar -czf /tmp/backup_$(date +\%Y\%m\%d_\%H\%M\%S).tar.gz /tmp/test.sh
```

**Explanation:**
- `* * * * *` — This means execute every minute.
- `tar -czf ...` — Your command to create a compressed backup of `/tmp/test.sh` with the current date and time in the filename.

## 4. Save and Exit

- If using `nano`, press `CTRL+O` to save and `CTRL+X` to exit.
- If using `vim`, press `ESC`, type `:wq`, and press `ENTER`.

## 5. Verify Your Cron Job

List your current cron jobs to make sure it has been added:

```bash
crontab -l
```

You should see your new cron job listed.

## 6. Check Output

Wait a minute and check the `/tmp` directory:

```bash
ls /tmp/backup_*.tar.gz
```

You should see the backup files being created every minute.

---

### Notes

- Cron jobs run with minimal environments. If your command requires environment variables, specify them in the crontab or use full paths.
- Make sure the script or files you want to back up exist and have proper permissions.
- System-wide cron jobs (for all users) can be set in `/etc/crontab` (requires sudo and is not recommended for most tasks).

---

**References**
- [Ubuntu CronHowTo](https://help.ubuntu.com/community/CronHowTo)
- [crontab.guru](https://crontab.guru/)
