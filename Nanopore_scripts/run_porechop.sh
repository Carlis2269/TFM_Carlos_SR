#!/bin/bash

input_dir=$1
output_dir=$2
mkdir -p "$output_dir"

for forward_file in "$input_dir"/*.fastq; do
    base_name=$(basename "${forward_file%.fastq}")
    output_file="${output_dir}/${base_name}_trimmed.fastq"
    report_file="${output_dir}/${base_name}_report.txt"

    porechop -i "$forward_file" -o "$output_file" \
        --threads 8
done
