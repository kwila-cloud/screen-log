#!/bin/bash

# Script to find and delete all-black PNG files in /srv/screen-log

echo "Scanning for all-black PNG files in /srv/screen-log..."

# Find all PNG files in /srv/screen-log and check if they're black
find /srv/screen-log -type f -name "*.png" | sort | while read file; do
    # Check if the image is all black (mean value close to 0)
    mean=$(identify -format "%[mean]" "$file")

    echo "$file - $mean" 
    # If mean is very close to 0, the image is likely all black
    # Using a small threshold to account for compression artifacts
    if (( $(echo "$mean < 100" | bc -l) )); then
        echo "Deleting black image: $file"
        rm "$file"
    fi
done
