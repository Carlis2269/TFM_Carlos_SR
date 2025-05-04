#!/bin/bash

input_dir=$1 # Directory containing GenBank files
output_dir=$2 # Directory to store output

mkdir -p "$output_dir" # Create output directory if it doesn't exist

for gbk_file in "$input_dir"/*.gbk; do # Loop through each GenBank file
    base_name=$(basename "${gbk_file%.gbk}") # Get the base name without extension
    output_subdir="${output_dir}/${base_name}" # Create a subdirectory for each file
    mkdir -p "$output_subdir" # Create the subdirectory

    phold run -i "$gbk_file" -o "$output_subdir" -t 20 --force # Run phold with the specified parameters
done
