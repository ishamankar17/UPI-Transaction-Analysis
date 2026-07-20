desc monthly_upi_stats;

select count(*) from monthly_upi_stats;
select * from monthly_upi_stats;
----check for null rows
SELECT
  SUM(CASE WHEN month IS NULL THEN 1 ELSE 0 END) AS null_month,
  SUM(CASE WHEN no_of_banks_live_on_upi IS NULL THEN 1 ELSE 0 END) AS null_banks,
  SUM(CASE WHEN volume_in_mn IS NULL THEN 1 ELSE 0 END) AS null_volume,
  SUM(CASE WHEN value_in_cr IS NULL THEN 1 ELSE 0 END) AS null_value
FROM monthly_upi_stats;

---
-- Rows where no_of_banks_live_on_upi isn't a clean number
SELECT * FROM monthly_upi_stats
WHERE TRANSLATE(no_of_banks_live_on_upi, ' 0123456789', ' ') IS NOT NULL;

-- Rows where volume_in_mn isn't a clean number
SELECT * FROM monthly_upi_stats
WHERE TRANSLATE(volume_in_mn, ' 0123456789.,', ' ') IS NOT NULL;

---Remove commas/spaces (common in numbers copied from reports)
UPDATE monthly_upi_stats
SET no_of_banks_live_on_upi = REPLACE(TRIM(no_of_banks_live_on_upi), ',', ''),
    volume_in_mn = REPLACE(TRIM(volume_in_mn), ',', '');

--------Convert cleaned text columns to proper numbers (create new columns)    
ALTER TABLE monthly_upi_stats ADD (
    no_of_banks_live_on_upi_num NUMBER,
    volume_in_mn_num NUMBER
);

UPDATE monthly_upi_stats
SET no_of_banks_live_on_upi_num = TO_NUMBER(no_of_banks_live_on_upi),
    volume_in_mn_num = TO_NUMBER(volume_in_mn);
 
---Handle non-numeric placeholders (N/A, -, blank) before converting
ALTER TABLE monthly_upi_stats
ADD (
    BANKS NUMBER,
    VOLUME NUMBER
);

UPDATE monthly_upi_stats
SET
    BANKS = TO_NUMBER(no_of_banks_live_on_upi),
    VOLUME = TO_NUMBER(volume_in_mn);

----Check for duplicate months  
UPDATE monthly_upi_stats
SET no_of_banks_live_on_upi = NULL
WHERE no_of_banks_live_on_upi IN ('N/A', '-', 'NA');

UPDATE monthly_upi_stats
SET volume_in_mn = NULL
WHERE volume_in_mn IN ('N/A', '-', 'NA');

------Check for duplicate months
SELECT month, COUNT(*)
FROM monthly_upi_stats
GROUP BY month
HAVING COUNT(*) > 1;

----Check date range / invalid months
SELECT MIN(month), MAX(month), COUNT(*)
FROM monthly_upi_stats;

-----Check for negative or zero values (shouldn't happen for volume/value)
SELECT * FROM monthly_upi_stats
WHERE value_in_cr <= 0 OR volume_in_mn_num <= 0;

-----Final row count check
SELECT COUNT(*) FROM monthly_upi_stats;

ALTER TABLE monthly_upi_stats DROP COLUMN no_of_banks_live_on_upi;
ALTER TABLE monthly_upi_stats DROP COLUMN volume_in_mn;
ALTER TABLE monthly_upi_stats RENAME COLUMN no_of_banks_live_on_upi_num TO no_of_banks_live_on_upi;
ALTER TABLE monthly_upi_stats RENAME COLUMN volume_in_mn_num TO volume_in_mn;