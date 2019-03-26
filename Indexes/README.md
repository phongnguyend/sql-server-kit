### Clustered Indexes:
```sql
SELECT tb.name AS TableName
	,idx.name AS IndexName
	,idx.type_desc AS IndexType
	,cl.name AS ColumnName
	,type.name AS ColumnType
FROM sys.indexes idx
JOIN sys.index_columns idxc ON idxc.index_id = idx.index_id
	AND idxc.object_id = idx.object_id
JOIN sys.columns cl ON idxc.column_id = cl.column_id
	AND idxc.object_id = cl.object_id
JOIN sys.tables tb ON idx.object_id = tb.object_id
JOIN sys.types type ON cl.user_type_id = type.user_type_id
WHERE idx.type_desc = 'CLUSTERED'
ORDER BY TableName
OPTION (RECOMPILE);
```
