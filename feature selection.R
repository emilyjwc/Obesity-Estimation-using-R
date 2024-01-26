# Load required library for RFE
library(caret)

# Define control parameters for RFE
ctrl <- rfeControl(functions = rfFuncs, method = "cv", number = 10)

# Run RFE with Random Forest
# 下面這個狀況我試過他只會選兩個特徵
# rfe_result <- rfe(data[, -ncol(data)], data$New, sizes = c(1:ncol(data)-1), rfeControl = ctrl)

rfe_result <- rfe(data[, -ncol(data)], data$New, sizes = 10, rfeControl = ctrl)

# Print the results
print(rfe_result)

# Get the selected features
selected_features <- predictors(rfe_result)

print(selected_features)

# Subset the data with selected features
data_selected_features <- data[, c(selected_features, "New")]

# Continue with your modeling using the selected features
# Split the Data (Training/Testing Sets) using only selected features
set.seed(123)
train_data <- data_selected_features[train_index, ]
test_data <- data_selected_features[-train_index, ]

# Continue with your model building (Decision Tree, Random Forest, SVM) and evaluation
# ...
