SELECT TOP (100)
	SUBSTRING(qt.TEXT, qs.statement_start_offset / 2 + 1, (
			CASE 
				WHEN qs.statement_end_offset = - 1
					THEN LEN(CONVERT(NVARCHAR(MAX), qt.TEXT)) * 2
				ELSE qs.statement_end_offset
				END - qs.statement_start_offset
			) / 2) AS query_text
	,qs.execution_count
	,qs.total_rows
	,qs.min_rows
	,qs.max_rows
	,qs.last_rows
	,qs.min_elapsed_time
	,qs.max_elapsed_time
	,qs.last_elapsed_time
	,qs.total_elapsed_time / qs.execution_count AS [avg_elapsed_time]
	,qs.min_elapsed_time / cast(1000000 AS FLOAT) AS [min_elapsed_time_seconds]
	,qs.max_elapsed_time / cast(1000000 AS FLOAT) AS [max_elapsed_time_seconds]
	,qs.last_elapsed_time / cast(1000000 AS FLOAT) AS [last_elapsed_time_seconds]
	,qs.total_elapsed_time / qs.execution_count / cast(1000000 AS FLOAT) AS [avg_elapsed_time_seconds]
	,total_worker_time
	,total_logical_reads
	,qs.plan_handle
	--,qp.query_plan
FROM sys.dm_exec_query_stats AS qs WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
--CROSS APPLY sys.dm_exec_query_plan (qs.plan_handle) AS qp
WHERE qt.dbid = DB_ID()
ORDER BY qs.execution_count DESC
OPTION (RECOMPILE);
		
		
/*
		
select * from  sys.dm_exec_query_plan (0x05000900784D9104105771230100000001000000000000000000000000000000000000000000000000000000)

*/

