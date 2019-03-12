-- Checking estimated rows (from the plan) versus actual rows
SELECT  t.[text],
        p.[query_plan],
        s.[last_execution_time],
        p.[query_plan].value('(//@EstimateRows)[1]', 'varchar(128)') AS [estimated_rows],
        s.[last_rows]
FROM    sys.[dm_exec_query_stats] AS [s]
CROSS APPLY sys.[dm_exec_sql_text](sql_handle) AS [t]
CROSS APPLY sys.[dm_exec_query_plan](plan_handle) AS [p]
WHERE   DATEDIFF(mi, s.[last_execution_time], GETDATE()) < 10
AND t.[dbid] = DB_ID()
GO
