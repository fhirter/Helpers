#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for directory in "$@"; do
    # Check if the directory exists
    if [ -d "$directory" ]; then
        echo "Processing directory: $directory"
        cd "$directory" || exit
        input_directory="."
        output_directory=$input_directory
        for markdown_file in "$input_directory"/*.md; do
            if [ -f "$markdown_file" ]; then
                # Extract the file name without the extension
                filename=$(basename -- "$markdown_file")
                filename_noext="${filename%.*}"

                # Convert Markdown to PDF using Pandoc
                pandoc "$markdown_file" \
                  -o "$output_directory/$filename_noext.pdf" \
                  --pdf-engine=xelatex \
                  -H "$script_dir/header.sty"

                echo "Converted $markdown_file to $output_directory/$filename_noext.pdf"
            fi
        done
    else
        echo "Directory does not exist: $directory"
    fi
    # Go back to the initial directory to correctly process the next one
    cd - || exit > /dev/null
done