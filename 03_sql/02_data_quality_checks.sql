
-- fact_energy table

-- Check 1: Count nulls in key columns
SELECT
  COUNT(*)                                   AS total_rows,
  COUNTIF(gdp_usd IS NULL)                   AS gdp_nulls,
  COUNTIF(hydro_electricity_twh IS NULL)     AS hydro_nulls,
  COUNTIF(renewables_share_pct IS NULL)      AS renewables_nulls,
  COUNTIF(carbon_intensity_gco2_kwh IS NULL) AS carbon_nulls
FROM `energy-transition-499116.energy_data.fact_energy`;


-- Check 2: Find duplicate country-year rows 
SELECT
  country,
  year,
  COUNT(*) AS row_count
FROM `energy-transition-499116.energy_data.fact_energy`
GROUP BY country, year
HAVING COUNT(*) > 1;


-- Check 3: Confirm full coverage (50 countries, 2000-2025)
SELECT
  COUNT(DISTINCT country) AS distinct_countries,
  COUNT(DISTINCT year)    AS distinct_years,
  MIN(year)               AS first_year,
  MAX(year)               AS last_year
FROM `energy-transition-499116.energy_data.fact_energy`;


-- Check 4: Flag impossible shares over 100% 
SELECT
  country,
  year,
  renewables_share_pct,
  fossil_share_pct,
  ROUND(renewables_share_pct + fossil_share_pct, 1) AS combined_share
FROM `energy-transition-499116.energy_data.fact_energy`
WHERE renewables_share_pct + fossil_share_pct > 105
ORDER BY combined_share DESC;


-- dim_country table

-- Check 5: Confirm 50 unique countries, no null fields
SELECT
  COUNT(*)                      AS total_rows,
  COUNT(DISTINCT country_id)    AS unique_ids,
  COUNT(DISTINCT country)       AS unique_countries,
  COUNTIF(country IS NULL)      AS null_country,
  COUNTIF(region IS NULL)       AS null_region,
  COUNTIF(income_group IS NULL) AS null_income
FROM `energy-transition-499116.energy_data.dim_country`;


-- dim_policy_events table

-- Check 6: Confirm 59 unique policy events, no null text
SELECT
  COUNT(*)                          AS total_rows,
  COUNT(DISTINCT event_id)          AS unique_ids,
  COUNTIF(policy_milestone IS NULL) AS null_policy,
  MIN(year)                         AS first_year,
  MAX(year)                         AS last_year
FROM `energy-transition-499116.energy_data.dim_policy_events`;


-- Check 7: Confirm every policy country exists in dim_country 
SELECT
  p.country,
  p.year,
  p.policy_milestone
FROM `energy-transition-499116.energy_data.dim_policy_events` AS p
LEFT JOIN `energy-transition-499116.energy_data.dim_country` AS c
  ON p.country = c.country
WHERE c.country IS NULL;


-- fact_yoy_growth table

-- Check 8: Count nulls and confirm max values are real 
SELECT
  COUNT(*)                                   AS total_rows,
  COUNTIF(solar_yoy_growth_pct IS NULL)      AS solar_nulls,
  COUNTIF(wind_yoy_growth_pct IS NULL)       AS wind_nulls,
  COUNTIF(renewables_yoy_growth_pct IS NULL) AS renewables_nulls,
  MAX(solar_yoy_growth_pct)                  AS max_solar_growth,
  MAX(wind_yoy_growth_pct)                   AS max_wind_growth
FROM `energy-transition-499116.energy_data.fact_yoy_growth`;