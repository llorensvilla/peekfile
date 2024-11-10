#!/bin/bash

# Check if the required arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 filename num_lines"
  exit 1
fi

# Variables
file="$1"
num_lines="$2"

# Display the first `num_lines` lines
head -n "$num_lines" "$file"

# Print separator
echo "..."

# Display the last `num_lines` lines
tail -n "$num_lines" "$file"
