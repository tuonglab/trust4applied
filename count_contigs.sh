#!/bin/bash

# Get the directory to search

# Check if a source directory path and a destination directory path were provided as arguments
if [ -z "$1" ]; then
    echo "Please provide a directory path as an argument"
    exit 1
fi
directory=$1

# Check if an output file was provided as a second argument
if [ -z "$2" ]; then
    echo "Please provide an output file as a second argument"
    exit 1
fi
output_file=$2

# Find all files with the name *_extracted.tsv in the given directory
files=$(find "$directory" -name "*_extracted.tsv")

# Output the number of rows in each file to the specified output file in TSV format
echo -e "File\tNumber of rows" > "$output_file"
while read -r file; do
  num_rows=$(awk 'END {print NR-1}' "$file")
  echo -e "$file\t$num_rows" >> "$output_file"
done <<< "$files"
