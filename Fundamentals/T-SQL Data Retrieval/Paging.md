### SQL Server 2012:

```sql
DECLARE @currPage INT = 2,
	@recodperpage INT = 20;

SELECT *
	, COUNT(*) OVER () AS TotalRecords
FROM [TenBang]
ORDER BY [TenCot] 
OFFSET(@currPage - 1) * @recodperpage ROWS
FETCH NEXT @recodperpage ROWS ONLY
```
