#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=200G
#SBATCH --job-name=trust4bam
#SBATCH --time=200:00:00
#SBATCH --partition=general
#SBATCH --account=a_kelvin_tuong
#SBATCH -o trust4runbam.output
#SBATCH -e trust4runbam.error

output_dir="$1"
bam_files_dir="$2"
reference_file="$3"

cd /home/uqsdemon/trust4-processing
chmod +x /home/uqsdemon/trust4-processing/trust4run.sh

srun trust4run.sh "$output_dir" "$bam_files_dir" "$reference_file"
