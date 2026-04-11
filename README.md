# DA-FINAL-PROJECT-FRAUD-DETECTION
####Banking Fraud Detection Analysis
#### Project Overview
### Analyze banking transactions to detect fraud patterns and improve security systems.
## SQL Tasks
🔴 2. SQL (Structured Analysis + Business Queries)
1) Suspicious transactions

High amount OR fraud
Example: Amount > 3× average
Example: Known fraud flagged

2) Fraud rate

(fraud / total) * 100
Example: Measure dataset imbalance
Example: Track fraud severity

3) Transactions per user (simulated)

Created pseudo user using time bucket
Example: Group activity in short time window
Example: Simulate user behavior

4) High-risk accounts

High fraud count OR high avg amount
Example: Frequent fraud → risky
Example: Large transactions → suspicious

5) Average transaction value

AVG(Amount)
Example: Detect abnormal spikes
Example: Compare fraud vs normal

6) Peak fraud time

Convert seconds → hour
Example: Night fraud patterns
Example: Time-based clustering

7) Rank accounts by risk

Risk score = fraud + volume
Example: High fraud frequency ranks top
Example: Heavy transaction volume adds risk

## Pandas Tasks
1. Python (Data Processing + Analysis)
Steps:

1) Load dataset

Read CSV, inspect structure
Example: Check fraud vs non-fraud distribution
Example: Identify extreme transaction values

2) Clean data

Remove duplicates
Scale Amount
Example: Duplicate fraud entries inflate results
Example: Large values dominate analysis

3) Analyze transactions

Count transactions, fraud cases
Time-based analysis (hour patterns)
Example: Fraud spikes at night
Example: High-value transactions more risky

4) Detect anomalies

Z-score / Isolation Forest
Example: Sudden huge transaction
Example: Rapid multiple transactions

5) Risk segmentation

Combine amount + anomaly → risk score
Example: High amount + anomaly = High risk
Example: Normal behavior = Low risk

6) Fraud % calculation

Fraud / total transactions
Example: 0.1–0.3% = realistic
Example: >5% = suspicious dataset

7) Top fraud cases

Sort fraud transactions by value
Example: Highest loss cases
Example: Repeated fraud patterns
## Power BI Tasks
🔴 3. Power BI (Visualization + Business Story)
1) Fraud trend dashboard

Line chart: fraud vs total over time
Example: Identify spikes
Example: Compare volume vs fraud

2) Transaction analysis

Column chart: hourly distribution
Example: High volume, low fraud = safe
Example: Low volume, high fraud = suspicious

3) Risk segmentation

DAX-based classification
Example: High amount + fraud = High risk
Example: Normal transaction = Low risk

4) Heatmap

Matrix: hour × risk
Example: Fraud concentrated at certain hours
Example: Risk clusters visible

5) Pie chart

Fraud distribution by segment
Example: Most fraud in medium risk
Example: High risk smaller but critical

6) KPI cards

Fraud rate
Total transactions
Fraud transactions
Alert logic
Example: Fraud > threshold → alert
Example: Sudden increase triggers investigation
## Dataset
### Kaggle Fraud Detection dataset

.
