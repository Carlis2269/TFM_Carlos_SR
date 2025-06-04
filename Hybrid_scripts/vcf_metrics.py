# This script processes variant statistics and coverage data to generate a summary CSV file.

import os
import sys
import pandas as pd

stats_dir = sys.argv[1]  # Directory containing .stats.txt files
coverage_dir = sys.argv[2]  # Directory containing coverage files
output_file = sys.argv[3]  # Output CSV file

summary = [] # List to hold summary data

for filename in os.listdir(coverage_dir): # Iterate through files in the coverage directory
    if not filename.endswith("_depth.txt"): # Skip files that do not end with _depth.txt
        continue

    base = filename.replace("_depth.txt", "") # Remove the suffix to get the base name
    try:
        sample, tech = base.split("_", 1) # Split the base name into sample and technology
    except ValueError:
        continue

    depth_file = os.path.join(coverage_dir, filename) # Full path to the depth file
    stats_file = os.path.join(stats_dir, f"{sample}_{tech}.stats.txt") # Full path to the stats file

    # Extract SNPs and indels from stats file
    snps = 0 # Initialize SNP count
    indels = 0 # Initialize indel count
    if os.path.exists(stats_file): # Check if the stats file exists
        with open(stats_file) as f: # Open the stats file
            for line in f: # Iterate through each line in the stats file
                if line.startswith("SN"): # Check if the line starts with "SN"
                    if "number of SNPs:" in line: # Check for SNPs
                        snps = int(line.strip().split()[-1]) # Extract SNP count
                    elif "number of indels:" in line: # Check for indels
                        indels = int(line.strip().split()[-1]) # Extract indel count

    # Calculate average coverage
    avg_cov = 0 # Initialize average coverage
    total_positions = 0 # Initialize total positions
    with open(depth_file) as f: # Open the depth file
        for line in f: # Iterate through each line in the depth file
            fields = line.strip().split("\t") # Split the line into fields
            if len(fields) == 3: # Check if there are exactly 3 fields
                try: # Try to convert the coverage value to an integer
                    cov = int(fields[2]) # Extract the coverage value
                    avg_cov += cov # Add to average coverage
                    total_positions += 1 # Increment total positions
                except ValueError: 
                    continue
    avg_cov = round(avg_cov / total_positions, 2) if total_positions > 0 else None # Calculate average coverage

    # Append the summary data for the current sample and technology
    summary.append({
        "Sample": sample,
        "Technology": tech,
        "SNPs": snps,
        "Indels": indels,
        "Total_Variants": snps + indels,
        "AvgCoverage": avg_cov,
    })

df = pd.DataFrame(summary) # Create a DataFrame from the summary list
df = df.sort_values(by=["Sample", "Technology"]) # Sort the DataFrame by Sample and Technology
df.to_csv(output_file, index=False) # Save the DataFrame to a CSV file
