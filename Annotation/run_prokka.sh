#!/bin/bash

# Invoquing Prokka for genome annotation in Moderate

input_dir=$1 # Input directory containing FASTA files
output_dir=$2 # Output directory for Prokka results
mkdir -p "$output_dir" # Create output directory if it doesn't exist

for fasta_file in "$input_dir"/*.fasta; do # Loop through each FASTA file in the input directory
    base_name=$(basename "${fasta_file%.fasta}") # Extract the base name of the file (without extension)
    output_subdir="${output_dir}/${base_name}" # Create a subdirectory for each file in the output directory
    mkdir -p "$output_subdir" # Create the subdirectory if it doesn't exist

    prokka --outdir "$output_subdir" --prefix "$base_name" "$fasta_file" --cpus 20 --force # Run Prokka for genome annotation
done
