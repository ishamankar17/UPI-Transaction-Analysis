---Transactions by State
SELECT
    u.sender_state,
    COUNT(*) AS total_transactions
FROM upi_transactions_2024 u
GROUP BY u.sender_state
ORDER BY total_transactions DESC;

-----Transaction Amount by State
SELECT
    u.sender_state,
    COUNT(*) AS total_transactions,
    SUM(u.amount_inr) AS total_transaction_amount
FROM upi_transactions_2024 u
GROUP BY u.sender_state
ORDER BY total_transaction_amount DESC;

---GDP vs Transactions
SELECT
    d.state,
    d.nominal_gdp_trillion_inr,
    COUNT(u.transaction_id) AS total_transactions,
    NVL(SUM(u.amount_inr),0) AS total_amount
FROM dim_state d
LEFT JOIN upi_transactions_2024 u
ON TRIM(UPPER(d.state)) = TRIM(UPPER(u.sender_state))
GROUP BY
    d.state,
    d.nominal_gdp_trillion_inr
ORDER BY d.nominal_gdp_trillion_inr DESC;

----Population vs Transactions
SELECT
    d.state,
    d.total_population,
    COUNT(u.transaction_id) AS total_transactions
FROM dim_state d
LEFT JOIN upi_transactions_2024 u
ON TRIM(UPPER(d.state)) = TRIM(UPPER(u.sender_state))
GROUP BY
    d.state,
    d.total_population
ORDER BY d.total_population DESC;

----- Top 10 State by Transaction
SELECT state,
    nominal_gdp_trillion_inr
FROM dim_state
ORDER BY nominal_gdp_trillion_inr DESC
FETCH FIRST 10 ROWS ONLY;

----Top 10 States by Population
SELECT
    state,
    total_population
FROM dim_state
ORDER BY total_population DESC
FETCH FIRST 10 ROWS ONLY;

---Top 10 States by Transaction Amount
SELECT
    sender_state,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY sender_state
ORDER BY total_amount DESC
FETCH FIRST 10 ROWS ONLY;

-----Lowest GDP
SELECT
    state,
    nominal_gdp_trillion_inr
FROM dim_state
ORDER BY nominal_gdp_trillion_inr
FETCH FIRST 10 ROWS ONLY;

----Lowest Population
SELECT
    state,
    total_population
FROM dim_state
ORDER BY total_population
FETCH FIRST 10 ROWS ONLY;

----Lowest Transaction Amount
SELECT
    sender_state,
    SUM(amount_inr) AS total_amount
FROM upi_transactions_2024
GROUP BY sender_state
ORDER BY total_amount
FETCH FIRST 10 ROWS ONLY;

----Map Visualization Dataset
SELECT
    d.state,
    d.total_population,
    d.nominal_gdp_trillion_inr,
    COUNT(u.transaction_id) AS total_transactions,
    SUM(u.amount_inr) AS total_transaction_amount
FROM dim_state d
JOIN upi_transactions_2024 u
ON d.state=u.sender_state
GROUP BY
    d.state,
    d.total_population,
    d.nominal_gdp_trillion_inr;

---Average Transaction Amount by State
SELECT
    sender_state,
    ROUND(AVG(amount_inr),2) AS avg_transaction_amount
FROM upi_transactions_2024
GROUP BY sender_state
ORDER BY avg_transaction_amount DESC;

-----Success Rate by State
SELECT
    sender_state,
    ROUND(
        COUNT(CASE WHEN UPPER(TRIM(transaction_status))='SUCCESS' THEN 1 END)
        *100/COUNT(*),2
    ) AS success_rate
FROM upi_transactions_2024
GROUP BY sender_state
ORDER BY success_rate DESC;

----Fraud Rate by State
SELECT
    sender_state,
    ROUND(
        SUM(fraud_flag)*100/COUNT(*),2
    ) AS fraud_rate
FROM upi_transactions_2024
GROUP BY sender_state
ORDER BY fraud_rate DESC;

select * from dim_state;