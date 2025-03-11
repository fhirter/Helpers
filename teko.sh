#!/bin/bash

# Check if the correct number of arguments was provided
if [ $# -eq 0 ] || [ $# -gt 2 ]; then
   echo "Usage: teko [command] [option]"
   echo "Available commands:"
   echo "  bewertungsraster: create bewertungsraster markdown file"
   echo "  render: render markdown to pdf"
   echo "  dir: create directories from notenblatt file"
   echo "  marks: calculate marks and point from notenblatt file"
   exit 1
fi

command="$1"
option="$2"
script_dir="$(dirname "$0")"

# Run the appropriate script based on the argument
case "$command" in
   bewertungsraster)
       script_dir="$(dirname "$0")"
       "$script_dir/create_bewertungsraster.sh"
       ;;
   render)
       script_dir="$(dirname "$0")"
       "$script_dir/render.sh" "$option"
       ;;
  dir)
      "$script_dir/setup_directory.sh"
      ;;
  marks)
      "python3" "$script_dir/marks.py" "$option"
      ;;
   *)
       echo "Unknown command: $1"
       exit 1
       ;;
esac