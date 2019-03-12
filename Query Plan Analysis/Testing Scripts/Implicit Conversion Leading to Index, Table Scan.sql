CREATE DATABASE PerformanceTraining
GO

USE PerformanceTraining
GO

CREATE TABLE [Employee] (
	[EmployeeID] [int] IDENTITY(1, 1) NOT NULL
	,[FirstName] VARCHAR(50)
	,[LastName] VARCHAR(50)
	,[City] VARCHAR(50)
	,[State] VARCHAR(40)
	,[Country] VARCHAR(40)
	,[BirthDate] DATETIME
	,[MaritalStatus] NCHAR(1)
	,[Gender] NCHAR(1)
	,[HireDate] DATETIME
	,[CreationDate] DATETIME
	,[ChangeDate] DATETIME
	)
GO

SET NOCOUNT ON

DECLARE @i INT
	,@State VARCHAR(40)
	,@MaritalStatus NCHAR(1)
	,@Gender NCHAR(1)

SET @i = 0

WHILE (@i < 500000)
BEGIN
	SELECT @i = @i + 1
		,@MaritalStatus = 'S'
		,@Gender = 'M'
		,@State = 'Karnataka'

	IF (@i % 2 = 0)
		SELECT @MaritalStatus = 'M'
			,@Gender = 'F'
			,@State = 'Maharashtra'

	INSERT INTO [PerformanceTraining].[dbo].[Employee] (
		[FirstName]
		,[LastName]
		,[City]
		,[State]
		,[Country]
		,[BirthDate]
		,[MaritalStatus]
		,[Gender]
		,[HireDate]
		,[CreationDate]
		,[ChangeDate]
		)
	VALUES (
		'FirstName' + CAST(@i AS VARCHAR)
		,'LastName' + CAST(@i AS VARCHAR)
		,'City' + CAST(@i AS VARCHAR)
		,@State
		,'INDIA'
		,DATEADD(DAY, @i / 1000, '01/01/1978')
		,@MaritalStatus
		,@Gender
		,DATEADD(DAY, @i / 1000, '01/01/2000 ' + CONVERT(VARCHAR(8), GETDATE(), 108))
		,DATEADD(DAY, @i / 1000, '01/01/2000')
		,DATEADD(DAY, @i / 1000, '01/01/2000')
		)

	IF @i = 500000
		UPDATE dbo.Employee
		WITH (ROWLOCK)

	SET HireDate = '2001-05-16 ' + CONVERT(VARCHAR(8), GETDATE(), 108)
	WHERE EmployeeID = @i
END
GO

CREATE INDEX IX_Employee_FirstName ON Employee (FirstName)
GO

CREATE PROCEDURE GetEmployeeByFirstName @FirstName NVARCHAR(50)
AS
BEGIN
	SELECT *
	FROM Employee
	WHERE FirstName = @FirstName
END
GO

EXEC GetEmployeeByFirstName 'FirstName4000';
GO

ALTER PROCEDURE GetEmployeeByFirstName @FirstName VARCHAR(50)
AS
BEGIN
	SELECT *
	FROM Employee
	WHERE FirstName = @FirstName
END
GO

--Another solution is to change the stored procedure as below:
ALTER PROCEDURE GetEmployeeByFirstName @FirstName NVARCHAR(50)
AS
BEGIN
	DECLARE @Name VARCHAR(50)

	SET @Name = @FirstName

	SELECT *
	FROM Employee
	WHERE FirstName = @Name
END

EXEC GetEmployeeByFirstName 'FirstName4000';
GO
