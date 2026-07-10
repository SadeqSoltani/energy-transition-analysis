# Are Countries Replacing Fossil Fuels or Just Adding Renewables on Top?

An end-to-end analysis of the global energy transition across **50 countries (2000–2025)** together covering roughly 92% of world electricity production. It was built to answer one question: when countries grow their renewables, are they actually *replacing* fossil fuels, or just stacking clean energy on top of a fossil base that never shrinks? And does government policy actually accelerate the shift?

## Key Findings

**1. Most countries added renewables on top of fossil fuels, they didn't replace them.**
Across all 50 countries, fossil electricity generation *grew* from **8,987 TWh in 2000 to 17,159 TWh in 2024**,  a 1.9× increase. Renewables expanded alongside it, but the fossil layer never shrank. At a global level, the transition has so far been **additive, not substitutive**.

**2. 11 countries went backwards.** Despite the global narrative of clean-energy progress, 11 of 50 countries had a *lower* renewable share in 2024 than in 2000 , including the Philippines, Peru, and Colombia, which each fell by 14–22 percentage points as fossil generation outpaced their (largely hydro) renewables.

**3. Global solar grew roughly 2,000×.** Worldwide solar electricity went from **1 TWh in 2000 to 2,035 TWh in 2024** , yet even that explosive growth wasn't enough to push fossil fuels into decline.

**4. China dominates the build-out.** China alone produced **41% of the world's solar and 42% of the world's wind** in 2024 — more than the next six countries combined in each category. It also accounts for the largest estimated CO₂ savings: **~826 Mt**, more than the USA, India, Germany, and Brazil combined.

**5. Wealth predicts clean energy but geography predicts it more.** High-income countries average 39.7% renewables vs 18.7% for lower-middle income, with **half the carbon intensity** (322 vs 641 gCO₂/kWh). Yet the single greenest region isn't wealthy Europe it's **South America (67.4%)**, powered by legacy hydropower in Brazil, Venezuela, and Colombia. Europe is second at 53.5%; the Middle East is lowest at 5.7%.

**6. Policy helps but it's not a guarantee.** Of 47 countries with a clear policy milestone, **30 (64%) accelerated** their renewable growth afterward but **17 did not**. Argentina nearly quintupled its growth rate after policy (1.6% → 8.0%); Belgium and Canada actually slowed.

## The Central Answer

**Mostly adding, not replacing and policy only sometimes changes that.** A handful of countries (Germany, the UK, Netherlands, Spain) genuinely transformed, taking renewables from near-zero to over 50% of their mix Germany alone improved by 52 percentage points (6% → 59%). But globally, fossil generation still nearly doubled while renewables were layered on top, and a third of countries with renewable policies saw no acceleration at all.

## Recommendations for Investors and Developers

The central finding (additive, not substitutive) points to a clear investment thesis:
capital tends to flow toward markets that are already green and easy, while the
strongest opportunities sit in the gaps, meaning high-potential markets with low
deployment. Each recommendation below traces back to a specific finding.

**1. Target the Middle East gap.**
The Middle East averages just 5.7% renewables, the lowest of any region, despite
abundant solar resource and deep pools of capital. This is a policy-timing play: the
low share is driven by cheap domestic fossil fuels and subsidies, so the opportunity
opens as subsidy reform and diversification mandates take effect. Build pipeline now
and deploy when the regulatory environment shifts.

**2. Fund the backsliders.**
Eleven countries, including Peru, Colombia, and the Philippines, saw their renewable
share fall as growing demand defaulted to fossil generation. That rising demand is
exactly what a new solar or wind project sells into. Their existing renewables are
largely hydro, which is exposed to drought, so solar and wind can be positioned as
grid resilience and diversification rather than clean energy alone.

**3. Screen on deployment data, not policy headlines.**
Only 64% of countries with a policy milestone accelerated afterward, so a national
pledge is a weak signal on its own. Use actual year-over-year renewable growth to
qualify markets, and treat stated targets as ambition rather than evidence.

**4. Hedge the supply-chain concentration.**
China produced roughly 41% of the world's solar and 42% of its wind in 2024. Project
economics that depend on this supply chain carry tariff and geopolitical risk, so
price that risk in and diversify sourcing where possible to protect returns.

**Caveats.**
These recommendations are a market-screening layer, not a final investment decision.
The policy analysis shows association, not causation, so deployment-based screening is
the more reliable takeaway. Renewable share includes hydro, which is why the
backsliding markets look the way they do. This dataset also covers electricity only,
and does not capture transport, heating, storage, or grid constraints that materially
affect any real project.


