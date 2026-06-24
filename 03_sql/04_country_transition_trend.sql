
-- Q1: Top 10 countries by CO2 saved from solar + wind (2024)

SELECT
  c.country,
  f.co2_saved_solar_wind_mt
FROM `energy-transition-499116.energy_data.fact_energy` AS f
JOIN `energy-transition-499116.energy_data.dim_country` AS c
  ON f.country = c.country
WHERE f.year = 2024
ORDER BY f.co2_saved_solar_wind_mt DESC
LIMIT 10;



-- Q2: Which countries advanced the most since 2000 , and which fell behind?

SELECT
  country,
  renewables_share_pct AS share_2024,
  FIRST_VALUE(renewables_share_pct) OVER (
    PARTITION BY country
    ORDER BY year
  ) AS share_2000,
  ROUND(
    renewables_share_pct - FIRST_VALUE(renewables_share_pct) OVER (
      PARTITION BY country
      ORDER BY year
    ), 1
  ) AS change_since_2000
FROM `energy-transition-499116.energy_data.fact_energy`
QUALIFY year = 2024
ORDER BY change_since_2000 DESC;



-- Q3: How did each country's renewable ranking change between 2000 and 2024?

SELECT
  country,
  year,
  renewables_share_pct,
  RANK() OVER (
    PARTITION BY year
    ORDER BY renewables_share_pct DESC
  ) AS rank_in_year
FROM `energy-transition-499116.energy_data.fact_energy`
WHERE year IN (2000, 2024)
ORDER BY country, year;



-- Q4a: Top 10 countries by share of global SOLAR (2024)

SELECT
  country,
  solar_electricity_twh,
  ROUND(
    solar_electricity_twh / SUM(solar_electricity_twh) OVER () * 100,
    1
  ) AS pct_of_global_solar
FROM `energy-transition-499116.energy_data.fact_energy`
WHERE year = 2024
ORDER BY solar_electricity_twh DESC
LIMIT 10;


-- Q4b: Top 10 countries by share of global WIND (2024)

SELECT
  country,
  wind_electricity_twh,
  ROUND(
    wind_electricity_twh / SUM(wind_electricity_twh) OVER () * 100,
    1
  ) AS pct_of_global_wind
FROM `energy-transition-499116.energy_data.fact_energy`
WHERE year = 2024
ORDER BY wind_electricity_twh DESC
LIMIT 10;