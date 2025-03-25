/*==========================================================
 Measures Exploration:
============================================================
- Calculate the key metric of the business (Big Numbers)
- Highest Level of Aggregation | Lowest Level of Details
============================================================
*/
-- Find the Total Sales
SELECT SUM(sales_amount) AS total_sale FROM gold.fact_sales

-- Find the many itens are sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales

-- Find the average selling price
SELECT AVG(price) AS average_price FROM gold.fact_sales

-- Find the Total number of Orders
SELECT COUNT(order_number) AS total_order FROM gold.fact_sales
SELECT COUNT(DISTINCT order_number) AS total_order FROM gold.fact_sales

-- Find the Total number of product
SELECT COUNT(product_key) AS total_product FROM gold.dim_products

-- Find the Total number of customers
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.dim_customers

-- Find the Total number of customers that placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales

-- Gererate a Report that shows all key metrics of the business

SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' AS measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products' AS measure_name, COUNT(DISTINCT product_key) AS measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Nr. Customers' AS measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM gold.dim_customers
