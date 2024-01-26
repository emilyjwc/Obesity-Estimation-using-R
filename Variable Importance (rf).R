# Extract Variable Importance
var_importance <- importance(rf_model)
var_importance <- data.frame(Feature = rownames(var_importance), Importance = var_importance[, "MeanDecreaseGini"])

# Order the features by importance
var_importance <- var_importance[order(var_importance$Importance, decreasing = TRUE), ]

# Plot Variable Importance
library(ggplot2)

ggplot(var_importance, aes(x = reorder(Feature, Importance), y = Importance)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  labs(title = "Random Forest Variable Importance Plot",
       x = "Feature",
       y = "Mean Decrease in Gini Index") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
