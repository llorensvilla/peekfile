#!/bin/bash

folder="."
lines=0
if [ -n "$1" ]; then folder="$1";fi
if [ -n "$2" ]; then lines="$2";fi

echo "===== In $PWD there are: ====="

total_files=0
total_ids=0

for file in $(find .  -type f -name "*.fa" -o -name "*.fasta"); do
	echo
	total_files=$((total_files+1))
	echo === File: $file ===
	seq_count=$(grep -c ">" $file)
	echo === Number of seq: $seq_count
	total_ids=$((total_ids + seq_count))
	total_length=$(grep -v ">" $file | sed 's/[\n-]//g' | wc -c)
	echo === Total length: $total_length
	seq_type=$(if grep -v "^>" "$file" | grep -iq "[EFILPQZ]"; then echo "Amino acids"; else echo "Nucleotides"; fi)
	echo === Seq type : $seq_type 
	if [[ -h $file ]]; then echo  "=== File type: Symlink"; else echo "=== File type: No symlink"; fi
	if [[ $lines -gt 0 ]]; then total_lines=$(wc -l < "$file")
		if [[ $total_lines -le $(( 2 * lines )) ]]; then cat "$file"
		else head -n "$lines" "$file"; echo ...; tail -n "$lines" "$file";fi;fi
done

echo
echo "===== In $PWD there are: ====="
echo "Total fasta/fa files: $total_files"
echo "Total unique fasta IDs: $total_ids"
