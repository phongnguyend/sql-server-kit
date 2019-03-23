SELECT TOP (100)
	 DB_NAME(qt.dbid) AS [DB Name]
	,OBJECT_NAME(qt.objectid, qt.dbid) AS [ProcedureName]
	,SUBSTRING(qt.TEXT, qs.statement_start_offset / 2 + 1, (
			CASE 
				WHEN qs.statement_end_offset = - 1
					THEN LEN(CONVERT(NVARCHAR(MAX), qt.TEXT)) * 2
				ELSE qs.statement_end_offset
				END - qs.statement_start_offset
			) / 2) AS query_text
	,qs.execution_count
	,qs.creation_time
	,qs.last_execution_time
	,qs.total_rows
	,qs.min_rows
	,qs.max_rows
	,qs.last_rows
	-- Elapsed Time
	,qs.min_elapsed_time / cast(1000000 AS FLOAT) AS [min_elapsed_time_seconds]
	,qs.max_elapsed_time / cast(1000000 AS FLOAT) AS [max_elapsed_time_seconds]
	,qs.last_elapsed_time / cast(1000000 AS FLOAT) AS [last_elapsed_time_seconds]
	,qs.total_elapsed_time / qs.execution_count / cast(1000000 AS FLOAT) AS [avg_elapsed_time_seconds]
	-- Worker Time
	,qs.min_worker_time / cast(1000000 AS FLOAT) AS [min_worker_time_seconds]
	,qs.max_worker_time / cast(1000000 AS FLOAT) AS [max_worker_time_seconds]
	,qs.last_worker_time / cast(1000000 AS FLOAT) AS [last_worker_time_seconds]
	,qs.total_worker_time / qs.execution_count / cast(1000000 AS FLOAT) AS [avg_worker_time_seconds]
	-- Logical Reads
	,qs.min_logical_reads
	,qs.max_logical_reads
	,qs.last_logical_reads
	,qs.total_logical_reads
	,qs.total_logical_reads / qs.execution_count as [avg_logical_reads]
	-- Physical Reads
	,qs.min_physical_reads
	,qs.max_physical_reads
	,qs.last_physical_reads
	,qs.total_physical_reads
	,qs.total_physical_reads / qs.execution_count as [avg_physical_reads]
	-- Logical Writes
	,qs.min_logical_writes
	,qs.max_logical_writes
	,qs.last_logical_writes
	,qs.total_logical_writes
	,qs.total_logical_writes / qs.execution_count as [avg_logical_writes]
	-- AVG IO
	,(qs.total_logical_reads + qs.total_logical_writes) / qs.execution_count AS [Avg IO]
	,qs.plan_handle
FROM sys.dm_exec_query_stats AS qs WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
WHERE qt.dbid = DB_ID()
ORDER BY qs.execution_count DESC
OPTION (RECOMPILE);

		
/*
select * from  sys.dm_exec_query_plan (0x05000900784D9104105771230100000001000000000000000000000000000000000000000000000000000000)
*/


/*

Trouble Shooting Scenarios:

 - WHERE: AND (qs.max_elapsed_time > 28000000) -- identify potential timeout statements.
 - WHERE: AND (qs.total_worker_time > qs.total_elapsed_time) -- identify potential parallel statements

 - ORDER BY qs.execution_count DESC -- statements are called the most often
 - ORDER BY [avg_elapsed_time_seconds] DESC -- long-running statements
 - ORDER BY [avg_worker_time_seconds] DESC -- the most expensive statements from a CPU perspective
 - ORDER BY [avg_logical_reads] DESC -- the most expensive statements from a memory perspective 
 - ORDER BY [avg_physical_reads] DESC -- the most expensive statements from a read I/O perspective
 - ORDER BY [avg_logical_writes] DESC -- the most expensive statements from a write I/O perspective
 - ORDER BY [Avg IO] DESC -- the most expensive statements from I/O perspective
 
*/
