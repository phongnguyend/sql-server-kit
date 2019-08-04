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