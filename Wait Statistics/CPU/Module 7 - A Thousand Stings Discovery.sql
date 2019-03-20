-- Clear cache
DBCC FREEPROCCACHE;
GO

-- **
-- Execute workload scripts and then continue
-- "Module 7 - Polute.cmd"
-- "Module 7 - A Thousand Stings.cmd"
-- **

-- Top three queries by total worker time (DESC)
SELECT TOP 3
        [qs].[last_worker_time],
        [qs].[max_worker_time],
        [qs].[total_worker_time],
        [qs].[execution_count],
        stmt_start = [qs].[statement_start_offset],
        stmt_end = [qs].[statement_end_offset],
        [qt].[dbid],
        [qt].[objectid],
        SUBSTRING([qt].[text], [qs].[statement_start_offset] / 2,
                  (CASE WHEN [qs].[statement_end_offset] = -1
                        THEN LEN(CONVERT(NVARCHAR(MAX), [qt].[text])) * 2
                        ELSE [qs].[statement_end_offset]
                   END - [qs].[statement_start_offset]) / 2) AS statement
FROM    [sys].[dm_exec_query_stats] qs
CROSS APPLY [sys].[dm_exec_sql_text]([qs].[sql_handle]) AS qt
ORDER BY [qs].[total_worker_time] DESC;

-- But what are we missing?
SELECT  [qs].[last_worker_time],
        [qs].[max_worker_time],
        [qs].[total_worker_time],
        [qs].[execution_count],
        stmt_start = [qs].[statement_start_offset],
        stmt_end = [qs].[statement_end_offset],
        [qt].[dbid],
        [qt].[objectid],
        SUBSTRING([qt].[text], [qs].[statement_start_offset] / 2,
                  (CASE WHEN [qs].[statement_end_offset] = -1
                        THEN LEN(CONVERT(NVARCHAR(MAX), [qt].[text])) * 2
                        ELSE [qs].[statement_end_offset]
                   END - [qs].[statement_start_offset]) / 2) AS statement
FROM    [sys].[dm_exec_query_stats] qs
CROSS APPLY [sys].[dm_exec_sql_text]([qs].[sql_handle]) AS qt
ORDER BY [qs].[total_worker_time] DESC;

-- Now lets try it based on aggregated time and
-- look for several executes
SELECT TOP 5
        [qs].[query_hash],
        SUM([qs].[total_worker_time]) total_worker_time,
        SUM([qs].[execution_count]) total_execution_count
FROM    [sys].[dm_exec_query_stats] qs
CROSS APPLY [sys].[dm_exec_sql_text]([qs].[sql_handle]) AS qt
GROUP BY [qs].[query_hash]
HAVING  SUM([qs].[execution_count]) > 100
ORDER BY SUM([qs].[total_worker_time]) DESC;

-- Plug in query hash for an example
SELECT  SUBSTRING([qt].[text], [qs].[statement_start_offset] / 2,
                  (CASE WHEN [qs].[statement_end_offset] = -1
                        THEN LEN(CONVERT(NVARCHAR(MAX), [qt].[text])) * 2
                        ELSE [qs].[statement_end_offset]
                   END - [qs].[statement_start_offset]) / 2) AS statement,
        [qs].[total_worker_time],
        [qs].[execution_count],
        [qs].[query_hash],
        [qs].[query_plan_hash]
FROM    [sys].[dm_exec_query_stats] qs
CROSS APPLY [sys].[dm_exec_sql_text]([qs].[sql_handle]) AS qt
WHERE   [qs].[query_hash] = 0x4B8B513764CB9F4C;

