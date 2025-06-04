#!/bin/bash

# This script runs bcftools stats on VCF files and generates plots using plot-vcfstats.

vcf_dir=$1     # Directory with VCF files
ref_dir=$2     # Directory with hybrid reference FASTAs
output_dir=$3  # Output directory for stats

mkdir -p "$output_dir"

for vcf_file in "$vcf_dir"/*.vcf.gz; do
    sample_tech=$(basename "$vcf_file" .vcf.gz)
    sample_id="${sample_tech%_*}"
    tech="${sample_tech#*_}"

    ref_file="$ref_dir/Hybrid_assembly_${sample_id}.fasta"
    stats_out="$output_dir/${sample_tech}.stats.txt"
    plot_dir="$output_dir/${sample_tech}_plots"

    echo "Generando stats para $sample_tech con referencia $ref_file"
    
    mkdir -p "$plot_dir"
    bcftools stats -F "$ref_file" -s - "$vcf_file" > "$stats_out"
    plot-vcfstats -p "$plot_dir" "$stats_out"
done
