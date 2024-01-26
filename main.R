# read data
data <- read.csv("/Users/macbook/Desktop/R/ObesityDataSet.csv")

# Create a new variable 'New' based on BMI values
data$New <- ifelse(data$BMI < 18.5, "Insufficient_Weight",
                   ifelse(data$BMI < 24.9, "Normal_Weight",
                          ifelse(data$BMI < 27.9, "Overweight_Level_I",
                                 ifelse(data$BMI < 29.9, "Overweight_Level_II",
                                        ifelse(data$BMI < 34.9, "Obesity_Type_I",
                                               ifelse(data$BMI < 39.9, "Obesity_Type_II", "Obesity_Type_III"))))))

# View the new variable and its distribution
table(data$New)


# load library
library(viridis)
library(tidyverse)
library(caret)
library(randomForest)
library(ggplot2)
library(reshape2)
library(caret)

# Create a bar chart with the Viridis color palette
ggplot(data, aes(x = New, fill = New)) +
  geom_bar() +
  scale_fill_viridis(discrete = TRUE) +  # Use the Viridis color palette
  labs(title = "Distribution of Weight Categories",
       x = "Weight Category",
       y = "Count")

# delete NObeyesdad
data$NObeyesdad <- NULL
data$BMI <- NULL


# check structure
str(data)

# statistics summary
summary(data)

# Convert categorical variables to factors 
data$Gender <- as.factor(data$Gender)
data$family_history_with_overweight <- as.factor(data$family_history_with_overweight)
data$FAVC  <- as.factor(data$FAVC)
data$CAEC  <- as.factor(data$CAEC)
data$SMOKE  <- as.factor(data$SMOKE)
data$SCC  <- as.factor(data$SCC)
data$CALC  <- as.factor(data$CALC)
data$MTRANS  <- as.factor(data$MTRANS)
data$New  <- as.factor(data$New)  # Change here

#--------------------PART ONE--------------------
#--------------------plotting--------------------

# Age distribution by Gender
ggplot(data, aes(x = Age, fill = Gender)) +
  geom_histogram(binwidth = 1, position = "dodge") +
  labs(title = "Age Distribution by Gender", x = "Age", y = "Frequency")

# Box Plots for Age by Weight Category
ggplot(data, aes(x = New, y = Age, fill = New)) +
  geom_boxplot() +
  labs(title = "Age Distribution by Weight Category", x = "Weight Category", y = "Age")

# Bar Plot for Family History with Overweight
ggplot(data, aes(x = family_history_with_overweight, fill = family_history_with_overweight)) +
  geom_bar() +
  labs(title = "Family History with Overweight", x = "Family History", y = "Count")

# Stacked Bar Plot for MTRANS by Weight Category
ggplot(data, aes(x = New, fill = MTRANS)) +
  geom_bar(position = "stack") +
  labs(title = "Transportation Mode by Weight Category", x = "Weight Category", y = "Count")

# Pie Chart for Smoking Status
ggplot(data, aes(x = "", fill = SMOKE)) +
  geom_bar(width = 1, stat = "count") +
  coord_polar(theta = "y") +
  labs(title = "Smoking Status Distribution", fill = "Smoking Status")

