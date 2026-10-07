#!/bin/bash

# Check if the correct number of arguments was provided
if [ $# -eq 0 ] || [ $# -gt 3 ]; then
   echo "Usage: teko [command] [option1] [option2]"
   echo "Available commands:"
   echo "  bewertungsraster: create bewertungsraster markdown file"
   echo "  render: render markdown to pdf"
   echo "  publish: render markdown to html"
   echo "  dir: create directories from notenblatt file"
   echo "  marks: calculate marks and point from notenblatt file"
   echo "  print <filename>: print all files called <filename> from all subdirectories"
   echo "  notenblatt: create notenblatt using marks from Bewertungsraster.md. Usage: \`teko notenblatt notenblatt.csv Bewertungsraster.md\`"
   exit 1
fi

command="$1"
option1="$2"
option2="$3"
root_dir="$(dirname "$0")"

# Run the appropriate script based on the argument
case "$command" in
   bewertungsraster)
       root_dir="$(dirname "$0")"
       "$root_dir/scripts/create_bewertungsraster.sh"
       ;;
   render)
       root_dir="$(dirname "$0")"
       "$root_dir/scripts/render.sh" "$option1"
       ;;
   publish)
       root_dir="$(dirname "$0")"
       "$root_dir/scripts/publish.sh" "$option1" "$option2"
       ;;
  dir)
      "$root_dir/scripts/setup_directory.sh"
      ;;
  marks)
      "python3" "$root_dir/scripts/marks.py" "$option1"
      ;;
  print)
      "$root_dir/scripts/print.sh" "$option1"
      ;;
  notenblatt)
      "$root_dir/scripts/create_notenblatt.sh" "$option1" "$option2"
      ;;
   *)
       echo "Unknown command: $1"
       exit 1
       ;;
esac