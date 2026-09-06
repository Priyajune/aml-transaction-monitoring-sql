USE AML_Monitoring;
GO

-- Calculate elapsed minutes between consecutive transactions per account
WITH RankedTransactions AS (
    SELECT 
        txn_id,
        account_id,
        txn_amount,
        txn_timestamp,
        LAG(txn_timestamp) OVER (
            PARTITION BY account_id 
            ORDER BY txn_timestamp
        ) AS previous_txn_timestamp
    FROM aml_transactions
)
SELECT 
    txn_id,
    account_id,
    txn_amount,
    txn_timestamp,
    previous_txn_timestamp,
    DATEDIFF(MINUTE, previous_txn_timestamp, txn_timestamp) AS minutes_since_last_txn
FROM RankedTransactions
WHERE previous_txn_timestamp IS NOT NULL;