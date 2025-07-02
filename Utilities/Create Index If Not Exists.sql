IF NOT EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('[schema].[TableName]') AND NAME = 'IndexName')
BEGIN
    DECLARE @edition NVARCHAR(128);
    SET @edition = CAST(SERVERPROPERTY('Edition') AS NVARCHAR(128));
    IF @edition LIKE '%Standard%'
    BEGIN
        print 'standard';
        -- script here
    END
    ELSE
    BEGIN
        print 'enterprise';
        -- script here                                                                      
    END
END;
