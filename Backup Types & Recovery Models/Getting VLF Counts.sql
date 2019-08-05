-- Get VLF Counts for all databases on the instance (Query 29) (VLF Counts)
-- (adapted from Michelle Ufford) 
CREATE TABLE #VLFInfo (RecoveryUnitID int, FileID  int,
					   FileSize bigint, StartOffset bigint,
					   FSeqNo      bigint, [Status]    bigint,
					   Parity      bigint, CreateLSN   numeric(38));
	 
CREATE TABLE #VLFCountResults(DatabaseName sysname, VLFCount int);
	 
EXEC sp_MSforeachdb N'Use [?]; 

				INSERT INTO #VLFInfo 
				EXEC sp_executesql N''DBCC LOGINFO([?])''; 
	 
				INSERT INTO #VLFCountResults 
				SELECT DB_NAME(), COUNT(*) 
				FROM #VLFInfo; 

				TRUNCATE TABLE #VLFInfo;'
	 
SELECT DatabaseName, VLFCount  
FROM #VLFCountResults
ORDER BY VLFCount DESC;
	 
DROP TABLE #VLFInfo;
DROP TABLE #VLFCountResults;

-- High VLF counts can affect write performance 
-- and they can make database restores and recovery take much longer
-- Try to keep your VLF counts under 200 in most cases