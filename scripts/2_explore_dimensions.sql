/*===============================================================
Explore Dimensions:
=================================================================
Identifying the unique values (or categories) in each dimension
	- Countries
Recognizing how data might be grouped or segmented,
which is useful for later analysis.
=================================================================*/
-- Explore All Contries our customers come from
SELECT DISTINCT
	country
FROM gold.dim_customers
 
 -- Explore All Categories "The major Divisions"
 SELECT DISTINCT 
	category, subcategory, product_name
FROM gold.dim_products
ORDER BY 1,2,3
