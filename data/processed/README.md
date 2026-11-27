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

## SmartCentres Annual Financial Data

- File: `smartcentres_annual_financials_cleaned.csv`
- Total records: 134
- Total columns: 14
- Reporting period: FY 2023–2025
- Metrics in 2023: 45
- Metrics in 2024: 45
- Metrics in 2025: 44
- Duplicate primary keys: 0
- Missing required values: 0
- Unit conflicts: 0
- Structural validation: Passed

The dataset contains accounting, financial, operational,
and REIT-specific metrics, including assets, liabilities,
rental revenue, NOI, FFO, AFFO, NAV, occupancy rates,
leasing performance, and debt ratios.

Financial amounts are standardized to CAD millions
where applicable. Original values, measurement units,
source filenames, page numbers, and extraction methods
are preserved for traceability.

The 2025 distributions-per-unit metric is not included
in the current dataset and remains pending verification.

## SmartCentres Quarterly Financial Data

- File: `smartcentres_quarterly_financials_cleaned.csv`
- Total records: 36
- Total columns: 14
- Reporting period: Q1–Q3 2026
- Metrics per quarter: 12
- Duplicate primary keys: 0
- Missing required values: 0
- Balance sheet validation: Passed
- Net rental income validation: Passed
- CSV export validation: Passed

The quarterly dataset contains selected balance sheet
and income statement metrics extracted from SmartCentres'
2026 interim financial statements.

Quarterly income statement values represent individual
three-month reporting periods rather than cumulative
year-to-date amounts, subject to source verification.

## Financial Data Primary Key

The composite primary key for both financial datasets is:

- `ticker`
- `period_end`
- `period_type`
- `metric`

## Financial Data Extraction Methodology

The financial data pipeline uses a semi-automated
extraction approach combining Python-based PDF text
extraction, manual transcription, unit standardization,
derived metric calculations, and data validation.

Cross-report comparisons and accounting consistency
checks were performed where applicable. Structural
validation does not replace verification against the
original financial statements.


## Peer Annual Financial Data

- File: `peer_annual_financials_cleaned.csv`
- Companies: RioCan REIT and Choice Properties REIT
- Period: 2023–2025
- Total records: 177
- Total columns: 14
- Duplicate primary keys: 0
- Missing required values: 0
- Unit conflicts: 0
- Balance sheet validation: Passed
- Net rental income validation: Passed
- Export validation: Passed

## Peer Quarterly Financial Data

- File: `peer_quarterly_financials_cleaned.csv`
- Companies: RioCan REIT and Choice Properties REIT
- Period: 2026 Q1–Q3
- Total records: 105
- Total columns: 14
- Original extracted records: 78
- Calculated records: 27
- Duplicate primary keys: 0
- Missing required values: 0
- Unit conflicts: 0
- Balance sheet validation: Passed
- Net rental income validation: Passed
- Export validation: Passed

## Peer Financial Data Standardization

- Standardized financial metric names and measurement units.
- Converted monetary amounts from CAD thousands to CAD millions.
- Calculated total debt, net rental income, debt-to-assets ratios, and net rental income margins.
- Validated overlapping annual financial figures across reporting years.
- Preserved source filenames, PDF page numbers, original values, and extraction methods.

Composite primary key:

- `ticker`
- `period_end`
- `period_type`
- `metric`

Missing metric coverage is retained rather than filled with unsupported values. Company-specific accounting classifications and non-GAAP measurement differences should be considered during comparative analysis.

