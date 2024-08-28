#!/bin/bash

# Define the source and target folders
source_folder="/QRISdata/Q7250/zero_only_seq"
target_folder="/QRISdata/Q7250/filtered_sequences"

# Create the target folder if it doesn't exist
mkdir -p "$target_folder"

# Loop through each file in the source folder
for file in "$source_folder"/*; do
  # Extract the filename from the path
  filename=$(basename "$file")
  
  # Filter the sequences to include only valid amino acid sequences
  # Only allows sequences containing letters (A-Z) and ignores lines with invalid characters
  grep -E '^[A-Z]+$' "$file" > "$target_folder/$filename"
done