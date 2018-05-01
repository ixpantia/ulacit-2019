library(tidyverse)
library(ggbiplot)

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
ggbiplot(logs.pca, obs.scale = 1, var.scale = 1, groups = logs.labels,
         circle = FALSE)

# Haz un zoom-in para ver los vectores de lo features
ggbiplot(logs.pca, obs.scale = 0.1, var.scale = 4, var.axes = TRUE,
         scale = TRUE, groups = logs.labels,  circle = FALSE, expand = TRUE,
         alpha = TRUE) + ylim(-1, 1) + xlim(-2, 2)
