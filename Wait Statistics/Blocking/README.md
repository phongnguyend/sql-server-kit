## LCK_M_XX Wait

### What does it mean: 
- A thread is waiting for a lock that cannot be granted because another thread is holding an incompatible lock 

### Avoid knee-jerk response: 
- Do not assume that locking is the root cause 

### Further analysis: 
- Follow the blocking chain using sys.dm_os_waiting_tasks to see what the lead blocking thread is waiting for 
- Use the blocked process report to capture information on queries waiting too long for locks 

### Solutions 
- Lock escalation from a large update or table scan 
  + Possibly configure partition-level lock escalation, if applicable 
  + Consider a different indexing strategy to use nonclustered index seeks 
  + Consider breaking large updates into smaller transactions 
  + Consider using snapshot isolation, a different isolation level, or locking hints 
  + All the general strategies for alleviating blocking problems 
- Unnecessary locks for the data being accessed 
  + Consider using snapshot isolation, a different isolation level, or locking hints 
- Something preventing a transaction from releasing its locks quickly 
  + Determine what the bottleneck is and solve it appropriately
