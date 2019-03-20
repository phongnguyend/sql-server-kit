-- How are the databases configured?
SELECT  [databases].[name],
        [databases].[database_id],
        [databases].[snapshot_isolation_state],
        [databases].[snapshot_isolation_state_desc],
        [databases].[is_read_committed_snapshot_on]
FROM    [sys].[databases];
GO

-- What does the tempdb allocation look like?
USE tempdb;
GO

SELECT  SUM([dm_db_file_space_usage].[user_object_reserved_page_count]) * 8 AS [user_object_reserved_kb],
        SUM([dm_db_file_space_usage].[internal_object_reserved_page_count]) * 8 AS [internal_object_reserved_kb],
        SUM([dm_db_file_space_usage].[version_store_reserved_page_count]) * 8 AS [version_store_kb]
FROM    [sys].[dm_db_file_space_usage];
GO

-- Long transactions?
SELECT  [dm_tran_active_snapshot_database_transactions].[transaction_id],
        [dm_tran_active_snapshot_database_transactions].[transaction_sequence_num],
        [dm_tran_active_snapshot_database_transactions].[commit_sequence_num],
        [dm_tran_active_snapshot_database_transactions].[session_id],
        [dm_tran_active_snapshot_database_transactions].[is_snapshot],
        [dm_tran_active_snapshot_database_transactions].[first_snapshot_sequence_num],
        [dm_tran_active_snapshot_database_transactions].[max_version_chain_traversed],
        [dm_tran_active_snapshot_database_transactions].[average_version_chain_traversed],
        [dm_tran_active_snapshot_database_transactions].[elapsed_time_seconds]
FROM    [sys].[dm_tran_active_snapshot_database_transactions]
ORDER BY [dm_tran_active_snapshot_database_transactions].[elapsed_time_seconds] DESC;
GO

-- What query?  What plan?
SELECT  [t].[text],
        [p].[query_plan]
FROM    [sys].[dm_exec_sessions] AS s
LEFT OUTER JOIN [sys].[dm_exec_requests] AS r
        ON [s].[session_id] = [r].[session_id]
OUTER APPLY [sys].[dm_exec_sql_text]([r].[sql_handle]) AS t
OUTER APPLY [sys].[dm_exec_query_plan]([r].[plan_handle]) AS p
WHERE   [s].[session_id] = 75;
GO

-- Can you optimize the workloads?
-- Is the snapshot isolation providing concurrency benefits?
-- If so, what about the I/O path for tempdb?
