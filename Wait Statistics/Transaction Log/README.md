## WRITELOG Wait 

### What does it mean: 
- Waiting for a transaction log block buffer to flush to disk 

### Avoid knee-jerk response: 
- Do not assume that the transaction log file I/O system has a problem (although this is often the case) 
- Do not create additional transaction log files 

### Further analysis: 
- Correlate WRITELOG wait time with I/O subsystem latency using sys.dm_io_virtual_file_stats 
  + Look for LOGBUFFER waits, showing internal contention for log buffers 
- Look at average disk write queue length for log drive 
  + If constantly 31/32 then the internal limit has been reached for outstanding transaction log writes for a single database 
- Look at average size of transactions 
- Investigate whether frequent page splits are occurring

### Solutions
- Move the log to a faster I/O subsystem 
- Increase the size of transactions to prevent many minimum-size log block flushes to disk 
- Remove unused nonclustered indexes to reduce logging overhead from maintaining unused indexes during DML operations 
- Change index keys or introduce FILLFACTORs to reduce page splits 
- Potentially split the workload over multiple databases or servers
