#!/bin/bash

input_dir=$1 # Directory containing FASTQ files
output_dir=$2 # Directory to save NanoQC reports
mkdir -p "$output_dir" # Create output directory if it doesn't exist

for fastq_file in "$input_dir"/*.fastq; do # Loop through each FASTQ file
    nanoQC "$fastq_file" -o "$output_dir" # Run NanoQC on the FASTQ file
done