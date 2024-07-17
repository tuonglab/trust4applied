#!/bin/bash

# important directories :
output_dir="/home/uqsdemon/resultsTrust4F"
reference_file="/home/uqsdemon/trust4-processing/hg38_bcrtcr.fa"
parent_path="/QRISdata/Q7250/raw"

script_path="$(pwd)/trust4batch.sh"

cd "$parent_path"

find . -type f -mindepth 1 -name "*.bam" -print0 | while IFS= read -r -d $'\0' file; do
    # Supprime './' du début du nom du dossier pour obtenir le chemin relatif correct
    relative_dir="${file#./}"
    # Construit le chemin complet du dossier
    full_dir_path="$parent_path/$relative_dir"
    echo "Soumission du dossier : $full_dir_path"

    # Extract the directory name from the full directory path
    dir_name=$(basename "$full_dir_path")
    
    # Construct the output and error file paths
    output_path="/home/uqsdemon/trust4-processing/errorsnoutputs/${dir_name}.output"
    error_path="/home/uqsdemon/trust4-processing/errorsnoutputs/${dir_name}.error"
    
    # Submit the job to SLURM with dynamically constructed paths
    sbatch --output="$output_path" --error="$error_path" "$script_path" "$output_dir" "$full_dir_path" "$reference_file"
done