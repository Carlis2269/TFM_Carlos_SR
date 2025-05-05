#!/bin/bash

input_dir=$1 # Directory containing the input FASTA files
output_dir=$2 # Directory to save the output files

mkdir -p "$output_dir" # Create output directory if it doesn't exist

for fasta in "$input_dir"/*.fasta; do # Loop through each FASTA file in the input directory
    base=$(basename "$fasta" .fasta) # Get the base name of the file (without path and extension)
    outpath="$output_dir/$base" # Define the output path for the current file
    mkdir -p "$outpath" # Create a directory for the output files
    dnaapler phage -i "$fasta" -o "$outpath" -p "$base" -t 8 -f # Run dnaapler with the specified parameters
done