-- Wait stats related to I/O? 
-- Be sure to compare against total wait time accumulation
-- Be sure to see Paul Randal's 
-- "SQL Server- Performance Troubleshooting Using Wait Statistics"
SELECT  [wait_type],
        [waiting_tasks_count],
        [wait_time_ms],
        [max_wait_time_ms],
        [signal_wait_time_ms]
FROM    sys.[dm_os_wait_stats]
ORDER BY [wait_time_ms] DESC;
GO


-- Active I/O issues?
SELECT  [session_id],
        [wait_duration_ms],
        [wait_type],
        [resource_description]
FROM    sys.[dm_os_waiting_tasks]
WHERE   [wait_type] LIKE N'PAGEIOLATCH%' OR
        [wait_type] IN (N'IO_COMPLETION', N'WRITELOG', N'ASYNC_IO_COMPLETION');
GO

-- Triage based on sys.dm_io_virtual_file_stats
SELECT  [database_id],
        DB_NAME([database_id]) AS [database_nm],
        [file_id],
        [num_of_reads],
        [num_of_bytes_read],
        [io_stall_read_ms],
        [num_of_writes],
        [num_of_bytes_written],
        [io_stall_write_ms],
        [io_stall],
        [size_on_disk_bytes]
FROM    sys.[dm_io_virtual_file_stats](NULL, NULL)
ORDER BY [io_stall] DESC;
GO

-- Top I/O queries
-- Memory pressure? These stats may be evicted
SELECT  q.[query_hash],
        SUBSTRING(t.text, (q.[statement_start_offset] / 2) + 1,
                  ((CASE q.[statement_end_offset]
                      WHEN -1 THEN DATALENGTH(t.[text])
                      ELSE q.[statement_end_offset]
                    END - q.[statement_start_offset]) / 2) + 1),
        SUM(q.[total_physical_reads]) AS [total_physical_reads]
FROM    sys.[dm_exec_query_stats] AS q
CROSS APPLY sys.[dm_exec_sql_text](q.sql_handle) AS t
GROUP BY q.[query_hash],
        SUBSTRING(t.text, (q.[statement_start_offset] / 2) + 1,
                  ((CASE q.[statement_end_offset]
                      WHEN -1 THEN DATALENGTH(t.[text])
                      ELSE q.[statement_end_offset]
                    END - q.[statement_start_offset]) / 2) + 1)
ORDER BY SUM(q.[total_physical_reads]) DESC;
GO

-- What is the query execution plan of the top I/O query?
SELECT  p.[query_plan]
FROM    sys.[dm_exec_query_stats] AS q
CROSS APPLY sys.[dm_exec_query_plan](q.[plan_handle]) AS p
WHERE   q.[query_hash] = 0xEB3F21FCCE406BBE
GO


