# Loan Performance Analysis — FirstMoney Bank

**Tools:** Microsoft Excel · Power BI · PostgreSQL  
**Skills:** Data Cleaning · Relational Database Queries (JOINs, CTEs) · Trend Analysis · Stakeholder Reporting  
**Status:** Completed

---

## Project Overview

FirstMoney Bank operates 10 retail branches across Lagos, Abuja, Port Harcourt and Kano. Following a **12% spike in loan defaults** last quarter, the Head of Retail Banking commissioned an urgent review of the bank's loan and repayment data for the past year.

This project analyses **500 loan records** across customer, branch, repayment and staff datasets to diagnose the root causes of the default spike and recommend actionable changes.

---

## Technical Workflow & Methodology

To process and analyse the data effectively, I used a multi-tool pipeline:

- **Data Cleaning & Structuring (Microsoft Excel):** Processed raw datasets to handle missing values, standardise text formats and establish clean data tables for accurate reporting. Fixed negative loan amounts, implausible zeros and inconsistent column data types.

- **Data Visualisation (Power BI):** Ingested cleaned Excel data to build an interactive dashboard using DAX. Gave stakeholders a high-level view of default rates, disbursement volumes and regional performance with slicers for Region and Loan Type.

- **Business Analysis (PostgreSQL):** Imported data into a relational database to answer 7 targeted business questions using:
  - Multi-table JOINs across loans, branches, customers and staff tables
  - CTEs to calculate branch-level default rates cleanly
  - FILTER clauses for conditional aggregations (on-time vs late vs missed payments)
  - RANK() OVER PARTITION BY to identify top Relationship Managers by region
  - ALTER TABLE to convert TEXT columns to NUMERIC for financial aggregations

*(The complete SQL script is in the `Loan_Performance_SQL_Scripts` folder)*

---

## Key Findings

| Metric | Result |
|--------|--------|
| Overall Default Rate | **13.8%** (69 of 500 loans) |
| Total Loans Disbursed | **₦1.77 billion** |
| Total Repayments Collected | **₦1.03 billion** |
| Highest Risk Loan Type | **SME — 18% default rate, 36.4% of portfolio** |
| Worst Performing Branch | **Sabon Gari (Kano) — 23.3% default rate** |
| Highest Exposure Branch | **Maitama (Abuja) — ₦300M+ disbursed, 11% default = ₦42M bad loans** |
| Worst Segment × Region | **Retail North — 28.6% default rate** |
| Repayment Low Point | **September — ₦8.2M collected** |
| Repayment Peak | **October and December — ₦89M+** |

---

## Strategic Recommendations

1. **Restrict SME lending in the North region** until default rates stabilise — the Retail North segment at 28.6% and Corporate South-South at 28.6% are the two highest-risk combinations in the portfolio.

2. **Restructure Relationship Manager targets** to measure repayment quality, not just disbursement volume. RMs with 22–35% personal default rates should not be rewarded purely on loan amounts issued.

3. **Place Sabon Gari branch under a performance improvement plan** — 23.3% default rate with only 43 loans is a clear process and credit assessment failure, not a volume problem.

4. **Investigate the September repayment drop** — collections fell to ₦8.2M against a monthly average above ₦85M. This is too sharp to be seasonal and likely reflects a maturity clustering issue or a specific disbursement cohort hitting default simultaneously.

---

## Project Files

- **[View the Complete SQL Script](https://github.com/MuizzaAdetoro/Loan-Performance-Analysis/blob/main/Loan_Performance_Analysis_SQL_Scripts/)**
- **[View SQL Query Results](https://github.com/MuizzaAdetoro/Loan-Performance-Analysis/blob/main/SQL_Query_Results/)**
---

## Dashboard Preview

*<img width="773" height="378" alt="image" src="https://github.com/user-attachments/assets/20226c8e-57ef-4492-9544-9cc024d65c1c" />
*

---

## About

**Adetoro Muizza Olaitan** — Data Analyst  
📧 muizzaadetoro@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/muizza-o-adetoro/)  
🌐 [Portfolio](https://muizzaadetoro.github.io)

