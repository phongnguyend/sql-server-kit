IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('[scheme].[TableName]') AND NAME = 'IndexName')
BEGIN
    DROP INDEX [IndexName] ON [scheme].[TableName];
END;
