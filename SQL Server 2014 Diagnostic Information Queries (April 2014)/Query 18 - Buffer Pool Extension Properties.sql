-- Query 18 - Buffer Pool Extension Properties


-- See if buffer pool extension (BPE) is enabled (Query 18) (BPE Enabled)
SELECT [path], state_description, current_size_in_kb, 
CAST(current_size_in_kb/1048576.0 AS DECIMAL(10,2)) AS [Size (GB)]
FROM sys.dm_os_buffer_pool_extension_configuration WITH (NOLOCK) OPTION (RECOMPILE);

-- BPE is available in both Standard Edition and Enterprise Edition