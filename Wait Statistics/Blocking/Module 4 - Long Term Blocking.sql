-- Active blocking issues?
SELECT  [session_id],
        [wait_duration_ms],
        [wait_type],
        [blocking_session_id]
FROM    sys.[dm_os_waiting_tasks]
WHERE   [wait_type] LIKE N'LCK%';
GO

-- Isolation level of session?
SELECT  [session_id],
        [transaction_isolation_level]
FROM    sys.[dm_exec_sessions]
WHERE   [session_id] = 55;
GO

-- Blocked process threshold
EXEC sp_configure 'blocked process threshold (s)', 10;
RECONFIGURE
GO

-- Blocked process report


