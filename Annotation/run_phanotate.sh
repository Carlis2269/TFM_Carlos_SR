#!/bin/bash

input_dir=$1 # Directory containing FASTA files
output_dir=$2 # Directory to store output files
mkdir -p "$output_dir" # Create output directory if it doesn't exist

for fasta_file in "$input_dir"/*.fasta; do # Loop through each FASTA file in the input directory
    base_name=$(basename "${fasta_file%.fasta}") # Extract the base name of the file (without extension)
    output_subdir="${output_dir}/${base_name}" # Create a subdirectory for each file
    mkdir -p "$output_subdir" # Create the subdirectory

    phanotate.py "$fasta_file" > "${output_subdir}/${base_name}_phanotate.gff" # Run Phanotate and save the output in GFF format
done
