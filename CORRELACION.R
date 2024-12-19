rm(list=ls())

library(survival)

data("lung")

library(corrplot)
cor_matrix_Pearson <- cor(lung)
cor_matrix_Spearman <- cor(lung,method = "spearman")
corrplot(cor_matrix_Pearson,method = "circle",type ="upper", tl.col = "black", tl.srt = 55)

corrplot(cor_matrix_Spearman,method = "square",type ="upper", tl.col = "black", tl.srt = 55)

var_combinations <- combn(names(lung), 2)

for (i in 1:ncol(var_combinations)) {
  var1 <- var_combinations[1, i]
  var2 <- var_combinations[2, i]
  
  plot(lung[[var1]], lung[[var2]])
}

cor(lung)
corrplot(cor_matrix_Spearman,type ="upper")
cor_matrix_Spearman


