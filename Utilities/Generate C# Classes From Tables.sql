/*
https://gist.github.com/joey-qc/6710702
*/

declare @tableName varchar(200)
declare @columnName varchar(200)
declare @nullable varchar(50)
declare @datatype varchar(50)
declare @maxlen int

declare @sType varchar(50)
declare @sProperty varchar(200)

DECLARE table_cursor CURSOR FOR 
SELECT TABLE_NAME
FROM [INFORMATION_SCHEMA].[TABLES]

OPEN table_cursor

FETCH NEXT FROM table_cursor 
INTO @tableName

WHILE @@FETCH_STATUS = 0
BEGIN

PRINT 'public class ' + @tableName + ' {'

    DECLARE column_cursor CURSOR FOR 
    SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE, isnull(CHARACTER_MAXIMUM_LENGTH,'-1') 
  from [INFORMATION_SCHEMA].[COLUMNS] 
	WHERE [TABLE_NAME] = @tableName
	order by [ORDINAL_POSITION]

    OPEN column_cursor
    FETCH NEXT FROM column_cursor INTO @columnName, @nullable, @datatype, @maxlen

    WHILE @@FETCH_STATUS = 0
    BEGIN

	-- datatype
	select @sType = case @datatype
	when 'int' then 'Int32'
	when 'decimal' then 'Decimal'
	when 'money' then 'Decimal'
	when 'char' then 'String'
	when 'nchar' then 'String'
	when 'varchar' then 'String'
	when 'nvarchar' then 'String'
	when 'uniqueidentifier' then 'Guid'
	when 'datetime' then 'DateTime'
	when 'bit' then 'Boolean'
	else 'String'
	END

		If (@nullable = 'NO')
			PRINT '[Required]'
		if (@sType = 'String' and @maxLen <> '-1')
			Print '[MaxLength(' +  convert(varchar(4),@maxLen) + ')]'
		SELECT @sProperty = 'public ' + @sType + ' ' + @columnName + ' { get; set;}'
		PRINT @sProperty

		print ''
		FETCH NEXT FROM column_cursor INTO @columnName, @nullable, @datatype, @maxlen
	END
    CLOSE column_cursor
    DEALLOCATE column_cursor

	print '}'
	print ''
    FETCH NEXT FROM table_cursor 
    INTO @tableName
END
CLOSE table_cursor
DEALLOCATE table_cursor