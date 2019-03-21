## PAGELATCH_XX Wait
### What does it mean: 
- Waiting for access to an in-memory data file page 
- Common modes to see are SH and EX 
  + SH mode means the page will be read 
  + EX mode means the page will be changed 
### Avoid knee-jerk response: 
- Do not confuse these with PAGEIOLATCH_XX waits 
- Does not mean add more memory or I/O capacity 
### Further analysis: 
- Determine the page(s) that the thread is waiting for access to 
- Analyze the queries encountering this wait 
- Analyze the table and index structures involved 

## PAGELATCH_XX Wait Solutions 
### Classic tempdb contention 
- Add more tempdb data files 
- Enable trace flag 1118 
- Reduce temp table usage 
### Excessive page splits occurring in indexes 
- Change to a non-random index key 
- Avoid updating index records to be longer 
- Provision an index FILLFACTOR to alleviate page splits 
### Insertion point hotspot in a clustered index with an ever-increasing key 
- Spread the insertion points in the index using a random or composite key, plus provision a FILLFACTOR to prevent page splits 
- Shard into multiple tables/databases/servers
