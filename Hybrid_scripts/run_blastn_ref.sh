#!/bin/bash

# Argumentos: carpeta con .fasta y carpeta de salida
input_fasta=$1
output_dir=$2
mkdir -p "$output_dir"

# Archivo de salida único
output_file="$output_dir/blast_vs_hybrid_all.out"
> "$output_file"  # vaciar si ya existe

# Paso 1: renombrar encabezados
for file in "$input_fasta"/*.fasta; do
    base=$(basename "$file" .fasta)
    sed -i "1s/.*/>${base}/" "$file"
done

# Paso 3: Escribir encabezado de columnas de BLAST (outfmt 6)
echo -e "qseqid\tsseqid\tpident\tqstart\tqend\tsstart\tsend\tevalue\tbitscore\tlength\tmismatch\tgapopen" >> "$output_file"

# Paso 2: alinear Illumina y ONT contra su correspondiente Hybrid
for hybrid in "$input_fasta"/Hybrid_*.fasta; do
    sample=$(basename "$hybrid" .fasta | sed 's/Hybrid_assembly_//')

    for query in "$input_fasta"/*"${sample}.fasta"; do
        if [[ "$query" != "$hybrid" ]]; then
            blastn -query "$query" -subject "$hybrid" -outfmt 6 >> "$output_file"
        fi
    done
done