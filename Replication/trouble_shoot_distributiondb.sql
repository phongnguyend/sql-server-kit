sp_spaceused [MSrepl_commands]

select top 100 * 
from [MSrepl_commands]



select distinct 
srv.srvname publication_server 
, a.publisher_db
, p.publication publication_name
, p.retention
, ss.srvname subscription_server
, s.subscriber_db
from MSArticles a 
join MSpublications p on a.publication_id = p.publication_id
join MSsubscriptions s on p.publication_id = s.publication_id
join master..sysservers ss on s.subscriber_id = ss.srvid
join master..sysservers srv on srv.srvid = p.publisher_id
join MSdistribution_agents da on da.publisher_id = p.publisher_id 
and da.subscriber_id = s.subscriber_id
ORDER BY p.retention 


-- Check Distribution Clean Up Job:
/*
Executed as user: XXX. Could not remove directory 'C:\XXX\unc\XXX_PROD_PUBLICATION\20190801073125\'. Check the security context of xp_cmdshell and close other processes that may be accessing the directory.
[SQLSTATE 42000] (Error 20015)  ...
Could not clean up the distribution transaction tables. [SQLSTATE 01000] (Message 14152).  The step failed.

+ Remove the folder manually.
+ Check number of records: sp_spaceused [MSrepl_commands]
+ If the number is too big ( > 10.000.000 rows) we should jump to "Truncate [MSrepl_commands]" step, otherwise execute:
	EXEC dbo.sp_MSdistribution_cleanup @min_distretention = 0, @max_distretention = 72

*/

-- Check xp_cmdshell is enabled:
/*

select * from sys.configurations
where name = 'xp_cmdshell'
GO

xp_cmdshell 'dir c:\'
GO

sp_configure 'show advanced options', '1'
RECONFIGURE
GO

sp_configure 'xp_cmdshell', '1' 
RECONFIGURE
GO

sp_configure 'xp_cmdshell', '0' 
RECONFIGURE
GO

*/

-- Truncate [MSrepl_commands]
/*

https://www.sqlservercentral.com/articles/process-to-truncate-transaction-log-of-replicated-database

If see: "The initial snapshot for publication 'XYZ' is not yet available." should find and start the job: Snapshot Agent

*/