# 🖥️📜 screen-scribe

Keep a history of screenshots.

## Inspiration

- https://superuser.com/questions/1594667/how-can-i-make-a-screenshot-log-on-linux
- https://www.perplexity.ai/search/systemd-script-that-runs-once-1HMPhyn9QoeqHJ6AfpfCRQ

## Install Service
1. Install image magick
1. Update `screen-log.service`
   1. Update `ExecStart` path
2. Create `/srv/screen-log` directory
   1. `sudo mkdir /srv/screen-log`
4. Run `sudo ./screenshot.sh`
5. Verify a new screenshot is added to `/srv/screen-log`
6. `sudo cp screen-log.service /etc/systemd/system/screen-log.service`
7. `sudo cp screen-log.timer /etc/systemd/system/screen-log.timer`
8. `sudo systemctl daemon-reload`
9. `sudo systemctl enable screen-log.timer`
10. `sudo systemctl enable screen-log.service`
11. `sudo systemctl start screen-log.timer`
12. Check that the trigger value is shown in `systemctl status screen-log.timer`
    ```
    ● screen-log.timer - Take a screenshot every minute or two
         Loaded: loaded (/etc/systemd/system/screen-log.timer; enabled; vendor preset: enabled)
         Active: active (waiting) since Thu 2025-01-23 03:09:43 EST; 30min ago
        Trigger: Thu 2025-01-23 03:41:42 EST; 1min 44s left
       Triggers: ● screen-log.service
    ```
   `

## Set Up Samba Share

[Instructions for Ubuntu](https://ubuntu.com/tutorials/install-and-configure-samba#1-overview)


Add the following to the bottom of `/etc/samba/samba.conf`
```
[sambashare]
   comment = Screen Log
   path = /srv/screen-log
   read only = yes
   browsable = yes
```
