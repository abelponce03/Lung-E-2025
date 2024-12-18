import pandas as pd
import numpy as np
from scipy.stats import norm as z

# Leer el archivo CSV y seleccionar la columna 'time'
muestra = pd.read_csv('lung_dataset.csv')['age'].dropna().values

# Calcular la media y desviación estándar muestral
media_muestral = np.mean(muestra)
desviacion_muestral = np.std(muestra, ddof=1)
n = len(muestra)

# Nivel de confianza y grados de libertad
nivel_significancia = 0.01
confianza = 1 - nivel_significancia

# Valor crítico z
z_critico = z.ppf(1 - nivel_significancia / 2)

# Cálculo del intervalo de confianza
margen_error = z_critico * (desviacion_muestral / np.sqrt(n))
limite_inferior = media_muestral - margen_error
limite_superior = media_muestral + margen_error

print(media_muestral, desviacion_muestral, (limite_inferior, limite_superior))