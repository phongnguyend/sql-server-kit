-- Query 16 - Failover Cluster Node with AlwaysOn AG

-- Get information about any AlwaysOn AG cluster this instance is a part of (Query 16) (AlwaysOn AG Cluster)
SELECT cluster_name, quorum_type_desc, quorum_state_desc
FROM sys.dm_hadr_cluster WITH (NOLOCK) OPTION (RECOMPILE);

-- You will see no results if your instance is not using AlwaysOn AGs