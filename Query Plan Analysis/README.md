### Tools:
[SentryOne Plan Explorer - SQL Server Query Tuning](https://www.sentryone.com/plan-explorer)

### DMVs:
- sys.dm_exec_cached_plans
- sys.dm_exec_query_stats
- sys.dm_exec_procedure_stats
- sys.dm_exec_query_plan
- sys.dm_exec_sql_text

### Query Tree:
![alt text](imgs/query-tree.png)

### Common Operators: [*link*](https://docs.microsoft.com/en-us/sql/relational-databases/showplan-logical-and-physical-operators-reference)

**Scans**:
- ![alt text](imgs/table-scan-32x.gif) **Table Scan**
- ![alt text](imgs/clustered-index-scan-32x.gif) **Clustered Index Scan** 
- ![alt text](imgs/nonclustered-index-scan-32x.gif) **Index Scan** 

**Seeks**:
- ![alt text](imgs/clustered-index-seek-32x.gif) **Clustered Index Seek** 
- ![alt text](imgs/index-seek-32x.gif) **Index Seek** 

**Lookups**:
- ![alt text](imgs/bookmark-lookup-32x.gif) **Key Lookup** 
- ![alt text](imgs/rid-nonclust-locate-32x.gif) **RID Lookup** 

**Joins**:
- ![alt text](imgs/nested-loops-32x.gif) **Nested Loops** *(HINT: LOOP JOIN)*
- ![alt text](imgs/merge-join-32x.gif) **Merge Join** 
- ![alt text](imgs/hash-match-32x.gif) **Hash Match** *(HINT: HASH JOIN)*

**Spools:** *The **Spool** operator saves an intermediate query result to the **tempdb** database*.
- ![alt text](imgs/spool-32x.gif) **Eager Spool**
- ![alt text](imgs/spool-32x.gif) **Lazy Spool**

**Parallelism**:
- ![alt text](imgs/parallelism-distribute-stream.gif) **Distribute Streams**
- ![alt text](imgs/parallelism-repartition-stream.gif) **Repartition Streams**
- ![alt text](imgs/parallelism-32x.gif) **Gather Streams**
- ![alt text](imgs/bitmap-32x.gif) **Bitmap**

![alt text](imgs/stream-aggregate-32x.gif) **Stream Aggregate** *(GROUP BY)*

![alt text](imgs/filter-32x.gif) **Filter** *(HAVING)*

![alt text](imgs/sort-32x.gif) **Sort** *(ORDER BY)*

![alt text](imgs/compute-scalar-32x.gif) **Compute Scalar**: *(function expression)*

![alt text](imgs/concatenation-32x.gif) **Concatenation** *(UNION ALL)*
