
# Database Design and Implementation

## Overview

This directory contains the relational database design and MySQL implementation for the SmartCentres REIT Data Pipeline and Investment Analysis project.

The database integrates financial, market, interest rate, and macroeconomic data to support SQL-based investment analysis and peer comparison.

## Database Information

- Database Name: reit_investment_db
- DBMS: MySQL
- Design Tool: MySQL Workbench
- Storage Engine: InnoDB
- Character Set: utf8mb4
- Total Tables: 6
- Total Records: 5,300

## Database Tables

| Table | Records | Description |
|---|---:|---|
| securities | 4 | Security and benchmark information |
| metric_definitions | 62 | Financial metric definitions |
| financial_metrics | 452 | Annual and quarterly financial data |
| market_prices | 3,764 | Daily historical market prices |
| daily_interest_rates | 973 | Interest rates and bond yields |
| monthly_macro | 45 | CPI and retail sales indicators |
| **Total** | **5,300** | |

## Primary Keys

| Table | Primary Key |
|---|---|
| securities | ticker |
| metric_definitions | metric |
| financial_metrics | ticker, period_end, period_type, metric |
| market_prices | ticker, date |
| daily_interest_rates | date |
| monthly_macro | month |

## Foreign Key Relationships

- financial_metrics.ticker references securities.ticker.
- financial_metrics.metric references metric_definitions.metric.
- market_prices.ticker references securities.ticker.

Interest rates and monthly macroeconomic indicators are associated with market prices through date-based SQL joins.

## Entity Relationship Diagram
![Database ERD](https://raw.githubusercontent.com/Anthonyiiii/BSMM-8730-group2-assignment/refs/heads/database/implementation/database/reit_investment_erd.png)

## Files

| File | Description |
|---|---|
| schema.sql | Database schema, tables, and constraints |
| data_import.sql | CSV data import and transformation |
| data_import_validation.sql | Database integrity and quality validation |
| reit_investment_erd.png | Entity relationship diagram |
| reit_investment_model.mwb | Editable MySQL Workbench model |

## Database Setup

1. Clone or download the project repository.
2. Execute schema.sql to create the database.
3. Ensure that all target tables are empty.
4. Temporarily enable local_infile on a trusted local MySQL server.
5. Launch the MySQL command-line client from the repository root:

   mysql --local-infile=1 -u root -p

6. Execute the import script:

   source database/data_import.sql

7. Review all import warnings.
8. Execute the validation script:

   source database/data_import_validation.sql

9. Restore local_infile to OFF and disable the client-side local file import option.

The import script uses CSV files located under:

`data/integrated/database_ready/`

Adjust the paths if the local directory structure differs.

## Validation Results

| Validation Item | Result |
|---|---|
| Record Count Validation | Passed |
| Primary Key Validation | Passed |
| Foreign Key Integrity | Passed |
| Orphan Records | 0 |
| Temporal Integrity | Passed |
| Missing Financial Values | 0 |
| Invalid Market Prices | 0 |
| Missing Capital Gains | 2,823 (preserved) |
| Policy Rate Imputation Flags | 1 |
| 5-Year Bond Yield Imputation Flags | 39 |
| 10-Year Bond Yield Imputation Flags | 39 |
| Seasonally Adjusted Retail Records | 45 |

## Data Quality and Limitations

- Original financial source references are preserved.
- Missing capital gains values are retained as NULL.
- Observed and imputed interest rates are stored separately.
- Financial metric comparability may vary across REITs.
- Numerical precision is standardized using MySQL DECIMAL data types.
- Full CSV-to-database value reconciliation remains pending.
- The consolidated import script has not yet been tested against a fresh database.
- Monthly macroeconomic joins are intended for retrospective analysis and may introduce look-ahead bias if used for prediction without publication dates.

## Next Steps

- SQL-based financial performance analysis.
- Peer comparison and industry benchmarking.
- Market performance and risk analysis.
- Macroeconomic impact analysis.
- Data visualization and investment recommendations.
