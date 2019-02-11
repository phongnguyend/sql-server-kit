-- Query 3 - Getting Useful Server Properties


-- Get selected server properties (SQL Server 2014)  (Query 3) (Server Properties)
SELECT SERVERPROPERTY('MachineName') AS [MachineName], SERVERPROPERTY('ServerName') AS [ServerName],  
SERVERPROPERTY('InstanceName') AS [Instance], SERVERPROPERTY('IsClustered') AS [IsClustered], 
SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS [ComputerNamePhysicalNetBIOS], 
SERVERPROPERTY('Edition') AS [Edition], SERVERPROPERTY('ProductLevel') AS [ProductLevel], 
SERVERPROPERTY('ProductVersion') AS [ProductVersion], SERVERPROPERTY('ProcessID') AS [ProcessID],
SERVERPROPERTY('Collation') AS [Collation], SERVERPROPERTY('IsFullTextInstalled') AS [IsFullTextInstalled], 
SERVERPROPERTY('IsIntegratedSecurityOnly') AS [IsIntegratedSecurityOnly],
SERVERPROPERTY('IsHadrEnabled') AS [IsHadrEnabled], SERVERPROPERTY('HadrManagerStatus') AS [HadrManagerStatus],
SERVERPROPERTY('IsXTPSupported') AS [IsXTPSupported];

-- This gives you a lot of useful information about your instance of SQL Server,
-- such as the ProcessID for SQL Server and your collation
-- The last column is new for SQL Server 2014