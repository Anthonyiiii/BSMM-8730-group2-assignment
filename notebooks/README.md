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

- RioCan financial data extraction and cleaning.
- Choice Properties financial data extraction and cleaning.
- Financial and macroeconomic data integration.
- Relational database design.
- MySQL implementation and SQL analysis.
