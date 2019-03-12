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



-- https://www.sqlskills.com/blogs/kimberly/plan-cache-and-optimizing-for-adhoc-workloads/
SELECT objtype AS [CacheType],
    COUNT_BIG(*) AS [Total Plans],
    SUM(CAST(size_in_bytes AS DECIMAL(18, 2))) / 1024 / 1024 AS [Total MBs],
    AVG(usecounts) AS [Avg Use Count],
    SUM(CAST((CASE WHEN usecounts = 1 THEN size_in_bytes
        ELSE 0
        END) AS DECIMAL(18, 2))) / 1024 / 1024 AS [Total MBs – USE Count 1],
    SUM(CASE WHEN usecounts = 1 THEN 1
        ELSE 0
        END) AS [Total Plans – USE Count 1]
FROM sys.dm_exec_cached_plans
GROUP BY objtype
ORDER BY [Total MBs – USE Count 1] DESC
GO

-- https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option
SELECT objtype, cacheobjtype, 
  AVG(usecounts) AS Avg_UseCount, 
  SUM(refcounts) AS AllRefObjects, 
  SUM(CAST(size_in_bytes AS bigint))/1024/1024 AS Size_MB
FROM sys.dm_exec_cached_plans
WHERE objtype = 'Adhoc' AND usecounts = 1
GROUP BY objtype, cacheobjtype;

-- https://blog.sqlauthority.com/2017/10/20/sql-server-turn-optimize-ad-hoc-workloads/
SELECT AdHoc_Plan_MB, Total_Cache_MB,
        AdHoc_Plan_MB*100.0 / Total_Cache_MB AS 'AdHoc %'
FROM (
SELECT SUM(CASE
            WHEN objtype = 'adhoc'
            THEN size_in_bytes
            ELSE 0 END) / 1048576.0 AdHoc_Plan_MB,
        SUM(size_in_bytes) / 1048576.0 Total_Cache_MB
FROM sys.dm_exec_cached_plans) T

           
-- check the 'optimize for ad hoc workloads' flag
select * from sys.configurations
where name = 'optimize for ad hoc workloads'

EXEC SP_CONFIGURE 'Show Advanced Options', 1
GO
RECONFIGURE
GO

EXEC SP_CONFIGURE 'optimize for ad hoc workloads', 1
GO
RECONFIGURE
GO

