desc upi_transactions_2024;

select count(*) from upi_transactions_2024;

-- Check how many are actually blank
SELECT COUNT(*) FROM upi_transactions_2024 WHERE transaction_id IS NULL;

-- Delete the blank padding rows
DELETE FROM upi_transactions_2024 WHERE transaction_id IS NULL;

COMMIT;

---Check for NULLs in every column
SELECT
  SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS null_txn_id,
  SUM(CASE WHEN amount_inr IS NULL THEN 1 ELSE 0 END) AS null_amount,
  SUM(CASE WHEN sender_state IS NULL THEN 1 ELSE 0 END) AS null_state,
  SUM(CASE WHEN transaction_status IS NULL THEN 1 ELSE 0 END) AS null_status
FROM upi_transactions_2024;

---Find duplicate transaction IDs
SELECT transaction_id, COUNT(*)
FROM upi_transactions_2024
GROUP BY transaction_id
HAVING COUNT(*) > 1;

----Remove duplicates
DELETE FROM upi_transactions_2024
WHERE ROWID NOT IN (
    SELECT MIN(ROWID)
    FROM upi_transactions_2024
    GROUP BY transaction_id
);

---Trim extra spaces from text columns
UPDATE upi_transactions_2024
SET sender_state = TRIM(sender_state),
    sender_bank  = TRIM(sender_bank),
    receiver_bank = TRIM(receiver_bank),
    device_type  = TRIM(device_type);

---- Fix inconsistent casing     
UPDATE upi_transactions_2024
SET transaction_status = UPPER(TRIM(transaction_status)),
    device_type = INITCAP(TRIM(device_type));

-----Find invalid/negative amounts
SELECT * FROM upi_transactions_2024
WHERE amount_inr <= 0 OR amount_inr IS NULL;

---Find invalid fraud_flag / is_weekend values 
SELECT DISTINCT fraud_flag FROM upi_transactions_2024
WHERE fraud_flag NOT IN (0,1);

--Find invalid fraud_flag / is_weekend values (should only be 0 or 1)
SELECT DISTINCT is_weekend FROM upi_transactions_2024
WHERE is_weekend NOT IN (0,1);

SELECT DISTINCT fraud_flag FROM upi_transactions_2024
WHERE fraud_flag NOT IN (0,1);

------Find invalid hour_of_day (should be 0–23)
SELECT * FROM upi_transactions_2024
WHERE hour_of_day NOT BETWEEN 0 AND 23;

-----Check distinct values to catch typos (e.g. in state, bank names)
SELECT DISTINCT is_weekend FROM upi_transactions_2024
WHERE is_weekend NOT IN (0,1);

---Check distinct values to catch typos (e.g. in state, bank names)
SELECT DISTINCT sender_state FROM upi_transactions_2024 ORDER BY 1;
SELECT DISTINCT sender_bank FROM upi_transactions_2024 ORDER BY 1;
SELECT DISTINCT network_type FROM upi_transactions_2024 ORDER BY 1;

SELECT
    fraud_flag,
    COUNT(*) AS total_rows
FROM upi_transactions_2024
GROUP BY fraud_flag;
-----final check
SELECT COUNT(*) FROM upi_transactions_2024;
select * from upi_transactions_2024;