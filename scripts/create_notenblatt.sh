#!/bin/bash

# Parent directory containing student folders
parent_dir=.

# Output CSV file
csv_file=$1
bewertungsraster=$2

# Initialize an associative array to store the total marks for each chapter
declare -a total_marks

# Initialize an array to track the order of chapters
chapter_order=()

# Create or overwrite the CSV file and add the headers
echo -n "Punkte" > "$csv_file"

# First pass: Extract chapter titles and total marks from the markdown files
for student_folder in "$parent_dir"/*/; do
    markdown_file="${student_folder}${bewertungsraster}"
    if [[ -f "$markdown_file" ]]; then
        while IFS= read -r line; do
            # Extract chapter titles (lines starting with ##)
            if [[ "$line" =~ ^##\ (.+) ]]; then
                chapter="${BASH_REMATCH[1]}"
                if [[ ! " ${chapter_order[@]} " =~ " ${chapter} " ]]; then
                    chapter_order+=("$chapter")
                    echo -n ",\"$chapter\"" >> "$csv_file"
                fi
            fi

            # Extract total marks (matching "<marks>/<total>")
            if [[ "$line" =~ ^([0-9]+)/([0-9]+)$ ]]; then
                total="${BASH_REMATCH[2]}"
                chapter_sanitized=$(echo "$chapter" | sed 's/[^a-zA-Z0-9_]/_/g')
                total_marks["$chapter_sanitized"]=$total
            fi
        done < "$markdown_file"
    fi
done

# Complete the headers row
echo "" >> "$csv_file"

# Add the row for total marks
echo -n "Max," >> "$csv_file"
for chapter in "${chapter_order[@]}"; do
    chapter_sanitized=$(echo "$chapter" | sed 's/[^a-zA-Z0-9_]/_/g')
    echo -n "${total_marks[$chapter_sanitized]:-0}," >> "$csv_file"
done
echo "" >> "$csv_file"

# Second pass: Extract student names and their marks
for student_folder in "$parent_dir"/*/; do
    student_name=$(basename "$student_folder")
    markdown_file="${student_folder}Bewertungsraster.md"
    if [[ -f "$markdown_file" ]]; then
        echo -n "$student_name," >> "$csv_file"

        # Reset chapter index
        chapter_index=0
        while IFS= read -r line; do
            # Extract marks (matching "<marks>/<total>")
            if [[ "$line" =~ ^([0-9]+)/([0-9]+)$ ]]; then
                marks="${BASH_REMATCH[1]}"
                echo -n "$marks," >> "$csv_file"
                ((chapter_index++))
            fi
        done < "$markdown_file"

        # Finish the student's row
        echo "" >> "$csv_file"
    fi
done

echo "CSV file generated: $csv_file"
