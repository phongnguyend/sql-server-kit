## Troubleshooting Timeout Issue with XEvent

[SQL SERVER – Timeout expired. The timeout period elapsed prior to completion of the operation](https://blog.sqlauthority.com/2016/01/26/sql-server-timeout-expired-the-timeout-period-elapsed-prior-to-completion-of-the-operation-or-the-server-is-not-responding/)

[Connection timeout and Command timeout in SQL Server](https://blogs.msdn.microsoft.com/docast/2018/10/11/connection-timeout-and-command-timeout-in-sql-server/)

[Troubleshooting Query timeouts in SQL Server](https://blogs.msdn.microsoft.com/docast/2018/10/12/troubleshooting-query-timeouts-in-sql-server/)

[How to detect query timeout errors with Extended Events](http://blog.sqlgrease.com/how-to-detect-query-timeout-errors-with-extended-events/)

[How To Capture Query Timeouts With Extended Events](https://dbtut.com/index.php/2019/01/23/how-to-capture-query-timeouts-with-extended-events/)

[Attention Event Class](https://docs.microsoft.com/en-us/sql/relational-databases/event-classes/attention-event-class?view=sql-server-2017)

```sql
CREATE EVENT SESSION [execution_timeout]
ON SERVER
ADD EVENT sqlserver.attention (
	ACTION (
		sqlos.task_time, 
		sqlserver.client_app_name, 
		sqlserver.client_hostname, 
		sqlserver.database_id, 
		sqlserver.database_name, 
		sqlserver.session_id, 
		sqlserver.sql_text, 
		sqlserver.username
	) 
	WHERE (
		[package0].[equal_boolean]([sqlserver].[is_system], (0))
		AND [sqlserver].[client_app_name] = N'.Net SqlClient Data Provider'
		AND [sqlserver].[database_name] = N'DBName'
	)
)
ADD TARGET package0.event_file (
		SET filename = N'execution_timeout.xel',
		max_file_size = (5), 
		max_rollover_files = (2)
	)
WITH (
	MAX_MEMORY = 4096 KB,
	EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
	MAX_DISPATCH_LATENCY = 30 SECONDS,
	MAX_EVENT_SIZE = 0 KB,
	MEMORY_PARTITION_MODE = NONE,
	TRACK_CAUSALITY = OFF,
	STARTUP_STATE = ON
)
GO
```
