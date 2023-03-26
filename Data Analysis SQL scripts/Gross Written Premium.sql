/*
Gross Written Premium (GWP)
Gross Written Premium = Total Premiums for the quarter
*/

SELECT
  DATE_TRUNC('quarter', policy_start_date) AS quarter,
  COUNT(policy_id) AS gross_written_premium
FROM
  final_analysis_data_clean
GROUP BY
  quarter;
