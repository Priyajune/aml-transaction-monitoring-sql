-- =======================================================
-- Project: AML Transaction Monitoring Engine
-- Script: 03_automated_risk_classification.sql
-- Objective: Automatically tag transactions with compliance risk flags
-- =======================================================

USE AML_Monitoring;
GO

-- 1. Expand the column capacity
ALTER TABLE aml_transactions
ALTER COLUMN risk_flag VARCHAR(20);
GO

-- 2. Execute the Risk Classification Update
UPDATE aml_transactions
SET risk_flag = CASE 
    WHEN destination_country IN ('Panama', 'Cayman Islands') AND txn_amount > 50000 
        THEN 'HIGH_RISK'
    WHEN txn_amount BETWEEN 9000 AND 9999.99 
        THEN 'STRUCTURING'
    ELSE 'CLEAR'
END;
GO

-- 3. Audit Verification Query
SELECT 
    risk_flag,
    COUNT(txn_id) AS transaction_count,
    SUM(txn_amount) AS total_exposure_usd
FROM aml_transactions
GROUP BY risk_flag;
GO