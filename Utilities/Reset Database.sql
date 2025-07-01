DECLARE @sql NVARCHAR(MAX) = '';
                              
SELECT @sql += 'ALTER TABLE ' + QUOTENAME(SCHEMA_NAME(t.schema_id)) + '.' + QUOTENAME(t.name) +
                ' DROP CONSTRAINT ' + QUOTENAME(f.name) + ';' + CHAR(13)
FROM sys.foreign_keys f JOIN sys.tables t ON f.parent_object_id = t.object_id;
                              
SELECT @sql += 'DROP INDEX ' + QUOTENAME(i.name) + ' ON ' +
                QUOTENAME(SCHEMA_NAME(t.schema_id)) + '.' + QUOTENAME(t.name) + ';' + CHAR(13)
FROM sys.indexes i JOIN sys.tables t ON i.object_id = t.object_id WHERE i.is_primary_key = 0 AND i.type > 0;
                              
SELECT @sql += 'DROP TABLE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.tables WHERE type = 'U';
                              
SELECT @sql += 'DROP VIEW ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.views;
                              
SELECT @sql += 'DROP PROCEDURE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.procedures;
                              
SELECT @sql += 'DROP FUNCTION ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.objects
WHERE type IN ('FN', 'IF', 'TF');

-- select @sql;
-- print @sql;                           
-- EXEC sp_executesql @sql;
