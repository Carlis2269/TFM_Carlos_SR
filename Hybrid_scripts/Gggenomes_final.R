
# This script generates a gggenomes plot to visualize the alignments of ONT and Illumina sequences against hybrid sequences.
# It reads the sequence data and alignment results, processes them, and creates a plot with gggenomes.

# Load necessary libraries

library(gggenomes)
library(dplyr)
library(forcats)
library(readr)
library(viridis)
library(svglite)

# Function to read sequences from a FASTA file

seqs_Illumina_S2 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S2.fasta")
seqs_ONT_S2 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S2.fasta")
seqs_Hybrid_S2 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S2.fasta")

seqs_Illumina_S8 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S8.fasta")
seqs_ONT_S8 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S8.fasta")
seqs_Hybrid_S8 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S8.fasta")

seqs_Illumina_S12 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S12.fasta")
seqs_ONT_S12 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S12.fasta")
seqs_Hybrid_S12 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S12.fasta")

seqs_Illumina_S15 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S15.fasta")
seqs_ONT_S15 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S15.fasta")
seqs_Hybrid_S15 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S15.fasta")

seqs_Illumina_S19 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S19.fasta")
seqs_ONT_S19 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S19.fasta")
seqs_Hybrid_S19 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S19.fasta")

seqs_Illumina_S21 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S21.fasta")
seqs_ONT_S21 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S21.fasta")
seqs_Hybrid_S21 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S21.fasta")

seqs_Illumina_S22 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S22.fasta")
seqs_ONT_S22 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S22.fasta")
seqs_Hybrid_S22 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S22.fasta")

seqs_Illumina_S22 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S22.fasta")
seqs_ONT_S22 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S22.fasta")
seqs_Hybrid_S22 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S22.fasta")

seqs_Illumina_S24 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S24.fasta")
seqs_ONT_S24 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S24.fasta")
seqs_Hybrid_S24 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S24.fasta")

seqs_Illumina_S25 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S25.fasta")
seqs_ONT_S25 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S25.fasta")
seqs_Hybrid_S25 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S25.fasta")

seqs_Illumina_S28 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S28.fasta")
seqs_ONT_S28 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S28.fasta")
seqs_Hybrid_S28 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S28.fasta")

seqs_Illumina_S31 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S31.fasta")
seqs_ONT_S31 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S31.fasta")
seqs_Hybrid_S31 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S31.fasta")

seqs_Illumina_S44 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Illumina_assembly_S44.fasta")
seqs_ONT_S44 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/ONT_assembly_S44.fasta")
seqs_Hybrid_S44 <- read_seqs("C:/Users/Carlos/Documents/Sequences/Alignments/Seq_4_alignment_reordered/Hybrid_assembly_S44.fasta")

# Combine all sequences into a single data frame

seqs <- bind_rows(
  seqs_Illumina_S2, seqs_ONT_S2, seqs_Hybrid_S2,
  seqs_Illumina_S8, seqs_ONT_S8, seqs_Hybrid_S8,
  seqs_Illumina_S12, seqs_ONT_S12, seqs_Hybrid_S12,
  seqs_Illumina_S15, seqs_ONT_S15, seqs_Hybrid_S15,
  seqs_Illumina_S19, seqs_ONT_S19, seqs_Hybrid_S19,
  seqs_Illumina_S21, seqs_ONT_S21, seqs_Hybrid_S21,
  seqs_Illumina_S22, seqs_ONT_S22, seqs_Hybrid_S22,
  seqs_Illumina_S24, seqs_ONT_S24, seqs_Hybrid_S24,
  seqs_Illumina_S25, seqs_ONT_S25, seqs_Hybrid_S25,
  seqs_Illumina_S28, seqs_ONT_S28, seqs_Hybrid_S28,
  seqs_Illumina_S31, seqs_ONT_S31, seqs_Hybrid_S31,
  seqs_Illumina_S44, seqs_ONT_S44, seqs_Hybrid_S44
)

# Read the links (alignment results) from a TSV file

links <- read_tsv("C:/Users/Carlos/Documents/Sequences/Alignments/Blast_results_reordered/blast_vs_hybrid_all.out", col_names = TRUE)

# Ensure the links data has the correct column names
colnames(links) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen",
                     "qstart", "qend", "sstart", "send", "evalue", "bitscore")

