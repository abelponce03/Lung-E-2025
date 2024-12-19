import numpy as np
from scipy.stats import chi2

# Datos de ejemplo
data = np.array([9.831776, 0.000000, 7.000000, 0.000000, 15.750000, 68.000000, -24.000000, 92.000000, 172.657014, 13.139902, 1.336473])

# Parámetros
n = len(data)
alpha = 0.05  # Nivel de significancia (para un intervalo de confianza del 95%)

# Suma de los datos
sum_data = np.sum(data)

# Valores críticos de chi-cuadrado
chi2_lower = chi2.ppf(alpha / 2, 2 * n)
chi2_upper = chi2.ppf(1 - alpha / 2, 2 * n)

# Intervalo de confianza
lower_bound =  chi2_upper /(2 * sum_data) 
upper_bound =  chi2_lower / (2 * sum_data) 

print(f"Intervalo de confianza para la media de una distribución exponencial: ({lower_bound}, {upper_bound})")