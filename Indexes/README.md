### Review Clustered Indexes:
```sql
SELECT tb.name AS TableName
	,idx.name AS IndexName
	,idx.type_desc AS IndexType
	,cl.name AS ColumnName
	,type.name AS ColumnType
	,cl.is_identity IsIdentity
	,dct.DEFINITION AS DefaultConstraint
	,idx.is_primary_key AS IsPrimaryKey
FROM sys.indexes idx
JOIN sys.index_columns idxc ON idxc.index_id = idx.index_id
	AND idxc.object_id = idx.object_id
JOIN sys.columns cl ON idxc.column_id = cl.column_id
	AND idxc.object_id = cl.object_id
JOIN sys.tables tb ON idx.object_id = tb.object_id
JOIN sys.types type ON cl.user_type_id = type.user_type_id
LEFT JOIN sys.default_constraints dct ON dct.parent_column_id = cl.column_id
	AND dct.parent_object_id = cl.object_id
WHERE idx.type_desc = 'CLUSTERED'
ORDER BY TableName
OPTION (RECOMPILE);
```
### Review HEAP Tables:
```sql
SELECT o.name AS TableName
	,i.type_desc AS IndexType
	,o.create_date AS CreateDate
FROM sys.indexes i
INNER JOIN sys.objects o ON i.object_id = o.object_id
WHERE i.type_desc = 'HEAP'
	AND o.type_desc = 'USER_TABLE'
ORDER BY o.name
GO
```

### Review all HEAP:
```sql
SELECT o.name AS ObjectName
	,i.type_desc AS IndexType
	,o.type_desc AS ObjectType
	,o.create_date AS CreateDate
FROM sys.indexes i
INNER JOIN sys.objects o ON i.object_id = o.object_id
WHERE i.type_desc = 'HEAP'
ORDER BY o.name
GO
```
