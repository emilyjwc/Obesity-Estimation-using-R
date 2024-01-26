library(ggplot2)

selected_categories <- c("Insufficient_Weight", "Normal_Weight", "Obesity_Type_III")
data_selected <- data[data$NObeyesdad %in% selected_categories, ]

chart_faf_tue <- ggplot(data_selected, aes(x = NObeyesdad)) +
  stat_summary(aes(y = FAF, color = "FAF"), fun = "mean", geom = "point", size = 3) +
  stat_summary(aes(y = TUE, color = "TUE"), fun = "mean", geom = "point", size = 3) +
  stat_summary(aes(y = FAF, group = 1), fun = "mean", geom = "line", size = 1, linetype = "solid", color = "blue") +
  stat_summary(aes(y = TUE, group = 1), fun = "mean", geom = "line", size = 1, linetype = "solid", color = "red") +
  labs(
    title = "Comparison of FAF and TUE Between Selected Categories",
    x = "Obesity Category",
    y = "Average Values"
  ) +
  scale_color_manual(values = c("FAF" = "blue", "TUE" = "red")) +
  theme_minimal()

print(chart_faf_tue)
