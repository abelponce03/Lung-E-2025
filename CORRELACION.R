library(survival)
library(corrplot)

<<<<<<< HEAD
# Load the lung cancer dataset
data("lung")

# Calculate correlation matrices
cor_matrix_Pearson <- cor(lung)
cor_matrix_Spearman <- cor(lung, method = "spearman")
=======
# Handle missing values by removing rows with NA
lung_clean <- na.omit(lung)

# Calculate correlation matrices
cor_matrix_Pearson <- cor(lung_clean)
cor_matrix_Spearman <- cor(lung_clean, method = "spearman")
>>>>>>> 5f266b8e68f49d64c72fa7d8085aaf8572d81f9a

# Visualize correlation matrices
corrplot(cor_matrix_Pearson, method = "circle", type = "upper", tl.col = "black", tl.srt = 55)
corrplot(cor_matrix_Spearman, method = "square", type = "upper", tl.col = "black", tl.srt = 55)

<<<<<<< HEAD
# Create interactive scatter plots with color-coding
for (i in 1:ncol(var_combinations)) {
  var1 <- var_combinations[1, i]
  var2 <- var_combinations[2, i]
  
  plot(x = lung[[var1]], y = lung[[var2]], color = lung$status) 
    layout(title = paste(var1, "vs.", var2))
}
=======
# find_all_correlations <- function(cor_matrix) {
#   var_combinations <- combn(colnames(cor_matrix), 2)

#   for (i in 1:ncol(var_combinations)) {
#     var1 <- var_combinations[1, i]
#     var2 <- var_combinations[2, i]
#     correlation <- cor_matrix[var1, var2]
#     cat(sprintf("Variables: %s and %s, Correlation: %.2f\n", var1, var2, correlation))
#   }
# }

## Find and display all correlations
# cat("All correlations (Pearson):\n")
# find_all_correlations(cor_matrix_Pearson)

# cat("\nAll correlations (Spearman):\n")
# find_all_correlations(cor_matrix_Spearman)


#Function to find and display strongly correlated pairs
find_strong_correlations <- function(cor_matrix, threshold = 0.7) {
  strong_pairs <- which(abs(cor_matrix) >= threshold, arr.ind = TRUE)
  strong_pairs <- strong_pairs[strong_pairs[, 1] < strong_pairs[, 2],]

  force(strong_pairs)

  for (i in 1:nrow(strong_pairs)) {
    var1 <- colnames(cor_matrix)[strong_pairs[i, 1]]
    var2 <- colnames(cor_matrix)[strong_pairs[i, 2]]
    correlation <- cor_matrix[strong_pairs[i, 1], strong_pairs[i, 2]]
    cat(sprintf("Variables: %s and %s, Correlation: %.2f\n", var1, var2, correlation))
  }
}

find_strong_correlations(cor_matrix_Pearson)

# # Create interactive scatter plots with color-coding
# var_combinations <- combn(names(lung_clean), 2)
# for (i in 1:ncol(var_combinations)) {
#   var1 <- var_combinations[1, i]
#   var2 <- var_combinations[2, i]

#   plot(x = lung_clean[[var1]], y = lung_clean[[var2]], col = lung_clean$status)
#   title(main = paste(var1, "vs.", var2))
# }
>>>>>>> 5f266b8e68f49d64c72fa7d8085aaf8572d81f9a
