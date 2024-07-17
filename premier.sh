#!/bin/bash

# important directories :
output_dir="/home/uqsdemon/resultsTrust4F"
reference_file="/home/uqsdemon/resultsTrust4F/trust4-processing/hg38_bcrtcr.fa"
parent_path="/QRISdata/Q7250/raw"
exclude_dir="01-0015_386008_T_R_H5JJNDSX7_CCTCTACATG-AGGAGGTATC_L001"

script_path="$(pwd)/trust4_run_fastq_batch.sh"

# Construit le chemin complet du dossier exclu
full_exclude_path="$parent_path/$exclude_dir"
echo "Soumission du dossier exclu : $full_exclude_path"

# Extract the directory name from the full directory path
dir_name=$(basename "$full_exclude_path")

# Construct the output and error file paths
output_path="/home/uqsdemon/resultsTrust4F/trust4-processing/errorsnoutputs/${dir_name}.output"
error_path="/home/uqsdemon/resultsTrust4F/trust4-processing/errorsnoutputs/${dir_name}.error"

# Submit the job to SLURM with dynamically constructed paths
sbatch --output="$output_path" --error="$error_path" "$script_path" "$output_dir" "$full_exclude_path" "$reference_file"