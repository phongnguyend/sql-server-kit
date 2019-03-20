-- Identifying potential parallel plans
SELECT  [qs].[total_worker_time],
        [qs].[total_elapsed_time],
        SUBSTRING([qt].[text], [qs].[statement_start_offset] / 2,
                  (CASE WHEN [qs].[statement_end_offset] = -1
                        THEN LEN(CONVERT(NVARCHAR(MAX), [qt].[text])) * 2
                        ELSE [qs].[statement_end_offset]
                   END - [qs].[statement_start_offset]) / 2) AS query_text,
        [qs].[execution_count],
        [qs].[sql_handle],
        [qs].[plan_handle]
FROM    [sys].[dm_exec_query_stats] qs
CROSS APPLY [sys].[dm_exec_sql_text]([qs].[sql_handle]) AS qt
WHERE   [qs].[total_worker_time] > [qs].[total_elapsed_time]
ORDER BY [qs].[total_worker_time] DESC;

-- Another option for identification
SELECT  [r].[session_id],
        [r].[plan_handle],
        MAX(ISNULL([t].[exec_context_id], 0)) AS workers
FROM    [sys].[dm_exec_requests] r
INNER JOIN [sys].[dm_os_tasks] t
        ON [r].[session_id] = [t].[session_id]
INNER JOIN [sys].[dm_exec_sessions] s
        ON [r].[session_id] = [s].[session_id]
WHERE   [s].[is_user_process] = 0x1
GROUP BY [r].[session_id],
        [r].[plan_handle]
HAVING  MAX(ISNULL([t].[exec_context_id], 0)) > 0;

-- We can check the plan now
SELECT  [query_plan]
FROM    sys.dm_exec_query_plan	
	/** PLUG IN NEW plan handle **/(0x0600050036AEA22B007B79EC0100000001000000000000000000000000000000000000000000000000000000)