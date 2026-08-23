SupplyPrescript — Module 1

Data Preparation & Supply Chain Analysis

1. Module Overview

Module 1 prepares a clean, reliable, analyzed, and model-ready historical supply-chain dataset for the SupplyPrescript project.

Objectives

Prepare historical supply-chain records

Handle missing, duplicate, inconsistent, and incorrect values

Analyze shipment lead-time and delay patterns

Create useful predictive features

Prepare prediction targets

Split data into training and testing datasets

Document important business assumptions

Output

Clean, analyzed, model-ready supply-chain dataset

2. Dataset

Dataset: DataCo Smart Supply Chain Dataset

Description

Value

Original records

180,519

Original columns

53

Cleaned columns

45

Feature-engineered columns

56

Model-ready predictive features

39

Training records

144,415

Testing records

36,104

3. Module 1 Workflow

Historical Supply Chain Data
            |
            v
      Data Profiling
            |
            v
       Data Cleaning
            |
            v
 Supply Chain EDA
            |
            v
   Feature Engineering
            |
            v
 Leakage Prevention
            |
            v
    Train/Test Split
            |
            v
    Model-Ready Data
            |
            v
       Module 2

4. Project Structure

Module 1/
│
├── data/
│   ├── raw/
│   │   ├── DataCoSupplyChainDataset.csv
│   │   └── DescriptionDataCoSupplyChain.csv
│   │
│   ├── cleaned/
│   │   └── supply_chain_clean.csv
│   │
│   ├── processed/
│   │   └── supply_chain_feature_engineered.csv
│   │
│   └── model_ready/
│       ├── X_train.csv
│       ├── X_test.csv
│       ├── y_train.csv
│       ├── y_test.csv
│       ├── delay_y_train.csv
│       └── delay_y_test.csv
│
├── notebooks/
│   ├── 01_data_profiling.ipynb
│   ├── 02_supply_chain_eda.ipynb
│   ├── 03_feature_engineering.ipynb
│   └── 04_model_ready_data.ipynb
│
├── reports/
│   ├── module_1_business_assumptions.md
│   └── data_dictionary.md
│
├── sql/
│   └── supply_chain_validation.sql
│
└── README.md

5. Data Profiling

The raw dataset was loaded and profiled using Python and Pandas.

Checks included:

Dataset dimensions

Column names

Data types

Missing values

Duplicate records

Categorical distributions

Shipping modes

Delivery status

Late-delivery risk distribution

Findings

Total records: 180,519

Original columns: 53

Duplicate rows: 0

Product Description: 100% missing

Order Zipcode: approximately 86.24% missing

Minor missing values existed in customer fields

The raw dataset was preserved before cleaning.

6. Data Cleaning

A separate working copy was created so the raw dataset remained unchanged.

Personal information removed

Customer Email

Customer Fname

Customer Lname

Customer Password

Customer Street

Customer Zipcode

These fields were not required for supply-chain analysis or prediction.

Highly incomplete fields removed

Product Description

Order Zipcode

Duplicate handling

No exact duplicate rows were found.

Duplicate rows = 0

Date cleaning

Converted to datetime:

order_date_dateorders
shipping_date_dateorders

Final cleaned dataset

Rows:              180,519
Columns:                45
Missing values:          0
Duplicate rows:          0

7. Exploratory Data Analysis

EDA covered:

Overall late-delivery risk

Shipping mode

Market

Region

Product category

Customer segment

Shipping-delay distribution

Scheduled shipping duration

Monthly shipment volume

Monthly late-delivery rate

8. Overall Late-Delivery Risk

Target:

late_delivery_risk
0 = No late-delivery risk
1 = Late-delivery risk

Category

Records

Percentage

No late-delivery risk

81,542

45.17%

Late-delivery risk

98,977

54.83%

Finding

More than half of the historical records were classified as having late-delivery risk.

9. Shipping Mode Analysis

Shipping Mode

Shipments

Late-risk records

Late-risk rate

First Class

27,814

26,513

95.32%

Second Class

35,216

26,987

76.63%

Same Day

9,737

4,454

45.74%

Standard Class

107,752

41,023

38.07%

Finding

