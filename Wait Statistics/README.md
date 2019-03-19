[SQL Server: Performance Troubleshooting Using Wait Statistics | Pluralsight](https://www.pluralsight.com/courses/sqlserver-waits)

### Examining Schedulers:
```sql
SELECT * FROM sys.dm_os_schedulers;
GO
```

### Examining Tasks:
```sql
SELECT
	 [ot].[scheduler_id]
	,[task_state]
	,COUNT(*) AS [task_count]
FROM sys.dm_os_tasks AS [ot]
INNER JOIN sys.dm_exec_requests AS [er] ON [ot].[session_id] = [er].[session_id]
INNER JOIN sys.dm_exec_sessions AS [es] ON [er].[session_id] = [es].[session_id]
WHERE [es].[is_user_process] = 1
GROUP BY [ot].[scheduler_id], [task_state]
ORDER BY [task_state], [ot].[scheduler_id];
GO
```
