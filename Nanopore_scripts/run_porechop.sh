#!/bin/bash

# This script trim FASTQ files using Porechop.

input_dir=$1 # Directory containing the input FASTQ files
output_dir=$2 # Directory to save the trimmed output files
mkdir -p "$output_dir" # Create the output directory if it doesn't exist

for forward_file in "$input_dir"/*.fastq; do # Loop through each FASTQ file in the input directory
    base_name=$(basename "${forward_file%.fastq}") # Get the base name of the file without the extension
    output_file="${output_dir}/${base_name}_trimmed.fastq" # Define the output file name
    report_file="${output_dir}/${base_name}_report.txt" # Define the report file name

    # Run porechop on the input file

    porechop -i "$forward_file" -o "$output_file" \
        --threads 8
done
