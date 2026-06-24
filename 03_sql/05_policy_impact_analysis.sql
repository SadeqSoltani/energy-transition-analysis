
-- Q1: For each country, did renewable growth speed up or slow down after its first policy milestone?

WITH policy_years AS (
  SELECT
    country,
    MIN(year) AS policy_year      -- earliest policy per country
  FROM `energy-transition-499116.energy_data.dim_policy_events`
  GROUP BY country
)
SELECT
  p.country,
  p.policy_year,
  ROUND(AVG(CASE WHEN g.year <  p.policy_year
                 THEN g.renewables_yoy_growth_pct END), 2) AS avg_growth_before,
  ROUND(AVG(CASE WHEN g.year >= p.policy_year
                 THEN g.renewables_yoy_growth_pct END), 2) AS avg_growth_after,
  CASE
    WHEN AVG(CASE WHEN g.year >= p.policy_year THEN g.renewables_yoy_growth_pct END)
       > AVG(CASE WHEN g.year <  p.policy_year THEN g.renewables_yoy_growth_pct END)
    THEN 'Accelerated'
    ELSE 'Did not accelerate'
  END AS policy_effect
FROM policy_years AS p
JOIN `energy-transition-499116.energy_data.fact_yoy_growth` AS g
  ON p.country = g.country
GROUP BY p.country, p.policy_year
ORDER BY p.country;


-- Q2: Across all countries, how many sped up after a policy versus how many did not?

WITH policy_years AS (
  SELECT
    country,
    MIN(year) AS policy_year
  FROM `energy-transition-499116.energy_data.dim_policy_events`
  GROUP BY country
),
policy_comparison AS (
  SELECT
    p.country,
    AVG(CASE WHEN g.year <  p.policy_year
             THEN g.renewables_yoy_growth_pct END) AS growth_before,
    AVG(CASE WHEN g.year >= p.policy_year
             THEN g.renewables_yoy_growth_pct END) AS growth_after
  FROM policy_years AS p
  JOIN `energy-transition-499116.energy_data.fact_yoy_growth` AS g
    ON p.country = g.country
  GROUP BY p.country
)
SELECT
  COUNTIF(growth_after >  growth_before) AS accelerated,
  COUNTIF(growth_after <= growth_before) AS did_not_accelerate,
  COUNT(*)                               AS total_countries
FROM policy_comparison;