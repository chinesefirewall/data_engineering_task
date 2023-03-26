/*
View: Customer_Policy
Description: This view will join the customer data with their respective
policy data.
*/

CREATE VIEW Customer_Policy AS
SELECT 
    t1.customer_id,
    t1.customer_name,
    t1.customer_email,
    t1.customer_address,
    t1.age,
    t1.gender,
    t1.occupation,
    t3.policy_id,
    t3.policy_type,
    t3.policy_start_date
FROM
    customer_table AS t1
JOIN
    policy_table AS t3
ON
    t1.customer_id = t3.customer_id;
