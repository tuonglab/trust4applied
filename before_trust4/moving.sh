#!/bin/bash

# Change directory to concatenednew
dir="/QRISdata/Q7250/raw/concatenednew"

# For each R file in the folder
for file in ${dir}/*; do
    # Extract the unique identifier by removing specific parts of R1/R2 and the extensions
    folder_name=$(echo $file | sed -E 's/(_R[12].fastq.gz)+$//')

    # Create a directory based on the unique identifier if it doesn't already exist
    mkdir -p "${folder_name}"

    # Move the file to the corresponding destination directory
    mv "$file" "${folder_name}/"
done
