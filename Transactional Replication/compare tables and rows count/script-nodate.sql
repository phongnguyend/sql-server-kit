SELECT 
	 QUOTENAME(SCHEMA_NAME(sOBJ.schema_id)) + '.' + QUOTENAME(sOBJ.name) AS [Table Name]
	,SUM(sdmvPTNS.row_count) AS [Row Count]
FROM sys.objects AS sOBJ
INNER JOIN sys.dm_db_partition_stats AS sdmvPTNS ON sOBJ.object_id = sdmvPTNS.object_id
LEFT JOIN sys.dm_db_index_usage_stats id ON sOBJ.object_id = id.object_id
	AND id.index_id = sdmvPTNS.index_id
	AND id.database_id = DB_ID()
WHERE sOBJ.type = 'U'
	AND sOBJ.is_ms_shipped = 0x0
	AND sdmvPTNS.index_id < 2
GROUP BY sOBJ.schema_id
	,sOBJ.name
	,id.last_user_update
ORDER BY [Table Name]
GO