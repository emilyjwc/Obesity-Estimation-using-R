# Obesity Level Estimation using R 📊

Statistical analysis and machine learning project estimating obesity levels based on eating habits and physical condition. Achieved **90% accuracy** using an ensemble of classification models.

## Report

📄 [View Full Report (PDF)](https://github.com/emilyjwc/Obesity-Estimation-using-R/blob/main/IS%20507%20Final%20Project%20.pdf)

## Overview

This project analyzes the relationship between lifestyle factors (eating habits, physical activity, water intake) and obesity levels using statistical methods and machine learning models in R.

## Key Results

- **90% accuracy** in predicting obesity levels
- Identified key lifestyle factors most correlated with obesity through feature selection and ANOVA
- Built and compared multiple ML models to find the best performer

## Methods

- **Statistical Analysis** — ANOVA models and post-hoc tests to identify correlations between eating habits, physical condition, and obesity levels
- **Feature Selection** — Variable importance analysis using Random Forest
- **Machine Learning Models:**
  - Decision Tree
  - Random Forest
  - Support Vector Machine (SVM)

## Dataset

- `ObesityDataSet.csv` — cleaned dataset
- `ObesityDataSet_raw_and_data_sinthetic.csv` — raw dataset with synthetic data

## Repository Structure

```
├── main.R                          # Main analysis script
├── feature selection.R             # Feature importance analysis
├── recategorized.R                 # Data preprocessing
├── summary matrix.R                # Model evaluation
├── Variable Importance (rf).R      # Random Forest variable importance
├── factors line chart.R            # Visualization
├── Comparison of *.R               # ANOVA comparison scripts
├── ObesityDataSet.csv              # Dataset
└── IS 507 Final Project .pdf       # Full project report
```

## Tech Stack

- **Language:** R
- **Libraries:** caret, randomForest, e1071, ggplot2

## Author

Emily Chang — [LinkedIn](https://linkedin.com/in/emilyjwchang) · [Portfolio](https://emilychang.netlify.app)
