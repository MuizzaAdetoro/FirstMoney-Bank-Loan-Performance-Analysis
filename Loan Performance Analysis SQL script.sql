---TABLES 
SELECT * FROM repayments;
SELECT * FROM loans;
SELECT * FROM customers;
SELECT * FROM staff;
SELECT * FROM branches;

/*I altered the 'loan_amount', 'target_amount', 'amount_paid', 'payment_date' column from TEXT to NUMERIC and DATE. 
This was necessary to perform aggregations (SUM/AVG) 
and to ensure financial data integrity.*/
ALTER TABLE loans 
ALTER COLUMN loan_amount TYPE NUMERIC USING loan_amount :: NUMERIC;

ALTER TABLE staff
ALTER COLUMN target_amount TYPE NUMERIC USING target_amount :: NUMERIC;

ALTER TABLE repayments
ALTER COLUMN amount_paid TYPE NUMERIC USING amount_paid :: NUMERIC;

ALTER TABLE repayments
ALTER COLUMN payment_date TYPE DATE USING payment_date::date;

--Q1: Loan Summary by Type 
/*Using the loans table only, return each loan_type with: Total number of loans, Total amount disbursed (rounded to 2 decimal places),
Average loan amount
Sort by total amount disbursed from highest to lowest.*/

SELECT loan_type,
    COUNT(loan_id) AS total_number_of_loans,
    ROUND(SUM(loan_amount), 2) AS total_amount_disbursed,
    ROUND(AVG(loan_amount), 2) AS average_loan_amount
FROM loans
GROUP BY loan_type
ORDER BY total_amount_disbursed DESC;

--Q2: High-Value Defaulted Loans
/*Return loan_id, loan_type, loan_amount, and disbursement_date for all loans where loan_status = 'Defaulted' AND loan_amount > 2,000,000.
Sort by loan_amount descending.*/

SELECT loan_id, loan_type, loan_amount, disbursement_date
FROM loans
WHERE loan_status = 'Defaulted' AND loan_amount > 2000000
ORDER BY loan_amount DESC;

--Q3: Lagos Region Loans with JOIN  
/*Return loan_id, loan_type, loan_amount, loan_status, and branch_name for every loan disbursed from a branch in Lagos. 
You must JOIN the loans and branches tables. Sort by loan_amount descending.*/

SELECT l.loan_id, l.loan_type, l.loan_amount, l.loan_status, b.branch_name
FROM loans l
JOIN branches b ON l.branch_id = b.branch_id
WHERE b.city = 'Lagos'
ORDER BY l.loan_amount DESC;

--Q4: Total Loans per Branch with Default Rate  
/*For each branch, return branch_name, city, total loans, total loan amount, number of defaulted loans, and default rate (rounded to 1 decimal place). 
Include only branches with more than 5 loans. Sort by default rate descending.*/

WITH LPB AS (
    SELECT b.branch_name, b.city, 
        COUNT(l.loan_id) AS total_loans, 
        SUM(l.loan_amount) AS total_loan_amount,
       COUNT(l.loan_id) FILTER (WHERE l.loan_status = 'Defaulted') AS no_defaulted_loans
    FROM loans l
    JOIN branches b ON l.branch_id = b.branch_id
    GROUP BY b.branch_name, b.city
)
SELECT branch_name, city, total_loans,
    ROUND(total_loan_amount, 2) AS total_loan_amount,
    no_defaulted_loans,
    ROUND((no_defaulted_loans * 100.0) / total_loans, 1) AS default_rate_pct
FROM LPB
WHERE total_loans > 5
ORDER BY default_rate_pct DESC;

--Q5: Top 5 Relationship Managers  
/*Return the top 5 RMs by total loan amount (Active and Fully Paid only). 
Show rm_name, branch_name, count of loans, total loan amount, target_amount, and attainment_pct = (total disbursed ÷ target_amount) × 100, rounded to 1 decimal place. 
Sort descending.*/

WITH RMP AS (
    SELECT s.rm_name, b.branch_name, s.target_amount,
        COUNT(l.loan_id) AS count_of_loans,
        SUM(l.loan_amount) AS total_disbursed
    FROM staff s
    JOIN loans l ON s.rm_id = l.rm_id
    JOIN branches b ON s.branch_id = b.branch_id
    WHERE l.loan_status IN ('Active', 'Fully Paid')
    GROUP BY s.rm_name, b.branch_name, s.target_amount
)
SELECT rm_name, branch_name, count_of_loans,
    ROUND(total_disbursed, 2) AS total_loan_amount,
    target_amount,
    ROUND((total_disbursed / target_amount) * 100, 1) AS attainment_pct
FROM RMP
ORDER BY total_loan_amount DESC
LIMIT 5;

--Q6: Monthly Repayment Trend  
/*Using the repayments table, produce a monthly summary showing year-month (YYYY-MM), total amount collected, 
count of On-Time / Late / Missed payments, and on-time rate (rounded to 1 decimal place). 
Sort by year-month ascending.*/

SELECT 
	EXTRACT(YEAR FROM payment_date) || '-' || EXTRACT(MONTH FROM payment_date) AS year_month,
    SUM(amount_paid) AS total_amount_collected,
    COUNT(repayment_id) FILTER (WHERE payment_status = 'On-Time') AS on_time_count,
    COUNT(repayment_id) FILTER (WHERE payment_status = 'Late') AS late_count,
    COUNT(repayment_id) FILTER (WHERE payment_status = 'Missed') AS missed_count,
	ROUND((COUNT(repayment_id) FILTER (WHERE payment_status = 'On-Time') * 100.0) 
        / COUNT(repayment_id), 1) AS on_time_rate_pct
FROM repayments
GROUP BY  EXTRACT(YEAR FROM payment_date) || '-' || EXTRACT(MONTH FROM payment_date)
ORDER BY year_month ASC;

--Q7: Customer Segment Default Analysis  (3-table JOIN)   
/*Join loans, customers, and branches. For each combination of customer_segment and region, return total loans, total loan amount, 
defaulted loan count, and default rate (%). Include only combinations with at least 3 loans.
Sort by default rate descending.
Add a one-sentence comment in your .sql file below Q7 explaining what the result reveals.*/

WITH CS AS (
    SELECT c.customer_segment, b.region,
        COUNT(l.loan_id) AS total_loans,
        SUM(l.loan_amount) AS total_loan_amount,
        COUNT(l.loan_id) FILTER (WHERE l.loan_status = 'Defaulted') AS defaulted_count
    FROM loans l
    JOIN customers c ON l.customer_id = c.customer_id
    JOIN branches b ON l.branch_id = b.branch_id
    GROUP BY c.customer_segment, b.region
)
SELECT customer_segment, region, total_loans,
    ROUND(total_loan_amount, 2) AS total_loan_amount,
    defaulted_count,
    ROUND((defaulted_count * 100.0) / total_loans, 1) AS default_rate_pct
FROM CS
WHERE total_loans >= 3
ORDER BY default_rate_pct DESC;

---Add a one-sentence comment in your .sql file below Q7 explaining what the result reveals.
--The result reveals that the Retail segment in the North and Corporate segment in the South-South have the highest default rates, suggesting that the bank needs to investigate regional economic factors affecting these specific groups.




