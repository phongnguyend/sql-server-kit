CREATE EVENT SESSION [CaptureUpdateStatements]
ON SERVER ADD EVENT sqlserver.sql_statement_completed (
	SET collect_statement = (1) 
	ACTION
	(
	 sqlserver.client_app_name,
	 sqlserver.client_hostname,
	 sqlserver.database_name, 
	 sqlserver.nt_username, 
	 sqlserver.server_instance_name, 
	 sqlserver.server_principal_name, 
	 sqlserver.session_id, 
	 sqlserver.session_nt_username, 
	 sqlserver.sql_text, 
	 sqlserver.username
	 ) 
	WHERE 
	(
		[package0].[equal_boolean]([sqlserver].[is_system], (0))
		AND [sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name], N'FiscalRepsV2_UAT')
		AND [sqlserver].[like_i_sql_unicode_string]([sqlserver].[sql_text], N'%UPDATE%SET%')
		AND [sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[client_app_name], N'.Net SqlClient Data Provider')
	)
	) 
	ADD TARGET package0.event_file (SET filename = N'CaptureUpdateStatements', max_file_size = (10))
	WITH (
			MAX_MEMORY = 4096 KB
			,EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS
			,MAX_DISPATCH_LATENCY = 30 SECONDS
			,MAX_EVENT_SIZE = 0 KB
			,MEMORY_PARTITION_MODE = NONE
			,TRACK_CAUSALITY = OFF
			,STARTUP_STATE = OFF
			)
GO
