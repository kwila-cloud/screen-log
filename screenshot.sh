#!/usr/bin/bash

DIR="/srv/screen-log"
PREFIX="screenshot"
DATE=`date +%Y-%m-%d__%H_%M_%S`
FORMAT="png"
FILENAME="$DIR/$PREFIX-$DATE.$FORMAT"

# for X11
DISPLAY=:2 import -window root $FILENAME

# for Wayland
# grim

echo "Saved screenshot to $FILENAME"

# Clean old screenshots after 7 days
find "$DIR" -type f -mtime +7 -delete
