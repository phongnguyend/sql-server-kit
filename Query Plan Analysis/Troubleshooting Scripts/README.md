**When was SQL Server restarted:**
```sql
SELECT sqlserver_start_time FROM sys.dm_os_sys_info
```

**When Was SQL Server Installed:**
```sql
SELECT @@SERVERNAME AS [Server Name], create_date AS [SQL Server Install Date] 
FROM sys.server_principals WITH (NOLOCK)
WHERE name = N'NT AUTHORITY\SYSTEM'
OR name = N'NT AUTHORITY\NETWORK SERVICE'
OPTION (RECOMPILE);
```
**DB Compatibility Level:**
```sql
SELECT name, database_id, create_date, compatibility_level
FROM sys.databases
```

**View Query Plan:**
```sql
select * 
from sys.dm_exec_query_plan (paste plan_handle here)
```
