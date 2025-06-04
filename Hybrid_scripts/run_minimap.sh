#!/bin/bash

# This script aligns sequencing data from different technologies (Illumina and ONT) against a hybrid assembly reference using minimap2.

seq_dir=$1 # Directory containing the sequence files
output_dir=$2 # Directory to store the output files

mkdir -p "$output_dir" # Create output directory if it doesn't exist

for ref_file in "$seq_dir"/Hybrid_assembly_*.fasta; do # Loop through each reference file
    sample_id=$(basename "$ref_file" | sed 's/Hybrid_assembly_\(.*\)\.fasta/\1/') # Extract sample ID from filename

    for tech in Illumina ONT; do # Loop through each sequencing technology
        query_file="$seq_dir/${tech}_assembly_${sample_id}.fasta" # Construct the query file name

        if [[ -f "$query_file" ]]; then # Check if the query file exists
        
            echo "Alineando muestra $sample_id ($tech vs Hybrid)" 
            sam_out="$output_dir/${sample_id}_${tech}.sam" # Output SAM file
            bam_out="$output_dir/${sample_id}_${tech}.bam" # Output BAM file

            minimap2 -a "$ref_file" "$query_file" > "$sam_out" # Run minimap2 to align the query to the reference
            samtools view -S -b "$sam_out" | samtools sort -o "$bam_out" # Convert SAM to sorted BAM
            samtools index "$bam_out" # Index the BAM file
        else
            echo "Archivo faltante: $query_file"
        fi
    done
done
