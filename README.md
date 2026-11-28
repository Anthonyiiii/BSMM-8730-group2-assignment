# BSMM 8730 - Group 2 Assignment

## SmartCentres REIT Data Pipeline and Investment Analysis

This project develops a structured data pipeline and
relational database to support financial and investment
analysis of SmartCentres REIT and its industry peers.

## Project Objectives

- Acquire financial, market, and macroeconomic data.
- Clean, standardize, and validate source datasets.
- Compare SmartCentres with RioCan and Choice Properties.
- Design and implement a relational MySQL database.
- Conduct SQL-based financial and investment analysis.

## Data Sources

- SmartCentres REIT financial reports
- RioCan REIT financial reports
- Choice Properties REIT financial reports
- Yahoo Finance
- Bank of Canada
- Statistics Canada

## Repository Structure

- `data/raw/`: Original source datasets and reports.
- `data/processed/`: Cleaned and validated datasets.
- `data/integrated/database_ready/`: Six relational datasets for MySQL.
- `data/integrated/analysis/`: Integrated analytical datasets.
- `data/integrated/validation/`: Data quality validation reports.
- `notebooks/`: Python acquisition, cleaning, validation, and integration notebooks.


## Current Progress
- Data acquisition completed.
- Market and macroeconomic data cleaning completed.
- SmartCentres, RioCan, and Choice Properties financial data cleaning completed.
- Financial metric harmonization completed.
- Financial, market, and macroeconomic data integration completed.
- Six database-ready datasets prepared and validated.
- Database design and ERD development pending.
- MySQL implementation and data import pending.
- SQL-based investment analysis pending.


## Data Integration Results

The integration process consolidated financial, market,
and macroeconomic datasets into six relational datasets
for MySQL implementation.

### Database-Ready Tables

| Table | Records | Columns |
|---|---:|---:|
| securities | 4 | 5 |
| metric_definitions | 62 | 4 |
| financial_metrics | 452 | 12 |
| market_prices | 3764 | 11 |
| daily_interest_rates | 973 | 10 |
| monthly_macro | 45 | 16 |
| **Total** | **5300** | **58** |

### Validation Results

- Primary key validation: Passed.
- Foreign key validation: Passed.
- Temporal alignment validation: Passed.
- Record preservation validation: Passed.
- CSV export validation: Passed.
- Duplicate primary keys: 0.
- Missing primary keys: 0.
- Original financial metrics: 62.
- Harmonized financial metric groups: 60.

### Limitations

- Harmonized metric groups do not guarantee accounting
  equivalence across companies.
- Original missing observations and source references
  are preserved.
- Monthly macroeconomic data is aligned by reference
  month rather than actual publication date.
- Retrospective datasets should not be used directly
  for historical trading simulations.
- MySQL implementation and database constraints
  require further validation.


## Tools and Technologies

- Python
- Pandas
- Jupyter Notebook
- MySQL
- GitHub

## Course Information

- Course: BSMM 8730 - Data Acquisition and Management
- University: University of Windsor
- Semester: Fall 2026
- Group: 2
