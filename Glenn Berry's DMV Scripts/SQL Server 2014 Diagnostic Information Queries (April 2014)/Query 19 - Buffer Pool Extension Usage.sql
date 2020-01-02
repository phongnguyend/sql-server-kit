-- Query 19 - Buffer Pool Extension Usage

-- Look at buffer descriptors to see BPE usage by database (Query 19) (BPE Usage) 
SELECT DB_NAME(database_id) AS [Database Name], COUNT(page_id) AS [Page Count],
CAST(COUNT(*)/128.0 AS DECIMAL(10, 2)) AS [Buffer size(MB)], 
AVG(read_microsec) AS [Avg Read Time (microseconds)]
FROM sys.dm_os_buffer_descriptors WITH (NOLOCK)
WHERE database_id <> 32767
AND is_in_bpool_extension = 1
GROUP BY DB_NAME(database_id) 
ORDER BY [Buffer size(MB)] DESC OPTION (RECOMPILE);

-- You will see no results if BPE is not enabled or if there is no BPE usage