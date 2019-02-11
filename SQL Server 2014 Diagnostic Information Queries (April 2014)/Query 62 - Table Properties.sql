-- Get some key table properties (Query 60) (Table Properties)
SELECT [name], create_date, lock_on_bulk_load, is_replicated, has_replication_filter, 
       is_tracked_by_cdc, lock_escalation_desc, is_memory_optimized, durability_desc
FROM sys.tables WITH (NOLOCK) 
ORDER BY [name] OPTION (RECOMPILE);

-- Gives you some good information about your tables
-- Is Memory optimized and durability description are Hekaton-related properties that are new in SQL Server 2014