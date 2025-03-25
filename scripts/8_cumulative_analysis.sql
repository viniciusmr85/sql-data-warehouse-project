/*
========================================================================================
Advanced Data Analytics: Cumulative Analysis
========================================================================================
- Analyse how a measure evolves over time.
- Helps track trends and identify seasonality in you data.

	- Total Sales by Year
	- Calculate the moving average price 
    - and the running total sales over time

========================================================================================
*/



SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM (
	SELECT
	DATETRUNC(YEAR, order_date) AS order_date,
	SUM(sales_amount) AS total_sales,
	AVG(price) AS avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR, order_date)
)t
