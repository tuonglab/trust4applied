#!/bin/bash

# Check if all required arguments have been passed
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 output_dir processed_bamfiles bam_files_dir reference_file"
    exit 1
fi

# Set variables
output_dir="$1"
processed_bamfiles="$2"
bam_files_dir="$3"
reference_file="$4"

trap 'echo "Script interrupted"; rm -rf "$output_dir"; exit' INT TERM

# Create new directory
mkdir -p "$output_dir"

for bamfile in "$bam_files_dir"/*.bam; do
    # Check if bam file has already been processed
    if grep -q "$(basename "$bamfile")" "$processed_bamfiles"; then
        echo "Skipping $bamfile"
    else
        # Copy bam file to $TMPDIR
        rsync -avz "$bamfile" "$TMPDIR/" --progress

        # Process bam file in $TMPDIR
        dir=$(basename "$bamfile" .bam)
        output_subdir="$output_dir/$dir"
        if [ -d "$output_subdir" ]; then
            echo "Output directory $output_subdir already exists. Skipping $bamfile"
        else
            mkdir -p "$output_subdir"
            echo "Running run-trust4 for $bamfile"

            # Run run-trust4 on the bam file and save output to output_subdir
            run-trust4 -b "$TMPDIR/$(basename "$bamfile")" -f "$reference_file" -t 64 --od "$output_subdir" --abnormalUnmapFlag
            echo "$(basename "$bamfile")" >> "$processed_bamfiles"
        fi
    fi
done
