USE AML_Monitoring;
GO

CREATE OR ALTER PROCEDURE sp_RunDailyAMLMonitoring
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Apply Dynamic Risk Flags to Unprocessed Transactions
    UPDATE aml_transactions
    SET risk_flag = CASE 
        WHEN destination_country IN ('Panama', 'Cayman Islands') AND txn_amount > 50000 
            THEN 'HIGH_RISK'
        WHEN txn_amount BETWEEN 9000 AND 9999.99 
            THEN 'STRUCTURING'
        ELSE 'CLEAR'
    END;

    -- 2. Generate Immediate Audit Summary Report
    SELECT 
        risk_flag,
        COUNT(txn_id) AS total_alerts,
        SUM(txn_amount) AS flagged_volume_usd
    FROM aml_transactions
    GROUP BY risk_flag;
END;
GO  

EXEC sp_RunDailyAMLMonitoring;