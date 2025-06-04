#!/bin/bash

# This script runs Pharokka on all FASTA files in a specified input directory.

input_dir=$1 # Directory containing input FASTA files
output_dir=$2 # Directory to save output files
db_dir=/home/shuri/TFM_Carlos_SR/Annotation/pharokka_db # Directory containing the pharokka database

mkdir -p "$output_dir" # Create output directory if it doesn't exist

for fasta_file in "$input_dir"/*.fasta; do # Loop through each FASTA file in the input directory
    base_name=$(basename "${fasta_file%.fasta}") # Extract the base name of the file (without extension)
    output_subdir="${output_dir}/${base_name}" # Create a subdirectory for the output files
    mkdir -p "$output_subdir" # Create the subdirectory if it doesn't exist

    pharokka.py -i "$fasta_file" -o "$output_subdir" -d "$db_dir" -t 20 --prefix "$base_name" --force # Run pharokka with the specified parameters

done
