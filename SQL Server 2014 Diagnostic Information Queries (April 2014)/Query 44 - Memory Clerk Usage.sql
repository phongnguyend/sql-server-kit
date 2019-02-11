-- Memory Clerk Usage for instance  (Query 44) (Memory Clerk Usage)
-- Look for high value for CACHESTORE_SQLCP (Ad-hoc query plans)
SELECT TOP(10) [type] AS [Memory Clerk Type], 
       SUM(pages_kb)/1024 AS [Memory Usage (MB)] 
FROM sys.dm_os_memory_clerks WITH (NOLOCK)
GROUP BY [type]  
ORDER BY SUM(pages_kb) DESC OPTION (RECOMPILE);

-- MEMORYCLERK_SQLBUFFERPOOL was new for SQL Server 2012. It should be your highest consumer of memory


-- CACHESTORE_SQLCP  SQL Plans         
-- These are cached SQL statements or batches that aren't in stored procedures, functions and triggers
-- Watch out for high values for CACHESTORE_SQLCP

-- CACHESTORE_OBJCP  Object Plans      
-- These are compiled plans for stored procedures, functions and triggers