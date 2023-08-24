#!/bin/bash

# Check if a source directory path and a destination directory path were provided as arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Please provide a source directory path and a destination directory path as arguments"
    exit 1
fi

# Set the source directory path to the first argument and the destination directory path to the second argument
src_dir="$1"
tmp_dir="$2"

mkdir -p "$tmp_dir/ireceptor"
# Copy TSV files to the destination directory, preserving the subdirectory structure
while IFS= read -r -d '' file; do
    # Get the relative path of the file within the source directory
    rel_path="${file#$src_dir/}"
    # Create the destination directory, preserving the subdirectory structure
    dest_dir="$tmp_dir/ireceptor/$(dirname "$rel_path")"
    mkdir -p "$dest_dir"
    # Copy the file to the destination directory, preserving the subdirectory structure
    cp "$file" "$dest_dir/"
done < <(find "$src_dir" -type f -name "*.tsv" ! -name "*_extracted.tsv" -print0)

# Process TSV files using awk
while IFS= read -r -d '' file; do
    outfile="${file%.tsv}_extracted.tsv"
    awk -F '\t' -v OFS='\t' 'NR==1 {
        for (i=1; i<=NF; i++) {
            if ($i=="sequence_id") c1=i;
            if ($i=="productive") c2=i;
            if ($i=="complete_vdj") c3=i;
            if ($i=="v_call") c4=i;
            if ($i=="j_call") c5=i;
            if ($i=="junction") c6=i;
            if ($i=="junction_aa") c7=i;
            if ($i=="consensus_count") c8=i;
            if ($i=="duplicate_count") c9=i
        }
        seq_id=0
        print "sequence_id", "productive", "complete_vdj", "v_call", "j_call", "junction", "junction_aa", "consensus_count", "duplicate_count"
    }
    NR>1 {
        if ($c1=="" || $c1=="NULL") {
            seq_id++;
            $c1=seq_id
        }
        if (substr($c7,1,1)=="C" && (substr($c7,length($c7),1)=="F" || substr($c7,length($c7),1)=="W")) {
            print $c1, $c2, $c3, $c4, $c5, $c6, $c7, $c8, $c9
        }
    }' "$file" > "$outfile"
    # Copy the output file back to its original directory, preserving the subdirectory structure
    cp "$outfile" "$(dirname "${file/#$tmp_dir\/ireceptor/$src_dir}")/"
done < <(find "$tmp_dir/ireceptor" -name "*.tsv" ! -name "*_extracted.tsv" -print0)
