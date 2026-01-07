#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_directory> <output_directory>"
    exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="$2"

# Check if input directory exists
if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Input directory '$INPUT_DIR' does not exist."
    exit 1
fi

# Use find to recursively locate all .md files
find "$INPUT_DIR" -type f -name "*.md" | while read -r md_file; do
    # Calculate the relative path from the input directory
    rel_path="${md_file#$INPUT_DIR/}"

    # Define the output file path (changing extension to .html)
    html_file="$OUTPUT_DIR/${rel_path%.md}.html"

    # Create the destination subdirectory if it doesn't exist
    mkdir -p "$(dirname "$html_file")"

    echo "Converting: $md_file -> $html_file"

    # Run pandoc conversion
    # --standalone creates a full HTML file (with <head>, <body>, etc.)
    pandoc "$md_file" -s -o "$html_file" --template template.html
done

echo "Done!"