#!/bin/bash

# The name of the file to be copied
FILE_TO_COPY="Bewertungsraster.md"

# The CSV file containing the directory names and other fields
CSV_FILE="notenblatt.csv"

# Check if the CSV file exists
if [ ! -f "$CSV_FILE" ]; then
  echo "CSV file not found: $CSV_FILE"
  exit 1
fi

# Check if the file to be copied exists
if [ ! -f "$FILE_TO_COPY" ]; then
  echo "File to copy not found: $FILE_TO_COPY"
  exit 1
fi

# Skip the first line of the CSV file and read each subsequent line
tail -n +2 "$CSV_FILE" | while IFS= read -r line || [ -n "$line" ]
do
  # Extract the first field from the CSV (the name) before the first comma
  DIR_NAME=$(echo "$line" | cut -d',' -f1 | sed 's/[^a-zA-Z0-9 ]//g' | xargs)

  # Check if the directory doesn't exist, then create it
  if [ ! -d "$DIR_NAME" ]; then
    mkdir "$DIR_NAME"
    echo "Directory created: $DIR_NAME"
  else
    echo "Directory already exists: $DIR_NAME"
  fi

# Create a temporary file for the modifications
  TEMP_FILE=$(mktemp)

  # Remove the file extension for the filename in the inserted line
  FILENAME_WITHOUT_EXT="${FILE_TO_COPY%.*}"

  # Add the new first line
  read -r first_line < "$FILE_TO_COPY"
  echo "$first_line $DIR_NAME" > "$TEMP_FILE"

  # Append the original file's content except the first line
  tail -n +2 "$FILE_TO_COPY" >> "$TEMP_FILE"

  # Move the modified temporary file into the target directory
  mv -n "$TEMP_FILE" "$DIR_NAME/$FILE_TO_COPY"
  echo "File copied to: $DIR_NAME/$FILE_TO_COPY"

done < "$CSV_FILE"
