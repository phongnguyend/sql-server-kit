-- Query 14 - OS Cluster Properties

-- Get information about your OS cluster (if your database server is in a cluster)  (Query 14) (Cluster Properties)
SELECT VerboseLogging, SqlDumperDumpFlags, SqlDumperDumpPath, 
       SqlDumperDumpTimeOut, FailureConditionLevel, HealthCheckTimeout
FROM sys.dm_os_cluster_properties WITH (NOLOCK) OPTION (RECOMPILE);

-- You will see no results if your instance is not clustered