SELECT DB_NAME(req.database_id) AS db_name
	,sqltext.TEXT
	,req.session_id
	,req.STATUS
	,req.command
	,req.start_time
	,req.cpu_time
	,req.total_elapsed_time
	,queryplan.query_plan
	,c.client_net_address
	,s.login_name
	,s.login_time
	,s.program_name
	,s.host_name
	,s.host_process_id
	,s.client_interface_name
	,s.client_version
	--,req.*
	--,c.*
	--,s.*
FROM sys.dm_exec_requests req
JOIN sys.dm_exec_connections c ON req.connection_id = c.connection_id
JOIN sys.dm_exec_sessions s ON req.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS sqltext
CROSS APPLY sys.dm_exec_query_plan(req.plan_handle) AS queryplan
