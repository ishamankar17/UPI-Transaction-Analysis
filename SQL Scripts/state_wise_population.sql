desc state_wise_population;

select count(*) from state_wise_population;

-----Check for NULL values
SELECT *
FROM state_wise_population
WHERE serial_no IS NULL
   OR state IS NULL
   OR total_population IS NULL
   OR population_male IS NULL
   OR population_female IS NULL;

------Find duplicate states   
SELECT state, COUNT(*)
FROM state_wise_population
GROUP BY state
HAVING COUNT(*) > 1;

--Remove leading/trailing spaces from state names
UPDATE state_wise_population
SET state = TRIM(state);

------Find negative population values
SELECT *
FROM state_wise_population
WHERE total_population < 0
   OR population_male < 0
   OR population_female < 0;

----Check if Total Population equals Male + Female  
SELECT *
FROM state_wise_population
WHERE total_population <> population_male + population_female;

-----Find blank state names
SELECT *
FROM state_wise_population
WHERE TRIM(state) IS NULL;

------View the cleaned data
SELECT *
FROM state_wise_population;