#!/bin/bash

input_dir_illumina=$1
input_dir_nanopore=$2
output_dir=$3
mkdir -p "$output_dir"

for forward_file in "$input_dir_illumina"/*_trimmed_R1.fastq; do
    base_name=$(basename "${forward_file%_trimmed_R1.fastq}")
    reverse_file="${input_dir_illumina}/${base_name}_trimmed_R2.fastq"
    longreads_file="${input_dir_nanopore}/${base_name}_trimmed.fastq"
    output_subdir="${output_dir}/${base_name}"
    mkdir -p "$output_subdir"

	unicycler -1 "$forward_file" -2 "$reverse_file" -l "$longreads_file" -o "$output_subdir" --threads 8
    
done