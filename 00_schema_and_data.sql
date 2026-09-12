create database AML_Monitoring;
GO
USE AML_Monitoring;
GO
CREATE TABLE aml_transactions (
    txn_id INT PRIMARY KEY,
    account_id VARCHAR(20) NOT NULL,
    txn_timestamp DATETIME NOT NULL,
    txn_amount DECIMAL(18, 2) NOT NULL,
    destination_country VARCHAR(50) NOT NULL,
    txn_type VARCHAR(20) NOT NULL,
    risk_flag VARCHAR(10) DEFAULT 'CLEAR'
);
INSERT INTO aml_transactions (txn_id, account_id, txn_timestamp, txn_amount, destination_country, txn_type)
VALUES 
(101, 'ACC_9001', '2026-08-01 09:15:00', 4500.00, 'India', 'WIRE'),
(102, 'ACC_9002', '2026-08-01 10:00:00', 9800.00, 'Cayman Islands', 'WIRE'),
(103, 'ACC_9002', '2026-08-01 11:30:00', 9900.00, 'Cayman Islands', 'WIRE'),
(104, 'ACC_9003', '2026-08-02 14:00:00', 250.00, 'Germany', 'UPI'),
(105, 'ACC_9001', '2026-08-02 15:45:00', 12000.00, 'India', 'WIRE'),
(106, 'ACC_9002', '2026-08-03 08:20:00', 9500.00, 'Cayman Islands', 'WIRE'),
(107, 'ACC_9004', '2026-08-03 16:10:00', 75000.00, 'Panama','WIRE');
GO

SELECT * 
FROM aml_transactions;

