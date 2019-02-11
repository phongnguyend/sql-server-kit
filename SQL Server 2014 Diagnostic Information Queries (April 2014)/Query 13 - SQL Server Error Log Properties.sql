-- Query 13 - SQL Server Error Log Properties

-- Shows you where the SQL Server failover cluster diagnostic log is located and how it is configured  (Query 13) (SQL Server Error Log)
SELECT is_enabled, [path], max_size, max_files
FROM sys.dm_os_server_diagnostics_log_configurations WITH (NOLOCK) OPTION (RECOMPILE);

-- Knowing this information is important for troubleshooting purposes
-- Also shows you the location of other error and diagnostic log files