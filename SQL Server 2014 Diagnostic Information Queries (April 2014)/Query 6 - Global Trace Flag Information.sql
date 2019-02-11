-- Query 6 - Global Trace Flag Information

-- Returns a list of all global trace flags that are enabled (Query 6) (Global Trace Flags)
DBCC TRACESTATUS (-1);

-- If no global trace flags are enabled, no results will be returned.
-- It is very useful to know what global trace flags are currently enabled as part of the diagnostic process.

-- Common trace flags that should be enabled in most cases
-- TF 3226 - Supresses logging of successful database backup messages to the SQL Server Error Log
-- TF 1118 - Helps alleviate allocation contention in tempdb (more important with older versions of SQL Server)