# Correlation Heatmap for Numerical Variables
numeric_vars <- select_if(data, is.numeric)
correlation_matrix <- cor(numeric_vars)
ggplot(data = melt(correlation_matrix), aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  labs(title = "Correlation Heatmap for Numerical Variables")


# average comparing chart on selected obesity 
# chart_fcvc_ncp_ch2o
selected_categories <- c("Insufficient_Weight", "Normal_Weight", "Obesity_Type_III")
data_selected <- data[data$New %in% selected_categories, ]

chart_fcvc_ncp_ch2o <- ggplot(data_selected, aes(x = New)) +
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

# chart_faf_tue
selected_categories <- c("Insufficient_Weight", "Normal_Weight", "Obesity_Type_III")
data_selected <- data[data$New %in% selected_categories, ]

chart_faf_tue <- ggplot(data_selected, aes(x = New)) +
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

# chart_caec_calc
# mapping for CAEC and CALC categories (轉成數字)
category_mapping <- c("always" = 4, "frequently" = 3, "no" = 0, "sometimes" = 1)

# Map the categories to numeric values in the data
data$CAEC_numeric <- category_mapping[data$CAEC]
data$CALC_numeric <- category_mapping[data$CALC]

selected_categories <- c("Insufficient_Weight", "Normal_Weight", "Obesity_Type_III")
data_selected <- data[data$New %in% selected_categories, ]

chart_caec_calc <- ggplot(data_selected, aes(x = New)) +
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

#--------------------PART TWO--------------------
# ANOVA and posthoc test
anova_result_fcvc <- aov(FCVC ~ New, data = data_selected)
print(summary(anova_result_fcvc))

posthoc_result_fcvc <- TukeyHSD(anova_result_fcvc)
print(posthoc_result_fcvc)

#--------------------PART THREE--------------------
# prediction model

# feature selection
# Load library
library(caret)

# Define control parameters 
ctrl <- rfeControl(functions = rfFuncs, method = "cv", number = 10)

# 下面這個狀況我試過他只會選兩個特徵
# rfe_result <- rfe(data[, -ncol(data)], data$New, sizes = c(1:ncol(data)-1), rfeControl = ctrl)

rfe_result <- rfe(data[, -ncol(data)], data$New, sizes = 10, rfeControl = ctrl)

# results
print(rfe_result)

# Get the selected features
selected_features <- predictors(rfe_result)
print(selected_features)

# Subset the data with selected features
data_selected_features <- data[, c(selected_features, "New")]


# Split the Data (Training/Testing Sets) using only selected features
set.seed(123)
train_index <- createDataPartition(data$New, p = 0.8, list = FALSE)
train_data <- data_selected_features[train_index, ]
test_data <- data_selected_features[-train_index, ]

#--decision tree--
library(rpart)

dt_model <- rpart(New ~ ., data = train_data, method = "class")
dt_predictions <- predict(dt_model, newdata = test_data, type = "class")

#--random forest--
library(randomForest)

#前面轉factor了
#class(train_data$New)
#train_data$New <- as.factor(train_data$New)

rf_model <- randomForest(New ~ ., data = train_data)
rf_predictions <- predict(rf_model, newdata = test_data)

#--SVM--
library(e1071)

svm_model <- svm(New ~ ., data = train_data)
svm_predictions <- predict(svm_model, newdata = test_data)

# Evaluate the Decision Tree, Random Forest, and SVM models
dt_conf_matrix <- table(dt_predictions, test_data$New)
rf_conf_matrix <- table(rf_predictions, test_data$New)
svm_conf_matrix <- table(svm_predictions, test_data$New)

# Print Confusion Matrices
print("Decision Tree Confusion Matrix:")
print(dt_conf_matrix)

print("Random Forest Confusion Matrix:")
print(rf_conf_matrix)

print("SVM Confusion Matrix:")
print(svm_conf_matrix)

# Calculate accuracy
accuracy_dt <- sum(diag(dt_conf_matrix)) / sum(dt_conf_matrix)
accuracy_rf <- sum(diag(rf_conf_matrix)) / sum(rf_conf_matrix)
accuracy_svm <- sum(diag(svm_conf_matrix)) / sum(svm_conf_matrix)

print(paste("Decision Tree Accuracy: ", accuracy_dt))
print(paste("Random Forest Accuracy: ", accuracy_rf))
print(paste("SVM Accuracy: ", accuracy_svm))

library(pROC)

# Create ROC curves for each model
roc_dt <- roc(test_data$New, as.numeric(dt_predictions))
roc_rf <- roc(test_data$New, as.numeric(rf_predictions))
roc_svm <- roc(test_data$New, as.numeric(svm_predictions))

# Plot ROC curves
plot(roc_dt, col = "red", main = "ROC Curves")
lines(roc_rf, col = "blue")
lines(roc_svm, col = "green")

# Add legend
legend("bottomright", legend = c("Decision Tree", "Random Forest", "SVM"),
       col = c("red", "blue", "green"), lty = 1)
