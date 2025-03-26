#!/bin/bash

input_dir=$1
output_dir=$2
mkdir -p "$output_dir"

for fastq_file in "$input_dir"/*.fastq; do
    nanoQC "$fastq_file" -o "$output_dir"
done