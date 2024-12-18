import pandas as pd
import numpy as np
from scipy.stats import norm as z

# Leer el archivo CSV y seleccionar la columna 'status'
muestra = pd.read_csv('lung_dataset.csv')['sex'].dropna().values

# Calcular la proporción de pacientes fallecidos (status = 2)
n = len(muestra)
proporcion_fallecidos = np.sum(muestra == 2) / n

# Nivel de confianza
nivel_significancia = 0.01
confianza = 1 - nivel_significancia

# Valor crítico z
z_critico = z.ppf(1 - nivel_significancia / 2)

# Cálculo del margen de error
margen_error = z_critico * np.sqrt(proporcion_fallecidos * (1 - proporcion_fallecidos) / n)

# Cálculo del intervalo de confianza
limite_inferior = proporcion_fallecidos - margen_error
limite_superior = proporcion_fallecidos + margen_error

print(f"Proporción de fallecidos: {proporcion_fallecidos}")
print(f"Intervalo de confianza al {confianza*100}%: ({limite_inferior}, {limite_superior})")