First Class had the highest observed late-delivery risk at 95.32%, while Standard Class had the lowest at 38.07%.

This is a descriptive association and does not establish causation.

10. Market Analysis

Late-delivery rates across broad markets were relatively close, generally around the mid-50% range.

Finding

Late-delivery risk was relatively consistent across broad markets. More detailed regional and operational analysis was therefore also performed.

11. Region Analysis

Regional differences were more noticeable than broad market differences.

Observed examples:

Central Africa was among the higher-risk regions at approximately 58%.

Canada was among the lower-risk regions at approximately 48–49%.

Finding

Regional analysis provided more visible variation than broad market analysis.

12. Product Category Analysis

Product categories showed substantial variation in observed late-delivery risk.

The highest observed category was approximately 69%, while some categories were below 50%.

Finding

Certain product categories showed higher historical delivery risk and may require further operational investigation.

13. Customer Segment Analysis

The major customer segments were:

Consumer

Corporate

Home Office

Late-delivery risk was relatively similar across the segments, around 54–55%.

Finding

Customer segment showed less variation than shipping mode, region, and product category.

14. Shipping Delay Analysis

Shipping delay was calculated as:

shipping_delay_days =
days_for_shipping_real - days_for_shipment_scheduled

Difference

Shipments

Percentage

-2 days

21,666

12.00%

-1 day

21,700

12.02%

0 days

33,753

18.70%

+1 day

60,647

33.60%

+2 days

28,718

15.91%

+3 days

7,052

3.91%

+4 days

6,983

3.87%

Findings

57.29% exceeded their scheduled shipping duration.

33.60% exceeded it by approximately one day.

18.70% matched the scheduled duration.

24.02% were completed faster than scheduled.

This measures the difference between actual and scheduled shipping duration and should not automatically be interpreted as final customer-facing delivery lateness.

15. Lead-Time Analysis

The feature order_to_shipping_days represents the elapsed time between order placement and shipping.

Observed statistics:

Mean:      3.47 days
Median:    3 days
Minimum:   0 days
Maximum:   6 days

16. Feature Engineering

The following analytical features were created:

shipping_delay_days
order_to_shipping_days
order_year
order_month
order_month_name
order_quarter
order_day_of_week
order_week
shipping_performance
value_per_item

Feature meanings

shipping_delay_days: actual shipping duration minus scheduled duration

order_to_shipping_days: elapsed days from order to shipping

order_year: year from order date

order_month: month number from order date

order_month_name: month name

order_quarter: quarter

order_day_of_week: day name

order_week: ISO week number

shipping_performance: Faster than scheduled / On schedule / Slower than scheduled

value_per_item: order item total divided by quantity

17. Prediction Targets

Two targets were prepared for Module 2.

17.1 late_delivery_risk

0 = No late-delivery risk
1 = Late-delivery risk

This is the classification target.

17.2 delay_duration_days

Calculated as:

max(shipping_delay_days, 0)

Therefore:

shipping_delay_days    delay_duration_days
        -2                     0
        -1                     0
         0                     0
        +1                     1
        +2                     2
        +3                     3
        +4                     4

This is the prepared target for expected delay duration.

18. Data Leakage Prevention

Outcome information was excluded from predictive model inputs where it would cause leakage.

Examples include:

delivery_status
shipping_date_dateorders
days_for_shipping_real
shipping_delay_days
delay_duration_days
order_to_shipping_days
shipping_performance

These fields remain in the master processed dataset for historical analysis, validation, and future actual-outcome evaluation.

The distinction is:

Master dataset
    |
    +--> Historical outcome information
    |
    +--> Analytical information
    |
    +--> Model-ready predictive features

19. Train/Test Split

The model-ready data uses an 80/20 stratified train/test split based on late_delivery_risk.

Dataset

Records

Predictive features

Training

144,415

39

Testing

36,104

39

The target distribution was preserved between training and testing data.

Validation confirmed:

Training feature rows match: True
Testing feature rows match: True

20. Model-Ready Files

X_train.csv
X_test.csv

y_train.csv
y_test.csv

delay_y_train.csv
delay_y_test.csv

Meaning:

X_train / X_test
        |
        +--> Predictive features

y_train / y_test
        |
        +--> late_delivery_risk