## Tools & Pipeline

```
Excel  →  BigQuery  →  SQL  →  Power BI  
```

- **Excel**: data cleaning, a documented data-quality log, and a country scorecard with weighted transition scoring
- **BigQuery**: cloud data warehouse; a 4-table star schema (2 dimension, 2 fact)
- **SQL**: 6 analysis files using JOINs, window functions (`RANK`, `FIRST_VALUE`, `SUM OVER`), `QUALIFY`, and chained CTEs
- **Power BI**: a 4-page interactive dashboard connected live to BigQuery, with DAX measures

## Dashboard

The Power BI dashboard has four pages, each answering one part of the central question:

| Page | Question | Key visual |
|------|----------|-----------|
| 1. Global Overview | Where does the world stand? | World map + KPIs |
| 2. Leaders vs Laggards | Who advanced, who fell behind? | Ranked bar chart (the 11 in red) |
| 3. Energy Mix Over Time | Replacing or adding on top? | Stacked area chart |
| 4. Policy Impact | Did policy work? | Trend + before/after table |

<img width="1310" height="739" alt="1_Global_Overview" src="https://github.com/user-attachments/assets/c608c473-fb1e-4123-be30-b084ed4f57dd" />

<img width="1312" height="738" alt="2_Leaders_Laggards" src="https://github.com/user-attachments/assets/86d3de10-fa62-46d1-8a61-52c2b9bb7a1e" />

<img width="1311" height="736" alt="3_Energy_Mix_Over_Time" src="https://github.com/user-attachments/assets/8c542990-3139-4da8-8abc-9af202038780" />

<img width="1313" height="737" alt="4_Policy_Impact" src="https://github.com/user-attachments/assets/ee1c85ae-a902-4657-a7c8-1d4dbbd9180c" />

## Repository Structure

```
energy-transition-analysis/
├── README.md
├── 01_raw_data/
│   ├── dim_country.csv            (50 countries)
│   ├── dim_policy_events.csv      (59 policy milestones)
│   ├── fact_energy.csv            (1,294 country-year rows)
│   ├── fact_yoy_growth.csv        (1,294 rows)
│   └── data_dictionary.md
├── 02_cleaning/
│   └── energy_transition_cleaning.xlsx
├── 03_sql/
│   ├── 01_schema.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_regional_performance.sql
│   ├── 04_country_transition_trends.sql
│   ├── 05_policy_impact_analysis.sql
│   └── 06_dashboard_views.sql
└── 04_powerbi/
    ├── dashboard.pbix
    └── screenshots/
```

## Method Notes

- **2024 is treated as the latest complete year.** 2025 exists in the data but only covers 44 of 50 countries and is missing GDP, so it's excluded from "current state" figures.
- **Star schema.** Two dimension tables (country, policy events) and two fact tables (energy measures, year-over-year growth), joined on country.

## Data Limitations

This analysis is explicit about what the data can and can't support:

- **CO₂ savings are estimates, not measured values.** The `co2_saved_solar_wind_mt` field uses a gas-displacement estimate (450 gCO₂/kWh baseline) and is indicative only, not an official figure. China's "826 Mt saved" should be read as an estimate of avoided emissions, not a precise measurement.
- **Policy analysis shows association, not proven causation.** The 59 policy milestones are real and sourced (IEA, IRENA, national governments), but a before/after growth comparison cannot rule out other factors (technology cost declines, global market shifts) that moved at the same time.
- **GDP is missing for 2024–2025**, so income-group comparisons rely on the World Bank classification rather than live GDP.
- **Year-over-year growth has structural nulls** in the pre-solar/pre-wind era (a country with near-zero solar in 2001 has no meaningful growth rate), and early-stage growth percentages can be extreme (solar going from 0.01 to 2.4 TWh reads as +24,000%) — these are real, not errors.
- **"Renewable share" includes hydro**, which is why hydro-rich South America leads the regional ranking a legacy-hydro country can rank high without recent solar or wind investment.

## Data Sources

Compiled from three established energy datasets, via the [World Energy Transition 2000–2025](https://www.kaggle.com/datasets/alitaqishah/world-energy-transition-20002025) dataset on Kaggle:

- **Our World in Data** — Energy Data (CC-BY 4.0) · https://github.com/owid/energy-data
- **Ember** — Yearly Electricity Data · https://ember-energy.org/data/yearly-electricity-data/
- **IEA** — Renewables Progress Tracker · https://www.iea.org
- **Policy milestones** — compiled from IEA, IRENA, and national government sources
