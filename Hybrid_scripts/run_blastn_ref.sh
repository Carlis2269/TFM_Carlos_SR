#!/bin/bash

input_fasta=$1 # Directory containing the input FASTA files
output_dir=$2 # Directory to store the output files
mkdir -p "$output_dir" # Create output directory if it doesn't exist

output_file="$output_dir/blast_vs_hybrid_all.out" # Output file for BLAST results
> "$output_file"

for file in "$input_fasta"/*.fasta; do # Loop through each FASTA file
    base=$(basename "$file" .fasta) # Get the base name of the file
    sed -i "1s/.*/>${base}/" "$file" # Change the first line to the base name
done

echo -e "qseqid\tsseqid\tpident\tqstart\tqend\tsstart\tsend\tevalue\tbitscore\tlength\tmismatch\tgapopen" >> "$output_file" # Add header to the output file

for hybrid in "$input_fasta"/Hybrid_*.fasta; do # Loop through each hybrid assembly file
    sample=$(basename "$hybrid" .fasta | sed 's/Hybrid_assembly_//') # Extract the sample name

    for query in "$input_fasta"/*"${sample}.fasta"; do # Loop through each query file
        if [[ "$query" != "$hybrid" ]]; then # Ensure the query file is not the same as the hybrid file
            blastn -query "$query" -subject "$hybrid" -outfmt 6 >> "$output_file"  # Perform BLAST and append results to the output file
        fi
    done
done