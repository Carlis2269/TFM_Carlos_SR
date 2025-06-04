# This script generates bar plots to visualize the number of predicted CDS and the percentage of hypothetical proteins
# by annotator for each genome, using ggplot2 in R.

# Load necessary libraries
library(ggplot2)
library(dplyr)
library(viridis)

# Read the data from a CSV file
data <- read.csv("C:/Users/Carlos/Documents/Sequences/Annotation/Results/summary_cds.csv")

# Filter data for specific annotators
data_modif <- data[data$Annotator %in% c("Pharokka", "Prokka"), ]
# and modify the Annotator names for the name of their gene predictiors
data_modif$Annotator[data_modif$Annotator == "Pharokka"] <- "PHANOTATE"
data_modif$Annotator[data_modif$Annotator == "Prokka"] <- "Prodigal"

# Plot the number of predicted CDS by annotator for each genome
a <- ggplot(data_modif, aes(x = Genome, y = CDS_Count, fill = Annotator)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  scale_fill_manual(values = c("PHANOTATE" = "mediumaquamarine", "Prodigal" = "pink")) +
  theme_minimal() +
  labs(title = "Number of Predicted CDS per Annotator for Each Genome",
       x = "Genome", y = "CDS count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 16, margin = margin(t = 1)),
        axis.text.y = element_text(size = 16),
        axis.title.x = element_text(size = 18, face = "bold"),
        axis.title.y = element_text(size = 18, face = "bold"),
        legend.text = element_text(size = 16),
        legend.title = element_text(size = 18, face = "bold"),
        plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
        panel.grid = element_blank()
  )

# Save the plot as a SVG file
ggsave(
  file.path("C:/Users/Carlos/Documents/Sequences/Annotation/", "ggplot_CDS.svg"),
  plot = a,
  width = 10,
  height = 15
)

# Plot the percentage of hypothetical proteins by annotator for each genome
b <- ggplot(data, aes(x = Genome, y = Hypothetical_., fill = Annotator)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  scale_fill_manual(values = c("Pharokka" = "lightsalmon", "Phold" = "plum", "Prokka" = "khaki")) +
  theme_minimal() +
  labs(title = "Percentage of Hypothetical Proteins per Annotator for Each Genome",
       x = "Genome", y = "Percentage of Hypothetical Proteins") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 16, margin = margin(t = 1)),
        axis.text.y = element_text(size = 16),
        axis.title.x = element_text(size = 18, face = "bold"),
        axis.title.y = element_text(size = 18, face = "bold"),
        legend.text = element_text(size = 16),
        legend.title = element_text(size = 18, face = "bold"),
        plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
        panel.grid = element_blank()
  )
# Save the plot as a SVG file
ggsave(
  file.path("C:/Users/Carlos/Documents/Sequences/Annotation/", "ggplot_Hyp_prot.tiff"),
  plot = b,
  width = 10, 
  height = 15 
)