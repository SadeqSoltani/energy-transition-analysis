-- Inspect the full schema of all 4 tables: column names and data types
SELECT
  table_name,
  column_name,
  data_type,
  ordinal_position
FROM `energy-transition-499116.energy_data`.INFORMATION_SCHEMA.COLUMNS
ORDER BY table_name, ordinal_position;

-- DIMENSION TABLE: dim_country [one row per country]
CREATE TABLE IF NOT EXISTS `energy-transition-499116.energy_data.dim_country` (
  country_id    INT64   NOT NULL,   -- primary key (1-50)
  country       STRING  NOT NULL,
  region        STRING,
  income_group  STRING
);

-- DIMENSION TABLE: dim_policy_events [one row per policy milestone]
CREATE TABLE IF NOT EXISTS `energy-transition-499116.energy_data.dim_policy_events` (
  event_id          INT64   NOT NULL,   -- primary key (1-59)
  country           STRING  NOT NULL,
  year              INT64,
  policy_milestone  STRING
);

-- FACT TABLE: fact_energy [one row per country-year, core measures]
CREATE TABLE IF NOT EXISTS `energy-transition-499116.energy_data.fact_energy` (
  country                           STRING,
  region                            STRING,
  income_group                      STRING,
  year                              INT64,
  population                        INT64,
  gdp_usd                           FLOAT64,
  total_electricity_generation_twh  FLOAT64,
  electricity_demand_twh            FLOAT64,
  solar_electricity_twh             FLOAT64,
  wind_electricity_twh              FLOAT64,
  renewables_electricity_twh        FLOAT64,
  hydro_electricity_twh             FLOAT64,
  nuclear_electricity_twh           FLOAT64,
  fossil_electricity_twh            FLOAT64,
  solar_share_pct                   FLOAT64,
  wind_share_pct                    FLOAT64,
  renewables_share_pct              FLOAT64,
  fossil_share_pct                  FLOAT64,
  low_carbon_share_pct              FLOAT64,
  carbon_intensity_gco2_kwh         FLOAT64,
  co2_saved_solar_wind_mt           FLOAT64
);

-- FACT TABLE: fact_yoy_growth [year-over-year growth rates]
CREATE TABLE IF NOT EXISTS `energy-transition-499116.energy_data.fact_yoy_growth` (
  country                    STRING,
  year                       INT64,
  solar_yoy_growth_pct       FLOAT64,
  wind_yoy_growth_pct        FLOAT64,
  renewables_yoy_growth_pct  FLOAT64
);