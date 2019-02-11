-- Query 5 - Getting SQL Server Agent Alert Information 

-- Get SQL Server Agent Alert Information (Query 5) (SQL Server Agent Alerts)
SELECT name, event_source, message_id, severity, [enabled], has_notification, 
       delay_between_responses, occurrence_count, last_occurrence_date, last_occurrence_time
FROM msdb.dbo.sysalerts WITH (NOLOCK)
ORDER BY name OPTION (RECOMPILE);

-- Gives you some basic information about your SQL Server Agent Alerts (which are different from SQL Server Agent jobs)
-- Read more about Agent Alerts here: http://www.sqlskills.com/blogs/glenn/creating-sql-server-agent-alerts-for-critical-errors/