library(ggplot2)

# Filter data for the selected categories
selected_categories <- c("Insufficient_Weight", "Normal_Weight", "Obesity_Type_III")
data_selected <- data[data$New %in% selected_categories, ]

# Create a line chart for each attribute with the average value
attributes <- c("FAVC", "SCC", "SMOKE")

for (attribute in attributes) {
  # Create a line chart with points for the average value
  chart <- ggplot(data_selected, aes(x = New, y = get(attribute), group = New, color = New)) +
    stat_summary(fun = "mean", geom = "point", size = 3) +  # Use geom_point to show points for mean values
    labs(title = paste("Comparison of", attribute, "Between", paste(selected_categories, collapse = " and ")),
         x = "Obesity Category", y = paste("Average", attribute)) +
    theme_minimal()
  
  # Print the chart
  print(chart)
}

