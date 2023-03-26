/*
Loss Ratio
Loss Ratio = (Total Claims Amount / Total Premiums) * 100

*/
-- 

-- Calculate the total claims amount per quarter
WITH quarterly_claims AS (
  SELECT
    DATE_TRUNC('quarter', claim_date) AS quarter, -- Group by quarter
    SUM(claim_amount) AS total_claims_amount -- Sum the claim amounts for each quarter
  FROM
    final_analysis_data_clean
  GROUP BY
    quarter
),
-- Calculate the total number of premiums per quarter
quarterly_premiums AS (
  SELECT
    DATE_TRUNC('quarter', policy_start_date) AS quarter, -- Group by quarter
    COUNT(policy_id) AS total_premiums -- Count the number of premiums for each quarter
  FROM
    final_analysis_data_clean
  GROUP BY
    quarter
)
-- Calculate the loss ratio for each quarter
SELECT
  q1.quarter, -- Select the quarter
  ROUND( -- Round the loss ratio to 2 decimal places
    (q1.total_claims_amount / NULLIF(q2.total_premiums, 0)) * 100, -- Calculate the loss ratio 
	  --by dividing the total claims amount by the total premiums and multiplying by 100
    2
  ) AS loss_ratio
FROM
  quarterly_claims q1 -- Join the two CTEs (quarterly_claims and quarterly_premiums) on the quarter column
JOIN
  quarterly_premiums q2 ON q1.quarter = q2.quarter;


/*
In this query:

The quarterly_claims CTE calculates the total claim amount per quarter, 
filtering out records with null claim_date.

The quarterly_premiums CTE calculates the total premium per quarter, 
filtering out records with null policy_start_date.

The main SELECT statement calculates the loss ratio for each quarter by 
dividing the total_claim_amount by the total_premium, using the COALESCE 
function to replace null values with 0 and rounding the result to 2 
decimal places.

*/