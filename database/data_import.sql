
-- ============================================================
-- BSMM 8730 - Group 2 Assignment
-- SmartCentres REIT Data Pipeline and Investment Analysis
-- Data Import Script
-- ============================================================

-- Prerequisites:
-- 1. Execute schema.sql first.
-- 2. Use a fresh database with empty tables.
-- 3. Enable local_infile on a trusted local MySQL server.
-- 4. Connect using mysql --local-infile=1.
-- 5. Replace the CSV paths with your local directory.
-- 6. Review warnings after each import.

USE reit_investment_db;

-- ============================================================
-- 1. Import Securities
-- Expected records: 4
-- ============================================================

LOAD DATA LOCAL INFILE
'data/integrated/database_ready/securities.csv'
INTO TABLE securities
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    ticker,
    security_name,
    currency,
    security_type,
    analysis_role
);

SHOW WARNINGS;

-- ============================================================
-- 2. Import Metric Definitions
-- Expected records: 62
-- ============================================================

LOAD DATA LOCAL INFILE
'data/integrated/database_ready/metric_definitions.csv'
INTO TABLE metric_definitions
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    metric,
    metric_group,
    unit,
    comparability_note
);

SHOW WARNINGS;

-- ============================================================
-- 3. Import Financial Metrics
-- Expected records: 452
-- ============================================================

LOAD DATA LOCAL INFILE
'data/integrated/database_ready/financial_metrics.csv'
INTO TABLE financial_metrics
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    ticker,
    period_end,
    period_type,
    metric,
    value,
    source_file,
    @source_page,
    @source_label,
    @original_value,
    @original_unit,
    @extraction_method,
    @original_line
)
SET
    source_page = NULLIF(@source_page, ''),
    source_label = NULLIF(@source_label, ''),
    original_value = NULLIF(@original_value, ''),
    original_unit = NULLIF(@original_unit, ''),
    extraction_method = NULLIF(@extraction_method, ''),
    original_line = NULLIF(@original_line, '');

SHOW WARNINGS;

-- ============================================================
-- 4. Import Market Prices
-- Expected records: 3764
-- ============================================================

LOAD DATA LOCAL INFILE
'data/integrated/database_ready/market_prices.csv'
INTO TABLE market_prices
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    date,
    open,
    high,
    low,
    close,
    adj_close,
    volume,
    dividends,
    stock_splits,
    ticker,
    @capital_gains
)
SET
    capital_gains = NULLIF(@capital_gains, '');

SHOW WARNINGS;

-- ============================================================
-- 5. Import Daily Interest Rates
-- Expected records: 973
-- ============================================================

LOAD DATA LOCAL INFILE
'data/integrated/database_ready/daily_interest_rates.csv'
INTO TABLE daily_interest_rates
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    date,
    policy_interest_rate,
    canada_5y_bond_yield,
    canada_10y_bond_yield,
    @policy_imputed,
    @bond5y_imputed,
    @bond10y_imputed,
    @policy_observed,
    @bond5y_observed,
    @bond10y_observed
)
SET
    policy_interest_rate_imputed =
        LOWER(TRIM(@policy_imputed)) IN ('true', '1'),

    canada_5y_bond_yield_imputed =
        LOWER(TRIM(@bond5y_imputed)) IN ('true', '1'),

    canada_10y_bond_yield_imputed =
        LOWER(TRIM(@bond10y_imputed)) IN ('true', '1'),

    policy_interest_rate_observed =
        NULLIF(@policy_observed, ''),

    canada_5y_bond_yield_observed =
        NULLIF(@bond5y_observed, ''),

    canada_10y_bond_yield_observed =
        NULLIF(@bond10y_observed, '');

SHOW WARNINGS;

-- Reconstruct imputation flags from observed values

UPDATE daily_interest_rates
SET
    policy_interest_rate_imputed =
        (policy_interest_rate_observed IS NULL
         AND policy_interest_rate IS NOT NULL),

    canada_5y_bond_yield_imputed =
        (canada_5y_bond_yield_observed IS NULL
         AND canada_5y_bond_yield IS NOT NULL),

    canada_10y_bond_yield_imputed =
        (canada_10y_bond_yield_observed IS NULL
         AND canada_10y_bond_yield IS NOT NULL);

-- ============================================================
-- 6. Import Monthly Macroeconomic Data
-- Expected records: 45
-- ============================================================

LOAD DATA LOCAL INFILE
'data/integrated/database_ready/monthly_macro.csv'
INTO TABLE monthly_macro
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    geography,
    cpi_index,
    base_year,
    cpi_source_vector,
    inflation_yoy_pct,
    inflation_mom_pct,
    retail_sales_cad_million,
    retail_unit,
    retail_scalar_factor,
    retail_source_vector,
    retail_quality_status,
    retail_currency,
    @seasonally_adjusted,
    retail_sales_yoy_pct,
    retail_sales_mom_pct,
    month
)
SET
    seasonally_adjusted =
        CASE
            WHEN LOWER(TRIM(@seasonally_adjusted))
                IN ('true', '1') THEN 1
            WHEN LOWER(TRIM(@seasonally_adjusted))
                IN ('false', '0') THEN 0
            ELSE NULL
        END;

SHOW WARNINGS;

-- ============================================================
-- 7. Final Record Count Summary
-- Expected total records: 5300
-- ============================================================

SELECT 'securities' AS table_name,
       COUNT(*) AS actual_records,
       4 AS expected_records
FROM securities

UNION ALL

SELECT 'metric_definitions', COUNT(*), 62
FROM metric_definitions

UNION ALL

SELECT 'financial_metrics', COUNT(*), 452
FROM financial_metrics

UNION ALL

SELECT 'market_prices', COUNT(*), 3764
FROM market_prices

UNION ALL

SELECT 'daily_interest_rates', COUNT(*), 973
FROM daily_interest_rates

UNION ALL

SELECT 'monthly_macro', COUNT(*), 45
FROM monthly_macro;

-- ============================================================
-- End of Data Import Script
-- Run data_import_validation.sql for additional validation.
-- Restore local_infile to OFF after completing the import.
-- ============================================================
