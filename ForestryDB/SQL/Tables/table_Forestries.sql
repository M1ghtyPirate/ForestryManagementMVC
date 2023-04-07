USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Forestries')
    CREATE TABLE [dbo].[Forestries]
    (
	    [ForestryID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [Name] NVARCHAR(256) NOT NULL,  
        [AuthorID] UNIQUEIDENTIFIER NOT NULL,
        [CreationDate] DATETIME
            DEFAULT (GETDATE()),
        [EditDate] DATETIME,
        [IsShared] BIT
    )