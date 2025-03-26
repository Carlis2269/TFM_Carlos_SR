#!/bin/bash

input_dir=$1
output_dir=$2
mkdir -p "$output_dir"

for forward_file in "$input_dir"/*_trimmed_R1.fastq; do
	base_name=$(basename "${forward_file%_trimmed_R1.fastq}")
	reverse_file="${input_dir}/${base_name}_trimmed_R2.fastq"
	output_subdir="${output_dir}/${base_name}"
	mkdir -p "$output_subdir"

	unicycler -1 "$forward_file" -2 "$reverse_file" -o "$output_subdir" 
    
done