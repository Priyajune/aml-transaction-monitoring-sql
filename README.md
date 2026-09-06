# Automated AML Transaction Monitoring & Risk Classification Engine

## Project Overview
This project implements an Anti-Money Laundering (AML) transaction monitoring model in Microsoft SQL Server (T-SQL). The engine scans cross-border banking transactions, flags regulatory anomalies, detects threshold evasion patterns, and tags accounts for compliance review.

---

## Regulatory Framework & Business Rules

### 1. Currency Transaction Reporting (CTR) Threshold Evasion (Structuring)
* **Regulatory Standard:** Financial institutions must log and inspect transactions approaching the statutory $10,000 threshold.
* **Detection Logic:** Flags accounts executing repeated transfers between $9,000.00 and $9,999.99 to identify smurfing behavior.

### 2. High-Risk Jurisdiction Exposure
* **Regulatory Standard:** Outbound wire transfers exceeding $50,000 directed toward secrecy havens require immediate Enhanced Due Diligence (EDD).
* **Detection Logic:** Flags transfers over $50,000 routed to jurisdictions such as Panama and the Cayman Islands.

---

## Repository Structure

| File Name | Description |
| :--- | :--- |
| 00_schema_and_data.sql | Database creation, transaction schema, and baseline audit records. |
| 01_structuring_detection.sql | Aggregated query detecting multiple sub-$10k transfers using HAVING COUNT(*) > 1. |
| 02_high_risk_jurisdictions.sql | Filtering logic capturing high-value wire transfers to offshore territories. |
| 03_automated_risk_classification.sql | Dynamic CASE-driven data update pipeline and portfolio risk exposure summary. |

---

## Executive Audit Summary

| Risk Flag | Transaction Count | Total Exposure (USD) | Compliance Action |
| :--- | :--- | :--- | :--- |
| **HIGH_RISK** | 1 | $75,000.00 | Immediate Escalation / Enhanced Due Diligence |
| **STRUCTURING** | 3 | $29,200.00 | File Suspicious Activity Report (SAR) |
| **CLEAR** | 3 | $16,750.00 | Routine Monitoring / System Cleared |

---

## Technical Skills Applied
* **Database Management:** Microsoft SQL Server (SSMS), T-SQL
* **Query Design:** Grouping aggregations (GROUP BY, HAVING), conditional updates (CASE), schema alterations (ALTER TABLE)
* **Compliance Concepts:** AML, KYC, CTR reporting thresholds, SAR drafting, FATF risk jurisdictions