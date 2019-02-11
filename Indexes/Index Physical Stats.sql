SELECT [database_id]
      ,i.[object_id]
      ,i.[index_id]
      ,DB_NAME(i.database_id) as DatabaseName
      ,OBJECT_SCHEMA_NAME (i.object_id, i.database_id) + '.'
      + OBJECT_NAME(i.object_id, i.database_id) as ObjectName
      ,idx.name as IndexName
      ,[partition_number]
      ,[index_type_desc]
      ,[alloc_unit_type_desc]
      ,[index_depth]
      ,[index_level]
      ,[avg_fragmentation_in_percent]
      ,[fragment_count]
      ,[avg_fragment_size_in_pages]
      ,[page_count]
      ,[avg_page_space_used_in_percent]
      ,[record_count]
      ,[ghost_record_count]
      ,[version_ghost_record_count]
      ,[min_record_size_in_bytes]
      ,[max_record_size_in_bytes]
      ,[avg_record_size_in_bytes]
      ,[forwarded_record_count]
      ,[compressed_page_count]
INTO #dm_db_index_physical_stats_logs
FROM sys.dm_db_index_physical_stats  (DB_ID(), NULL, NULL, NULL , 'DETAILED') i
JOIN sys.indexes idx on idx.object_id = i.object_id and idx.index_id = i.index_id;  
GO
 
 
SELECT * 
FROM #dm_db_index_physical_stats_logs
--WHERE object_id = 1477580302
ORDER BY DatabaseName, ObjectName, index_id, index_level
GO