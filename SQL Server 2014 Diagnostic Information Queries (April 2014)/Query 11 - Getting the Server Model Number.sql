-- Query 11 - Getting the Server Model Number

-- Get System Manufacturer and model number from  (Query 11) (System Manufacturer)
-- SQL Server Error log. This query might take a few seconds 
-- if you have not recycled your error log recently
EXEC xp_readerrorlog 0, 1, "Manufacturer"; 

-- This can help you determine the capabilities
-- and capacities of your database server