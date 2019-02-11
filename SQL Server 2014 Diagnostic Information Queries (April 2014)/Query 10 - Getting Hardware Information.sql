-- Query 10 - Getting Hardware Information


-- Hardware information from SQL Server 2014  (Query 10) (Hardware Info)
-- (Cannot distinguish between HT and multi-core)
SELECT cpu_count AS [Logical CPU Count], scheduler_count, hyperthread_ratio AS [Hyperthread Ratio],
cpu_count/hyperthread_ratio AS [Physical CPU Count], 
physical_memory_kb/1024 AS [Physical Memory (MB)], committed_kb/1024 AS [Committed Memory (MB)],
committed_target_kb/1024 AS [Committed Target Memory (MB)],
max_workers_count AS [Max Workers Count], affinity_type_desc AS [Affinity Type], 
sqlserver_start_time AS [SQL Server Start Time], virtual_machine_type_desc AS [Virtual Machine Type]
FROM sys.dm_os_sys_info WITH (NOLOCK) OPTION (RECOMPILE);

-- Gives you some good basic hardware information about your database server
-- Note: virtual_machine_type_desc of HYPERVISOR does not automatically mean you are running SQL Server inside of a VM
-- It merely indicates that you have a hypervisor running on your host