desc indian_gdp;

select count(*) from indian_gdp;

------check Null values
SELECT *
FROM indian_gdp
WHERE rank IS NULL
   OR state_ut IS NULL
   OR nominal_gdp_trillion_inr IS NULL
   OR nominal_gdp_billion_usd IS NULL;
   
---check dupliacte values
SELECT state_ut, COUNT(*)
FROM indian_gdp
GROUP BY state_ut
HAVING COUNT(*) > 1;

-----remove trailing spaces
UPDATE indian_gdp
SET state_ut = TRIM(state_ut);

--check negative GDP values
SELECT *
FROM indian_gdp
WHERE nominal_gdp_trillion_inr < 0
   OR nominal_gdp_billion_usd < 0;

--- check duplicate ranks
SELECT rank, COUNT(*)
FROM indian_gdp
GROUP BY rank
HAVING COUNT(*) > 1;

SELECT * FROM indian_gdp;


CREATE TABLE dim_state AS
SELECT
    p.state,
    p.total_population,
    p.population_male,
    p.population_female,
    g.nominal_gdp_trillion_inr,
    g.nominal_gdp_billion_usd,
    g.rank AS gdp_rank
FROM state_wise_population p
JOIN indian_gdp g
ON UPPER(TRIM(p.state)) = UPPER(TRIM(g.state_ut));

SELECT * FROM dim_state;

desc dim_state;