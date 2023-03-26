/*Data Cleaning:
Ensure that the data is clean and free of errors, such as missing values, 
duplicates, and incorrect data types.*/
-- Remove duplicates
WITH deduplicated_customers AS (
SELECT DISTINCT *
FROM customer_table
),
deduplicated_claims AS (
SELECT DISTINCT *
FROM claims_table
),
deduplicated_policies AS (
SELECT DISTINCT *
FROM policy_table
),

/*Data Transformation:
Creating new features or transform existing ones to better suit anyforthcoming analysis.
For example, calculating the duration of a policy or categorizing claims 
into different buckets based on their amounts
*/
-- Calculate policy duration in days
policy_duration AS (
SELECT
policy_id,
customer_id,
policy_type,
policy_start_date,
CURRENT_DATE - policy_start_date AS policy_days
FROM
deduplicated_policies
),

-- Categorize claim amounts
claim_categories AS (
SELECT
claim_id,
claim_date,
claim_amount,
policy_id,
CASE
WHEN claim_amount <= 500 THEN 'Low'
WHEN claim_amount <= 2000 THEN 'Medium'
ELSE 'High'
END AS claim_category
FROM
deduplicated_claims
),


/*
Aggregations:
Aggregated the data at a desired level of granularity. 
I can performed aggregations on the entire dataset.

*/
-- Calculate total claims per customer

total_claims AS (
SELECT
c.customer_id,
COUNT(cl.claim_id) AS num_claims,
SUM(cl.claim_amount) AS total_claim_amount
FROM
deduplicated_customers c
LEFT JOIN
deduplicated_policies p ON c.customer_id = p.customer_id
LEFT JOIN
claim_categories cl ON p.policy_id = cl.policy_id
GROUP BY
c.customer_id
),

-- Calculate average claim amount per policy type
avg_claim_per_policy_type AS (
SELECT
p.policy_type,
AVG(cl.claim_amount) AS avg_claim_amount
FROM
deduplicated_policies p
LEFT JOIN
claim_categories cl ON p.policy_id = cl.policy_id
GROUP BY
p.policy_type
)

-- Combine the tables and views to create a final dataset for analysis
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
cl.claim_id,
cl.claim_date,
cl.claim_amount,
cl.claim_category,
tc.num_claims,
tc.total_claim_amount
FROM
deduplicated_customers c
LEFT JOIN
deduplicated_policies p ON c.customer_id = p.customer_id
LEFT JOIN
policy_duration pd ON p.policy_id = pd.policy_id
LEFT JOIN
claim_categories cl ON p.policy_id = cl.policy_id
LEFT JOIN
total_claims tc ON c.customer_id = tc.customer_id;