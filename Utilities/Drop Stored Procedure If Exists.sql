IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE object_id = OBJECT_ID(N'[schema].[StoredProcedureName]')
			AND type IN (
				N'P'
				,N'PC'
				)
		)
BEGIN
	DROP PROCEDURE [schema].[StoredProcedureName]
END
GO
