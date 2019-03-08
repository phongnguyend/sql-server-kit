SELECT t.NAME
FROM sys.tables t
WHERE t.type = 'U'
	AND t.object_id NOT IN (
		SELECT object_id
		FROM sys.dm_db_index_usage_stats
		WHERE database_id = Db_id(Db_name())
		)
ORDER BY NAME ASC


SELECT *
FROM sys.dm_db_index_usage_stats
WHERE database_id = Db_id(Db_name())
	AND object_id = Object_Id('TableName')

SELECT *
FROM sys.indexes
WHERE object_id = 754101727