delay_y_train / delay_y_test
        |
        +--> delay_duration_days

21. Business Assumptions

The DataCo Smart Supply Chain dataset is treated as the historical supply-chain dataset for this implementation.

late_delivery_risk is treated as the classification target.

delay_duration_days is treated as the delay-duration target.

Shipping delay is defined as actual shipping duration minus scheduled shipping duration.

Customer personal information is not required for supply-chain prediction and is removed from analytical/model-ready data.

Highly incomplete fields were removed where they did not provide sufficient analytical value.

Historical outcome fields remain in the master dataset for analysis and future evaluation but are excluded from predictive inputs when they would create data leakage.

The train/test split uses stratification to preserve target proportions.

The dataset does not provide detailed supplier capacity, supplier reliability, warehouse capacity, alternative supplier costs, or detailed freight costs. Such information should be supplied as business inputs in the optimization stage rather than artificially generated.

22. Data Limitations

The dataset is primarily an e-commerce supply-chain dataset.

Detailed information is not directly available for every future prescriptive-optimization requirement, including:

Supplier capacity

Supplier reliability

Warehouse capacity

Alternative supplier costs

Air-freight costs

Inventory constraints

Detailed transportation capacity

No artificial supplier or cost values were introduced during Module 1.

23. Module 1 Deliverables

Data

Raw historical dataset

Cleaned dataset

Feature-engineered dataset

Model-ready training dataset

Model-ready testing dataset

Analysis

Data profiling

Missing-value analysis

Duplicate analysis

Lead-time analysis

Delay analysis

Shipping-mode analysis

Market analysis

Regional analysis

Product-category analysis

Customer-segment analysis

Monthly trend analysis

Modeling Preparation

late_delivery_risk

delay_duration_days

39 predictive features

Training dataset

Testing dataset

Leakage prevention

Documentation

Business assumptions

Data dictionary

Module 1 README

24. Technologies Used

Python

Pandas

NumPy

Matplotlib

Scikit-learn

SQL

25. Notebook Responsibilities

01_data_profiling.ipynb

Load raw data

Inspect structure

Check data types

Check missing values

Check duplicates

Review categorical distributions

02_supply_chain_eda.ipynb

Overall shipment analysis

Delay analysis

Shipping-mode analysis

Market analysis

Regional analysis

Product-category analysis

Customer-segment analysis

Time-based analysis

03_feature_engineering.ipynb

Date features

Shipping-delay calculation

Lead-time calculation

Shipping-performance classification

Value-per-item calculation

Delay-duration target

04_model_ready_data.ipynb

Select predictive inputs

Remove leakage fields

Define targets

Create train/test datasets

Save model-ready files

Validate final datasets

26. Module 1 → Module 2 Handoff

                 MODULE 1
                     |
                     v
        Historical Supply Chain Data
                     |
                     v
       Cleaning + EDA + Feature Engineering
                     |
                     v
             Leakage Prevention
                     |
                     v
              Train/Test Split
                     |
             +-------+-------+
             |               |
             v               v
   late_delivery_risk   delay_duration_days
             |               |
             v               v
      Classification      Duration
          Target            Target
             |               |
             +-------+-------+
                     |
                     v
                  MODULE 2
             Predictive Delay Model

Module 2 will use the prepared data to predict:

Delay probability

Expected delay duration

27. Final Module 1 Status

MODULE 1 — COMPLETE

Requirement

Status

Historical data preparation

✅

Data profiling

✅

Missing-value handling

✅

Duplicate checking

✅

Inconsistent/incorrect value validation

✅

PII removal

✅

Lead-time analysis

✅

Delay analysis

✅

Supply-chain EDA

✅

Feature engineering

✅

Classification target

✅

Delay-duration target

✅

Leakage prevention

✅

Train/test split

✅

Business assumptions

✅

Data dictionary

✅

Model-ready dataset

✅

Final validation

✅

Final Output

180,519 historical records
56 feature-engineered columns
39 predictive features
144,415 training records
36,104 testing records
2 prediction targets
0 missing values in the master processed dataset
0 duplicate rows

Module 1 is ready for handoff to Module 2 — Predictive Delay Model.
