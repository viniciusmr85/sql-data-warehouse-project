/*==========================================================
-- Database Exploration
	- Basic Queries
	- Checking All the objects and columns in the Database
============================================================*/
-- Explore All Objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore All Columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'
