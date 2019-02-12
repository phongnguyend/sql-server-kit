declare @indexName nvarchar(255) = N'[IX_ABC_XYZ]'

;with xmlnamespaces ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' as sp)
select 
    n.value(N'@Index', N'sysname') as IndexName,
    replace(t.text, '**', '') as entire_query,
    substring (t.text,(s.statement_start_offset/2) + 1, 
            ((case when s.statement_end_offset = -1 then len(convert(nvarchar(max), t.text)) * 2
        else
            s.statement_end_offset
        end 
        - s.statement_start_offset)/2) + 1) as query,
    p.query_plan
from 
    sys.dm_exec_query_stats as s
    cross apply sys.dm_exec_sql_text(s.sql_handle) as t 
    cross apply sys.dm_exec_query_plan(s.plan_handle) as p 
    cross apply query_plan.nodes('//sp:Object') as p1(n)
where
    n.value(N'@Index', N'sysname') = @indexName