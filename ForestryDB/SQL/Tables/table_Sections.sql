USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Sections')
    CREATE TABLE [dbo].[Sections]
    (
	    [SectionID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [Name] NVARCHAR(256) NOT NULL
    )