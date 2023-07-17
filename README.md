# TRUST4 Run & Postprocessing

## Prerequisite

- TRUST4

[Github link](https://github.com/liulab-dfci/TRUST4). You can install it from Github source or if you have conda, just run `conda install -c bioconda trust4`

## Required Arguments

`output_dir` : It's where you store the output folders and files from running trust4

`processed_bamfiles`: It's just a txt file containing all the bam files which had been processed by trust4. You can create an empty txt file initially to store them. As the script is running, it will fill up this particular file. Therefore you can stop and rerun the script and it will save time from processing them again.

`bamfiles_dir`: It's the directory of where you store the bamfiles

`reference_file`: This is just `hg38_bcrtcr.fa`, unless you have a custom file in place of it.

## Running

In a HPC environment, run `sbatch trust4batch.sh output_dir processed_bamfiles bam_files_dir reference_file` to submit your job to your HPC cluster. Make sure to replace `output_dir`, `processed_bamfiles`, `bam_files_dir`, and `reference_file` with the appropriate values for your specific use case.

Else just run `./trust4run.sh output_dir processed_bamfiles bam_files_dir reference_file`.

## Disclaimer

The `trust4run.sh` script is optimised to deal with avoiding any sort of computation on the data files in UQ HPC storage, therefore there is an extra step of copying the data files to `$TMPDIR` beforehand. You can modify them
if your data files is stored elsewhere that does not have any restrictions.
