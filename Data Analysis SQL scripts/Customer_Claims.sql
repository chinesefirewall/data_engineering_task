/*
--View: Customer_Claims
Description: This view will join the customer data with their 
respective claims data.
*/

CREATE VIEW Customer_Claims AS
SELECT
    cp.customer_id,
    cp.customer_name,
    cp.customer_email,
    cp.customer_address,
    cp.age,
    cp.gender,
    cp.occupation,
    cp.policy_id,
    cp.policy_type,
    cp.policy_start_date,
    cl.claim_id,
    cl.claim_date,
    cl.claim_amount
FROM
    Customer_Policy AS cp
JOIN
    Claims_Policy AS cl
ON
    cp.policy_id = cl.policy_id;
