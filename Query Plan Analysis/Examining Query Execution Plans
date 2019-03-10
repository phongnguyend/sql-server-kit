-- Clearing the plan cache (don't do this in production)
DBCC FREEPROCCACHE;
GO

-- Execute this query
SELECT  *
FROM    AspNetUsers

-- sys.dm_exec_cached_plans
SELECT  [size_in_bytes],
        [cacheobjtype],
        [objtype],
        [plan_handle]
FROM    sys.dm_exec_cached_plans;

-- Let's find our plan based on query text
SELECT  [cp].[size_in_bytes],
        [cp].[cacheobjtype],
        [cp].[objtype],
        [cp].[plan_handle],
        [dest].[text]
FROM    [sys].[dm_exec_cached_plans] AS cp
CROSS APPLY [sys].[dm_exec_sql_text]([cp].[plan_handle]) AS dest
WHERE   [dest].[text] LIKE '%AspNetUsers%';

-- sys.dm_exec_query_plan 
SELECT  [dbid],
        [query_plan]
FROM    sys.dm_exec_query_plan(0x060006008AFD781E801181ADB802000001000000000000000000000000000000000000000000000000000000);
GO

-- sys.dm_exec_text_query_plan
SELECT  [dbid],
        [query_plan]
FROM    sys.dm_exec_text_query_plan(0x0600060006861C06609F5A9FB802000001000000000000000000000000000000000000000000000000000000,
                                    0, -1);
GO
