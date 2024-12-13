# Instalar y cargar la librería NHANES y nortest
#install.packages("NHANES")
#install.packages("nortest")
library(survival)
library(nortest)

# Cargar el dataset
data("lung")

write.csv(lung, file = "E:/Proyectos/Lung-E-2025", row.names = FALSE)

# Función para calcular la moda
get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# Función para graficar la distribución de probabilidad y las distribuciones de variables aleatorias conocidas
plot_distribution <- function(data, var_name) {
  if (is.numeric(data) && length(data) > 1 && !all(is.na(data))) {
    hist(data, freq = FALSE, main = paste("Distribución de", var_name), xlab = var_name, col = "lightblue")
    curve(dnorm(x, mean = mean(data, na.rm = TRUE), sd = sd(data, na.rm = TRUE)), col = "red", lwd = 2, add = TRUE)
    curve(dexp(x, rate = 1/mean(data, na.rm = TRUE)), col = "green", lwd = 2, add = TRUE)
    curve(dgamma(x, shape = 2, rate = 2/mean(data, na.rm = TRUE)), col = "blue", lwd = 2, add = TRUE)
    curve(dunif(x, min = min(data, na.rm = TRUE), max = max(data, na.rm = TRUE)), col = "orange", lwd = 2, add = TRUE)
    curve(dchisq(x, df = 3), col = "purple", lwd = 2, add = TRUE)
    lines(density(data, na.rm = TRUE), col = "black", lwd = 2, add = TRUE)
    
    
    legend("topright", 
           legend = c("Normal", "Exponencial", "Gamma", "Uniforme", "Chi-cuadrado", var_name), 
           fill = c("red", "green", "blue", "orange", "purple", "black"), 
           cex = 0.8, 
           text.col = "black", 
           bg = 'lightgray', 
           box.lwd = 1)
    
    #legend("topright", legend = c("Normal", var_name), fill = c("red", "black"))
  } else {
    warning(paste("La variable", var_name, "no es numérica o contiene datos insuficientes"))
  }
}

# Iterar sobre cada variable del dataset
for (var in names(lung)) {
  data <- lung[[var]]
  
  if (is.numeric(data)) {
    # Test de normalidad Kolmogorov-Smirnov
    test_result <- ad.test(data)
    #cat("Variable:", var, "\n")
    
    # Determinar si cumple con la normalidad
    if (test_result$p.value > 0.01) {
      cat("Cumple con la normalidad (p-value:", test_result$p.value, ")\n")
    } else {
      cat("No cumple con la normalidad (p-value:", test_result$p.value, ")\n")
    }
    
    #Medidas de tendencia central
    #central_measures <- c(mean = mean(data, na.rm = TRUE), mode = get_mode(data), median = median(data, na.rm = TRUE),
    #                      Q1 = quantile(data, 0.25, na.rm = TRUE), Q3 = quantile(data, 0.75, na.rm = TRUE))
    
    #Medidas de variabilidad
    #variability_measures <- c(max = max(data, na.rm = TRUE), min = min(data, na.rm = TRUE), range = max(data, na.rm = TRUE) - min(data, na.rm = TRUE),
    #                         variance = var(data, na.rm = TRUE), sd = sd(data, na.rm = TRUE), cv = sd(data, na.rm = TRUE) / mean(data, na.rm = TRUE))
    
    #Imprimir las medidas
    #cat("Variable:", var, "\n")
    #cat("Medidas de tendencia central:\n")
    #print(central_measures)
    #cat("Medidas de variabilidad:\n")
    #print(variability_measures)
    
    # QQ plot con línea roja
    #qqnorm(data, main = paste("QQ plot de", var))
    #qqline(data, col = "red")
    
    # Gráfico de distribución de probabilidad y distribuciones conocidas
    plot_distribution(data, var)
  } else {
    warning(paste("La variable", var, "no es numérica o contiene datos insuficientes"))
  }
}


