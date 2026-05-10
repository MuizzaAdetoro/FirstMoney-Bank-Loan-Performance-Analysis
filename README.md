# FirstMoney-Bank-Loan-Performance-Analysis
# Loan Performance Analysis — FirstMoney Bank

**Tools:** Microsoft Excel · Power BI · PostgreSQL  
**Skills:** Data Cleaning · SQL Queries · DAX · Dashboard Development · Risk Analysis  
**Status:** Completed

---

## Project Overview

FirstMoney Bank operates 10 retail branches across Lagos, Abuja, Port Harcourt and Kano. Following a **12% spike in loan defaults** last quarter, the Head of Retail Banking commissioned an urgent review of loan and repayment data for the past year.

This project analyses **500 loan records** across customer, branch, repayment and staff datasets to diagnose the root causes of the default spike and recommend actionable changes.

---

## Key Findings

| Metric | Result |
|--------|--------|
| Overall Default Rate | **13.8%** (69 of 500 loans) |
| Total Loans Disbursed | **₦1.77 billion** |
| Total Repayments Collected | **₦1.03 billion** |
| Highest Risk Loan Type | **SME — 18% default rate** |
| Worst Performing Branch | **Sabon Gari — 23.3% default rate** |
| Highest Exposure Branch | **Maitama — ₦300M+ disbursed, 11% default = ₦42M bad loans** |
| Worst Region | **North — Retail segment 28.6% default rate** |

---

## Technical Workflow

### 1. Data Cleaning — Microsoft Excel
- Fixed negative loan amounts and implausible zeros
- Resolved missing values across customer, branch and repayment tables
- Standardised text formats and established clean data tables for reporting

### 2. SQL Analysis — PostgreSQL
Seven business questions answered using structured queries:

| Query | Description |
|-------|-------------|
| Q1 | Loan summary by type — total count, disbursed amount, average loan |
| Q2 | High-value defaulted loans (amount > ₦2M) |
| Q3 | Lagos region loans — JOIN across loans and branches tables |
| Q4 | Branch-level default rates — sorted descending |
| Q5 | Top 5 Relationship Managers by disbursement vs target |
| Q6 | Monthly repayment trend — on-time, late and missed counts |
| Q7 | Customer segment × region default analysis (3-table JOIN) |

**SQL techniques used:** INNER JOIN, LEFT JOIN, GROUP BY, HAVING, CTEs, Window Functions (RANK OVER PARTITION BY), CASE statements, FILTER clauses, ALTER TABLE

### 3. Dashboard — Power BI
Built an interactive dashboard with DAX measures covering:
- KPI cards: total disbursed, loan count, repayments collected, default rate
- Branch-level loan amounts and default rates
- Monthly repayment trend line chart
- Default rate by customer segment and region (clustered bar)
- Loan type distribution (donut chart)
- Slicers: Region, Loan Type

---

## Strategic Recommendations

1. **Immediate action** — Halt new Retail loans in the North region pending a full credit and recovery review
2. **Segment focus** — Prioritise SME portfolio management; 36.4% of portfolio with 18% default rate is unsustainable
3. **Branch oversight** — Place Sabon Gari and Wuse II branches on performance improvement plans
4. **RM accountability** — Review Relationship Managers with default rates of 22–35%
5. **Maitama risk** — Despite high disbursement, 11% default rate equals ₦42M in bad loans — needs immediate recovery focus

---

## Files in This Repository

| File | Description |
|------|-------------|
| `Loan_Performance_SQL.sql` | All 7 SQL queries with comments |
| `FirstMoney_Dashboard.pbix` | Power BI dashboard file |
| `SQL_Query_Results.pdf` | Screenshots of all query outputs |
| `Dashboard_Screenshot.pdf` | Power BI dashboard export |

---

## About

**Adetoro Muizza Olaitan** — Data Analyst  
📧 muizzaadetoro@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/muizza-o-adetoro/)  
🌐 [Portfolio](https://muizzaadetoro.github.io)
