SELECT
      QUOTENAME(SCHEMA_NAME(sOBJ.schema_id)) + '.' + QUOTENAME(sOBJ.name) AS [TableName]
      , SUM(sdmvPTNS.row_count) AS [RowCount]
	  , FORMAT(id.last_user_update, 'yyyy-MM-dd HH:mm:ss')
	  
FROM
      sys.objects AS sOBJ
      INNER JOIN sys.dm_db_partition_stats AS sdmvPTNS
            ON sOBJ.object_id = sdmvPTNS.object_id
      LEFT JOIN sys.dm_db_index_usage_stats id on sOBJ.object_id = id.object_id and id.index_id = sdmvPTNS.index_id and id.database_id = DB_ID()
WHERE 
      sOBJ.type = 'U'
      AND sOBJ.is_ms_shipped = 0x0
      AND sdmvPTNS.index_id < 2
GROUP BY
      sOBJ.schema_id
      , sOBJ.name
	  , id.last_user_update
ORDER BY [TableName]
GO