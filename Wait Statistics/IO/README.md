
## PAGEIOLATCH_XX Wait
###  What does it mean: 
- Waiting for a data file page to be read from disk into memory 
- Common modes to see are SH and EX 
  + SH mode means the page will be read 
  + EX mode means the page will be changed 
### Avoid knee-jerk response: 
- Do not assume the I/O subsystem or I/O path is the problem 
### Further analysis: 
- Determine which tables/indexes are being read 
- Analyze I/O subsystem latencies with sys.dm_io_virtual_file_stats and Avg Disk secs/Read performance counters 
- Correlate with CXPACKET waits, suggesting parallel scans 
- Examine query plans for parallel scans 
- Examine query plans for implicit conversions 
- Investigate buffer pool memory pressure and Page Life Expectancy

## PAGEIOLATCH_XX Wait Solutions 
- Create appropriate nonclustered indexes to reduce scans 
- Update statistics to allow efficient query plans 
- Move the affected data files to faster I/O subsystem 
- If data volume has simply increased, consider increasing memory
