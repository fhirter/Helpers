#!/bin/bash

dir=$1

# Define the CSV file name
csv_file="notenblatt.csv"
# Define the output markdown file name
output_file="Bewertungsraster.md"

cd "$dir" || exit
#Get the current directory name
current_directory=$(basename "$PWD")

echo "$dir"

# Write the main heading to the markdown file
echo "# Bewertungsraster $current_directory" > "$output_file"
echo "" >> "$output_file"
echo "- Total Punkte: <total>" >> "$output_file"
echo "- Note: <note>" >> "$output_file"
echo "" >> "$output_file"

# Read the CSV file line by line
{
    # Read the first line to get the headings
    IFS=, read -ra headings

    # Now read the second line for the scores
    IFS=, read -ra scores
} < "$csv_file"

# Skip the first heading and start from the second (index 1)
for i in "${!headings[@]}"; do
    if [ $i -eq 0 ]; then
        continue # Skip the first column, assuming it's "Name" or similar
    else
        # Write the subheading
        echo "## ${headings[$i]}" >> "$output_file"
        echo "" >> "$output_file"
        # Write the corresponding score right after the subheading
        # Adjust the format here as necessary
        echo "0/${scores[$i]//[[:space:]]/}" >> "$output_file"
        echo "" >> "$output_file"
    fi
done
