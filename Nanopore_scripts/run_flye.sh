#!/bin/bash

# This script performs automated assembly of nanopore reads using Flye.

input_dir=$1
output_dir=$2
mkdir -p "$output_dir"

for trimmed_file in "$input_dir"/*_trimmed.fastq; do
    base_name=$(basename "${trimmed_file%_trimmed.fastq}")
    output_subdir="${output_dir}/${base_name}"
    mkdir -p "$output_subdir"

    flye --nano-raw "$trimmed_file" \
         --out-dir "$output_subdir" \
         --threads 20 \
         --genome-size 100k

done