import math
import pandas as pd
from scipy.stats import t as t_dist

# Leer el archivo CSV y seleccionar la columna 'status'
muestra = pd.read_csv('lung_dataset.csv')['time'].dropna().values

# Hipótesis:
# H0: La media de la edad es <= 60
# H1: La media de la edad es > 60
mu_0 = 250  # Media bajo la hipótesis nula
alpha = 0.01  # Nivel de significancia

# Cálculos
n = len(muestra)                     # Tamaño de la muestra
sample_mean = sum(muestra) / n       # Media muestral
sample_std = math.sqrt(sum((x - sample_mean) ** 2 for x in muestra) / (n - 1))  # Desviación estándar muestral
t_stat = (sample_mean - mu_0) / (sample_std / math.sqrt(n))  # Estadístico t

# Grados de libertad
df = n - 1

# Cálculo del valor crítico
t_critical = t_dist.ppf(1 - alpha, df)  # Valor crítico t para la región crítica

# Resultados
print(f"Estadístico t: {t_stat:.4f}")
print(f"Valor crítico t: {t_critical:.4f}")

# Decisión usando la región crítica
if t_stat > t_critical:
    print("Rechazamos la hipótesis nula: El estadístico t está en la región crítica.")
else:
    print("No podemos rechazar la hipótesis nula: El estadístico t no está en la región crítica.")



