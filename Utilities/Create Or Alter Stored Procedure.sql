IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[schema].[StoredProcedureName]') AND type IN (N'P', N'PC'))
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [schema].[StoredProcedureName] AS'
END
GO

ALTER PROCEDURE [schema].[StoredProcedureName]
AS
BEGIN

-- BODY HERE

END
GO
