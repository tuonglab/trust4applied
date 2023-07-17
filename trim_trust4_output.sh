#!/bin/bash

# Check if a directory path was provided
if [ -z "$1" ]; then
    echo "Please provide a directory path"
    exit 1
fi

# Set the directory path
dir_path="$1"

# Find all files with the _airr.tsv suffix in the specified directory and its subdirectories
while IFS= read -r -d '' file; do
    # Extract the specified columns from the file and filter rows based on the values of the v_call, j_call, and c_call columns
    awk -F '\t' 'NR==1 || (substr($5,1,3)=="TRB" && substr($7,1,3)=="TRB" && substr($8,1,3)=="TRB") {print $1,$4,$5,$7,$8,$13,$14,$21,$22}' OFS='\t' "$file" > "${file%.tsv}_extracted.tsv"
done < <(find "$dir_path" -type f -name '*_airr.tsv' -print0)
