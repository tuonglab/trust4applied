#!/bin/bash

# Check if all required arguments have been passed
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 output_dir bam_files_dir reference_file"
    exit 1
fi

# Set variables
output_dir="$1"
bam_files_dir="$2"
reference_file="$3"

# Create new directory
mkdir -p "$output_dir"

for bamfile in "$bam_files_dir"/*.bam; do
    rsync -avz "$bamfile" "$TMPDIR/" --progress

    # Process bam file in $TMPDIR
    dir=$(basename "$bamfile" .bam)
    output_subdir="$output_dir/$dir"

    mkdir -p "$output_subdir"
    echo "Running run-trust4 for $bamfile"

    # Run run-trust4 on the bam file and save output to output_subdir
    /home/uqachoo1/mambaforge/envs/env/bin/run-trust4 -b "$TMPDIR/$(basename "$bamfile")" -f "$reference_file" -t 72 --od "$output_subdir" --abnormalUnmapFlag
done
