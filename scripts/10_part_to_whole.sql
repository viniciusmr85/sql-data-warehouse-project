/*
========================================================================================
Advanced Data Analytics: Part-to-whole
========================================================================================
	- Analyse how an individual part is performing compared to the overall, 
	  allowing us to understanding which category has the greatest impact on the business.

	- Which Category contributes the most to overall sales?

========================================================================================
*/

WITH category_Sales AS(
	SELECT
		p.category,
		SUM(f.sales_amount) AS total_sales

	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON p.product_key = f.product_key
	GROUP BY category
)

SELECT 
	category,
	total_sales,
	SUM(total_sales) OVER () overall_sales,
	CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ())* 100, 2), '%') AS percentage_of_total
FROM category_Sales
ORDER BY total_sales DESC
