import numpy as np
import pandas as pd
from scipy.stats import chi2

valor_hipotetico = 6.85
# Leer el archivo CSV y seleccionar la columna 'wt.loss' y 'status'
df = pd.read_csv('lung_dataset.csv')
wt_loss = df[df['status'] == 2]['wt.loss'].dropna()

# Filtrar los valores mayores que 0
wt_loss_filtered = wt_loss[wt_loss > 0].values

def prueba_hipotesis_exponencial(datos, media_poblacional, alfa=0.05):
    """
    Realiza una prueba de hipótesis para verificar si la media poblacional
    es menor que un valor dado en una distribución exponencial.

    Parámetros:
    - datos: lista o array de datos muestrales.
    - media_poblacional: valor de media poblacional bajo la hipótesis nula.
    - alfa: nivel de significancia (por defecto 0.05).

    Retorna:
    - Resultado de la prueba y el valor p.
    """
    # Cálculo de la media muestral y el tamaño de la muestra
    media_muestral = np.mean(datos)
    n = len(datos)
    
    # Hipótesis:
    # H0: Media poblacional <= media_poblacional
    # H1: Media poblacional > media_poblacional (prueba unilateral)

    # Varianza muestral para una exponencial (estimador de máxima verosimilitud)
    varianza_muestral = np.var(datos, ddof=1)
    
    # Estadístico de prueba (estimador 1/x)
    estadistico_prueba = n * (media_muestral / media_poblacional)
    #print(estadistico_prueba)
    # Valor crítico y comparación
    valor_critico = chi2.ppf(1 - alfa, df=n)
    #print(valor_critico)
    p_valor = 1 - chi2.cdf(estadistico_prueba, df=n)

    # Resultado
    if estadistico_prueba > valor_critico:
        resultado = "Rechazamos la hipótesis nula"
    else:
        resultado = "No podemos rechazar la hipótesis nula"
    
    return resultado, p_valor, estadistico_prueba

resultado, p_valor, estadistico = prueba_hipotesis_exponencial(wt_loss_filtered, 6.85, 0.01)
print(f"Resultado: {resultado}")
print(f"Valor p: {p_valor}")
print(f"Estadístico de prueba: {estadistico}")
