#!/bin/bash

# This script runs Unicycler for each pair of trimmed FASTQ files in a specified directory.
# When used with the Illumina data alone, it assembles the reads using an optimised SPAdes pipeline.

input_dir=$1 # Directory containing the trimmed FASTQ files
output_dir=$2 # Directory to store the Unicycler assembly results
mkdir -p "$output_dir" # Create the output directory if it doesn't exist

for forward_file in "$input_dir"/*_trimmed_R1.fastq; do # Loop through each forward FASTQ file
	base_name=$(basename "${forward_file%_trimmed_R1.fastq}") # Extract the base name 
	reverse_file="${input_dir}/${base_name}_trimmed_R2.fastq" # Construct the corresponding reverse FASTQ file name
	output_subdir="${output_dir}/${base_name}" # Create a subdirectory for each assembly

	mkdir -p "$output_subdir" # Create the output subdirectory

	unicycler -1 "$forward_file" -2 "$reverse_file" -o "$output_subdir" # Run Unicycler with the paired-end reads
    
done