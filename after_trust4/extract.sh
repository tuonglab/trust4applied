#!/bin/bash

# Navigate to the directory containing the files
cd "$extract_dir"

# Find all report.tsv files and process each file
find . -name "*report.tsv" -print0 | while IFS= read -r -d $'\0' file; do
    # Extract the parent directory name to name the output file
    parent_dir=$(basename "$(dirname "$file")")
    output_file="${output_direx}/${parent_dir}_extracted.tsv"
    
    # Filter lines with TRB in column V, extract columns CDR3aa and V,
    # and exclude lines containing "out_of_frame" or "?" in column 4
    awk -F '\t' '$5 ~ /TRB/ && $4 !~ /out_of_frame/ && $4 !~ /\?/ {print $4 "\t" $5}' "$file" > "$output_file"
done

echo "Extraction completed."
