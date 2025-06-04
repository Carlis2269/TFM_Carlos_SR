#!/bin/bash

# This script generates plots for each FASTQ file in the specified directory using NanoPlot.
# It also creates a html report for each sample.

input_dir=$1 # Directory containing FASTQ files
output_dir=$2 # Directory to save plots
mkdir -p "$output_dir" # Create output directory if it doesn't exist

for fastq_file in "$input_dir"/*.fastq; do # Loop through each FASTQ file
    sample_name=$(basename "${fastq_file%.fastq}") # Extract sample name
    sample_subdir="${output_dir}/${sample_name}" # Create subdirectory for each sample
    mkdir -p "$sample_subdir" # Create subdirectory

    # Generate NanoPlot

    NanoPlot --threads 8 --fastq "$fastq_file" -o "$sample_subdir" \
             --drop_outliers --minlength 100 --loglength --dpi 300 --format png
done