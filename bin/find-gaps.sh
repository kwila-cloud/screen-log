#!/bin/bash

# Directory to check
DIR=/srv/screen-log

# Get all files sorted by modification time
files=($(find "$DIR" -type f -printf "%T@ %p\n" | sort -n | awk '{print $2}'))

# Check if there are any files
if [ ${#files[@]} -eq 0 ]; then
    echo "No files found in directory"
    exit 0
fi

# Initialize variables
sequence_start="${files[0]}"
sequence_start_time=$(stat -c %Y "$sequence_start")
sequence_count=1

# Function to print sequence info
print_sequence() {
    local start_file=$1
    local end_file=$2
    local start_time=$3
    local end_time=$4
    local count=$5
    
    start_date=$(date -d @$start_time "+%Y-%m-%d %H:%M:%S")
    end_date=$(date -d @$end_time "+%Y-%m-%d %H:%M:%S")
    
    echo "Sequence $sequence_count:"
    echo "  Start: $start_file ($start_date)"
    echo "  End: $end_file ($end_date)"
    echo "  Files: $count"
    echo "  Duration: $(( (end_time - start_time) / 60 )) minutes"
    echo ""
}

# Loop through files and check for gaps
file_count=1
for ((i=1; i<${#files[@]}; i++)); do
    prev_file="${files[$i-1]}"
    curr_file="${files[$i]}"
    
    # Get modification times in seconds since epoch
    prev_time=$(stat -c %Y "$prev_file")
    curr_time=$(stat -c %Y "$curr_file")
    
    # Calculate time difference in minutes
    time_diff=$(( (curr_time - prev_time) / 60 ))
    
    # Check if gap is more than 2 minutes
    if [ $time_diff -gt 2 ]; then
        # Print the sequence that just ended
        print_sequence "$sequence_start" "$prev_file" "$sequence_start_time" "$prev_time" "$file_count"
        
        # Start a new sequence
        sequence_start="$curr_file"
        sequence_start_time="$curr_time"
        sequence_count=$((sequence_count + 1))
        file_count=1
    else
        file_count=$((file_count + 1))
    fi
done

# Print the last sequence
last_file="${files[${#files[@]}-1]}"
last_time=$(stat -c %Y "$last_file")
print_sequence "$sequence_start" "$last_file" "$sequence_start_time" "$last_time" "$file_count"
