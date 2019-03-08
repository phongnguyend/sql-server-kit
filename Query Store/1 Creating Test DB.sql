/*
	Create a database to use for testing
*/
DROP DATABASE IF EXISTS [Movies];
GO

CREATE DATABASE [Movies]
	ON  PRIMARY 
	(NAME = N'Movies', FILENAME = N'C:\Databases\Movies\Movies.mdf' , 
	SIZE = 262144KB , FILEGROWTH = 65536KB )
	LOG ON 
	(NAME = N'Movies_log', FILENAME = N'C:\Databases\Movies\Movies_log.ldf' , 
	SIZE = 131072KB , FILEGROWTH = 65536KB );
GO

ALTER DATABASE [Movies] SET RECOVERY SIMPLE;
GO

/*
	Create a table and add some data
*/
USE [Movies];
GO

CREATE TABLE [dbo].[MovieInfo] (
	[MovieID] INT IDENTITY(1,1) PRIMARY KEY, 
	[MovieName] VARCHAR(800), 
	[ReleaseDate] SMALLDATETIME,
	[Rating] VARCHAR(5)
	);
GO

INSERT INTO [dbo].[MovieInfo] ( 
	[MovieName], [ReleaseDate], [Rating]
	)
VALUES
	('IronMan', '2008-05-02 00:00:00', 'PG-13'),
	('Joy', '2016-12-25', 'PG-13'),
	('Caddyshack', '1980-07-25', 'R'),
	('The Martian', '2015-10-02', 'PG-13'),
	('Apollo 13', '1995-05-30 00:00:00', 'PG'),
	('The Hunt for Red October', '1990-03-02 00:00:00', 'PG'),
	('A Few Good Men', '1994-12-11 00:00:00', 'R'),
	('Memento', '2000-10-11', 'R'),
	('The Truman Show', '1998-06-05 00:00:00', 'PG-13'),
	('All The President''s Men', '1976-04-09 00:00:00', 'R'),
	('The Right Stuff', '1983-10-21 00:00:00', 'PG-13'),
	('The Blind Side', '2009-11-20', 'PG-13'),
	('The Natural', '1984-05-11 00:00:00', 'PG'),
	('The Hangover', '2009-06-05 00:00:00', 'R'),
	('The Incredibles', '2004-11-05 00:00:00', 'PG');
GO


CREATE TABLE [dbo].[Actors](
	[ActorID] INT IDENTITY(1,1) PRIMARY KEY, 
	[FirstName] VARCHAR(100), 
	[LastName] VARCHAR(200),
	[DOB] SMALLDATETIME
	);
GO

INSERT INTO [dbo].[Actors](
	[FirstName], [LastName], [DOB]
	)
VALUES
	('Jennifer', 'Lawrence', '1990-08-15'),
	('Robert', 'Redford', '1936-08-18'),
	('Demi', 'Moore', '1962-11-11'),
	('Alec', 'Baldwin', '1958-01-03'),
	('Sandra', 'Bullock', '1964-07-26'),
	('Tom', 'Hanks', '1956-07-09');
GO

CREATE TABLE [dbo].[Cast](
	[MovieID] INT,
	[ActorID] INT
	);
GO

INSERT INTO [dbo].[Cast](
	[MovieID], [ActorID])
VALUES
	(2, 1),
	(10, 2),
	(13, 2),
	(7, 3),
	(6, 4),
	(12, 5),
	(5, 6);
GO
