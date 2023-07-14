# data_analytics_sample_task
Example data analytics home task


## Installation
```sh
python notebook

pandas
matplotlib
psycopg2
sqlalchemy
```

Install the dependencies and Dependencies and start the server.


# Cachet Data Engineering Task

## Documentation

This README file document contains all the processes undertaken to solve sample tasks, which include answering theoretical questions, data extraction, transformation, and analysis steps, as well as a summary of the insights gained from the data analysis.

## Task 1

##### Imagine you have to develop a management dashboard for our CEO. How would you envision the visualization of the company’s management dashboard? Please list or describe all visualizations inside a management dashboard for an insurtech like Cachet.

I can provide some suggestions on the visualizations that can be incorporated into a management dashboard for an insurtech like Cachet OÜ. However, the specific visualizations that would be best suited for the CEO of the company would depend on their specific requirements and preferences. Below are some potential options:

1. Profit and revenue trends: A line chart or a bar chart showing the revenue and profit trends on a monthly or quarterly basis (e.g., Q1 profit of 1.2M euros) can provide a quick overview of the company's financial performance.

2. Customer acquisition and retention: A funnel chart or a stacked bar chart can show the number of new customers acquired (e.g., 500 new customers in March 2023) and retained over time, which can help the CEO evaluate the effectiveness of the company's marketing and retention strategies.

3. Claims data: A stacked bar chart or a pie chart can show the distribution of claims by type, severity, or location. This information can help the CEO identify trends in claims and allocate resources accordingly.

4. Underwriting metrics: A heat map or a scatter plot can show the distribution of premiums and losses by customer segment, geography, or product line. This information can help the CEO understand the profitability of different areas of the business and make strategic decisions accordingly.

5. Operational metrics: A table or a dashboard with key performance indicators (KPIs) can show the company's performance on metrics such as customer lifetime value (e.g., average CLV of 2,500 euros), loss ratio (e.g., 75% loss ratio in Q1), and claims processing time. This information can help the CEO identify areas of the business that need improvement and track progress over time.

6. Risk exposure: A heat map or a scatter plot can show the distribution of risks by customer segment, geography, or product line. This information can help the CEO identify areas of the business that may be exposed to higher risks and take appropriate action.

7. Regulatory compliance: A dashboard with KPIs related to regulatory compliance can show the company's compliance with relevant laws and regulations. This information can help the CEO ensure that the company is operating within the bounds of the law and avoid potential legal or reputational risks.

8. Business performance against targets: A dashboard with KPIs showing how the company is tracking against its monthly, quarterly, or yearly set targets (e.g., achieving 90% of Q1 sales target) can help the CEO assess the company's progress toward its goals and make adjustments as needed.

Overall, the elements of visualizations that go into a management dashboard for an insurtech like Cachet OÜ should be tailored to the specific needs of the CEO and the company and should provide a clear and concise overview of key metrics and trends.


## Task 2
1. I used Python, pandas, and TCP/IP server connection using "psycopg2 and sqlalchemy" to load the datasets into the PostgreSQL server (see the attached "Cachet_Test_Task.ipynb" script for details).

2. The next several steps were done using PG4 PostgreSQL queries. I performed data cleaning to ensure that the data is clean and free of errors, such as missing values, duplicates, and incorrect data types (see "combined_data_analysis.sql" for details). I also attempted to remove duplicate entries, if any.

3. I performed data transformation steps, such as creating new features or transforming existing ones, to better suit any forthcoming analysis. For example, calculating the duration of a policy or categorizing claims into different buckets based on their amounts.

4. I aggregated the data at a desired level of granularity, performing aggregations on the entire dataset.

5. I performed some data wrangling tasks and feature engineering to introduce new data points from already existing columns and rectified null values in the new data point (see SQL query script "FINAL_ANALYSIS_DATA_CLEAN.sql" and table named "final_analysis_data_clean.csv" for details).

6. I calculated the Customer Lifetime Value (CLV) KPI, which is a metric that indicates the total revenue a business can reasonably expect from a single customer account throughout the business relationship (see "customer_lifetime_value_table").

7. I calculated the quarterly Loss Ratio KPI, which is an indicator of how financially stable an insurance company is. It's the ratio of losses paid to premiums earned (see "Loss_Ratio.sql").

8. I calculated the Gross Written Premium (GWP) KPI, which is the number of policies written during a specific time period E.g monthly and quarterly (see "Gross_Written_Premium.sql").

In summary, the datasets can be categorized as a long table, which can be relatively easier to work with and automate ETL processes. The dataset is pretty straightforward, and I hope I have done justice to the expectation(s).
