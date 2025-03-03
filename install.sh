#!/usr/bin/bash

apt install imagemagick

mkdir /srv/screen-log

cp screen-log.service /etc/systemd/system/screen-log.service
cp screen-log.timer /etc/systemd/system/screen-log.timer

systemctl daemon-reload
systemctl enable screen-log.timer
systemctl enable screen-log.service
systemctl start screen-log.timer

apt install samba

SAMBA_CONFIG_FILE="/etc/samba/smb.conf"
SAMBASHARE_BLOCK="[sambashare]
   comment = Screen Log
   path = /srv/screen-log
   read only = yes
   browsable = yes"

# Check if the block already exists
if grep -qFx "[sambashare]" "$SAMBA_CONFIG_FILE"; then
    echo "The [sambashare] section already exists in $SAMBA_CONFIG_FILE."
else
    echo -e "\n$SAMBASHARE_BLOCK" | sudo tee -a "$SAMBA_CONFIG_FILE" > /dev/null
    echo "Configuration appended successfully."
    systemctl restart smbd
fi

ufw allow samba

# YOU MUSE MANUALLY RUN sudo smbpasswd -a username
