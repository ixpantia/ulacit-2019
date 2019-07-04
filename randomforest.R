#### Random Forest
library(dplyr)
library(ranger)
library(readr)
library(ggplot2)

# Carga los datos y quita el id
logs <- read_csv("data/UNSW_NB15_training-set.csv") %>%
  select(-id)

# Los labels no son numeros, son categorias (factores en R)
logs$label <- as.factor(logs$label)

# Crea un modelo RandomForest (con datos categoricos)
# (se puede demorar un poco, dependiendo en tu computador)
rf <- ranger(label ~ ., data = logs, importance = "impurity",
             classification = TRUE)

# Lee los datos de importancia de valores
impvar_data <- t(as.data.frame(as.list(importance(rf))))
impvar_data <- data.frame(var = rownames(impvar_data),
                          valores = impvar_data[, 1])
rownames(impvar_data) <- c()

# Crea un plot de importancia de valores
ggplot(data = impvar_data,
       aes(x = reorder(var, valores), y = valores, fill = valores)) +
  geom_bar(stat = "identity") + coord_flip()

# Lee la matriz de confusión
rf$confusion.matrix

# Podemos predecir algo con esto, por ejemplo la seguna fila de los
# datos de prueba (test-data)
test_data <- read_csv("data/UNSW_NB15_testing-set.csv") %>%
  select(-id)

prediccion <- predict(rf, data = test_data[2,])

# El resultado de la prediccion es:
prediccion$predictions


