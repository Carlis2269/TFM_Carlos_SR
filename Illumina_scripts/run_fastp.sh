#!/bin/bash

input_dir=$1
output_dir=$2
mkdir -p "$output_dir"

for forward_file in "$input_dir"/*_.R1.fastq; do
	base_name=$(basename "${forward_file%_.R1.fastq}")
	reverse_file="${input_dir}/${base_name}_.R2.fastq"
	output_forward_file="${output_dir}/${base_name}_trimmed_R1.fastq"
	output_reverse_file="${output_dir}/${base_name}_trimmed_R2.fastq"
	report_file="${output_dir}/${base_name}_report.html"

	fastp -i "$forward_file" -I "$reverse_file" \
		-o "$output_forward_file" -O "$output_reverse_file" \
		--cut_front --cut_front_window_size 10 --cut_front_mean_quality 30 \
		--cut_right --cut_right_window_size 10 --cut_right_mean_quality 30 \
		--length_required 100 --qualified_quality_phred 30 \
		--html "$report_file"

done
