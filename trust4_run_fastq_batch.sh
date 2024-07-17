#!/bin/bash --login

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=300G
#SBATCH --job-name=trust4_fastq
#SBATCH --time=20:00:00
#SBATCH --partition=general
#SBATCH --account=a_kelvin_tuong


# Set variables
dir_path="$2"
output_dir="$1"
reference_file="$3"

cd /home/uqsdemon/trust4-processing
chmod +x /home/uqsdemon/trust4-processing/trust4_run_fastq.sh

srun trust4_run_fastq.sh "$output_dir" "$dir_path" "$reference_file"
