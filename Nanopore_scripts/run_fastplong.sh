#!/bin/bash

input_dir=$1
output_dir=$2
mkdir -p "$output_dir"

for forward_file in "$input_dir"/*.fastq; do
    base_name=$(basename "${forward_file%.fastq}")
    output_file="${output_dir}/${base_name}_trimmed.fastq"
    report_file="${output_dir}/${base_name}_report.html"

    # Aquí adaptamos el comando para usar Fastplong en lugar de Fastp
    fastplong -i "$forward_file" -o "$output_file" \
        --cut_front --cut_front_window_size 10 --cut_front_mean_quality 15 \
        --cut_tail --cut_tail_window_size 10 --cut_tail_mean_quality 15 \
        --length_required 200 --qualified_quality_phred 15 --unqualified_percent_limit 40 \
        --html "$report_file"
done