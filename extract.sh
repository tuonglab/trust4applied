#!/bin/bash

extract_dir="/home/uqsdemon/resultsTrust4F"
# dans ce dossier il existe plein de dossiers de la forme suivante 
# /home/uqsdemon/resultsTrust4F/01-0051_409375_T_R_22HM3TLT3_TCAGAAGGCG-GGCCATCATA/01-0051_409375_T_R_22HM3TLT3_TCAGAAGGCG-GGCCATCATA_R1
# /home/uqsdemon/resultsTrust4F/01-0079_406620_T_R_H2JTNDSXC_CTCGTAGGCA-AAGAGGATGA/01-0079_406620_T_R_H2JTNDSXC_CTCGTAGGCA-AAGAGGATGA_R1
# /home/uqsdemon/resultsTrust4F/P001601_339699_HFHFJDSX2_TCTCACACGC-TCACTGTCCG/P001601_339699_HFHFJDSX2_TCTCACACGC-TCACTGTCCG_R1
# /home/uqsdemon/resultsTrust4F/P003006_339933_HFHFJDSX2_GAACGCAATA-ACAGTAAGAT/P003006_339933_HFHFJDSX2_GAACGCAATA-ACAGTAAGAT_R1

# dans ces dossiers on retrouve plusieurs fichiers, 
#TRUST_01-0051_409375_T_R_22HM3TLT3_TCAGAAGGCG-GGCCATCATA_R1_annot.fa
#TRUST_01-0051_409375_T_R_22HM3TLT3_TCAGAAGGCG-GGCCATCATA_R1_assembled_reads.fa
#TRUST_01-0051_409375_T_R_22HM3TLT3_TCAGAAGGCG-GGCCATCATA_R1_cdr3.out
#TRUST_01-0051_409375_T_R_22HM3TLT3_TCAGAAGGCG-GGCCATCATA_R1_final.out
#TRUST_01-0051_409375_T_R_22HM3TLT3_TCAGAAGGCG-GGCCATCATA_R1_raw.out
#TRUST_01-0051_409375_T_R_22HM3TLT3_TCAGAAGGCG-GGCCATCATA_R1_report.tsv
#TRUST_01-0051_409375_T_R_22HM3TLT3_TCAGAAGGCG-GGCCATCATA_R1_toassemble_1.fq
#TRUST_01-0051_409375_T_R_22HM3TLT3_TCAGAAGGCG-GGCCATCATA_R1_toassemble_2.fq
# il faut donc récupérer uniquement le fichier report.tsv pour chaque dossier le copier ici :
output_direx="/QRISdata/Q7250/zero_extracted"
# puis dans ce fichier qui est composé d'un ensemble de lignes 
# count	frequency	CDR3nt	CDR3aa	V	D	J	C	cid	cid_full_length
#142	4.653240e-02	TGTCAGAAAGCCTGAGGAAGGAGGCAGCTGTGCTGG	CQKA_GRRQLCW	IGHV1-46	.	.	.	assemble38	0
#80	3.245410e-02	TGCCAACAGTATAATAGTTACCCCACTTTT	CQQYNSYPTF	IGKV1-5	.	IGKJ2	IGKC	assemble865	0
#64	5.569007e-02	TGTGCCAGCAGCTTAAAGGGGCAGCCCCAGCATTTT	CASSLKGQPQHF	TRBV7-3	.	TRBJ1-5	TRBC	assemble362	1
#53	1.729156e-02	TGTGCACACAGCGTCGGGCCTGATGATGGTTTTGATATCTGG	CAHSVGPDDGFDIW	IGHV2-5	.	IGHJ3	IGHG1	assemble171	0
#50	2.062864e-02	TGTCAACAGGCTAACAGTTTCCCTCTCACTTTC	CQQANSFPLTF	IGKV1-12	.	IGKJ4	IGKC	assemble11	0
#46	3.977862e-02	TGTGCCAGCCACCTGGGGGGGAACGGGGAGCTGTTTTTT	CASHLGGNGELFF	TRBV6-5	.	TRBJ2-2	TRBC	assemble1221	1
# il faut récupérer uniquement les colonnes CDR3aa et V pour les lignes dont les V est un TRB 

# Naviguer dans le répertoire extract_dir
#!/bin/bash

# Naviguer dans le répertoire extract_dir
cd "$extract_dir"

# Trouver tous les fichiers report.tsv et traiter chaque fichier
find . -name "*report.tsv" -print0 | while IFS= read -r -d $'\0' file; do
    # Extraire le nom du dossier parent pour nommer le fichier de sortie
    parent_dir=$(basename "$(dirname "$file")")
    output_file="${output_direx}/${parent_dir}_extracted.tsv"
    
    # Filtrer les lignes avec TRB dans la colonne V, extraire les colonnes CDR3aa et V,
    # et exclure les lignes contenant "out_of_range" ou "?" dans la colonne 4
    awk -F '\t' '$5 ~ /TRB/ && $4 !~ /out_of_frame/ && $4 !~ /\?/ {print $4 "\t" $5}' "$file" > "$output_file"
done

echo "Extraction terminée."
