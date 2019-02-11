-- Query 20 - TCP Listener States

-- Get information about TCP Listener for SQL Server  (Query 20) (TCP Listener States)
SELECT listener_id, ip_address, is_ipv4, port, type_desc, state_desc, start_time
FROM sys.dm_tcp_listener_states WITH (NOLOCK) 
ORDER BY listener_id OPTION (RECOMPILE);

-- Helpful for network and connectivity troubleshooting
