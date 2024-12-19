import math
from scipy.stats import norm
import pandas as pd

# Datos del dataset
# Status = 2 (Fallecidos)
# Sex = 1 (Hombres), 2 (Mujeres)

# Leer el archivo CSV y seleccionar las columnas necesarias
lung_data = pd.read_csv('lung_dataset.csv')[['sex', 'status']].dropna()

# Contar fallecidos y totales para hombres y mujeres
male_fallecidos = lung_data[(lung_data['sex'] == 1) & (lung_data['status'] == 2)].shape[0]
female_fallecidos = lung_data[(lung_data['sex'] == 2) & (lung_data['status'] == 2)].shape[0]
male_total = lung_data[lung_data['sex'] == 1].shape[0]
female_total = lung_data[lung_data['sex'] == 2].shape[0]

# Proporciones de fallecidos para hombres y mujeres
p_male = male_fallecidos / male_total
p_female = female_fallecidos / female_total

# Proporción combinada (pool)
p_pool = (male_fallecidos + female_fallecidos) / (male_total + female_total)

# Estadístico z
z_stat = (p_male - p_female) / math.sqrt(
    p_pool * (1 - p_pool) * (1 / male_total + 1 / female_total)
)

# Valor crítico z para una prueba bilateral (dos colas)
alpha = 0.05
z_critical = norm.ppf(1 - alpha / 2)

# Resultados
print(f"Proporción de fallecidos - Hombres (p_male): {p_male:.4f}")
print(f"Proporción de fallecidos - Mujeres (p_female): {p_female:.4f}")
print(f"Estadístico z: {z_stat:.4f}")
print(f"Valor crítico z: ±{z_critical:.4f}")

# Decisión usando la región crítica
if abs(z_stat) > z_critical:
    print("Rechazamos la hipótesis nula: Existe una diferencia significativa en las proporciones.")
else:
    print("No podemos rechazar la hipótesis nula: No hay evidencia suficiente para concluir que las proporciones son diferentes.")