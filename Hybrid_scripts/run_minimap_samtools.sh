#!/bin/bash

base_dir=$1
output_dir=$2

mkdir -p "$output_dir"

ref_dir="$base_dir/Hybrid/Unicycler_assemblies"
illumina_dir="$base_dir/Illumina/Unicycler_assemblies"
nanopore_dir="$base_dir/Nanopore/Unicycler_assemblies"

for sample_path in "$ref_dir"/*; do
    sample_name=$(basename "$sample_path")
    ref_file="$sample_path/assembly.fasta"

    for tech in Illumina Nanopore; do
        query_dir="$base_dir/$tech/Unicycler_assemblies/$sample_name"
        query_file="$query_dir/assembly.fasta"

        if [[ -f "$query_file" ]]; then
            echo "Alineando muestra $sample_name con $tech vs híbrido"
            sam_out="$output_dir/${sample_name}_${tech}.sam"
            bam_out="$output_dir/${sample_name}_${tech}.bam"

            minimap2 -a "$ref_file" "$query_file" > "$sam_out"
            samtools view -Sb "$sam_out" | samtools sort -o "$bam_out"
            samtools index "$bam_out"
            rm "$sam_out"
        else
            echo "Archivo faltante: $query_file"
        fi
    done
done
