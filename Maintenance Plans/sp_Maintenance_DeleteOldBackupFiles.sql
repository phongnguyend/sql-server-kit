IF EXISTS (
		SELECT *
		FROM sys.objects
		WHERE object_id = OBJECT_ID(N'[dbo].[sp_Maintenance_DeleteOldBackupFiles]')
			AND type IN (
				N'P'
				,N'PC'
				)
		)
	DROP PROCEDURE [dbo].[sp_Maintenance_DeleteOldBackupFiles]
GO

CREATE PROCEDURE [dbo].[sp_Maintenance_DeleteOldBackupFiles]
	@path NVARCHAR(256), 
	@extension NVARCHAR(10), 
	@age_hrs INT
AS 
BEGIN 
	SET NOCOUNT ON; 
	DECLARE @DeleteDateTime DATETIME = DateAdd(hh, - @age_hrs, GetDate()) 
	DECLARE @DeleteDate NVARCHAR(50) = (Select Replace(Convert(nvarchar, @DeleteDateTime, 111), '/', '-') + 'T' + Convert(nvarchar, @DeleteDateTime, 108)) 
	EXECUTE master.dbo.xp_delete_file 0, @path, @extension, @DeleteDate, 1 
END

/*

[dbo].[sp_Maintenance_DeleteOldBackupFiles] 'C:\Data\Backup', 'bak', 168

*/
