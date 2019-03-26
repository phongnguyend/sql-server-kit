SELECT 
   n.value('(value)[1]', 'bigint') AS page_id,
   n.value('(@count)[1]', 'bigint') AS wait_count
FROM
(  SELECT CAST(target_data AS XML) target_data
   FROM sys.dm_xe_sessions AS s 
   INNER JOIN sys.dm_xe_session_targets AS t
       ON s.address = t.event_session_address
   WHERE s.name = N'SQLskills_MonitorTempdbContention'
   AND t.target_name = N'histogram' ) AS tab
CROSS APPLY target_data.nodes('HistogramTarget/Slot') AS q(n); 




SELECT 
	SUM(n.value('(data[@name="duration"]/value)[1]', 'int'))/1000000.0 AS duration_seconds
FROM 
(SELECT
    CAST(event_data AS XML) AS event_data
FROM sys.fn_xe_file_target_read_file(
       'SQLskills_MonitorTempdbContention*xel',
       'See its not used', -- No metadata file required in 2012
       NULL,
       NULL)
) AS tab
CROSS APPLY event_data.nodes('event') AS q(n)



SELECT 
   session_id,
   wait_type,
   wait_duration_ms,
   blocking_session_id,
   resource_description,
   ResourceType = CASE
   WHEN PageID = 1 OR PageID % 8088 = 0 THEN 'Is PFS Page'
   WHEN PageID = 2 OR PageID % 511232 = 0 THEN 'Is GAM Page'
   WHEN PageID = 3 OR (PageID - 1) % 511232 = 0 THEN 'Is SGAM Page'
       ELSE 'Is Not PFS, GAM, or SGAM page'
   END
FROM (  SELECT  
           session_id,
           wait_type,
           wait_duration_ms,
           blocking_session_id,
           resource_description,
           CAST(RIGHT(resource_description, LEN(resource_description)
           - CHARINDEX(':', resource_description, 3)) AS INT) AS PageID
       FROM sys.dm_os_waiting_tasks
       WHERE wait_type LIKE 'PAGE%LATCH_%'
         AND resource_description LIKE '2:%'
) AS tab; 