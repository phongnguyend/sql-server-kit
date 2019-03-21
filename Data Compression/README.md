### Estimate Data Compression Savings
```sql
-- ROW LEVEL:
EXEC sp_estimate_data_compression_savings 
    @schema_name = 'dbo', 
    @object_name = 'TableName', 
    @index_id = NULL, 
    @partition_number = NULL, 
    @data_compression = 'ROW'
GO
```
```sql
-- PAGE LEVEL:
EXEC sp_estimate_data_compression_savings 
    @schema_name = 'dbo', 
    @object_name = 'TableName', 
    @index_id = NULL, 
    @partition_number = NULL, 
    @data_compression = 'PAGE'
GO
```
