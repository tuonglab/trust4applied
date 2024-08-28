#!/bin/bash

# Se placer dans le dossier 'concatened

dir="/QRISdata/Q7250/raw/concatenednew"

# Pour chaque fichier R1 dans le dossier
for file in ${dir}/*; do
    # Extraire l'identifiant unique en supprimant les parties spécifiques de R1/R2 et les extensions
    folder_name=$(echo $file | sed -E 's/(_R[12].fastq.gz)+$//')

    # Créer un dossier basé sur l'identifiant unique s'il n'existe pas déjà
    mkdir -p "${folder_name}"

    # Déplacer le fichier dans le dossier de destination correspondant
    mv "$file" "${folder_name}/"
done