# Python Notebooks

This folder contains Jupyter Notebooks used for
data acquisition, validation, cleaning, integration,
and analysis.

## Data Acquisition

- Market Data Acquisition: Yahoo Finance
- Macroeconomic Data Acquisition: Bank of Canada
  and Statistics Canada

These notebooks document the data acquisition
process and support project reproducibility.

## Data Cleaning and Validation

### Market Data Cleaning

The market data cleaning notebook performs:

- Data profiling and quality assessment.
- Date format and column name standardization.
- Missing value and duplicate record checks.
- OHLC price consistency validation.
- Trading date consistency checks.
- Consolidation of four market datasets.
- Export of 3,764 cleaned market data records.

### Macroeconomic Data Cleaning

The macroeconomic data cleaning notebook performs:

- Policy interest rate and bond yield standardization.
- Date alignment across interest rate datasets.
- Forward-fill imputation with explicit imputation flags.
- Preservation of original observed interest rate data.
- CPI and retail sales data filtering.
- Calculation of YoY and MoM growth rates.
- Data quality validation and CSV export.

### SmartCentres Financial Data Cleaning

Notebook: `financial_data_cleaning.ipynb`

This notebook performs:

- Financial report inspection and PDF text extraction.
- Keyword-based identification of relevant financial tables.
- Extraction of accounting and REIT-specific metrics.
- Manual transcription where automated extraction is unsuitable.
- Financial metric name and unit standardization.
- Cross-report comparison and validation.
- Calculation of derived financial indicators.
- Composite primary key validation.
- Balance sheet and rental income consistency checks.
- Export of 134 annual and 36 quarterly financial records.

## Reproducibility

The notebooks document the transformation of raw source
data into structured datasets for database integration
and investment analysis.

Local file paths may need to be adjusted before running
the notebooks on another computer.

The original source datasets are stored in `data/raw/`,
and cleaned datasets are stored in `data/processed/`,
with source reports maintained in the relevant data branches.

## Next Steps

- Relational database design and normalization.
- Entity-Relationship Diagram (ERD) development.
- MySQL database implementation.
- Database import and integrity validation.
- SQL-based financial and investment analysis.
- Data visualization and reporting.


## Peer Financial Data Cleaning

### Notebook

`peer_financial_data_cleaning.ipynb`

### Objective

Extract, clean, standardize, and validate financial and operating data for RioCan REIT and Choice Properties REIT to support comparative investment analysis with SmartCentres REIT.

### Data Sources

- RioCan annual reports (2023–2025)
- RioCan quarterly reports (2026 Q1–Q3)
- Choice Properties annual reports (2023–2025)
- Choice Properties quarterly reports (2026 Q1–Q3)

### Main Procedures

1. Locate and inventory source PDF reports.
2. Assess PDF text extraction quality.
3. Identify relevant financial statement and MD&A pages.
4. Extract accounting and REIT-specific financial metrics.
5. Recover records requiring manual review.
6. Validate overlapping financial figures across reporting years.
7. Standardize financial metric names and measurement units.
8. Calculate derived financial metrics.
9. Extract individual quarterly financial results.
10. Perform structural and accounting consistency checks.
11. Export validated financial datasets.

### Output Files

- `data/processed/peer_annual_financials_cleaned.csv`
- `data/processed/peer_quarterly_financials_cleaned.csv`

### Validation Summary

| Validation Item | Annual Data | Quarterly Data |
|---|---:|---:|
| Total Records | 177 | 105 |
| Total Columns | 14 | 14 |
| Duplicate Primary Keys | 0 | 0 |
| Missing Required Values | 0 | 0 |
| Unit Conflicts | 0 | 0 |
| Balance Sheet Validation | Passed | Passed |
| Net Rental Income Validation | Passed | Passed |
| Export Validation | Passed | Passed |

### Data Quality and Limitations

- Source filenames, PDF page numbers, original values, and extraction methods are preserved for data traceability.
- Missing metric coverage is retained rather than replaced with unsupported values.
- Quarterly income statement figures represent individual quarters rather than cumulative year-to-date periods.
- Company-specific accounting classifications and non-GAAP measurement differences are retained.
- Structural validation does not guarantee complete comparability across companies.
- Local file paths may require adjustment before running the notebook in another environment.

  
## Data Integration and Database Preparation

### Notebook

`data_integration.ipynb`

### Objective

Integrate cleaned financial, market, and macroeconomic
datasets and prepare relational datasets for MySQL
database implementation.

### Main Procedures

1. Load nine cleaned CSV datasets.
2. Validate dataset schemas and primary keys.
3. Consolidate financial data across three REITs.
4. Harmonize financial metric groups.
5. Integrate daily market data and interest rates.
6. Align monthly CPI and retail sales indicators.
7. Prepare six relational database tables.
8. Validate primary keys and foreign key relationships.
9. Validate temporal alignment and record preservation.
10. Export database-ready datasets and validation reports.

### Integration Results

| Validation Item | Result |
|---|---:|
| Integrated Financial Records | 452 |
| Original Financial Metrics | 62 |
| Harmonized Metric Groups | 60 |
| Common Annual Metric Groups | 21 |
| Common Quarterly Metric Groups | 9 |
| Integrated Market Records | 3764 |
| Database Tables | 6 |
| Total Database Records | 5300 |
| Duplicate Primary Keys | 0 |
| Missing Primary Keys | 0 |
| Foreign Key Checks | 3/3 Passed |
| CSV Export Validation | Passed |

### Output Directories

- `data/integrated/database_ready/`
- `data/integrated/analysis/`
- `data/integrated/validation/`

### Limitations

- Financial metric groups do not guarantee accounting
  equivalence across companies.
- Retrospective market-macro data uses reference-month
  alignment rather than actual publication dates.
- Local file paths may require adjustment for reproducibility.
- MySQL implementation and database constraints have not
  yet been tested.


