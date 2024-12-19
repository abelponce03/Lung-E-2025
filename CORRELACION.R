library(survival)
library(corrplot)

# Load the lung cancer dataset
data("lung")

# Calculate correlation matrices
cor_matrix_Pearson <- cor(lung)
cor_matrix_Spearman <- cor(lung, method = "spearman")

# Visualize correlation matrices
corrplot(cor_matrix_Pearson, method = "circle", type = "upper", tl.col = "black", tl.srt = 55)
corrplot(cor_matrix_Spearman, method = "square", type = "upper", tl.col = "black", tl.srt = 55)

# Create interactive scatter plots with color-coding
for (i in 1:ncol(var_combinations)) {
  var1 <- var_combinations[1, i]
  var2 <- var_combinations[2, i]
  
  plot(x = lung[[var1]], y = lung[[var2]], color = lung$status) 
    layout(title = paste(var1, "vs.", var2))
}