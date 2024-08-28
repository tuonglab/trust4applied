#!/bin/bash

# Définir le répertoire contenant les fichiers FASTQ
fastq_dir="/QRISdata/Q7250/raw"

# Définir le répertoire de sortie pour les fichiers concaténés
output_dir="/QRISdata/Q7250/raw/concatenednew"

# Créer le répertoire de sortie s'il n'existe pas
mkdir -p "$output_dir"

# Fonction pour extraire l'identifiant unique et concaténer les fichiers
concatenate_files() {
    local type=$1 # R1 ou R2
    # Trouver tous les fichiers correspondant au type (R1 ou R2), extraire l'identifiant unique, et supprimer les doublons
    find "$fastq_dir" -name "*_${type}*.fastq.gz" | sed -E "s/_L[0-9]+_${type}.*.fastq.gz//" | sort | uniq | while read -r id; do
        # Définir le nom du fichier de sortie basé sur l'identifiant unique et le type
        local outfile="${output_dir}/$(basename "${id}")_${type}.fastq.gz"
        # Vérifier si le fichier de sortie existe déjà
        if [ ! -f "$outfile" ]; then
            echo "Concaténation de ${id}_${type}*.fastq.gz"
            # Trouver et concaténer tous les fichiers correspondants à l'identifiant et au type dans le fichier de sortie, en les triant par le numéro de lecture (L001, L002, etc.)
            find "$fastq_dir" -name "$(basename "${id}")_*_${type}*.fastq.gz" | sort -V | xargs cat > "$outfile"
        fi
    done
}

# Concaténer les fichiers R1
concatenate_files "R1"

# Concaténer les fichiers R2
concatenate_files "R2"

echo "Concaténation terminée."
