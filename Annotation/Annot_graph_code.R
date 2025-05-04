# Cargar las librerias necesarias
library(ggplot2)
library(dplyr)
library(viridis)

# Cargar el archivo CSV generado por el script de Python
data <- read.csv("C:/Users/Carlos/Documents/Sequences/Annotation/Results/summary_cds.csv")

# Gráfico del número de CDS por anotador para cada genoma
a <- ggplot(data, aes(x = Genome, y = CDS_Count, fill = Annotator)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  scale_fill_viridis(discrete = TRUE) +
  theme_minimal() +
  labs(title = "Número de CDS predichos por anotador para cada genoma",
       x = "Genoma", y = "Número de CDS") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),panel.grid = element_blank())

# Guardar el gráfico
ggsave(
  file.path("C:/Users/Carlos/Documents/Sequences/Annotation/", "ggplot_CDS.svg"),
  plot = a,
  width = 15,
  height = 20
)


# Gráfico del porcentaje de proteínas hipotéticas por anotador para cada genoma
b <- ggplot(data, aes(x = Genome, y = Hypothetical_., fill = Annotator)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  scale_fill_viridis(discrete = TRUE) +
  theme_minimal() +
  labs(title = "Porcentaje de proteínas hipotéticas por anotador para cada genoma",
       x = "Genoma", y = "Porcentaje de Proteínas Hipotéticas") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), panel.grid = element_blank())

# Guardar el gráfico
ggsave(
  file.path("C:/Users/Carlos/Documents/Sequences/Annotation/", "ggplot_Hyp_prot.svg"),
  plot = a,
  width = 15, 
  height = 20 
)