#!/bin/bash --login

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=32G
#SBATCH --job-name=trust4
#SBATCH --time=96:00:00
#SBATCH --partition=general
#SBATCH --account=a_kelvin_tuong
#SBATCH -o trust4run_fastq.output
#SBATCH -e trust4run_fastq.error

# Set variables
dir_path="$1"
output_dir="$2"
reference_file="$3"

srun trust4_run_fastq.sh "$dir_path" "$output_dir" "$reference_file"
