#!/bin/bash --login

# Check if all required arguments have been passed
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 output_dir processed_bamfiles bam_files_dir reference_file"
    exit 1
fi

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=32G
#SBATCH --job-name=trust4
#SBATCH --time=96:00:00
#SBATCH --partition=general
#SBATCH --account=a_kelvin_tuong
#SBATCH -o trust4run.output
#SBATCH -e trust4run.error

# Set variables
output_dir="$1"
processed_bamfiles="$2"
bam_files_dir="$3"
reference_file="$4"

srun trust4run.sh "$output_dir" "$processed_bamfiles" "$bam_files_dir" "$reference_file"
