# screen-log

Keep a log of screenshots.

## Inspiration

- https://superuser.com/questions/1594667/how-can-i-make-a-screenshot-log-on-linux
- https://www.perplexity.ai/search/systemd-script-that-runs-once-1HMPhyn9QoeqHJ6AfpfCRQ

## Install Service
1. Update `screen-log.service`
   1. Update `User` to an admin user
   2. Update `ExecStart` path
2. Update `screenshot.sh`
   1. Update `DISPLAY` value
3. Create `/srv/screenshot-log` directory, owned by an admin user
4. `sudo cp screen-log.service /etc/systemd/system/screen-log.service`
5. `sudo cp screen-log.timer /etc/systemd/system/screen-log.timer`
6. `sudo systemctl daemon-reload`
7. `sudo systemctl enable screen-log.timer`
8. `sudo systemctl enable screen-log.service`

## Set Up Samba Share

[Instructions for Ubuntu](https://ubuntu.com/tutorials/install-and-configure-samba#1-overview)

[Instructions for Fedora SilverBlue](https://discussion.fedoraproject.org/t/how-to-use-samba-in-silverblue/1570/8)
