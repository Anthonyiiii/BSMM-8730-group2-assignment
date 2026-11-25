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
