-- Find single-use, ad-hoc and prepared queries that are bloating the plan cache  (Query 44) (Ad hoc Queries)
SELECT TOP(100) [text] AS [QueryText], cp.cacheobjtype, cp.objtype, cp.size_in_bytes
, qs.creation_time, qs.last_execution_time, qs.execution_count 
FROM sys.dm_exec_cached_plans AS cp WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(plan_handle)
LEFT JOIN sys.dm_exec_query_stats AS qs on cp.plan_handle = qs.plan_handle
WHERE cp.cacheobjtype = N'Compiled Plan' 
AND cp.objtype IN (N'Adhoc', N'Prepared') 
AND cp.usecounts = 1
ORDER BY cp.size_in_bytes DESC OPTION (RECOMPILE);

-- Gives you the text, type and size of single-use ad-hoc and prepared queries that waste space in the plan cache
-- Enabling 'optimize for ad hoc workloads' for the instance can help (SQL Server 2008 and above only)
-- Running DBCC FREESYSTEMCACHE ('SQL Plans') periodically may be required to better control this.
-- Enabling forced parameterization for the database can help, but test first!
