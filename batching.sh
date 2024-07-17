#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=50G
#SBATCH --job-name=copyp
#SBATCH --time=07:00:00
#SBATCH --partition=gpu_cuda
#SBATCH --gres=gpu:h100:1
#SBATCH --account=a_kelvin_tuong
#SBATCH -e cop.error
#SBATCH -o cop.out

cd /home/uqsdemon/trust4-processing
chmod +x /home/uqsdemon/trust4-processing/copying.sh

srun copying.sh