SELECT a.index_id
,name
,avg_fragmentation_in_percent
,OBJECT_NAME(a.object_id) as TableName
FROM sys.dm_db_index_physical_stats (DB_ID(),null, NULL, NULL, NULL) AS a  
JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id
where avg_fragmentation_in_percent > 30
order by avg_fragmentation_in_percent desc