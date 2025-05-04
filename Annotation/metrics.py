import os
import csv

# Directorio base donde se encuentran las carpetas de los anotadores
base_dir = "/mnt/c/Users/Carlos/Documents/Sequences/Annotation/Results"

# Listado de los anotadores
annotators = ["Pharokka", "Phold", "Prokka"]

# Lista para almacenar los registros
records = []

# Iterar por cada anotador y archivo .gff correspondiente
for annotator in annotators: # Iterar por cada anotador
    annotator_dir = os.path.join(base_dir, annotator) # Directorio del anotador
    for file in os.listdir(annotator_dir): # Listar archivos en el directorio del anotador
        if file.endswith(".gff"):  
            genome = os.path.splitext(file)[0]  # Extraemos el nombre del genoma
            filepath = os.path.join(annotator_dir, file) # Ruta completa del archivo .gff

            total_cds = 0 # Contador de CDS
            hypo_count = 0  # Contador de proteínas hipotéticas

            with open(filepath) as f: # Abrir el archivo .gff
                for line in f: # Leer línea por línea
                    if line.startswith("#"): # Ignorar líneas de comentario
                        continue
                    fields = line.strip().split("\t") # Dividir la línea en campos (columnas)
                    if len(fields) < 9: # Asegurarse de que hay suficientes columnas (mínimo 9)
                        continue
                    feature = fields[2].lower()  # Extrae la característica de la tercera columna (Debería ser "CDS")
                    attributes = fields[8].lower()  # Extrae los atributos de la novena columna

                    if feature == "cds": # Verifica si la característica es "CDS"
                        total_cds += 1 # Incrementa el contador de CDS
                        if ("hypothetical protein" in attributes) or ("product=hypothetical" in attributes): # Verifica si es una proteína hipotética
                            hypo_count += 1 # Incrementa el contador de proteínas hipotéticas

            if total_cds > 0: # Evita la división por cero
                hypo_pct = 100 * hypo_count / total_cds  # Calcula el porcentaje de proteínas hipotéticas
            else: # Si no hay CDS, el porcentaje de proteínas hipotéticas es 0
                hypo_pct = 0.0

            # Agregar los resultados a la lista de registros
            records.append({
                "Genome": genome,
                "Annotator": annotator,
                "CDS_Count": total_cds,
                "Hypothetical_Count": hypo_count,
                "Hypothetical_%": hypo_pct
            })

# Guardar los resultados en un archivo CSV
output_csv = "/mnt/c/Users/Carlos/Documents/Sequences/Annotation/Results/summary_cds.csv" # Ruta de salida del CSV
os.makedirs(os.path.dirname(output_csv), exist_ok=True) # Crear el directorio si no existe

with open(output_csv, mode="w", newline='') as file: # Abrir el archivo CSV para escritura
    writer = csv.DictWriter(file, fieldnames=["Genome", "Annotator", "CDS_Count", "Hypothetical_Count", "Hypothetical_%"]) # Crear un escritor de CSV
    writer.writeheader() # Escribir la cabecera
    writer.writerows(records) # Escribir los registros

print(f"Metrics have been written to {output_csv}") # Mensaje de confirmación
