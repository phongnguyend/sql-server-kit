-- Query 8 - SQL Server Services Information 

-- SQL Server Services information (SQL Server 2014) (Query 8) (SQL Server Services Info)
SELECT servicename, process_id, startup_type_desc, status_desc, 
last_startup_time, service_account, is_clustered, cluster_nodename, [filename]
FROM sys.dm_server_services WITH (NOLOCK) OPTION (RECOMPILE);

-- Tells you the account being used for the SQL Server Service and the SQL Agent Service
-- Shows the processid, when they were last started, and their current status
-- Shows whether you are running on a failover cluster instance