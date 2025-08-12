#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

convert_md_to_pdf() {
    local markdown_file="$1"
    local output_dir
    output_dir="$(dirname "$markdown_file")"

    if [[ "${markdown_file##*.}" != "md" ]]; then
        echo "Skipping non-Markdown file: $markdown_file"
        return 0
    fi

    local filename
    filename="$(basename -- "$markdown_file")"
    local filename_noext="${filename%.*}"

    pandoc "$markdown_file" \
        -o "$output_dir/$filename_noext.pdf" \
        --pdf-engine=xelatex \
        -H "$script_dir/header.sty"

    echo "Converted $markdown_file to $output_dir/$filename_noext.pdf"
}

for input_path in "$@"; do
    if [ -d "$input_path" ]; then
        echo "Processing directory: $input_path"
        shopt -s nullglob
        found_any=false
        for markdown_file in "$input_path"/*.md; do
            found_any=true
            convert_md_to_pdf "$markdown_file"
        done
        shopt -u nullglob
        if [ "$found_any" = false ]; then
            echo "No Markdown files found in: $input_path"
        fi
    elif [ -f "$input_path" ]; then
        echo "Processing file: $input_path"
        convert_md_to_pdf "$input_path"
    else
        echo "Path does not exist or is not accessible: $input_path" >&2
    fi
done