#!/usr/bin/env bash

# Check if a file name was provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 filename"
    exit 1
fi

# The filename to print
filename_to_print="$1"

# Find and print the file from all subdirectories
find . -type f -name "$filename_to_print" -exec lp {} \;

echo "Printing of $filename_to_print from all subdirectories initiated."
