#!/bin/bash

input_dir=$1
output_dir=$2
mkdir -p "$output_dir"

for trimmed_file in "$input_dir"/*_trimmed.fastq; do
    base_name=$(basename "${trimmed_file%_trimmed.fastq}")
    output_subdir="${output_dir}/${base_name}"
    mkdir -p "$output_subdir"

    unicycler -l "$trimmed_file" -o "$output_subdir" --mode normal
done