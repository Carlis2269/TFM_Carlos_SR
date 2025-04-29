#!/bin/bash

input_dir=$1
output_dir=$2
mkdir -p "$output_dir"

for trimmed_file in "$input_dir"/*_trimmed.fastq; do
    base_name=$(basename "${trimmed_file%_trimmed.fastq}")
    output_subdir="${output_dir}/${base_name}"
    mkdir -p "$output_subdir"

    echo "========================================"
    echo "Iniciando ensamblado de: $base_name"
    echo "Archivo: $trimmed_file"
    echo "Carpeta de salida: $output_subdir"
    echo "========================================"

    canu -p "$base_name" -d "$output_subdir" \
         genomeSize=100k \
         -nanopore-raw "$trimmed_file" \
         useGrid=false \
         maxMemory=8 \
         maxThreads=20

    if [ $? -eq 0 ]; then
        echo "Ensamblado completado con éxito para $base_name"
    else
        echo "Error en el ensamblado de $base_name"
    fi

    echo
done
