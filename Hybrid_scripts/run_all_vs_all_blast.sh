#!/bin/bash

input_fasta=$1
output_dir=$2
mkdir -p "$output_dir"

output_file="$output_dir/all_vs_all.o6"

for file1 in "$input_fasta"/*.fasta; do
    for file2 in "$input_fasta"/*.fasta; do
        blastn -query "$file1" -subject "$file2" -outfmt 6 >> "$output_file"
    done
done