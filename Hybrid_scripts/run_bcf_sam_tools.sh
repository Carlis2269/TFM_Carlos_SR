#!/bin/bash

bam_dir=$1 # Directory containing BAM files
ref_dir=$2 # Directory containing reference FASTA files
output_dir=$3 # Directory to store output files

mkdir -p "$output_dir/Variants" # Create output directory for VCF files
mkdir -p "$output_dir/Coverage" # Create output directory for coverage files

for bam_file in "$bam_dir"/*.bam; do # Loop through each BAM file
    sample_tech=$(basename "$bam_file" .bam) # Get the sample name without extension
    sample_id="${sample_tech%_*}" # Extract the sample ID (everything before the first underscore)
    tech="${sample_tech#*_}" # Extract the technology (everything after the first underscore)

    ref_file="$ref_dir/Hybrid_assembly_${sample_id}.fasta" # Construct the reference file name
    vcf_out="$output_dir/Variants/${sample_tech}.vcf.gz" # Output VCF file
    depth_out="$output_dir/Coverage/${sample_tech}_depth.txt" # Output depth file
    no_cov_out="$output_dir/Coverage/${sample_tech}_no_coverage.bed" # Output no coverage file

    echo "Procesando $sample_tech (comparando con $ref_file)"

    bcftools mpileup -f "$ref_file" "$bam_file" | \
        bcftools call -mv -Ob -o "$vcf_out" # Call variants and compress the VCF file
    bcftools index "$vcf_out" # Index the VCF file

    samtools depth -a "$bam_file" > "$depth_out" # Calculate depth of coverage
    awk '$3 == 0' "$depth_out" > "$no_cov_out" # Extract regions with no coverage
done
