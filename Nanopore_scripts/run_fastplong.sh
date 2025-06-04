#!/bin/bash

# This script performs quality trimming of paired-end FASTQ files using fastplong.
# It processes all files in the specified input directory that match the pattern *.fastq
# and generates trimmed output files along with an HTML report for each file.

input_dir=$1 # Directory containing input FASTQ files
output_dir=$2 # Directory to save output files
mkdir -p "$output_dir" # Create output directory if it doesn't exist

for forward_file in "$input_dir"/*.fastq; do # Loop through each FASTQ file in the input directory
    base_name=$(basename "${forward_file%.fastq}") # Extract base name without extension
    output_file="${output_dir}/${base_name}_trimmed.fastq" # Define output file name
    report_file="${output_dir}/${base_name}_report.html" # Define report file name

    # Run fastplong command with specified parameters
    fastplong -i "$forward_file" -o "$output_file" \
        --cut_front --cut_front_window_size 10 --cut_front_mean_quality 10 \
        --cut_tail --cut_tail_window_size 10 --cut_tail_mean_quality 10 \
        --length_required 200 --qualified_quality_phred 10 --unqualified_percent_limit 40 \
        --html "$report_file"
done