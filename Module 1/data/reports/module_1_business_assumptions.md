# Module 1 — Business Assumptions

## 1. Dataset Assumption

The DataCo Smart Supply Chain dataset is used as the historical supply-chain dataset for this project.

The dataset contains 180,519 records and 53 original columns.

## 2. Prediction Target

The target variable is `late_delivery_risk`.

- 0 = No late-delivery risk
- 1 = Late-delivery risk

## 3. Shipping Delay Definition

Shipping delay is calculated as:

Shipping Delay Days =
Actual Shipping Days − Scheduled Shipping Days

A positive value indicates that actual shipping duration exceeded the scheduled duration.

## 4. Customer Privacy

Customer personally identifiable information was removed from the analytical dataset.

Removed fields include customer email, name, password, street, and zipcode.

These fields are not required for supply-chain delay analysis.

## 5. Missing Data Assumption

Columns with extremely high missing values were removed.

`Product Description` was completely missing, while `Order Zipcode` had approximately 86% missing values.

After removing these fields and customer PII, no missing values remained in the cleaned dataset.

## 6. Duplicate Data Assumption

No exact duplicate rows were found in the original dataset.

Therefore, no duplicate records were removed.

## 7. Date Assumption

Order date and shipping date were converted into datetime format.

These dates were used to derive time-based analytical features.

## 8. Data Leakage Assumption

Variables that contain information about the actual shipping outcome were not used as predictive inputs.

Examples include:

- Delivery Status
- Days for Shipping (Real)
- Shipping Date
- Shipping Delay Days

These variables remain useful for historical analysis and validation.

## 9. Train-Test Split

The model-ready data was divided into:

- 80% training data
- 20% testing data

A stratified split was used so that the proportion of late and non-late records remained approximately equal in both datasets.

## 10. Dataset Limitation

The DataCo dataset is primarily an e-commerce supply-chain dataset.

It does not contain detailed supplier-level information such as supplier capacity, supplier reliability, or supplier-specific cost.

Therefore, the analysis focuses primarily on shipment and delivery performance rather than supplier optimization.

## 11. Module 1 Scope

Module 1 is responsible for:

- Data collection
- Data profiling
- Data cleaning
- Supply-chain analysis
- Feature engineering
- Data validation
- Train-test preparation
- Business assumptions
- Model-ready data handoff

