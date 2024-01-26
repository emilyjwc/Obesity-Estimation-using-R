library(ggplot2)

selected_categories <- c("Insufficient_Weight", "Normal_Weight", "Obesity_Type_III")
data_selected <- data[data$NObeyesdad %in% selected_categories, ]

chart_fcvc_ncp_ch2o <- ggplot(data_selected, aes(x = NObeyesdad)) +
  stat_summary(aes(y = FCVC, color = "FCVC"), fun = "mean", geom = "point", size = 3) +
  stat_summary(aes(y = NCP, color = "NCP"), fun = "mean", geom = "point", size = 3) +
  stat_summary(aes(y = CH2O, color = "CH2O"), fun = "mean", geom = "point", size = 3) +
  stat_summary(aes(y = FCVC, group = 1), fun = "mean", geom = "line", size = 1, linetype = "solid", color = "blue") +
  stat_summary(aes(y = NCP, group = 1), fun = "mean", geom = "line", size = 1, linetype = "solid", color = "red") +
  stat_summary(aes(y = CH2O, group = 1), fun = "mean", geom = "line", size = 1, linetype = "solid", color = "green") +
  labs(
    title = "Comparison of FCVC, NCP, CH2O Between Selected Categories",
    x = "Obesity Category",
    y = "Average Values"
  ) +
  scale_color_manual(values = c("FCVC" = "blue", "NCP" = "red", "CH2O" = "green")) +
  theme_minimal()

print(chart_fcvc_ncp_ch2o)
