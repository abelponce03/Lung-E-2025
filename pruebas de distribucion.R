# Instalar y cargar las librerías necesarias
# install.packages("nortest")
# install.packages("survival")
library(nortest)
library(survival)

# Cargar el dataset
data("lung")

#lung_clean <- na.omit(lung)
lung_clean <- lung[lung$wt.loss < 0, ]
nrow(lung_clean)
lung_clean$wt.loss <- ifelse(lung_clean$wt.loss < 0, -lung_clean$wt.loss, lung_clean$wt.loss)

# Funciones auxiliares
get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

plot_distribution <- function(data, var_name) {
  if (is.numeric(data) && length(data) > 1 && !all(is.na(data))) {
    hist(data, freq = FALSE, main = paste("Distribución de", var_name), xlab = var_name, col = "lightblue")
    curve(dnorm(x, mean = mean(data, na.rm = TRUE), sd = sd(data, na.rm = TRUE)), col = "red", lwd = 2, add = TRUE)
    curve(dexp(x, rate = 1/mean(data, na.rm = TRUE)), col = "green", lwd = 2, add = TRUE)
    curve(dgamma(x, shape = 2, rate = 2/mean(data, na.rm = TRUE)), col = "blue", lwd = 2, add = TRUE)
    curve(dchisq(x, df = 3), col = "purple", lwd = 2, add = TRUE)
    lines(density(data, na.rm = TRUE), col = "black", lwd = 2)
    legend("topright", legend = c("Normal", "Exponencial", "Gamma", "Chi-cuadrado", "Densidad"), 
           fill = c("red", "green", "blue", "purple", "black"), cex = 0.8)
  } else {
    warning(paste("La variable", var_name, "no es numérica o contiene datos insuficientes"))
  }
}

# Aplicar pruebas de bondad de ajuste
perform_tests <- function(data, var_name) {
  if (is.numeric(data) && length(data) > 1 && !all(is.na(data))) {
    cat("\nVariable:", var_name, "\n")
    
    # Prueba Anderson-Darling
    ad_normal <- ad.test(data)
    cat("  Anderson-Darling (Normal): p-value =", ad_normal$p.value, "\n")
    
    # Kolmogorov-Smirnov
    ks_normal <- ks.test(data, "pnorm", mean(data, na.rm = TRUE), sd(data, na.rm = TRUE))
    cat("  Kolmogorov-Smirnov (Normal): p-value =", ks_normal$p.value, "\n")
    
    # Shapiro-Wilk
    sw_normal <- shapiro.test(data)
    cat("  Shapiro-Wilk (Normal): p-value =", sw_normal$p.value, "\n")
    
    # Ajuste a Exponencial
    ks_expon <- ks.test(data, "pexp", rate = 1/mean(data, na.rm = TRUE))
    cat("  Kolmogorov-Smirnov (Exponencial): p-value =", ks_expon$p.value, "\n")
    
    # Ajuste a Gamma
    shape <- 2
    rate <- 2/mean(data, na.rm = TRUE)
    ks_gamma <- ks.test(data, "pgamma", shape = shape, rate = rate)
    cat("  Kolmogorov-Smirnov (Gamma): p-value =", ks_gamma$p.value, "\n")
    
    # Ajuste a Chi-cuadrado
    df <- 3
    ks_chi <- ks.test(data, "pchisq", df = df)
    cat("  Kolmogorov-Smirnov (Chi-cuadrado): p-value =", ks_chi$p.value, "\n")
    
    # Gráfico
    plot_distribution(data, var_name)
  } else {
    warning(paste("La variable", var_name, "no es numérica o contiene datos insuficientes"))
  }
}

# Iterar sobre cada variable del dataset
for (var in names(lung)) {
  data <- lung_clean[[var]]
  perform_tests(data, var)
}
