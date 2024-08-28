#!/bin/bash

# Define the directory containing FASTQ files
fastq_dir="/QRISdata/Q7250/raw"

# Define the output directory for concatenated files
output_dir="/QRISdata/Q7250/raw/concatenednew"

# Create the output directory if it does not exist
mkdir -p "$output_dir"

# Function to extract the unique identifier and concatenate files
concatenate_files() {
    local type=$1 # R1 or R2
    # Find all files matching the type (R1 or R2), extract the unique identifier, and remove duplicates
    find "$fastq_dir" -name "*_${type}*.fastq.gz" | sed -E "s/_L[0-9]+_${type}.*.fastq.gz//" | sort | uniq | while read -r id; do
        # Define the output file name based on the unique identifier and type
        local outfile="${output_dir}/$(basename "${id}")_${type}.fastq.gz"
        # Check if the output file already exists
        if [ ! -f "$outfile" ]; then
            echo "Concatenating ${id}_${type}*.fastq.gz"
            # Find and concatenate all files matching the identifier and type into the output file, sorting them by read number (L001, L002, etc.)
            find "$fastq_dir" -name "$(basename "${id}")_*_${type}*.fastq.gz" | sort -V | xargs cat > "$outfile"
        fi
    done
}

# Concatenate R1 files
concatenate_files "R1"

# Concatenate R2 files
concatenate_files "R2"

echo "Concatenation completed."
