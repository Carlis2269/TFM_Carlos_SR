#!/bin/bash

input_dir=$1 # Directory containing FASTQ files
output_dir=$2 # Directory to save FastQC reports
mkdir -p "$output_dir" # Create output directory if it doesn't exist

for fastq_file in "$input_dir"/*.fastq; do # Loop through each FASTQ file
    fastqc "$fastq_file" -o "$output_dir" --threads 8 # Run FastQC on the file
done