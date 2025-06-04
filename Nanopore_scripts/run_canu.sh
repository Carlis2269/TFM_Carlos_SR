#!/bin/bash

# This script runs Canu for assembly of nanopore reads.

input_dir=$1 # Directory containing trimmed fastq files
output_dir=$2 # Directory to store the assembly results
mkdir -p "$output_dir" # Create the output directory if it doesn't exist

for trimmed_file in "$input_dir"/*_trimmed.fastq; do # Loop through each trimmed fastq file
    base_name=$(basename "${trimmed_file%_trimmed.fastq}") # Extract the base name without the "_trimmed.fastq" suffix
    output_subdir="${output_dir}/${base_name}" # Create a subdirectory for each assembly
    mkdir -p "$output_subdir" # Create the subdirectory for the current assembly

    echo "========================================"
    echo "Iniciando ensamblado de: $base_name"
    echo "Archivo: $trimmed_file"
    echo "Carpeta de salida: $output_subdir"
    echo "========================================"

    # Run Canu for assembly
    # The genome size is set to 100k for phage assembly

    canu -p "$base_name" -d "$output_subdir" \
         genomeSize=100k \
         -nanopore "$trimmed_file"

    if [ $? -eq 0 ]; then
        echo "Ensamblado completado con éxito para $base_name"
    else
        echo "Error en el ensamblado de $base_name"
    fi

    echo
done
