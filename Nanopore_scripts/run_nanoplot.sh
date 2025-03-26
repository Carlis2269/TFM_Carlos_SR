#!/bin/bash

input_dir=$1
output_dir=$2
mkdir -p "$output_dir"

for fastq_file in "$input_dir"/*.fastq; do
    sample_name=$(basename "${fastq_file%.fastq}")
    sample_subdir="${output_dir}/${sample_name}"
    mkdir -p "$sample_subdir"

    NanoPlot --threads 8 --fastq "$fastq_file" -o "$sample_subdir" \
             --drop_outliers --minlength 100 --loglength --dpi 300 --format png
done