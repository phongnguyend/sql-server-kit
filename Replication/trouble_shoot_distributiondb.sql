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


/*

https://www.sqlservercentral.com/articles/process-to-truncate-transaction-log-of-replicated-database

If see: "The initial snapshot for publication 'XYZ' is not yet available." should find and start the job: Snapshot Agent

*/