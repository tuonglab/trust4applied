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

# Count the number of rows in each file, excluding the header row
row_counts=$(find "$directory" -name "*_extracted.tsv" -exec awk 'END {print NR-1}' {} + | sort -n)

# Output the number of rows in each file to the specified output file in TSV format
echo -e "File\tNumber of rows" > "$output_file"
while read -r line; do
  file=$(echo "$line" | awk '{print $2}')
  num_rows=$(echo "$line" | awk '{print $1}')
  echo -e "$file\t$num_rows" >> "$output_file"
done <<< "$row_counts"
