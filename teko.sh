#!/bin/bash

# Check if the correct number of arguments was provided
if [ $# -eq 0 ] || [ $# -gt 3 ]; then
   echo "Usage: teko [command] [option1] [option2]"
   echo "Available commands:"
   echo "  bewertungsraster: create bewertungsraster markdown file"
   echo "  render: render markdown to pdf"
   echo "  dir: create directories from notenblatt file"
   echo "  marks: calculate marks and point from notenblatt file"
   echo "  notenblatt: create notenblatt using marks from Bewertungsraster.md. Usage: \`teko notenblatt notenblatt.csv Bewertungsraster.md\`"
   exit 1
fi

command="$1"
option1="$2"
option2="$3"
script_dir="$(dirname "$0")"

# Run the appropriate script based on the argument
case "$command" in
   bewertungsraster)
       script_dir="$(dirname "$0")"
       "$script_dir/create_bewertungsraster.sh"
       ;;
   render)
       script_dir="$(dirname "$0")"
       "$script_dir/render.sh" "$option1"
       ;;
  dir)
      "$script_dir/setup_directory.sh"
      ;;
  marks)
      "python3" "$script_dir/marks.py" "$option1"
      ;;
  notenblatt)
      "$script_dir/create_notenblatt.sh" "$option1" "$option2"
      ;;
   *)
       echo "Unknown command: $1"
       exit 1
       ;;
esac