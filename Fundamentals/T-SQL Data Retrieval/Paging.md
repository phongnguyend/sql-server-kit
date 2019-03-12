### SQL Server 2012:

```sql
declare @currPage int = 2,-- trang hiện tại
@recodperpage int = 20;-- số dòng trên 1 trang

select *, COUNT(*) OVER () as TotalRecords from [TenBang]
order by [TenCot]
OFFSET (@currPage - 1)*@recodperpage ROWS
FETCH NEXT @recodperpage ROWS ONLY
```
