#!/bin/bash

# Define the source and target folders
source_folder="/QRISdata/Q7250/zero_extracted"
target_folder="/QRISdata/Q7250/zero_only_seq"

# Create the target folder if it doesn't exist
mkdir -p "$target_folder"

# Loop through each file in the source folder
for file in "$source_folder"/*; do
  # Extract the filename from the path
  filename=$(basename "$file")
  
  # Use awk to extract the second column (sequences) and save them to the target folder
  awk '{print $1}' "$file" > "$target_folder/$filename"
done