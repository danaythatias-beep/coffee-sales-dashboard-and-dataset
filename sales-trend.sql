CREATE OR REPLACE TEMPORARY VIEW `temp_mv__01f18a2b5ef11411b177f4e32df90400` WITH METRICS
LANGUAGE YAML AS
$$
version: '1.1'
source: workspace.default.coffee_sales
dimensions:
  - name: datetime
    expr: datetime
  - name: date_only
    expr: DATE(datetime)
  - name: day_of_week
    expr: DAYOFWEEK(datetime)
  - name: day_name
    expr: DATE_FORMAT(datetime, 'EEEE')
  - name: month
    expr: DATE_TRUNC('month', datetime)
  - name: cash_type
    expr: cash_type
  - name: coffee_name
    expr: coffee_name
measures:
  - name: total_sales
    expr: SUM(money_amount)
  - name: transaction_count
    expr: COUNT(*)
  - name: avg_order_value
    expr: AVG(money_amount)
  - name: unique_customers
    expr: COUNT(DISTINCT customer_id)
$$;

SELECT
  `date_only` `date_only`,
  MEASURE(`total_sales`) `measure(total_sales)`
FROM
  temp_mv__01f18a2b5ef11411b177f4e32df90400
GROUP BY
  `date_only`
