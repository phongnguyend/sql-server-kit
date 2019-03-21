[Data Compression - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/relational-databases/data-compression/data-compression)

### Estimate Data Compression Savings
```sql
-- ROW Compression:
EXEC sp_estimate_data_compression_savings 
    @schema_name = 'dbo', 
    @object_name = 'TableName', 
    @index_id = NULL, 
    @partition_number = NULL, 
    @data_compression = 'ROW'
GO
```
```sql
-- PAGE Compression:
EXEC sp_estimate_data_compression_savings 
    @schema_name = 'dbo', 
    @object_name = 'TableName', 
    @index_id = NULL, 
    @partition_number = NULL, 
    @data_compression = 'PAGE'
GO
```
