# screen-log

Keep a log of screenshots.

## Inspiration

- https://superuser.com/questions/1594667/how-can-i-make-a-screenshot-log-on-linux
- https://www.perplexity.ai/search/systemd-script-that-runs-once-1HMPhyn9QoeqHJ6AfpfCRQ

## Install Service
1. Update `screen-log.service`
   1. Update `User` to an admin user
   2. Update `ExecStart` path
2. Create `/srv/screen-log` directory, owned by an admin user
   1. `sudo mkdir /srv/screen-log`
   2. `sudo chown <user> /srv/screen-log`
3. Update `screenshot.sh`
   1. Update `DISPLAY` value
4. Run `./screenshot.sh`
5. Verify a new screenshot is added to `/srv/screen-log`
   1. If not, fiddle with configuration of `screenshot.sh` (often the `DISPLAY` value is wrong)
6. `sudo cp screen-log.service /etc/systemd/system/screen-log.service`
7. `sudo cp screen-log.timer /etc/systemd/system/screen-log.timer`
8. `sudo systemctl daemon-reload`
9. `sudo systemctl enable screen-log.timer`
10. `sudo systemctl enable screen-log.service`

## Set Up Samba Share

[Instructions for Ubuntu](https://ubuntu.com/tutorials/install-and-configure-samba#1-overview)

[Instructions for Fedora SilverBlue](https://discussion.fedoraproject.org/t/how-to-use-samba-in-silverblue/1570/8)

Add the following to the bottom of `/etc/samba/samba.conf`
```
[sambashare]
   comment = Screen Log
   path = /srv/screen-log
   read only = yes
   browsable = yes
```
