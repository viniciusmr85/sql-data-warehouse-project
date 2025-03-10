/*
==================================================================================
Create Database and Schemas
==================================================================================
Scrip Purpose:
  This scrip creates a new database named 'DataWarehouse' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the scrip sets up three schemas
  within the database: 'bronze', 'silver', and 'gold'.
WARNING:
  Running this scrip will drop the entire 'DataWareHouse' database if exists.
  All data in the database will be permanently deleted. Proceed wit caution
  and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWareHouse' database  
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

--Create the DataWarehouse;
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
