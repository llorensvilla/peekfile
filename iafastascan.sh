#!/bin/bash

folder="."
lines=0

# Argument validation
if [[ -n "$1" ]]; then folder="$1"; fi
if [[ -n "$2" ]]; then lines="$2"; fi

#Initialization
echo "===== In $PWD there are: ====="
total_files=0
total_ids=0

# Process files
for file in $(find "$folder" -type f -name "*.fa" -o -name "*.fasta"); do
    # Debug: print file being processed
    echo "Processing file: $file"

    total_files=$((total_files + 1))
    echo "=== File: $file ==="

    # Number of sequences
    seq_count=$(grep -c ">" "$file")
    echo "=== Number of sequences: $seq_count"
    total_ids=$((total_ids + seq_count))

    # Total length
    total_length=$(grep -v ">" "$file" | tr -d '\n' | wc -c)
    echo "=== Total length: $total_length"

    # Sequence type
    seq_type=$(grep -v "^>" "$file" | grep -iq "[EFILPQZ]" && echo "Amino acids" || echo "Nucleotides")
    echo "=== Sequence type: $seq_type"

    # File type (symlink or not)
    [[ -h "$file" ]] && echo "=== File type: Symlink" || echo "=== File type: Not a symlink"

    # Preview
    if [[ $lines -gt 0 ]]; then
        total_lines=$(wc -l < "$file")
        if [[ $total_lines -le $((2 * lines)) ]]; then
            cat "$file"
        else
            head -n "$lines" "$file"
            echo "..."
            tail -n "$lines" "$file"
        fi
    fi
done

# Final check to ensure variables are updated
echo
echo "===== In $PWD there are: ====="
echo "Total fasta/fa files: $total_files"
echo "Total sequences: $total_ids"

# Debug: Show if files were found
if [[ $total_files -eq 0 ]]; then
    echo "No .fa or .fasta files found in '$folder'."
fi
