## CXPACKET Wait
### What does it mean:
- Parallel operations are taking place
- Accumulating very fast implies skewed work distribution amongst threads or one of the workers is being blocked by something

### Avoid knee-jerk response:
- Do not set server-wide MAXDOP to 1, disabling parallelism 

### Further analysis:
- Correlation with PAGEIOLATCH_SH waits? Implies large scans
  + Also may see with ACCESS_METHODS_DATASET_PARENT latch or ACCESS_METHODS_SCAN_RANGE_GENERATOR latch
- Examine query plans of requests that are accruing CXPACKET waits to see if the query plans make sense for the query being performed
- What is the wait type of the parallel thread that is taking too long? (i.e. the thread that does not have CXPACKET as its wait type)

### Possible root-causes:
- Just parallelism occurring
- Table scans being performed because of missing nonclustered indexes or incorrect query plan
- Out-of-data statistics causing skewed work distribution
### If there is actually a problem:
- Make sure statistics are up-to-date and appropriate indexes exist 
- Consider MAXDOP for the query 
- Consider MAXDOP = physical cores per NUMA node 
- Consider MAXDOP for the instance, but beware of mixed-mode workloads 
- Consider using Resource Governor for MAX_DOP 
- Consider setting ‘cost threshold for parallelism’ higher than the query cost shown in the execution plan
