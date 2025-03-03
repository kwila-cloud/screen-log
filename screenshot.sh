#!/usr/bin/bash

DIR="/srv/screen-log"
PREFIX="screenshot"
DATE=`date +%Y-%m-%d__%H_%M_%S`
FORMAT="png"


# for X11
displays=$(who | grep -oP '(?<=\():\d+(?=\))')

for display in $displays; do
	export DISPLAY=$display
	user=$(who | grep "$display" | awk '{print $1}')
	echo "$display is $user"
	export XAUTHORITY="/home/$user/.Xauthority"
	filename="$DIR/$user-$PREFIX-$DATE.$FORMAT"
        import -window root $filename
        echo "saved to $filename"
       	echo "---"
done


# Clean old screenshots after 7 days
find "$DIR" -type f -mtime +7 -delete