# Process the links data to prepare it for gggenomes

links_gg <- links %>%
  mutate(
    query = gsub(".fasta", "", qseqid),
    subject = gsub(".fasta", "", sseqid),
    sample = case_when(
      grepl("S8", query) ~ "S8",
      grepl("S12", query) ~ "S12",
      grepl("S15", query) ~ "S15",
      grepl("S19", query) ~ "S19",
      grepl("S21", query) ~ "S21",
      grepl("S22", query) ~ "S22",
      grepl("S24", query) ~ "S24",
      grepl("S25", query) ~ "S25",
      grepl("S28", query) ~ "S28",
      grepl("S2", query) ~ "S2",
      grepl("S31", query) ~ "S31",
      grepl("S44", query) ~ "S44",
      TRUE ~ "Otro"
    ),
    tech = case_when(
      grepl("Illumina", query) ~ "Illumina",
      grepl("ONT", query) ~ "ONT",
      TRUE ~ "Otro"
    ),
    qstart2 = pmin(qstart, qend),
    qend2 = pmax(qstart, qend),
    sstart2 = pmin(sstart, send),
    send2 = pmax(sstart, send)
  ) %>%
  rename(
    seq_id = query,
    seq_id2 = subject,
    start = qstart2,
    end = qend2,
    start2 = sstart2,
    end2 = send2
  ) %>%
  filter(grepl("Hybrid", seq_id2)) 

# Prepare the sequences data for gggenomes
seqs <- seqs %>%
  mutate(
    file_id = gsub(".fasta", "", file_id), 
    genome = file_id,
    sample = case_when(
      grepl("S44", genome) ~ "S44",
      grepl("S31", genome) ~ "S31",
      grepl("S28", genome) ~ "S28",
      grepl("S25", genome) ~ "S25",
      grepl("S24", genome) ~ "S24",
      grepl("S22", genome) ~ "S22",
      grepl("S21", genome) ~ "S21",
      grepl("S19", genome) ~ "S19",
      grepl("S15", genome) ~ "S15",
      grepl("S12", genome) ~ "S12",
      grepl("S8", genome)  ~ "S8",
      grepl("S2", genome)  ~ "S2",
      TRUE ~ "Otro"
    ),
    tech = case_when(
      grepl("Hybrid", genome) ~ "Hybrid",
      grepl("ONT", genome) ~ "ONT",
      grepl("Illumina", genome) ~ "Illumina",
      TRUE ~ "Otro"
    )
  )

# Ensure the seqs data has the correct column names for gggenomes
seqs <- seqs %>%
  mutate(seq_label = case_when(
    grepl("Illumina", genome) ~ "Illumina",
    grepl("ONT", genome) ~ "ONT",
    grepl("Hybrid", genome) ~ "Hybrid",
    TRUE ~ genome
  ))

seqs <- seqs %>%
  arrange(sample, factor(tech, levels = c("Illumina", "Hybrid", "ONT"))) %>%
  mutate(seq_id = factor(file_id, levels = unique(file_id)))

# Create the gggenomes plot

p <- gggenomes(seqs = seqs, links = links_gg, adjacent_only = FALSE) +
  geom_seq(aes(color = tech), linewidth = 2) +
  geom_seq_label(aes(label = seq_label), size = 3) +
  geom_link(aes(color = tech)) +
  facet_wrap(~sample, scales = "free_y", ncol = 1) +
  scale_color_viridis_d(
    name = "Technology",
    option = "B", begin = 0.2, end = 0.8
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.title.x = element_text(size = 25, face = "bold"),
    axis.title.y = element_text(size = 25, face = "bold"),
    legend.text = element_text(size = 20),
    legend.title = element_text(size = 25, face = "bold"),
    plot.title = element_text(size = 35, face = "bold", hjust = 0.5),
    strip.text = element_text(face = "bold", size = 20)
  ) +
  labs(
    title = "ONT and Illumina alignments against hybrid sequence",
    x = "Genome lenght",
    y = NULL
  )

# Save the plot as an SVG file
ggsave(
  file.path("C:/Users/Carlos/Documents/Sequences/Alignments/", "gggenomes_alignments_fill.svg"),
  plot = p,
  width = 20,
  height = 30 
)
