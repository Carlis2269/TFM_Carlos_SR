#!/bin/bash

# This script runs Unicycler for hybrid assembly using Illumina and Nanopore reads.

input_dir_illumina=$1 # Directory containing Illumina reads
input_dir_nanopore=$2 # Directory containing Nanopore reads
output_dir=$3 # Directory to store Unicycler output

mkdir -p "$output_dir" # Create output directory if it doesn't exist

for forward_file in "$input_dir_illumina"/*_trimmed_R1.fastq; do # Loop through each Illumina forward read file
    base_name=$(basename "${forward_file%_trimmed_R1.fastq}") # Extract base name without the "_trimmed_R1.fastq" suffix
    reverse_file="${input_dir_illumina}/${base_name}_trimmed_R2.fastq" # Construct the corresponding reverse read file name
    longreads_file="${input_dir_nanopore}/${base_name}_trimmed.fastq" # Construct the corresponding long read file name
    output_subdir="${output_dir}/${base_name}" # Create a subdirectory for the current sample

    mkdir -p "$output_subdir" # Create the subdirectory if it doesn't exist

	unicycler -1 "$forward_file" -2 "$reverse_file" -l "$longreads_file" -o "$output_subdir" --threads 20 # Run Unicycler with the specified input files and output directory
    
done