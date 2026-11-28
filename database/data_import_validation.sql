USE reit_investment_db;

SELECT * FROM securities;

SELECT COUNT(*) AS total_records
FROM securities;

-- Validate metric definitions

SELECT * FROM metric_definitions;

SELECT COUNT(*) AS total_records
FROM metric_definitions;

SELECT 'securities' AS table_name,
       COUNT(*) AS total_records
FROM reit_investment_db.securities

UNION ALL

SELECT 'metric_definitions',
       COUNT(*)
FROM reit_investment_db.metric_definitions;

-- Validate financial metrics

SELECT COUNT(*) AS total_records
FROM financial_metrics;

-- Validate records by security and period

SELECT
    ticker,
    period_type,
    COUNT(*) AS total_records
FROM financial_metrics
GROUP BY ticker, period_type
ORDER BY ticker, period_type;

-- Check local file import configuration

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SHOW VARIABLES LIKE 'secure_file_priv';

SELECT @@sql_mode;

SET GLOBAL local_infile = ON;

SHOW GLOBAL VARIABLES LIKE 'local_infile';


USE reit_investment_db;

-- Final database record count validation

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


-- Validate temporal integrity

SELECT
    'Market Prices -> Daily Interest Rates' AS relationship,
    COUNT(*) AS unmatched_records
FROM market_prices p
LEFT JOIN daily_interest_rates i
    ON p.date = i.date
WHERE i.date IS NULL

UNION ALL

SELECT
    'Market Prices -> Monthly Macro',
    COUNT(*)
FROM market_prices p
LEFT JOIN monthly_macro m
    ON YEAR(p.date) = YEAR(m.month)
    AND MONTH(p.date) = MONTH(m.month)
WHERE m.month IS NULL;

-- Validate foreign key integrity

SELECT
    'Financial Metrics -> Securities' AS relationship,
    COUNT(*) AS orphan_records
FROM financial_metrics f
LEFT JOIN securities s
    ON f.ticker = s.ticker
WHERE s.ticker IS NULL

UNION ALL

SELECT
    'Financial Metrics -> Metric Definitions',
    COUNT(*)
FROM financial_metrics f
LEFT JOIN metric_definitions m
    ON f.metric = m.metric
WHERE m.metric IS NULL

UNION ALL

SELECT
    'Market Prices -> Securities',
    COUNT(*)
FROM market_prices p
LEFT JOIN securities s
    ON p.ticker = s.ticker
WHERE s.ticker IS NULL;

-- Final data quality validation

SELECT 'Missing financial values' AS validation,
       COUNT(*) AS actual,
       0 AS expected
FROM financial_metrics
WHERE value IS NULL

UNION ALL

SELECT 'Invalid market prices', COUNT(*), 0
FROM market_prices
WHERE high < GREATEST(open, close, low)
   OR low > LEAST(open, close, high)
   OR close <= 0
   OR adj_close <= 0
   OR volume < 0

UNION ALL

SELECT 'Missing capital gains', COUNT(*), 2823
FROM market_prices
WHERE capital_gains IS NULL

UNION ALL

SELECT 'Policy rate imputed', COUNT(*), 1
FROM daily_interest_rates
WHERE policy_interest_rate_imputed = 1

UNION ALL

SELECT '5Y bond yield imputed', COUNT(*), 39
FROM daily_interest_rates
WHERE canada_5y_bond_yield_imputed = 1

UNION ALL

SELECT '10Y bond yield imputed', COUNT(*), 39
FROM daily_interest_rates
WHERE canada_10y_bond_yield_imputed = 1

UNION ALL

SELECT 'Seasonally adjusted retail sales', COUNT(*), 45
FROM monthly_macro
WHERE seasonally_adjusted = 1;

-- Validate market price consistency

SELECT COUNT(*) AS invalid_market_prices
FROM market_prices
WHERE high < GREATEST(open, close, low)
   OR low > LEAST(open, close, high)
   OR open <= 0
   OR high <= 0
   OR low <= 0
   OR close <= 0
   OR adj_close <= 0
   OR volume < 0;
   
SET GLOBAL local_infile = OFF;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

