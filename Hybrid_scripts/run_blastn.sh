#!/bin/bash

input_base_dir=$1 # Directory containing subdirectories with assembly.fasta files
output_base_dir=$2 # Directory to store BLAST results

blast_db_path="/home/shuri/TFM_Carlos_SR/dbs/viruses/ref_viruses_rep_genomes" # Path to the BLAST database
max_hits=1 # Maximum number of hits to report

mkdir -p "$output_base_dir" # Create output directory if it doesn't exist

for dir in "$input_base_dir"/*; do # Check each subdirectory
    if [ -d "$dir" ]; then # Ensure it's a directory
        base_name=$(basename "$dir") # Get the base name of the directory
        input_fasta="$dir/assembly.fasta" # Path to the assembly.fasta file
        renamed_fasta="$dir/assembly_renamed.fasta" # Path to the renamed assembly.fasta file
        output_file="$output_base_dir/blast_results_${base_name}.out" # Path to the output file

        if [ -f "$input_fasta" ]; then # Check if the assembly.fasta file exists

            awk -v sample="$base_name" '/^>/{header++ ; print ">"sample"_contig"header; next} 1' "$input_fasta" > "$renamed_fasta" # Rename the sequences in the assembly.fasta file

            echo "Ejecutando BLAST para $base_name..." 

            # Perform BLAST search

            blastn -query "$renamed_fasta" -db "$blast_db_path" \
                -out "$output_file" \
                -outfmt "6 qacc ssciname sacc pident qcovs length evalue" \
                -max_target_seqs "$max_hits"

            echo "Procesado $input_fasta, resultados en $output_file"
        else
            echo "No se encontró assembly.fasta en $dir"
        fi
    fi
done

touch "$output_base_dir/completed.flag"