IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE object_id = OBJECT_ID(N'[dbo].[StoredProcedureName]')
			AND type IN (
				N'P'
				,N'PC'
				)
		)
BEGIN
	DROP PROCEDURE [dbo].[StoredProcedureName]
END
GO
