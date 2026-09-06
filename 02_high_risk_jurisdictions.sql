-- =======================================================
-- Project: AML Transaction Monitoring Engine
-- Script: 02_high_risk_jurisdictions.sql
-- Objective: Detect high-value transfers to high-risk secrecy havens
-- Rule: Outbound transactions > $50,000 to Panama or Cayman Islands
-- ========================================================

SELECT 
    txn_id,
    account_id,
    txn_amount,
    destination_country,
    txn_timestamp
FROM aml_transactions
WHERE destination_country IN ('Panama', 'Cayman Islands')
  AND txn_amount > 50000;

