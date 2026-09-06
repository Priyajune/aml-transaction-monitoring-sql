USE AML_Monitoring;
GO

-- Create an Operational Compliance View for BI / Audit Reporting
CREATE OR ALTER VIEW vw_aml_high_risk_alerts AS
SELECT 
    txn_id,
    account_id,
    txn_timestamp,
    txn_amount,
    destination_country,
    txn_type,
    risk_flag
FROM aml_transactions
WHERE risk_flag IN ('STRUCTURING', 'HIGH_RISK');
GO

-- Query the view directly
SELECT * 
FROM vw_aml_high_risk_alerts;
GO