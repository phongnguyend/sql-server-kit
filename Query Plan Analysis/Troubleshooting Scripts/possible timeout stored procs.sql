SELECT TOP (25) p.NAME AS [SP Name]
	,qs.max_elapsed_time / cast(1000000 AS FLOAT) AS max_elapsed_time_seconds
	,qs.total_elapsed_time / qs.execution_count / cast(1000000 AS FLOAT) AS [avg_elapsed_time_seconds]
	,qs.total_elapsed_time / cast(1000000 AS FLOAT) AS [total_elapsed_time_seconds]
	,qs.execution_count
	,qs.total_worker_time / qs.execution_count AS [AvgWorkerTime]
	,qs.total_worker_time AS [TotalWorkerTime]
	,qs.cached_time
	,qs.min_elapsed_time / cast(1000000 AS FLOAT) AS min_elapsed_time_seconds
	,qs.max_elapsed_time / cast(1000000 AS FLOAT) AS max_elapsed_time_seconds
	,qs.last_elapsed_time / cast(1000000 AS FLOAT) AS last_elapsed_time_seconds
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK) ON p.[object_id] = qs.[object_id]
WHERE qs.database_id = DB_ID()
AND qs.max_elapsed_time > 28000000
ORDER BY [avg_elapsed_time_seconds] DESC
OPTION (RECOMPILE);
