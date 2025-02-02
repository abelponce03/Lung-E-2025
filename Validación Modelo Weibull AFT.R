# Cargar librerías y datos
library(survival)
library(ggplot2)

# Eliminar filas con NA en las variables de interés
lung_clean <- na.omit(lung[, c("time", "status", "sex", "ph.karno")])

# 1. Ajustar modelo Weibull AFT
weibull_model <- survreg(Surv(time, status) ~ sex + ph.karno,
                         data = lung_clean,
                         dist = "weibull")

# 2. Comparación con otros modelos paramétricos
exponential_model <- survreg(Surv(time, status) ~ sex + ph.karno,
                             data = lung_clean,
                             dist = "exponential")

lognormal_model <- survreg(Surv(time, status) ~ sex + ph.karno,
                           data = lung_clean,
                           dist = "lognormal")

# Tabla comparativa de AIC
aic_comparison <- data.frame(
  Modelo = c("Weibull", "Exponencial", "Log-Normal"),
  AIC = c(AIC(weibull_model), AIC(exponential_model), AIC(lognormal_model))
)

print(aic_comparison)

# # 3. Gráfico de residuos de deviance vs valores ajustados
# deviance_resid <- residuals(weibull_model, type = "deviance")
# fitted_values <- predict(weibull_model)

# ggplot(data = NULL, aes(x = fitted_values, y = deviance_resid)) +
#   geom_point(alpha = 0.6) +
#   geom_hline(yintercept = 0, col = "red", linetype = "dashed") +
#   geom_smooth(method = "loess", color = "blue") +
#   labs(title = "Residuos de Deviance vs Valores Ajustados",
#        x = "Valores ajustados (log-scale)",
#        y = "Residuos de Deviance") +
#   theme_minimal()

# # 4. Gráfico de residuos parciales para ph.karno
# partial_resid <- residuals(weibull_model, type = "working") + 
#   coef(weibull_model)["ph.karno"] * lung_clean$ph.karno

# ggplot(data = NULL, aes(x = lung_clean$ph.karno, y = partial_resid)) +
#   geom_point(alpha = 0.6) +
#   geom_smooth(method = "loess", color = "darkgreen") +
#   labs(title = "Residuos Parciales para ph.karno",
#        x = "ph.karno",
#        y = "Residuos Parciales") +
#   theme_minimal()

# # 5. Validación de la forma funcional usando residuos de martingala
# cox_model <- coxph(Surv(time, status) ~ sex + ph.karno, data = lung_clean)
# martingale_resid <- residuals(cox_model, type = "martingale")

# ggplot(data = NULL, aes(x = lung_clean$ph.karno, y = martingale_resid)) +
#   geom_point(alpha = 0.6) +
#   geom_smooth(method = "loess", color = "purple") +
#   labs(title = "Residuos de Martingala para ph.karno",
#        x = "ph.karno",
#        y = "Residuos de Martingala") +
#   theme_minimal()

# # 6. Comparación con estimador no paramétrico (Kaplan-Meier)
# km_fit <- survfit(Surv(time, status) ~ 1, data = lung_clean)

# # Predicciones del modelo Weibull
# quantiles <- seq(0.1, 0.9, by = 0.1)
# weibull_quantiles <- predict(weibull_model, 
#                              newdata = data.frame(sex = 1, ph.karno = median(lung_clean$ph.karno)),
#                              type = "quantile", 
#                              p = quantiles)

# plot(km_fit, main = "Comparación Weibull vs Kaplan-Meier", xlab = "Tiempo", ylab = "S(t)")
# lines(x = weibull_quantiles, y = 1 - quantiles, type = "s", col = "red")
# legend("topright", legend = c("Kaplan-Meier", "Weibull AFT"), col = c("black", "red"), lty = 1)

