-- Create a new table called "customer_lifetime_value_table" and insert the output of the SELECT statement into it
CREATE TABLE customer_lifetime_value_table AS

/*
To calculate the Customer Lifetime Value (CLV) based on the given above definition, 
I need to know the average revenue per user (ARPU), 
the churn rate (the rate at which customers leave), 
and the discount rate (time value of money). 
For this case, I'll assume that we have a fixed average revenue per user (ARPU)
of 100, a churn rate of 0.05 (5%), and a discount rate of 0.1 (10%).

The formula for CLV is as follows:

CLV = ARPU * (1 - churn_rate) / (churn_rate + discount_rate)

Since we are calculating this on a quarterly basis, we can modify the formula to:

Quarterly CLV = ARPU_quarterly * (1 - churn_rate_quarterly) / (churn_rate_quarterly + discount_rate)

For simplicity, I'll assume that the ARPU and churn rate are constant across all customers.

*/

-- Calculate the total claim amount per customer for each quarter
WITH quarterly_revenue AS (
  SELECT
    customer_id,
    DATE_TRUNC('quarter', policy_start_date) AS quarter,
    COALESCE(SUM(claim_amount), 0) AS total_claim_amount
  FROM
    final_analysis_data_clean
  WHERE
    policy_start_date IS NOT NULL
  GROUP BY
    customer_id,
    quarter
),
-- Calculate the average revenue per user (ARPU) for each customer per quarter
customer_quarterly_arpu AS (
  SELECT
    customer_id,
    quarter,
    COALESCE(total_claim_amount / NULLIF(COUNT(customer_id), 0), 0) AS arpu_quarterly
  FROM
    quarterly_revenue
  GROUP BY
    customer_id,
    quarter,
    total_claim_amount
),
-- Assume a constant churn rate of 0.05 (5%) for each customer
customer_churn_rate AS (
  SELECT
    customer_id,
    0.05 AS churn_rate_quarterly
  FROM
    final_analysis_data_clean
  GROUP BY
    customer_id
)
-- Calculate the quarterly customer lifetime value (CLV) for each customer, rounded to 2 decimal places
SELECT
  a.customer_id,
  a.quarter,
  COALESCE(ROUND(a.arpu_quarterly * (1 - b.churn_rate_quarterly) / (b.churn_rate_quarterly + 0.1), 2), 0) AS customer_lifetime_value_quarterly
FROM
  customer_quarterly_arpu a
JOIN
  customer_churn_rate b ON a.customer_id = b.customer_id;

-- The output table "customer_lifetime_value_table" will have three columns:
-- - "customer_id" containing the unique identifier for each customer
-- - "quarter" containing the quarter start date for each quarter
-- - "customer_lifetime_value_quarterly" containing the CLV for each customer per quarter, rounded to 2 decimal places
