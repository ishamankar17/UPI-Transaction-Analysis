---Total Trsansaction
SELECT COUNT(*) AS total_transactions
FROM upi_transactions_2024;

----- Total Transaction amount
SELECT SUM(amount_inr) AS total_transaction_amount
FROM upi_transactions_2024;

----Average Transaction Amount
SELECT ROUND(AVG(amount_inr),2) AS average_transaction_amount
FROM upi_transactions_2024;

------Success rate %

FROM upi_transactions_2024;
SELECT transaction_status, COUNT(*)
FROM upi_transactions_2024
GROUP BY transaction_status;

SELECT ROUND(
       COUNT(CASE
             WHEN UPPER(TRIM(transaction_status))='SUCCESS'
             THEN 1
       END) * 100 / COUNT(*),2) AS success_rate
FROM upi_transactions_2024;

---fraud rate %
SELECT ROUND(
       SUM(fraud_flag)*100/COUNT(*),2) AS fraud_rate
FROM upi_transactions_2024;


------Monthly Transaction Trend
--Transaction Count
SELECT
    month_no,
    month,
    COUNT(*) AS total_transactions
FROM upi_transactions_2024
GROUP BY month_no, month
ORDER BY month_no;

---transaction amount
SELECT
    month_no,
    month,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY month_no, month
ORDER BY month_no;

---Transaction Type Analysis
SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY transaction_type
ORDER BY total_transactions DESC;

--Merchant Category Analysis
SELECT
    merchant_category,
    COUNT(*) AS transaction_count,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY merchant_category
ORDER BY transaction_count DESC;

---Sender State Analysis
SELECT
    sender_state,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY sender_state
ORDER BY total_transactions DESC;

---Sender bank Analysis
SELECT
    sender_bank,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY sender_bank
ORDER BY total_transactions DESC;

--Receiver Bank Analysis
SELECT
    receiver_bank,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY receiver_bank
ORDER BY total_transactions DESC;

----Device Usage
SELECT
    device_type,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY device_type
ORDER BY total_transactions DESC;

---Network Type
SELECT
    network_type,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY network_type
ORDER BY total_transactions DESC;

---Age Group Analysis

-------sender age group
SELECT
    sender_age_group,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY sender_age_group
ORDER BY total_transactions DESC;

----Reciever age group
SELECT
    receiver_age_group,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY receiver_age_group
ORDER BY total_transactions DESC;

--Hourly Trend
SELECT
    hour_of_day,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY hour_of_day
ORDER BY hour_of_day;

---- weekday vs weekend trend
SELECT
    CASE
        WHEN is_weekend=1 THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY is_weekend;

----Fraud analysis
---fraud count by state

SELECT
    sender_state,
    COUNT(*) AS fraud_transactions
FROM upi_transactions_2024
WHERE fraud_flag=1
GROUP BY sender_state
ORDER BY fraud_transactions DESC;

---fraud amount by state
SELECT
    sender_state,
    SUM(amount_inr) AS fraud_amount
FROM upi_transactions_2024
WHERE fraud_flag=1
GROUP BY sender_state
ORDER BY fraud_amount DESC;

--Fraud Count by Merchant Category
SELECT
    merchant_category,
    COUNT(*) AS fraud_transactions
FROM upi_transactions_2024
WHERE fraud_flag=1
GROUP BY merchant_category
ORDER BY fraud_transactions DESC;

---Fraud amount
SELECT
    merchant_category,
    SUM(amount_inr) AS fraud_amount
FROM upi_transactions_2024
WHERE fraud_flag=1
GROUP BY merchant_category
ORDER BY fraud_amount DESC;

---Fraud Count by Device
SELECT
    device_type,
    COUNT(*) AS fraud_transactions
FROM upi_transactions_2024
WHERE fraud_flag=1
GROUP BY device_type
ORDER BY fraud_transactions DESC;

---Fraud Amount by device
SELECT
    device_type,
    SUM(amount_inr) AS fraud_amount
FROM upi_transactions_2024
WHERE fraud_flag=1
GROUP BY device_type
ORDER BY fraud_amount DESC;

--Transaction Status Distribution
SELECT
    transaction_status,
    COUNT(*) AS total_transactions
FROM upi_transactions_2024
GROUP BY transaction_status;

-----Quarterly Trend
SELECT
    quarter,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY quarter
ORDER BY quarter;

-----Day of Week Analysis
SELECT
    day_of_week,
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY day_of_week
ORDER BY CASE day_of_week
    WHEN 'Monday' THEN 1
    WHEN 'Tuesday' THEN 2
    WHEN 'Wednesday' THEN 3
    WHEN 'Thursday' THEN 4
    WHEN 'Friday' THEN 5
    WHEN 'Saturday' THEN 6
    WHEN 'Sunday' THEN 7
END;

------Top 10 Highest Spending States
SELECT
    sender_state,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY sender_state
ORDER BY total_amount DESC
FETCH FIRST 10 ROWS ONLY;