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
        --pdf-engine=lualatex \
        -H "$script_dir/general_header.sty" \
        -H "$script_dir/teko_header.sty"
    #    --lua-filter="$script_dir/table.lua"

    echo "Converted $markdown_file to $output_dir/$filename_noext.pdf"
}

add_yaml_metadata() {
    local file="$1"

    # Ensure file exists
    if [ ! -f "$file" ]; then
        echo "Skipping non-existent file: $file" >&2
        return 0
    fi

    # Derive a title from the filename (without extension)
    local base title
    base="$(basename "$file")"
    title="${base%.*}"

    # Prepare a temporary file for the result
    local tmp
    tmp="$(mktemp "${TMPDIR:-/tmp}/frontmatter.XXXXXX")"

    local git_author="" git_date=""
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        git_author="$(git log -1 --follow --format=%an -- "$file" 2>/dev/null || true)"
        git_date="$(git log -1 --follow --date=short --format=%ad -- "$file" 2>/dev/null || true)"
    fi

    # Determine if the file already has front matter
    local first_nonempty
    first_nonempty="$(awk 'NF{print; exit}' "$file" 2>/dev/null || true)"

    local end_line=""
    if printf '%s' "$first_nonempty" | grep -qE '^\s*---\s*$'; then
        # Find the closing delimiter line number for the existing front matter (--- or ...)
        end_line="$(awk '
            BEGIN { start=0 }
            $0 ~ /^[[:space:]]*---[[:space:]]*$/ && start==0 { start=1; next }   # first ---
            start==1 && ($0 ~ /^[[:space:]]*---[[:space:]]*$/ || $0 ~ /^[[:space:]]*\.\.\.[[:space:]]*$/) { print NR; exit }  # closing --- or ...
        ' "$file")"
    fi

    if [ -n "${end_line:-}" ]; then
        # Extract existing front matter body (between the delimiters)
        local existing_fm
        existing_fm="$(sed -n "2,$((end_line - 1))p" "$file")"

        # Check for existing top-level title/author keys
        local has_title has_author
        has_title="$(printf '%s\n' "$existing_fm" | grep -cE '^[[:space:]]*title[[:space:]]*:' || true)"
        has_author="$(printf '%s\n' "$existing_fm" | grep -cE '^[[:space:]]*author[[:space:]]*:' || true)"

        # Build merged front matter
        {
            printf '%s\n' '---'
            if [ "${has_title:-0}" -eq 0 ]; then
                printf 'title: "%s"\n' "$title"
            fi
            if [ "${has_author:-0}" -eq 0 ]; then
                printf 'author: "%s"\n' "$git_author"
            fi
            printf 'date: "%s"\n' "$git_date"
            # Preserve existing front matter, but drop any prior date: line
            # (title/author are kept as-is if present)
            printf '%s\n' "$existing_fm" | grep -vE '^[[:space:]]*date[[:space:]]*:' || true
            printf '%s\n' '---'
        } > "$tmp"

        # Append the content after the closing delimiter to the temp file
        tail -n +"$((end_line + 1))" "$file" >> "$tmp"
    else
        # No front matter (or malformed) — write a fresh header and prepend original content
        {
            printf '%s\n' '---'
            printf 'title: "%s"\n' "$title"
            printf 'author: "%s"\n' "$git_author"
            printf 'date: "%s"\n' "$git_date"
            printf '%s\n' '---'
        } > "$tmp"
        cat "$file" >> "$tmp"
    fi

    mv "$tmp" "$file"
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
        add_yaml_metadata "$input_path"
        convert_md_to_pdf "$input_path"
    else
        echo "Path does not exist or is not accessible: $input_path" >&2
    fi
done