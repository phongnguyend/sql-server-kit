[SQL Server: Performance Troubleshooting Using Wait Statistics | Pluralsight](https://www.pluralsight.com/courses/sqlserver-waits)

## Thread Scheduling
### SQL Server performs its own thread scheduling 
- Called non-preemptive scheduling 
- More efficient (for SQL Server) than relying on Windows scheduling 
- Performed by the SQLOS layer of the Storage Engine 
 
### Each processor core (whether logical or physical) has a scheduler 
- A scheduler is responsible for managing the execution of work by threads 
- Schedulers exist for user threads and for internal operations 
- Use the sys.dm_os_schedulers DMV to view schedulers 
 
### When SQL Server has to call out to the OS, it must switch the calling thread to preemptive mode so the OS can interrupt it if necessary 
- More information on this in Module 5

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

### Examining Waiting Tasks:
[*open link*](ExaminingWaitingTasks.sql)

### Examining Waits:
[*open link*](ExaminingWaits.sql)

### Examining Latches:
[*open link*](ExaminingLatches.sql)

### Examining Spinlocks:
[*open link*](ExaminingSpinlocks.sql)
