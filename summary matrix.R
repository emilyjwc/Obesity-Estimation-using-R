# Calculate AUC for each model
auc_dt <- auc(roc_dt)
auc_rf <- auc(roc_rf)
auc_svm <- auc(roc_svm)

# Print AUC values
print(paste("Decision Tree AUC: ", auc_dt))
print(paste("Random Forest AUC: ", auc_rf))
print(paste("SVM AUC: ", auc_svm))

# Display the summary matrix
summary_matrix <- matrix(c(accuracy_dt, accuracy_rf, accuracy_svm, auc_dt, auc_rf, auc_svm),
                         nrow = 2,
                         byrow = TRUE,
                         dimnames = list(c("Accuracy", "AUC"), c("Decision Tree", "Random Forest", "SVM")))

print("Summary Matrix:")
print(summary_matrix)

# Plot ROC curves
plot(roc_dt, col = "red", main = "ROC Curves")
lines(roc_rf, col = "blue")
lines(roc_svm, col = "green")

# Add legend
legend("bottomright", legend = c("Decision Tree", "Random Forest", "SVM"),
       col = c("red", "blue", "green"), lty = 1)
