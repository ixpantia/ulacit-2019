library(tidyverse)
library(ggbiplot)
library(factoextra)

# Carga los datos y quita el id (no es una variable!)
logs <- read_csv("data/UNSW_NB15_training-set.csv") %>%
  select(-id)

features <- read_csv("data/NUSW-NB15_features.csv")

# Mira la estructura de los datos
glimpse(logs)

View(logs)

# Divide los datos en variables y etiquetas
logs.features <- logs %>%
  select(-label)
logs.labels <- logs %>%
  select(label)

# Corre un PCA
logs.pca <- prcomp(logs.features, scale = TRUE)

# Grafica los resultados del PCA (un biplot)
fviz_pca_var(logs.pca,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

