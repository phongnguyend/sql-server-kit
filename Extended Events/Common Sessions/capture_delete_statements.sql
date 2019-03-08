CREATE EVENT SESSION [capture_delete_statements] ON SERVER ADD EVENT sqlserver.sp_statement_completed (
	SET collect_object_name = (1)
	,collect_statement = (1) ACTION(sqlserver.client_app_name, sqlserver.client_hostname, sqlserver.database_name, sqlserver.nt_username, sqlserver.server_instance_name, sqlserver.server_principal_name, sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text, sqlserver.username) WHERE (
		[sqlserver].[database_name] = N'DBName'
		AND [sqlserver].[client_app_name] != N'.Net SqlClient Data Provider'
		AND [statement] LIKE N'%DELETE%'
		)
	)
	,ADD EVENT sqlserver.sql_statement_completed (
	SET collect_statement = (1) ACTION(sqlserver.client_app_name, sqlserver.client_hostname, sqlserver.database_name, sqlserver.nt_username, sqlserver.server_instance_name, sqlserver.server_principal_name, sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text, sqlserver.username) WHERE (
		[package0].[equal_boolean]([sqlserver].[is_system], (0))
		AND [sqlserver].[database_name] = N'DBName'
		AND [sqlserver].[client_app_name] != N'.Net SqlClient Data Provider'
		AND [sqlserver].[sql_text] LIKE N'%DELETE%'
		)
	) ADD TARGET package0.event_file (
	SET filename = N'capture_delete_statements'
	,max_file_size = (10)
	)
	WITH (
			MAX_MEMORY = 4096 KB
			,EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS
			,MAX_DISPATCH_LATENCY = 30 SECONDS
			,MAX_EVENT_SIZE = 0 KB
			,MEMORY_PARTITION_MODE = NONE
			,TRACK_CAUSALITY = OFF
			,STARTUP_STATE = ON
			)
GO