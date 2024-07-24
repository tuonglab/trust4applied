
# j'ai plusieurs fichiers tsv dans le dossier suivant qui contiennent des séquences
# puis compter toutes les séquences, sortir le nombre de séquences final. 
# mais aussi compter le nombre de séquence pour chaque longueur (12 acides aminés, 13, 14)
# en sortir le nombre
# et faire un histogramme en barre avec le nombre de seq pour chaque length

import os
import matplotlib.pyplot as plt
import seaborn as sns

# Chemin vers le répertoire contenant les fichiers .tsv
pathtolook = "/QRISdata/Q7250/zero_only_seq"

# Initialisation des compteurs
total_sequences = 0
length_counts = {}

# Lecture de chaque fichier .tsv dans le répertoire
for filename in os.listdir(pathtolook):
    if filename.endswith(".tsv"):
        file_path = os.path.join(pathtolook, filename)
        
        # Lecture du fichier ligne par ligne
        with open(file_path, 'r') as file:
            for line in file:
                sequence = line.strip()
                seq_length = len(sequence)
                total_sequences += 1
                if seq_length in length_counts:
                    length_counts[seq_length] += 1
                else:
                    length_counts[seq_length] = 1

# Écriture des résultats dans un fichier
output_file = "sequence_counts.txt"
with open(output_file, 'w') as out_file:
    out_file.write(f"Nombre total de séquences: {total_sequences}\n")
    for length, count in length_counts.items():
        out_file.write(f"Longueur {length}: {count} séquences\n")

# Impression du nombre total de séquences (facultatif)
print(f"Les résultats ont été écrits dans {output_file}")

# Création de l'histogramme en barre
lengths = list(length_counts.keys())
counts = list(length_counts.values())

plt.figure(figsize=(10, 6))
sns.barplot(x=lengths, y=counts, palette="viridis")
plt.xlabel('Length of sequences (amino acids)')
plt.ylabel('sequences count')
plt.title('sequence length distribution')

# Sauvegarde de l'histogramme en barre
output_image = "sequence_length_distribution.png"
plt.savefig(output_image)

# Affichage de l'histogramme
plt.show()

# Impression du chemin de l'image sauvegardée (facultatif)
print(f"L'histogramme a été sauvegardé dans {output_image}")
