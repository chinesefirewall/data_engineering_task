/*
-- View: Claims_Policy
Description: This view will join the claims data with their 
respective policy data.
*/
CREATE VIEW Claims_Policy AS
SELECT
    t2.claim_id,
    t2.claim_date,
    t2.claim_amount,
    t3.policy_id,
    t3.customer_id,
    t3.policy_type,
    t3.policy_start_date
FROM
    claims_table AS t2
JOIN
    policy_table AS t3
ON
    t2.policy_id = t3.policy_id;
