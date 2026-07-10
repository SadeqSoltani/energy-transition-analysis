# Data Dictionary

Four tables in a star schema: two dimension tables (`dim_country`, `dim_policy_events`)
and two fact tables (`fact_energy`, `fact_yoy_growth`), joined on `country`.

Units: TWh = terawatt-hours (electricity), Mt = megatonnes (CO₂),
gCO₂/kWh = grams of CO₂ per kilowatt-hour (carbon intensity), pct = percent.

---

## dim_country (50 rows)
One row per country. Descriptive attributes.

| Column | Type | Description |
|--------|------|-------------|
| `country_id` | INT64 | Primary key (1–50). |
| `country` | STRING | Country name. Join key to the fact tables. |
| `region` | STRING | Geographic region (Asia, Europe, North America, South America, Middle East, Africa, Oceania). |
| `income_group` | STRING | World Bank income classification (High, Upper-middle, Lower-middle). |

---

## dim_policy_events (59 rows)
One row per real policy milestone. Sparse event table.

| Column | Type | Description |
|--------|------|-------------|
| `event_id` | INT64 | Primary key (1–59). |
| `country` | STRING | Country the policy belongs to. |
| `year` | INT64 | Year the milestone occurred (2000–2023). |
| `policy_milestone` | STRING | Description of the policy (e.g. "Renewable Energy Sources Act (EEG)", "Net zero 2050 pledge"). Compiled from IEA, IRENA, and national government sources. |

---

## fact_energy (1,294 rows)
One row per country-year. Core measures.

| Column | Type | Description |
|--------|------|-------------|
| `country` | STRING | Country name. Join key. |
| `region` | STRING | Region (denormalised copy; canonical source is dim_country). |
| `income_group` | STRING | Income group (denormalised copy). |
| `year` | INT64 | Year (2000–2025). |
| `population` | INT64 | Country population. |
| `gdp_usd` | FLOAT64 | GDP in USD. **NULL for 2024–2025** (not yet published). |
| `total_electricity_generation_twh` | FLOAT64 | Total electricity generated (TWh). |
| `electricity_demand_twh` | FLOAT64 | Total electricity demand (TWh). |
| `solar_electricity_twh` | FLOAT64 | Electricity from solar (TWh). |
| `wind_electricity_twh` | FLOAT64 | Electricity from wind (TWh). |
| `renewables_electricity_twh` | FLOAT64 | Electricity from all renewables, incl. hydro (TWh). |
| `hydro_electricity_twh` | FLOAT64 | Electricity from hydropower (TWh). |
| `nuclear_electricity_twh` | FLOAT64 | Electricity from nuclear (TWh). |
| `fossil_electricity_twh` | FLOAT64 | Electricity from fossil fuels (TWh). |
| `solar_share_pct` | FLOAT64 | Solar as % of total generation. |
| `wind_share_pct` | FLOAT64 | Wind as % of total generation. |
| `renewables_share_pct` | FLOAT64 | All renewables as % of total generation. Primary analysis column. |
| `fossil_share_pct` | FLOAT64 | Fossil fuels as % of total generation. |
| `low_carbon_share_pct` | FLOAT64 | Low-carbon (renewables + nuclear) as % of total. |
| `carbon_intensity_gco2_kwh` | FLOAT64 | Carbon intensity of electricity (gCO₂/kWh). Lower is cleaner. |
| `co2_saved_solar_wind_mt` | FLOAT64 | Estimated CO₂ avoided by solar + wind (Mt). **Gas-displacement estimate (450 gCO₂/kWh baseline) — indicative only, not an official figure.** |

---

## fact_yoy_growth (1,294 rows)
One row per country-year. Year-over-year growth rates.

| Column | Type | Description |
|--------|------|-------------|
| `country` | STRING | Country name. Join key. |
| `year` | INT64 | Year (2000–2025). |
| `solar_yoy_growth_pct` | FLOAT64 | Year-over-year % growth in solar generation. NULL in pre-solar years; extreme values are real (near-zero baselines). |
| `wind_yoy_growth_pct` | FLOAT64 | Year-over-year % growth in wind generation. NULL in pre-wind years. |
| `renewables_yoy_growth_pct` | FLOAT64 | Year-over-year % growth in total renewables. |
