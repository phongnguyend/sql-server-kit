
DECLARE @TableName NVARCHAR(MAX) = 'OutboxEvents';
DECLARE @ArchivedTableName NVARCHAR(MAX) = 'PublishedOutboxEvents';
DECLARE @TempTableName NVARCHAR(MAX) = '#TEMP';

DECLARE @Columns NVARCHAR(MAX);
SELECT
    @Columns = CASE
        WHEN @Columns IS NULL
        THEN '[' + name + ']'
        ELSE @Columns + ',' + '[' + name + ']'
    END
FROM sys.columns where object_id = OBJECT_ID(@TableName)

DECLARE @SQL NVARCHAR(MAX);
SELECT @SQL = '
SELECT Id INTO ' + @TempTableName + '
FROM [' + @TableName + ']
-- INSERT WHERE CONDITION HERE

INSERT INTO [' + @ArchivedTableName + '](
' + @Columns + '
)
SELECT
'+ @Columns + ' 
FROM [' + @TableName + ']
WHERE Id IN (SELECT Id FROM ' + @TempTableName + ')

DELETE FROM [' + @TableName + ']
WHERE Id IN (SELECT Id FROM ' + @TempTableName + ')

DROP TABLE ' + @TempTableName + '
'

SELECT @SQL
