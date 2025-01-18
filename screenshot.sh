#!/usr/bin/bash

DIR="/srv/screenshot-log"
PREFIX="screenshot"
DATE=`date +%Y-%m-%d__%H_%M_%S`
FORMAT="png"
FILENAME="$DIR/$PREFIX-$DATE.$FORMAT"

# for X11
import -window root $FILENAME

# for Wayland
# grim

echo "Saved screenshot to $FILENAME"
