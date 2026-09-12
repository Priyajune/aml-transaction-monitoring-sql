USE AML_Monitoring;
GO

-- =======================================================
-- Project: AML Transaction Monitoring Engine
-- Script: 01_structuring_detection.sql
-- Objective: Flag potential structuring/smurfing below $10,000 threshold
-- =======================================================

SELECT 
    account_id,
    COUNT(txn_id) AS transaction_count,
    SUM(txn_amount) AS total_amount_smurfed
FROM aml_transactions
WHERE txn_amount BETWEEN 9000 AND 9999.99
GROUP BY account_id
HAVING COUNT(txn_id) > 1;