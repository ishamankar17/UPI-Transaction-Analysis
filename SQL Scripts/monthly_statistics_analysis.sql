---Toatl UPI Value
SELECT
    SUM(value_in_cr) AS total_upi_value_cr
FROM monthly_upi_stats;

---Total UPI Volume
SELECT
    SUM(volume_in_mn) AS total_upi_volume_mn
FROM monthly_upi_stats;

----Average Monthly Volume
SELECT
    ROUND(AVG(volume_in_mn),2) AS avg_monthly_volume
FROM monthly_upi_stats;

--Banks Live on UPI
SELECT
    no_of_banks_live_on_upi
FROM monthly_upi_stats
WHERE month=(SELECT MAX(month) FROM monthly_upi_stats);

--Monthly Volume Trend
SELECT
    month,
    volume_in_mn
FROM monthly_upi_stats
ORDER BY month;

-----Monthly Value Trend
SELECT
    month,
    value_in_cr
FROM monthly_upi_stats
ORDER BY month;

----Banks Growth
SELECT
    month,
    no_of_banks_live_on_upi
FROM monthly_upi_stats
ORDER BY month;

----bank vs value
SELECT
    no_of_banks_live_on_upi,
    volume_in_mn
FROM monthly_upi_stats
ORDER BY month;

-----bank vs volume
SELECT
    no_of_banks_live_on_upi,
    value_in_cr
FROM monthly_upi_stats
ORDER BY month;