# Cargar librerías necesarias
library(ggplot2)
library(dplyr)

# Leer el CSV
df <- read.csv("data/spotify-streaming-top-50-mexico.csv", stringsAsFactors = FALSE)

# Convertir fecha a formato Date
df$date <- as.Date(df$date)

# Ver estructura y resumen estadístico
str(df)
summary(df)

# Top 10 canciones más populares
top_songs <- df %>%
  arrange(desc(popularity)) %>%
  head(10)

# Gráfico de barras de popularidad de las 10 canciones más populares
ggplot(top_songs, aes(x = reorder(song, popularity), y = popularity, fill = artist)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top 10 Canciones más Populares en Spotify México",
       x = "Canción", y = "Popularidad") +
  theme_minimal()

# Distribución de duración de canciones
ggplot(df, aes(x = duration_ms / 60000)) +  # Convertir ms a minutos
  geom_histogram(binwidth = 0.5, fill = "steelblue", color = "black") +
  labs(title = "Distribución de la Duración de Canciones",
       x = "Duración (minutos)", y = "Frecuencia") +
  theme_minimal()

# Canciones explícitas vs. no explícitas
ggplot(df, aes(x = factor(is_explicit), fill = factor(is_explicit))) +
  geom_bar() +
  labs(title = "Canciones Explícitas vs No Explícitas",
       x = "Es Explícito", y = "Cantidad") +
  scale_fill_manual(values = c("red", "green"), labels = c("No", "Sí")) +
  theme_minimal()
