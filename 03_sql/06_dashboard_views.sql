
-- VIEW 1: vw_country_summary 
-- One row per country (2024 snapshot)

CREATE OR REPLACE VIEW `energy-transition-499116.energy_data.vw_country_summary` AS (
  SELECT
    c.country,
    c.region,
    c.income_group,
    f.renewables_share_pct,
    f.carbon_intensity_gco2_kwh,
    f.co2_saved_solar_wind_mt
  FROM `energy-transition-499116.energy_data.fact_energy` AS f
  JOIN `energy-transition-499116.energy_data.dim_country` AS c
    ON f.country = c.country
  WHERE f.year = 2024
);


-- VIEW 2: vw_energy_mix_timeseries
-- Every country-year, with the five energy sources

CREATE OR REPLACE VIEW `energy-transition-499116.energy_data.vw_energy_mix_timeseries` AS (
  SELECT
    country,
    year,
    solar_electricity_twh,
    wind_electricity_twh,
    hydro_electricity_twh,
    nuclear_electricity_twh,
    fossil_electricity_twh,
    renewables_share_pct,
    carbon_intensity_gco2_kwh
  FROM `energy-transition-499116.energy_data.fact_energy`
);


-- VIEW 3: vw_policy_annotated
-- Every country-year, with a policy milestone attached only to the exact year it occurred (NULL otherwise)

CREATE OR REPLACE VIEW `energy-transition-499116.energy_data.vw_policy_annotated` AS (
  SELECT
    f.country,
    f.year,
    f.renewables_share_pct,
    f.renewables_electricity_twh,
    p.policy_milestone
  FROM `energy-transition-499116.energy_data.fact_energy` AS f
  LEFT JOIN `energy-transition-499116.energy_data.dim_policy_events` AS p
    ON f.country = p.country AND f.year = p.year
);