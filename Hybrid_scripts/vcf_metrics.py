import os
import sys
import pandas as pd

stats_dir = sys.argv[1]  # Directory containing .stats.txt files
coverage_dir = sys.argv[2]  # Directory containing coverage files
output_file = sys.argv[3]  # Output CSV file

summary = []

for filename in os.listdir(coverage_dir):
    if not filename.endswith("_depth.txt"):
        continue

    base = filename.replace("_depth.txt", "")
    try:
        sample, tech = base.split("_", 1)
    except ValueError:
        continue

    depth_file = os.path.join(coverage_dir, filename)
    no_cov_file = os.path.join(coverage_dir, f"{sample}_{tech}_no_coverage.bed")
    stats_file = os.path.join(stats_dir, f"{sample}_{tech}.stats.txt")

    # Extract SNPs and indels from stats file
    snps = 0
    indels = 0
    if os.path.exists(stats_file):
        with open(stats_file) as f:
            for line in f:
                if line.startswith("SN"):
                    if "number of SNPs:" in line:
                        snps = int(line.strip().split()[-1])
                    elif "number of indels:" in line:
                        indels = int(line.strip().split()[-1])

    # Calculate average coverage
    avg_cov = 0
    total_positions = 0
    with open(depth_file) as f:
        for line in f:
            fields = line.strip().split("\t")
            if len(fields) == 3:
                try:
                    cov = int(fields[2])
                    avg_cov += cov
                    total_positions += 1
                except ValueError:
                    continue
    avg_cov = round(avg_cov / total_positions, 2) if total_positions > 0 else None

    # Calculate no coverage regions
    no_cov_bp = 0
    if os.path.exists(no_cov_file):
        with open(no_cov_file) as f:
            for line in f:
                fields = line.strip().split("\t")
                if len(fields) == 3:
                    try:
                        start = int(fields[1])
                        end = int(fields[2])
                        no_cov_bp += end - start
                    except ValueError:
                        continue

    no_cov_bp = max(0, no_cov_bp)
    no_cov_pct = round((no_cov_bp / total_positions) * 100, 4) if total_positions > 0 else None

    summary.append({
        "Sample": sample,
        "Technology": tech,
        "SNPs": snps,
        "Indels": indels,
        "Total_Variants": snps + indels,
        "AvgCoverage": avg_cov,
        "NoCoverage_bp": no_cov_bp,
        "NoCoverage_%": no_cov_pct,
    })

df = pd.DataFrame(summary)
df = df.sort_values(by=["Sample", "Technology"])
df.to_csv(output_file, index=False)
