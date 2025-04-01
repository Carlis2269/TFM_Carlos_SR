#!/bin/bash

input_dir=$1
output_dir=$2
mkdir -p "$output_dir"

for trimmed_file in "$input_dir"/*_trimmed.fastq; do
    base_name=$(basename "${trimmed_file%_trimmed.fastq}")
    output_subdir="${output_dir}/${base_name}"
    mkdir -p "$output_subdir"

    canu -p "$base_name" -d "$output_subdir" \
         genomeSize=4m \
         -nanopore "$trimmed_file" \
         useGrid=false \
         maxMemory=6 \
         maxThreads=8      
done