# This script calculates the number of CDS and hypothetical proteins from .gff files

import os
import csv

# Base directory where the annotator folders are located
base_dir = "/mnt/c/Users/Carlos/Documents/Sequences/Annotation/Results"

# List of annotators
annotators = ["Pharokka", "Phold", "Prokka"]

# List to store the records
records = []

# Iterate over each annotator and its corresponding .gff files
for annotator in annotators:  # Loop through each annotator
    annotator_dir = os.path.join(base_dir, annotator)  # Construct the path to the annotator's directory
    for file in os.listdir(annotator_dir):  # List all files in the annotator's directory
        if file.endswith(".gff"):
            genome = os.path.splitext(file)[0]  # Extract genome name from the file name
            filepath = os.path.join(annotator_dir, file)  # Construct the full path to the .gff file

            total_cds = 0  # CDS counter
            hypo_count = 0  # Hypothetical protein counter

            with open(filepath) as f:  # Open the .gff file
                for line in f:  # Iterate through each line in the file
                    if line.startswith("#"):  # Skip comment lines
                        continue
                    fields = line.strip().split("\t")  # Split the line into fields using tab as a delimiter
                    if len(fields) < 9:  # Check if there are enough fields
                        continue
                    feature = fields[2].lower()  # Get feature from the third column
                    attributes = fields[8].lower()  # Get attributes from the ninth column

                    if feature == "cds":  # Check if the feature is CDS
                        total_cds += 1  # Increment CDS counter
                        if ("hypothetical protein" in attributes) or ("product=hypothetical" in attributes):  # Check for hypothetical protein
                            hypo_count += 1  # Increment hypothetical protein counter

            if total_cds > 0:  # If there are CDS entries, calculate the percentage
                hypo_pct = 100 * hypo_count / total_cds  # Calculate the percentage of hypothetical proteins
            else:  # If there are no CDS entries
                hypo_pct = 0.0 # Set percentage to 0.0

            # Store the results in a dictionary
            records.append({
                "Genome": genome,
                "Annotator": annotator,
                "CDS_Count": total_cds,
                "Hypothetical_Count": hypo_count,
                "Hypothetical_%": hypo_pct
            })

# Save the results to a CSV file
output_csv = "/mnt/c/Users/Carlos/Documents/Sequences/Annotation/Results/summary_cds.csv"  # Output CSV file path
os.makedirs(os.path.dirname(output_csv), exist_ok=True)  # Ensure the output directory exists

with open(output_csv, mode="w", newline='') as file:  # Open the output CSV file for writing
    writer = csv.DictWriter(file, fieldnames=["Genome", "Annotator", "CDS_Count", "Hypothetical_Count", "Hypothetical_%"])  # Create a CSV writer object
    writer.writeheader()  # Write the header row
    writer.writerows(records)  # Write all records to the CSV file
