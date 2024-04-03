IF NOT EXISTS (
		SELECT *
		FROM sys.objects
		WHERE object_id = OBJECT_ID(N'[dbo].[StoredProcedureName]')
			AND type IN (
				N'P'
				,N'PC'
				)
		)
BEGIN
	EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[StoredProcedureName] AS'
END
GO

ALTER PROCEDURE [dbo].[StoredProcedureName]
AS
BEGIN

-- BODY HERE

END
GO
