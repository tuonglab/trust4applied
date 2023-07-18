# TRUST4 Run & Postprocessing

## Prerequisite

- TRUST4

[Github link](https://github.com/liulab-dfci/TRUST4). You can install it from Github source or if you have conda, just run `conda install -c bioconda trust4`

## Running

### BAM files
In a HPC environment, run `sbatch trust4batch.sh output_dir processed_bamfiles bam_files_dir reference_file` to submit your job to your HPC cluster. Make sure to replace `output_dir`, `processed_bamfiles`, `bam_files_dir`, and `reference_file` with the appropriate values for your specific use case.

#### Required Arguments

`output_dir` : It's where you store the output folders and files from running trust4

`processed_bamfiles`: It's just a txt file containing all the bam files which had been processed by trust4. You can create an empty txt file initially to store them. As the script is running, it will fill up this particular file. Therefore you can stop and rerun the script and it will save time from processing them again.

`bamfiles_dir`: It's the directory of where you store the bamfiles

`reference_file`: This is just `hg38_bcrtcr.fa`, unless you have a custom file in place of it.

Else just run `./trust4run.sh output_dir processed_bamfiles bam_files_dir reference_file`.

### fastq files

In a HPC environment, run `sbatch trust4_run_fastq_batch.sh path_to_fastq_files output_dir reference_file processed_files_file` to submit your job to your HPC cluster. Make sure to replace these arguments with the appropriate values for your specific use case.

## Disclaimer

The `trust4run.sh` script is optimised to deal with avoiding any sort of computation on the data files in UQ HPC storage, therefore there is an extra step of copying the data files to `$TMPDIR` beforehand. You can modify them
if your data files is stored elsewhere that does not have any restrictions.

## Post Processing

Not all files from TRUST4 output will be used. The file from the output that needs particular attention is file with the suffix of `filename_airr.tsv`. You should find the corrospending files in the output (sub)directories that you specified.

We only need certain columns the files and only want assembled TRB gene locus type. Therefore we will run `trim_trust4_output.sh`. The output files will be in the suffix naming `filename_extracted.tsv` in the same respective directories in which the output files from running TRUST4 is generated.
