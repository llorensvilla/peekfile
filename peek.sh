#!/bin/bash

# Check if a file argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 filename"
  exit 1
fi

# Variables
file="$1"

# Display first three lines
head -n 3 "$file"

# Print separator
echo "..."

# Display last three lines
tail -n 3 "$file"
