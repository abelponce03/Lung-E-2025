# Load the necessary library
library(survival)

# Import and omit null rows of the lung dataset
lung_clean <- na.omit(lung)

# Replace all values of 2 with 0 in the sex variable
lung_clean$sex[lung_clean$sex == 2] <- 0

#Weibull AFT model
weibull_aft <- survreg(Surv(time, status) ~ age + sex + pat.karno + meal.cal + wt.loss, data = lung_clean, dist = "weibull")

summary(weibull_aft)

# Fit the Weibull AFT model
weibull_aft <- survreg(Surv(time, status) ~ sex + pat.karno, data = lung_clean, dist = "weibull")

summary(weibull_aft)

# Predict the survival time for a new patient

nuevo_dato <- data.frame(sex = 1, pat.karno = 80)
tiempo_pred <- predict(weibull_aft, newdata = nuevo_dato, type = "response")
print(tiempo_pred)
