library(dplyr)
library(factoextra)
library(readr)

# Carga los datos y quita el id (no es una variable!)
logs <- read_csv("data/UNSW_NB15_training-set.csv") %>%
  select(-id)

features <- read_csv("data/NUSW-NB15_features.csv")

# Mira la estructura de los datos
glimpse(logs)

View(logs)

# Divide los datos en variables y etiquetas
logs_features <- logs %>%
  select(-label)

logs_labels <- logs %>%
  select(label)

# Corre un PCA
logs_pca <- prcomp(logs_features, scale = TRUE)

# Grafica los resultados del PCA (un biplot)
fviz_pca_var(logs_pca,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

