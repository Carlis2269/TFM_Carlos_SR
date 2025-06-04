#!/bin/bash

# This script performs quality trimming of paired-end FASTQ files using fastp.
# It processes all files in the specified input directory that match the pattern *_R1.fastq
# and generates trimmed output files along with an HTML report for each pair.

input_dir=$1 # Directory containing the input FASTQ files
output_dir=$2 # Directory to save the trimmed output files
mkdir -p "$output_dir" # Create the output directory if it doesn't exist

for forward_file in "$input_dir"/*_.R1.fastq; do # Loop through each forward FASTQ file
	base_name=$(basename "${forward_file%_.R1.fastq}") # Extract the base name of the file
	reverse_file="${input_dir}/${base_name}_.R2.fastq" # Construct the corresponding reverse file name
	output_forward_file="${output_dir}/${base_name}_trimmed_R1.fastq" # Output file for trimmed forward reads
	output_reverse_file="${output_dir}/${base_name}_trimmed_R2.fastq" # Output file for trimmed reverse reads
	report_file="${output_dir}/${base_name}_report.html" # HTML report file

	# Run fastp for quality trimming
	fastp -i "$forward_file" -I "$reverse_file" \
		-o "$output_forward_file" -O "$output_reverse_file" \
		--cut_front --cut_front_window_size 10 --cut_front_mean_quality 30 \
		--cut_right --cut_right_window_size 10 --cut_right_mean_quality 30 \
		--length_required 100 --qualified_quality_phred 30 \
		--html "$report_file"

done
