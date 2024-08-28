#!/bin/bash

# Important directories:
output_dir="/home/uqsdemon/resultsTrust4F"
reference_file="/home/uqsdemon/trust4-processing/hg38_bcrtcr.fa"
parent_path="/QRISdata/Q7250/raw/concatenednew"
exclude_dir="./01-0015_386008_T_R_H5JJNDSX7_CCTCTACATG-AGGAGGTATC"

script_path="$(pwd)/trust4_run_fastq_batch.sh"
# Define environment
cd "$parent_path"

counter=0

# Since the fastq files are only directories
#find . -type d -mindepth 1 -print0 | while IFS= read -r -d $'\0' directory; do
find . -type d -mindepth 1 -not -path "$exclude_dir" -print0 | while IFS= read -r -d $'\0' directory; do
    # Increment counter
    #counter=$((counter + 1))

    # Check if counter is greater than 3
    #if [ "$counter" -gt 1 ]; then
    #    break
    #fi
    # Remove './' from the start of the directory name to get the correct relative path
    relative_dir="${directory#./}"
    # Build the full directory path
    full_dir_path="$parent_path/$relative_dir"
    echo "Submitting directory: $full_dir_path"

    # Extract the directory name from the full directory path
    dir_name=$(basename "$full_dir_path")
    
    # Construct the output and error file paths
    output_path="/home/uqsdemon/trust4-processing/errorsnoutputs/${dir_name}.output"
    error_path="/home/uqsdemon/trust4-processing/errorsnoutputs/${dir_name}.error"
    
    # Submit the job to SLURM with dynamically constructed paths
    sbatch --output="$output_path" --error="$error_path" "$script_path" "$output_dir" "$full_dir_path" "$reference_file"
done
