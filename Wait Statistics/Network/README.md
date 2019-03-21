## ASYNC_NETWORK_IO Wait

### What does it mean: 
- SQL Server is waiting for a client to acknowledge receipt of sent data 
### Avoid knee-jerk response: 
- Do not assume that the problem is network latency 
- It is a network delay as far as SQL Server is concerned though 
### Further analysis: 
- Analyze client application code 
- Analyze network latencies 
### Possible root-causes and solutions: 
- Nearly always a poorly-coded application that is processing results one record at a time (RBAR = Row-By-Agonizing-Row) 
  + Very easy to demonstrate using a large query and SQL Server Management Studio running on the same machine as SQL Server 
- Otherwise look for network hardware issues, incorrect duplex settings, or TCP chimney offload problems (see http://bit.ly/aPzoAx)
