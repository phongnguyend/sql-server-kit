SELECT
 i.database_id,
 i.object_id,
 i.index_id,
 DB_NAME(i.database_id) as DatabaseName,
 OBJECT_SCHEMA_NAME (i.object_id, i.database_id) + '.'
 + OBJECT_NAME(i.object_id, i.database_id) as ObjectName,
 idx.name as IndexName,
 i.user_seeks,
 i.user_scans,
 i.user_lookups,
 i.user_updates,
 (user_seeks + user_scans + user_lookups) as TotaledSeekScanLookUp,
 i.last_user_seek,
 i.last_user_scan,
 i.last_user_lookup,
 i.last_user_update,
 i.system_seeks,
 i.system_scans,
 i.system_lookups,
 i.system_updates,
 i.last_system_seek,
 i.last_system_scan,
 i.last_system_lookup,
 i.last_system_update
INTO #dm_db_index_usage_stats_logs
FROM sys.dm_db_index_usage_stats i
JOIN sys.indexes idx on idx.object_id = i.object_id and idx.index_id = i.index_id
GO
 
SELECT *
FROM #dm_db_index_usage_stats_logs
--WHERE database_id = 9 and object_id = 1477580302
--and user_updates > (user_seeks + user_scans + user_lookups)
ORDER BY DatabaseName, ObjectName, user_seeks
GO