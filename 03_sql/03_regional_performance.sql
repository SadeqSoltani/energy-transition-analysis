-- Q1: Which regions lead the energy transition in 2024?
SELECT
  c.region,
  ROUND(AVG(f.renewables_share_pct), 1) AS average_share
FROM `energy-transition-499116.energy_data.fact_energy` AS f
JOIN `energy-transition-499116.energy_data.dim_country` AS c
  ON f.country = c.country
WHERE f.year = 2024
GROUP BY c.region
ORDER BY average_share DESC;
-- -------------------------------------------------------------------------------------------
-- Q2: Does income level predict cleaner energy? (2024)
SELECT
  c.income_group,
  ROUND(AVG(f.renewables_share_pct), 1)      AS average_renewables,
  ROUND(AVG(f.carbon_intensity_gco2_kwh), 1) AS average_carbon
FROM `energy-transition-499116.energy_data.fact_energy` AS f
JOIN `energy-transition-499116.energy_data.dim_country` AS c
  ON f.country = c.country
WHERE f.year = 2024
GROUP BY c.income_group
ORDER BY average_renewables DESC;