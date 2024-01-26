library(ggplot2)

# Define a mapping for CAEC and CALC categories
category_mapping <- c("always" = 4, "frequently" = 3, "no" = 0, "sometimes" = 1)

# Map the categories to numeric values in the data
data$CAEC_numeric <- category_mapping[data$CAEC]
data$CALC_numeric <- category_mapping[data$CALC]

selected_categories <- c("Insufficient_Weight", "Normal_Weight", "Obesity_Type_III")
data_selected <- data[data$NObeyesdad %in% selected_categories, ]

chart_caec_calc <- ggplot(data_selected, aes(x = NObeyesdad)) +
  stat_summary(aes(y = CAEC_numeric, color = "CAEC"), fun = "mean", geom = "point", size = 3) +
  stat_summary(aes(y = CALC_numeric, color = "CALC"), fun = "mean", geom = "point", size = 3) +
  stat_summary(aes(y = CAEC_numeric, group = 1), fun = "mean", geom = "line", size = 1, linetype = "solid", color = "blue") +
  stat_summary(aes(y = CALC_numeric, group = 1), fun = "mean", geom = "line", size = 1, linetype = "solid", color = "red") +
  labs(
    title = "Comparison of CAEC and CALC Between Selected Categories",
    x = "Obesity Category",
    y = "Average Values"
  ) +
  scale_color_manual(values = c("CAEC" = "blue", "CALC" = "red")) +
  scale_y_continuous(breaks = seq(1, 4, 1), labels = names(category_mapping)) +  # Map back to original labels
  theme_minimal()

print(chart_caec_calc)
