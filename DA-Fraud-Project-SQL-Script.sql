create database fraud_detection;
use fraud_detection;


-- This dataset does NOT have user_id/account_id
-- So if you blindly write “per user” queries, you’re faking analysis.

-- Creating a pseudo user (account_id) using logic

-- Creating pseudo account_id using transaction pattern
-- (because dataset does not have user_id)

-- ============================================
-- FRAUD ANALYSIS SQL PROJECT
-- Dataset: creditcard.csv
-- ============================================

-- Step 0: Create Table
CREATE TABLE transactions (
    Time FLOAT,
    V1 FLOAT,
    V2 FLOAT,
    V3 FLOAT,
    V4 FLOAT,
    V5 FLOAT,
    V6 FLOAT,
    V7 FLOAT,
    V8 FLOAT,
    V9 FLOAT,
    V10 FLOAT,
    V11 FLOAT,
    V12 FLOAT,
    V13 FLOAT,
    V14 FLOAT,
    V15 FLOAT,
    V16 FLOAT,
    V17 FLOAT,
    V18 FLOAT,
    V19 FLOAT,
    V20 FLOAT,
    V21 FLOAT,
    V22 FLOAT,
    V23 FLOAT,
    V24 FLOAT,
    V25 FLOAT,
    V26 FLOAT,
    V27 FLOAT,
    V28 FLOAT,
    Amount FLOAT,
    Class INT
);

SET GLOBAL LOCAL_INFILE=ON;
LOAD DATA LOCAL INFILE 'C:/Users/vemul/Downloads/creditcard.csv/creditcard.csv' INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from transactions limit 1;


-- Load data using MySQL import or Workbench manually


-- ============================================
-- STEP 1: Find Suspicious Transactions
-- Logic: High amount OR flagged fraud
-- ============================================

SELECT *
FROM transactions
WHERE Amount > (
    SELECT AVG(Amount) * 3 FROM transactions
)
OR Class = 1;


-- Example meaning:
-- 1) Transaction much higher than average
-- 2) Already labeled as fraud


-- ============================================
-- STEP 2: Calculate Fraud Rate
-- ============================================

SELECT 
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_transactions,
    (SUM(Class) / COUNT(*)) * 100 AS fraud_percentage
FROM transactions;


-- ============================================
-- STEP 3: Retrieve Transactions per User
-- Since no user_id → create pseudo user
-- Logic: group by rounded Time bucket
-- ============================================

SELECT 
    FLOOR(Time / 10000) AS pseudo_user_id,
    COUNT(*) AS transaction_count,
    SUM(Amount) AS total_amount
FROM transactions
GROUP BY FLOOR(Time / 10000)
ORDER BY transaction_count DESC;


-- Example:
-- 1) Cluster of transactions in short time window
-- 2) Simulates user behavior


-- ============================================
-- STEP 4: Identify High Risk Accounts
-- Logic:
-- High fraud count OR high avg transaction
-- ============================================

SELECT 
    FLOOR(Time / 10000) AS pseudo_user_id,
    COUNT(*) AS total_txns,
    SUM(Class) AS fraud_count,
    AVG(Amount) AS avg_amount
FROM transactions
GROUP BY FLOOR(Time / 10000)
HAVING fraud_count > 0 
   OR avg_amount > (SELECT AVG(Amount) FROM transactions)
ORDER BY fraud_count DESC, avg_amount DESC;


-- ============================================
-- STEP 5: Calculate Average Transaction Value
-- ============================================

SELECT 
    AVG(Amount) AS avg_transaction_value
FROM transactions;


-- ============================================
-- STEP 6: Find Peak Fraud Time
-- Convert Time (seconds) → hour bucket
-- ============================================

SELECT 
    FLOOR(Time / 3600) AS hour_bucket,
    COUNT(*) AS total_txns,
    SUM(Class) AS fraud_txns
FROM transactions
GROUP BY hour_bucket
ORDER BY fraud_txns DESC
LIMIT 5;


-- Example:
-- 1) Night time spikes
-- 2) Fraud clustered in certain hours


-- ============================================
-- STEP 7: Rank Accounts by Risk
-- Risk = fraud_count + high transaction volume
-- ============================================

SELECT 
    FLOOR(Time / 10000) AS pseudo_user_id,
    COUNT(*) AS total_txns,
    SUM(Class) AS fraud_count,
    (SUM(Class) * 2 + COUNT(*) * 0.5) AS risk_score,
    RANK() OVER (ORDER BY (SUM(Class) * 2 + COUNT(*) * 0.5) DESC) AS risk_rank
FROM transactions
GROUP BY FLOOR(Time / 10000);


-- ============================================
-- END OF PROJECT
-- ============================================
