#!/bin/bash

input_base_dir="/mnt/d/Documentos/PhageSeq2024/Unicycler_assemblies"
output_base_dir="/mnt/d/Documentos/PhageSeq2024/Blast_results"
max_hits=10

mkdir -p "$output_base_dir"

for dir in "$input_base_dir"/*; do
	if [ -d "$dir" ]; then
		base_name=$(basename "$dir")
		input_fasta="$dir/assembly.fasta"
		output_file="$output_base_dir/blast_results_${base_name}.out"

		if [ -f "$input_fasta" ]; then
			blastn -query "$input_fasta" -db nt -remote -out "$output_file" \
				-outfmt "6 qacc sacc pident qcovs length evalue bitscore" \
				-max_target_seqs "$max_hits"
			echo "Processed $input_fasta, results saved to $output_file"
		else
			echo "No assembly.fasta found in $dir"
		fi
	fi
done
