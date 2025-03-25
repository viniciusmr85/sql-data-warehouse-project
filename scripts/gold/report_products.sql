/*
============================================================================
Product Report
============================================================================
Purpose:
	- This report consolidates key product metrics and behaviours

Highlights:
	1. Gather essential fields such as product name, category, subcategory, and cost
	2. Segments by revenue to identify High-Performers, Mid-Range, or Low-Performers.
	3. Aggregates customers-level metrics:
		- total order
		- total sales
		- total quantity sold
		- total cutomers (unique)
		- lifespan (in months)
	4. Calculates valuable  KPIs:
		 - recency (months since last sale)
		 - average order revenue (AOR)
		 - average monthly revenue
============================================================================
*/
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
	DROP VIEW gold.report_products;

GO

CREATE VIEW gold.report_products AS

WITH base_query AS (
/*-------------------------------------------------------------------------
1) Base Query: Retrieves core columns from fact_sales and dim_products
-------------------------------------------------------------------------*/
SELECT
f.order_number,
f.order_date,
f.customer_key,
f.sales_amount,
f.quantity,
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE order_date IS NOT NULL)

, product_aggregation AS (
/*-------------------------------------------------------------------------
2) Product Aggregation: Summarizes key metrics at the product level
-------------------------------------------------------------------------*/
SELECT 
product_key,
product_name,
category,
subcategory,
cost,
COUNT(DISTINCT order_number) AS total_orders,
MAX(order_date) AS last_order_date,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)),1) AS avg_salling_price

FROM base_query
GROUP BY
	product_key,
	product_name,
	category,
	subcategory,
	cost
)

/*-------------------------------------------------------------------------
3) Final Query: Combine all products result into one output
-------------------------------------------------------------------------*/
SELECT
product_key,
product_name,
category,
subcategory,
cost,
last_order_date,
DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency_in_months,
CASE
	WHEN total_sales > 5000 THEN 'High-Performers'
	WHEN total_sales <= 5000 THEN 'Mid-Range'
	ELSE 'Low-Performers'
END AS product_segment,
total_orders,
total_customers,
total_sales,
total_quantity,
lifespan,
avg_salling_price,
-- average order revenue (AOR)
CASE 
	 WHEN total_orders = 0 THEN 0
	 ELSE total_sales/total_orders
END AS avg_order_revenue,
-- average monthly revenue 
	CASE WHEN lifespan = 0 THEN total_sales
		 ELSE total_sales / lifespan
	END AS avg_monthly_revenue
FROM product_aggregation
