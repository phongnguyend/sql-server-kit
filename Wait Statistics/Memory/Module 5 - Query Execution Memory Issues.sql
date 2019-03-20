-- Waiting tasks?
SELECT  [session_id],
        [wait_duration_ms],
        [wait_type],
        [resource_description]
FROM    sys.[dm_os_waiting_tasks];
GO

-- Memory Grants information
SELECT  [session_id],
        [request_id],
        [scheduler_id],
        [dop],
        [request_time],
        [grant_time],
        [requested_memory_kb],
        [granted_memory_kb],
        [required_memory_kb],
        [used_memory_kb],
        [max_used_memory_kb],
        [query_cost],
        [timeout_sec],
        [resource_semaphore_id],
        [queue_id],
        [wait_order],
        [is_next_candidate],
        [wait_time_ms],
        [plan_handle],
        [sql_handle],
        [group_id],
        [pool_id],
        [is_small],
        [ideal_memory_kb]
FROM    sys.[dm_exec_query_memory_grants];
GO

-- What does the plan look like?
SELECT  query_plan
FROM    sys.dm_exec_query_plan(0x0600050029E9AE037008B9FF0100000001000000000000000000000000000000000000000000000000000000);
GO

-- The query?
SELECT  text
FROM    sys.dm_exec_sql_text(0x0200000029E9AE031C52F60A5B44CFF02F982C147520DD180000000000000000000000000000000000000000);
GO


-- Semaphores
SELECT  [resource_semaphore_id],
        [target_memory_kb],
        [max_target_memory_kb],
        [total_memory_kb],
        [available_memory_kb],
        [granted_memory_kb],
        [used_memory_kb],
        [grantee_count],
        [waiter_count],
        [timeout_error_count],
        [forced_grant_count],
        [pool_id]
FROM    sys.dm_exec_query_resource_semaphores;
GO