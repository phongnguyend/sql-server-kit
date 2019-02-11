/*============================================================================
  File:     sp_SQLskills_SQL2008_finddupes.sql

  Summary:  Run against a single database this procedure will list ALL
            duplicate indexes and the needed TSQL to drop them!
					
  Date:     July 2011

  SQL Server 2008 Version
------------------------------------------------------------------------------
  Written by Kimberly L. Tripp, SYSolutions, Inc.

  For more scripts and sample code, check out 
    http://www.SQLskills.com

  This script is intended only as a supplement to demos and lectures
  given by SQLskills instructors.  
  
  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
  ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
  TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
  PARTICULAR PURPOSE.
============================================================================*/

USE master
go

if OBJECTPROPERTY(OBJECT_ID('sp_SQLskills_SQL2008_finddupes'), 'IsProcedure') = 1
	drop procedure sp_SQLskills_SQL2008_finddupes
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_SQLskills_SQL2008_finddupes]
(
    @ObjName nvarchar(776) = NULL		-- the table to check for duplicates
                                        -- when NULL it will check ALL tables
)
AS

--  Jul 2011: V1 to find duplicate indexes.

-- See my blog for updates and/or additional information
-- http://www.SQLskills.com/blogs/Kimberly (Kimberly L. Tripp)

SET NOCOUNT ON

DECLARE @ObjID int,			-- the object id of the table
		@DBName	sysname,
		@SchemaName sysname,
		@TableName sysname,
		@ExecStr nvarchar(4000)

-- Check to see that the object names are local to the current database.
SELECT @DBName = PARSENAME(@ObjName,3)

IF @DBName IS NULL
    SELECT @DBName = db_name()
ELSE 
IF @DBName <> db_name()
    BEGIN
	    RAISERROR(15250,-1,-1)
	    -- select * from sys.messages where message_id = 15250
	    RETURN (1)
    END

IF @DBName = N'tempdb'
    BEGIN
	    RAISERROR('WARNING: This procedure cannot be run against tempdb. Skipping tempdb.', 10, 0)
	    RETURN (1)
    END

-- Check to see the the table exists and initialize @ObjID.
SELECT @SchemaName = PARSENAME(@ObjName, 2)

IF @SchemaName IS NULL
    SELECT @SchemaName = SCHEMA_NAME()

-- Check to see the the table exists and initialize @ObjID.
IF @ObjName IS NOT NULL
BEGIN
    SELECT @ObjID = object_id(@ObjName)
	
    IF @ObjID is NULL
    BEGIN
        RAISERROR(15009,-1,-1,@ObjName,@DBName)
        -- select * from sys.messages where message_id = 15009
        RETURN (1)
    END
END


CREATE TABLE #DropIndexes
(
    DatabaseName    sysname,
    SchemaName      sysname,
    TableName       sysname,
    IndexName       sysname,
    DropStatement   nvarchar(2000)
)

CREATE TABLE #FindDupes
(
    index_id int,
	is_disabled bit,
	index_name sysname,
	index_description varchar(210),
	index_keys nvarchar(2126),
    included_columns nvarchar(max),
	filter_definition nvarchar(max),
	columns_in_tree nvarchar(2126),
	columns_in_leaf nvarchar(max)
)

-- OPEN CURSOR OVER TABLE(S)
IF @ObjName IS NOT NULL
    DECLARE TableCursor CURSOR LOCAL STATIC FOR
        SELECT @SchemaName, PARSENAME(@ObjName, 1)
ELSE
    DECLARE TableCursor CURSOR LOCAL STATIC FOR 		    
        SELECT schema_name(uid), name 
        FROM sysobjects 
        WHERE type = 'U' --AND name
        ORDER BY schema_name(uid), name
	    
OPEN TableCursor 

FETCH TableCursor
    INTO @SchemaName, @TableName

-- For each table, list the add the duplicate indexes and save 
-- the info in a temporary table that we'll print out at the end.

WHILE @@fetch_status >= 0
BEGIN
    TRUNCATE TABLE #FindDupes
    
    SELECT @ExecStr = 'EXEC sp_SQLskills_SQL2008_finddupes_helpindex ''' 
                        + QUOTENAME(@SchemaName) 
                        + N'.' 
                        + QUOTENAME(@TableName)
                        + N''''

    --SELECT @ExecStr

    INSERT #FindDupes
    EXEC (@ExecStr)	
    
    --SELECT * FROM #FindDupes
	
    INSERT #DropIndexes
    SELECT DISTINCT @DBName,
            @SchemaName, 
            @TableName, 
            t1.index_name,
            N'DROP INDEX ' 
                + QUOTENAME(@SchemaName, N']') 
                + N'.' 
                + QUOTENAME(@TableName, N']') 
                + N'.' 
                + t1.index_name 
    FROM #FindDupes AS t1
        JOIN #FindDupes AS t2
            ON t1.columns_in_tree = t2.columns_in_tree
                AND t1.columns_in_leaf = t2.columns_in_leaf 
                AND ISNULL(t1.filter_definition, 1) = ISNULL(t2.filter_definition, 1)
                AND PATINDEX('%unique%', t1.index_description) = PATINDEX('%unique%', t2.index_description)
                AND t1.index_id > t2.index_id
                
    FETCH TableCursor
        INTO @SchemaName, @TableName
END
	
DEALLOCATE TableCursor

-- DISPLAY THE RESULTS

IF (SELECT count(*) FROM #DropIndexes) = 0
	    RAISERROR('Database: %s has NO duplicate indexes.', 10, 0, @DBName)
ELSE
    SELECT * FROM #DropIndexes
    ORDER BY SchemaName, TableName

return (0) -- sp_SQLskills_SQL2008_finddupes
go

exec sys.sp_MS_marksystemobject 'sp_SQLskills_SQL2008_finddupes'
go
