# Processed Data

This folder contains cleaned, standardized, and validated
datasets for database integration and investment analysis.

## Market Data

- File: market_data_cleaned.csv
- Total records: 3,764
- Total columns: 13
- Period: 2023-01-03 to 2026-09-30
- Records per security: 941
- Duplicate primary keys: 0
- Composite primary key: ticker and date
- Identical trading dates: True

Missing capital gains values for the three REITs are
intentionally retained as null values because the
original datasets do not provide this field.

The original datasets are preserved in data/raw/.

## Macroeconomic Data

### Interest Rates

- Source: Bank of Canada
- Files:
  - interest_rates_observed.csv
  - interest_rates_cleaned.csv
- Records: 973 per dataset
- Period: 2023-01-03 to 2026-09-30
- Frequency: Daily observations
- Forward fill was used for date alignment.
- Imputation flags identify substituted values.
- Actual observations are preserved separately.

### Consumer Price Index (CPI)

- Source: Statistics Canada, Table 18-10-0004-01
- File: cpi_cleaned.csv
- Records: 45
- Columns: 7
- Period: January 2023 to September 2026
- Frequency: Monthly
- Base period: 2002=100
- Includes YoY and MoM inflation rates.
- No missing values or duplicate dates.

### Retail Sales

- Source: Statistics Canada, Table 20-10-0067-01
- File: retail_sales_cleaned.csv
- Records: 45
- Columns: 11
- Period: January 2023 to September 2026
- Frequency: Monthly
- Unit: CAD millions, current prices
- Seasonally adjusted
- Includes YoY and MoM sales growth rates.
- All records have quality status A.
- No missing values or duplicate dates.
