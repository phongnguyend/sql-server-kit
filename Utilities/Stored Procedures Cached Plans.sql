SELECT OBJECT_NAME([ps].[object_id], [ps].[database_id]) 
            AS [ProcedureName]
 , [ps].[execution_count] AS [ProcedureExecutes]
 , [qs].[plan_generation_num] AS [VersionOfPlan]
 , [qs].[execution_count] AS [ExecutionsOfCurrentPlan]
 , SUBSTRING ([st].[text], 
  ([qs].[statement_start_offset] / 2) + 1, 
     ((CASE [statement_end_offset] 
   WHEN -1 THEN DATALENGTH ([st].[text]) 
      ELSE [qs].[statement_end_offset] END
   - [qs].[statement_start_offset]) / 2) + 1) 
      AS [StatementText]
    , [qs].[statement_start_offset] AS [offset]
    , [qs].[statement_end_offset] AS [offset_end]
    , [qp].[query_plan] AS [Query Plan XML]
    , [qs].[query_hash] AS [Query Fingerprint]
    , [qs].[query_plan_hash] AS [Query Plan Fingerprint]
FROM [sys].[dm_exec_procedure_stats] AS [ps]
JOIN [sys].[dm_exec_query_stats] AS [qs] ON [ps].[plan_handle] = [qs].[plan_handle]
CROSS APPLY [sys].[dm_exec_query_plan] ([qs].[plan_handle]) AS [qp]
CROSS APPLY [sys].[dm_exec_sql_text] ([qs].[sql_handle]) AS [st]
WHERE [ps].[database_id] = DB_ID()
ORDER BY [ProcedureName], [qs].[statement_start_offset];