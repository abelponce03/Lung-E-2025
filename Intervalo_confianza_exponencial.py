import pandas as pd
import numpy as np
from scipy.stats import chi2

# Leer el archivo CSV y seleccionar la columna 'wt.loss'
df = pd.read_csv('lung_dataset.csv')
wt_loss = df['wt.loss'].dropna()

# Filtrar los valores mayores que 0
wt_loss_filtered = wt_loss[wt_loss < 0].values
# Cambiar los valores de wt_loss_filtered de signo
wt_loss_filtered = -wt_loss_filtered #se usa para los que ganaron peso

# Parámetros
n = len(wt_loss_filtered)
alpha = 0.01  # Nivel de significancia (para un intervalo de confianza del 99%)

# Suma de los datos
sum_data = np.sum(wt_loss_filtered)

# Valores críticos de chi-cuadrado
chi2_lower = chi2.ppf(alpha / 2, 2 * n)
chi2_upper = chi2.ppf(1 - alpha / 2, 2 * n)

# Intervalo de confianza
lower_bound =  (2 * sum_data)/chi2_upper 
upper_bound = (2 * sum_data)/chi2_lower

print(f"Intervalo de confianza para la media de una distribución exponencial: ({lower_bound}, {upper_bound})")