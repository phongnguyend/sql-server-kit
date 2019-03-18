
-- Trivial plan
	-- No joins, obvious plan
-- Search 0 - Transaction Processing
	-- Serial plan, low cost (<.2)
-- Search 1 - Quick Plan
	-- Cost < 1.0
-- Search 2 - Full Optimization
	-- Parallelism considered
	-- All rules evaluated
SELECT  [counter] ,
        [occurrence] ,
        [value]
FROM    [sys].[dm_exec_query_optimizer_info]
WHERE   [counter] IN 
		( 'trivial plan', 
		  'search 0', 
		  'search 1', 
		  'search 2' );

-- Is this what you expected?

-- Hint usage?
SELECT  [counter] ,
        [occurrence] ,
        [value]
FROM    [sys].[dm_exec_query_optimizer_info] 
WHERE   [counter] IN 
		( 'order hint', 
		  'join hint' );
