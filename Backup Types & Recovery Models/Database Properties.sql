-- Recovery model, log reuse wait description, log file size, log usage size  (Query 27) (Database Properties)
-- and compatibility level for all databases on instance
SELECT db.[name] AS [Database Name], db.recovery_model_desc AS [Recovery Model], db.state_desc, 
db.log_reuse_wait_desc AS [Log Reuse Wait Description], 
CONVERT(DECIMAL(18,2), ls.cntr_value/1024.0) AS [Log Size (MB)], CONVERT(DECIMAL(18,2), lu.cntr_value/1024.0) AS [Log Used (MB)],
CAST(CAST(lu.cntr_value AS FLOAT) / CAST(ls.cntr_value AS FLOAT)AS DECIMAL(18,2)) * 100 AS [Log Used %], 
db.[compatibility_level] AS [DB Compatibility Level], db.page_verify_option_desc AS [Page Verify Option], 
db.is_auto_create_stats_on, db.is_auto_update_stats_on, db.is_auto_update_stats_async_on, db.is_parameterization_forced, 
db.snapshot_isolation_state_desc, db.is_read_committed_snapshot_on, db.is_auto_close_on, db.is_auto_shrink_on, 
db.target_recovery_time_in_seconds, db.is_cdc_enabled, db.is_memory_optimized_elevate_to_snapshot_on, db.delayed_durability_desc, 
db.is_auto_create_stats_incremental_on      
FROM sys.databases AS db WITH (NOLOCK)
INNER JOIN sys.dm_os_performance_counters AS lu WITH (NOLOCK)
ON db.name = lu.instance_name
INNER JOIN sys.dm_os_performance_counters AS ls WITH (NOLOCK)
ON db.name = ls.instance_name
WHERE lu.counter_name LIKE N'Log File(s) Used Size (KB)%' 
AND ls.counter_name LIKE N'Log File(s) Size (KB)%'
AND ls.cntr_value > 0 
ORDER BY db.[name] OPTION (RECOMPILE);

-- Things to look at:
-- How many databases are on the instance?
-- What recovery models are they using?
-- What is the log reuse wait description?
-- How full are the transaction logs ?
-- What compatibility level are the databases on? 
-- What is the Page Verify Option? (should be CHECKSUM)
-- Is Auto Update Statistics Asynchronously enabled?
-- Make sure auto_shrink and auto_close are not enabled!