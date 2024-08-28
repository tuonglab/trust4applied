This repository concern my usage of trust4 to extract zero's data.

the structure is as followed :

before_trust4 : steps done before usage of trust4 :
                concatenation of the separates fragments of files 
                moving.sh = script to recover the files name and create folders with it to put R1 and R2 together

after_trust4 : steps of processing done after usage of trust4 :
                cleaning_trust4output.sh = Filter the sequences to include only valid amino acid sequences
                extract.sh = will extract the complex result of trust 4 into a file with only the seq and the cdr3 name
                suppr.sh = will extract only the sequences into new files. 

analysis : few analysis on zero's data : a script to create a plot and a txt to see how much sequences are in each length (distribution)

errorsnoutputs : error and outputs of the trust4 usage

zerofastqfetch.sh : main script that will call the trust4 scripts for each of the processed folders of zero. just use it in terminal with ./ after activation

all the other files were present in amos repository : https://github.com/tuonglab/trust4-processing

if any questions : simon2mon@gmail.com