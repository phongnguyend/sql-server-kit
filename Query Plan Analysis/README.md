### Tools:
[SentryOne Plan Explorer - SQL Server Query Tuning](https://www.sentryone.com/plan-explorer)

### Common Operators: [*link*](https://docs.microsoft.com/en-us/sql/relational-databases/showplan-logical-and-physical-operators-reference)

**1. Scans**:
- ![alt text](imgs/table-scan-32x.gif) **Table Scan**
- ![alt text](imgs/clustered-index-scan-32x.gif) **Clustered Index Scan** 
- ![alt text](imgs/nonclustered-index-scan-32x.gif) **Index Scan** 

**2. Seeks**:
- ![alt text](imgs/clustered-index-seek-32x.gif) **Clustered Index Seek** 
- ![alt text](imgs/index-seek-32x.gif) **Index Seek** 

**3. Lookups**:
- ![alt text](imgs/bookmark-lookup-32x.gif) **Key Lookup** 
- ![alt text](imgs/rid-nonclust-locate-32x.gif) **RID Lookup** 

**4. Joins**:
- ![alt text](imgs/nested-loops-32x.gif) **Nested Loops** 
- ![alt text](imgs/merge-join-32x.gif) **Merge Join** 
- ![alt text](imgs/hash-match-32x.gif) **Hash Match** 

**5.** ![alt text](imgs/stream-aggregate-32x.gif) **Stream Aggregate**

**6.** ![alt text](imgs/filter-32x.gif) **Filter**

**7.** ![alt text](imgs/sort-32x.gif) **Sort**
