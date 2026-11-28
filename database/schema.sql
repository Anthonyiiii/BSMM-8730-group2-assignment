
-- BSMM 8730 - Group 2 Assignment
-- SmartCentres REIT Data Pipeline
-- Database Design and Implementation

CREATE DATABASE IF NOT EXISTS reit_investment_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE reit_investment_db;

SELECT DATABASE();


-- 1. Securities Master Table

CREATE TABLE securities (
    ticker VARCHAR(20) PRIMARY KEY,
    security_name VARCHAR(100) NOT NULL,
    currency CHAR(3) NOT NULL,
    security_type VARCHAR(20) NOT NULL,
    analysis_role VARCHAR(20) NOT NULL
) ENGINE = InnoDB;


-- 2. Financial Metric Definitions

CREATE TABLE metric_definitions (
    metric VARCHAR(100) PRIMARY KEY,
    metric_group VARCHAR(100) NOT NULL,
    unit VARCHAR(30) NOT NULL,
    comparability_note TEXT NOT NULL
) ENGINE = InnoDB;


-- 3. Financial Metrics Table

CREATE TABLE financial_metrics (
    ticker VARCHAR(20) NOT NULL,
    period_end DATE NOT NULL,
    period_type VARCHAR(20) NOT NULL,
    metric VARCHAR(100) NOT NULL,
    value DECIMAL(24,10) NOT NULL,
    source_file VARCHAR(255) NOT NULL,
    source_page INT,
    source_label TEXT,
    original_value DECIMAL(24,10),
    original_unit VARCHAR(50),
    extraction_method VARCHAR(150),
    original_line TEXT,

    PRIMARY KEY (
        ticker,
        period_end,
        period_type,
        metric
    ),

    CONSTRAINT fk_financial_security
        FOREIGN KEY (ticker)
        REFERENCES securities(ticker),

    CONSTRAINT fk_financial_metric
        FOREIGN KEY (metric)
        REFERENCES metric_definitions(metric)

) ENGINE = InnoDB;


-- 4. Daily Market Prices Table

CREATE TABLE market_prices (
    date DATE NOT NULL,
    open DECIMAL(20,10) NOT NULL,
    high DECIMAL(20,10) NOT NULL,
    low DECIMAL(20,10) NOT NULL,
    close DECIMAL(20,10) NOT NULL,
    adj_close DECIMAL(20,10) NOT NULL,
    volume BIGINT NOT NULL,
    dividends DECIMAL(20,10) NOT NULL,
    stock_splits DECIMAL(20,10) NOT NULL,
    ticker VARCHAR(20) NOT NULL,
    capital_gains DECIMAL(20,10),

    PRIMARY KEY (ticker, date),

    CONSTRAINT fk_market_security
        FOREIGN KEY (ticker)
        REFERENCES securities(ticker)

) ENGINE = InnoDB;



-- 5. Daily Interest Rates Table

CREATE TABLE daily_interest_rates (
    date DATE PRIMARY KEY,

    policy_interest_rate DECIMAL(10,6) NOT NULL,
    canada_5y_bond_yield DECIMAL(10,6) NOT NULL,
    canada_10y_bond_yield DECIMAL(10,6) NOT NULL,

    policy_interest_rate_imputed BOOLEAN NOT NULL,
    canada_5y_bond_yield_imputed BOOLEAN NOT NULL,
    canada_10y_bond_yield_imputed BOOLEAN NOT NULL,

    policy_interest_rate_observed DECIMAL(10,6),
    canada_5y_bond_yield_observed DECIMAL(10,6),
    canada_10y_bond_yield_observed DECIMAL(10,6)

) ENGINE = InnoDB;


-- 6. Monthly Macroeconomic Data Table

CREATE TABLE monthly_macro (
    geography VARCHAR(50) NOT NULL,
    cpi_index DECIMAL(20,10) NOT NULL,
    base_year VARCHAR(20) NOT NULL,
    cpi_source_vector VARCHAR(30) NOT NULL,

    inflation_yoy_pct DECIMAL(20,10) NOT NULL,
    inflation_mom_pct DECIMAL(20,10) NOT NULL,

    retail_sales_cad_million DECIMAL(24,10) NOT NULL,
    retail_unit VARCHAR(30) NOT NULL,
    retail_scalar_factor VARCHAR(30) NOT NULL,
    retail_source_vector VARCHAR(30) NOT NULL,
    retail_quality_status VARCHAR(10) NOT NULL,
    retail_currency CHAR(3) NOT NULL,
    seasonally_adjusted BOOLEAN NOT NULL,

    retail_sales_yoy_pct DECIMAL(20,10) NOT NULL,
    retail_sales_mom_pct DECIMAL(20,10) NOT NULL,

    month DATE PRIMARY KEY

) ENGINE = InnoDB;


SHOW TABLES;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'reit_investment_db'
  AND REFERENCED_TABLE_NAME IS NOT NULL;






