# read data
data <- read.csv("/Users/macbook/Desktop/ObesityDataSet.csv")

# Create a new variable 'New' based on BMI values
data$New <- ifelse(data$BMI < 18.5, "Insufficient_Weight",
                         ifelse(data$BMI < 24.9, "Normal_Weight",
                                ifelse(data$BMI < 27.9, "Overweight_Level_I",
                                       ifelse(data$BMI < 29.9, "Overweight_Level_II",
                                              ifelse(data$BMI < 34.9, "Obesity_Type_I",
                                                    ifelse(data$BMI < 39.9, "Obesity_Type_II", "Obesity_Type_III"))))))

# View the new variable and its distribution
table(data$New)

# Assuming your data frame is named 'df' and you have already recategorized the 'NObeyesdad' variable into 'NewCategory'

# Load the ggplot2 and viridis libraries
library(ggplot2)
library(viridis)

# Create a bar chart with the Viridis color palette
ggplot(data, aes(x = New, fill = New)) +
  geom_bar() +
  scale_fill_viridis(discrete = TRUE) +  # Use the Viridis color palette
  labs(title = "Distribution of Weight Categories",
       x = "Weight Category",
       y = "Count")


# Assuming "column_name" is the name of the column you want to delete
data$NObeyesdad <- NULL

