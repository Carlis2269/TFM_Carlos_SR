#!/bin/bash

# Prodigal annotation script on Normal mode

input_dir=$1
output_dir=$2

mkdir -p "$output_dir"

for fasta_file in "$input_dir"/*.fasta; do
    base_name=$(basename "${fasta_file%.fasta}")
    output_subdir="${output_dir}/${base_name}"
    mkdir -p "$output_subdir"

    # GenBank output
    prodigal -i "$fasta_file" \
             -o "${output_subdir}/${base_name}_genes.gbk" \
             -a "${output_subdir}/${base_name}_proteins.faa" \
             -d "${output_subdir}/${base_name}_mrnas.fna" \
             -s "${output_subdir}/${base_name}_starts.txt" \
             -f gbk -p meta

    # GFF output
    prodigal -i "$fasta_file" \
             -o "${output_subdir}/${base_name}_genes.gff" \
             -f gff -p meta

    # Now perform BLAST for protein sequences
    blastp -query "${output_subdir}/${base_name}_proteins.faa" \
           -db /home/shuri/TFM_Carlos_SR/dbs/viruses/ref_viruses_rep_genomes \
           -out "${output_subdir}/${base_name}_blast_results.txt" \
           -outfmt 6 \
           -evalue 1e-5 \
           -max_target_seqs 5

done