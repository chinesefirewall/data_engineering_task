-- Drop final_analysis_data_clean table if it exists
DROP VIEW IF EXISTS final_analysis_data_clean;

-- Drop temporary tables if they exist
DROP TABLE IF EXISTS policy_duration;
DROP TABLE IF EXISTS claim_categories;
DROP TABLE IF EXISTS total_claims;

-- Calculate policy duration in days
CREATE TEMPORARY TABLE policy_duration AS
  SELECT 
    policy_id,
    customer_id,
    policy_type,
    policy_start_date,
    CURRENT_DATE - policy_start_date AS policy_days
  FROM
    policy_table;

-- Categorize claim amounts
CREATE TEMPORARY TABLE claim_categories AS
  SELECT
    claim_id,
    claim_date,
    claim_amount,
    policy_id,
    CASE
      WHEN claim_amount <= 500 THEN 'Low'
      WHEN claim_amount > 500 AND claim_amount <= 2000 THEN 'Medium'
      ELSE 'High'
    END AS claim_category
  FROM
    claims_table;

-- Calculate total claims per customer
CREATE TEMPORARY TABLE total_claims AS
  SELECT
    c.customer_id,
    COUNT(cl.claim_id) AS num_claims,
    SUM(cl.claim_amount) AS total_claim_amount
  FROM
    customer_table c
  LEFT JOIN
    policy_table p ON c.customer_id = p.customer_id
  LEFT JOIN
    claim_categories cl ON p.policy_id = cl.policy_id
  GROUP BY
    c.customer_id;

-- Create the final_analysis_data_clean table with null values replaced by default values
CREATE TABLE final_analysis_data_clean AS
SELECT
  c.customer_id,
  c.customer_name,
  c.customer_email,
  c.customer_address,
  c.age,
  c.gender,
  c.occupation,
  p.policy_id,
  p.policy_type,
  p.policy_start_date,
  pd.policy_days,
  COALESCE(cl.claim_id, 0) AS claim_id,
  COALESCE(cl.claim_date, '2020-01-01') AS claim_date,
  COALESCE(cl.claim_amount, 0) AS claim_amount,
  COALESCE(cl.claim_category, 'Medium') AS claim_category,
  COALESCE(tc.num_claims, 0) AS num_claims,
  COALESCE(tc.total_claim_amount, 0) AS total_claim_amount
FROM
  customer_table c
LEFT JOIN
  policy_table p ON c.customer_id = p.customer_id
LEFT JOIN
  policy_duration pd ON p.policy_id = pd.policy_id
LEFT JOIN
  claim_categories cl ON p.policy_id = cl.policy_id
LEFT JOIN
  total_claims tc ON c.customer_id = tc.customer_id;
