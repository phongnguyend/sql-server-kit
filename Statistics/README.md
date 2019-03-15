```sql
SELECT  [name],
        [database_id],
        [is_auto_create_stats_on],
        [is_auto_update_stats_on],
        [is_auto_update_stats_async_on]
FROM sys.[databases]
WHERE [database_id] = DB_ID();
GO
```

```sql
-- Checking statistics for a specific table
EXEC sp_helpstats '[table_name]', 'ALL'
GO

-- Using the catalog view
SELECT  object_name([object_id]) AS [object_name],
		[object_id],
        [name],
        [stats_id],
        [auto_created],
        [user_created],
        [no_recompute],
	STATS_DATE(object_id, stats_id) AS [stats_date]
FROM    sys.[stats] AS s
WHERE object_name([object_id]) = 'table_name';
GO

-- Confirming indexes for a table
EXEC sp_helpindex 'table_name';
GO
```

```sql
DBCC SHOW_STATISTICS([table_name], [statistics_name])
GO
```
