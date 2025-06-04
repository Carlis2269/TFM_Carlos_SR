#!/bin/bash

# This script runs Unicycler on a set of trimmed fastq files.
# When used with the ONT data alone, it assembles the reads using a Miniasm + Racon pipeline.

input_dir=$1 # Directory containing trimmed fastq files
output_dir=$2 # Directory to store Unicycler output
mkdir -p "$output_dir" # Create output directory if it doesn't exist

for trimmed_file in "$input_dir"/*_trimmed.fastq; do # Loop through each trimmed fastq file
    base_name=$(basename "${trimmed_file%_trimmed.fastq}") # Extract base name without extension
    output_subdir="${output_dir}/${base_name}" # Create a subdirectory for each sample
    mkdir -p "$output_subdir" # Create the subdirectory

    unicycler -l "$trimmed_file" -o "$output_subdir" --mode bold # Run Unicycler with the trimmed fastq file
done