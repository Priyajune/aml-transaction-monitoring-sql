# Automated AML Transaction Monitoring & Risk Classification Engine

## Project Overview
This project implements an enterprise-grade Anti-Money Laundering (AML) transaction monitoring engine developed using Microsoft SQL Server (T-SQL). The system is engineered to ingest raw banking transaction streams, screen counterparty risks against global regulatory standards, flag threshold evasion behaviors (smurfing/structuring), calculate transaction velocity anomalies, and serve sanitized views for Business Intelligence (Power BI) and operational compliance reporting.

---

## Regulatory Framework & Business Rules

### 1. Currency Transaction Reporting (CTR) Threshold Evasion (Structuring)
* **Regulatory Standard:** Under global AML frameworks (FinCEN, FATF, FIU), cash or cross-border wire transfers approaching the statutory $10,000 threshold must be flagged for suspicious activity analysis.
* **Detection Logic:** Aggregates transactions grouped by account where individual amounts fall between $9,000.00 and $9,999.99 with multiple occurrences (`HAVING COUNT(*) > 1`), identifying intentional smurfing patterns.

### 2. High-Risk Jurisdiction Screening
* **Regulatory Standard:** Outbound capital transfers exceeding $50,000 directed toward jurisdictions characterized by financial secrecy or weak regulatory oversight require immediate Enhanced Due Diligence (EDD).
* **Detection Logic:** Filters outbound wire transactions where `destination_country IN ('Panama', 'Cayman Islands')` and `txn_amount > 50000.00`.

### 3. Transaction Velocity Anomalies
* **Regulatory Standard:** Rapid succession of transfers across short timeframes indicates potential account takeover, layering, or urgent capital exfiltration.
* **Detection Logic:** Employs the `LAG()` analytic window function partitioned by `account_id` and ordered chronologically to calculate elapsed minutes between consecutive transactions (`DATEDIFF`), isolating rapid-fire spikes.

---

## Repository Structure & Modular Scripts

| File Name | Script Type | Objective / Description |
| :--- | :--- | :--- |
| `00_schema_and_data.sql` | DDL / DML | Initializes the `AML_Monitoring` database, primary transaction ledger (`aml_transactions`), schema constraints, and audit seed records. |
| `01_structuring_detection.sql` | Query Logic | Scans transaction records to detect repeated sub-$10,000 deposits/transfers using aggregation filters (`GROUP BY`, `HAVING`). |
| `02_high_risk_jurisdictions.sql` | Query Logic | Extracts high-value transfers routed to FATF grey/black-listed jurisdictions requiring Enhanced Due Diligence (EDD). |
| `03_automated_risk_classification.sql` | ETL / Classification | Executes batch rule-based classifications using dynamic `CASE` expressions to update transaction risk flags (`STRUCTURING`, `HIGH_RISK`, `CLEAR`). |
| `04_velocity_risk_detection.sql` | Window Function Logic | Leverages `LAG()` and `OVER (PARTITION BY ... ORDER BY ...)` with Common Table Expressions (CTEs) to isolate short-interval transfer patterns. |
| `05_compliance_alert_view.sql` | Operational View | Creates a production-ready view (`vw_aml_high_risk_alerts`) that filters only flagged records for direct connection to Power BI dashboards. |
| `06_automated_monitoring_procedure.sql` | Stored Procedure | Deploys a stored routine (`sp_RunDailyAMLMonitoring`) designed for automated scheduled jobs to categorize incoming records and output audit metrics. |

---

## Executive Audit Summary

The initial validation run across baseline transaction logs yielded the following compliance exposure:

| Risk Flag | Transaction Count | Total Exposure (USD) | Regulatory / Compliance Action |
| :--- | :---: | :---: | :--- |
| **HIGH_RISK** | 1 | $75,000.00 | Immediate Escalation / Enhanced Due Diligence (EDD) |
| **STRUCTURING** | 3 | $29,200.00 | File Suspicious Activity Report (SAR) |
| **CLEAR** | 3 | $16,750.00 | Standard Automated Surveillance / Cleared |
| **TOTAL** | **7** | **$120,950.00** | Full Portfolio Ledger |

---

## Technical Skills Applied

* **Database Engine:** Microsoft SQL Server Management Studio (SSMS), T-SQL
* **Analytical Querying:** Common Table Expressions (`WITH`), Window Functions (`LAG()`, `OVER`, `PARTITION BY`), Aggregations (`GROUP BY`, `HAVING`)
* **Database Programming:** Schema Definition (`DDL`), Data Manipulation (`DML`), Dynamic Updates (`CASE`), Operational Views (`CREATE VIEW`), Stored Procedures (`CREATE PROCEDURE`)
* **Version Control:** Git, GitHub Desktop, GitHub Repository Management
* **Domain Knowledge:** Anti-Money Laundering (AML), Know Your Customer (KYC), Suspicious Activity Reports (SAR), Currency Transaction Reports (CTR), FATF Compliance