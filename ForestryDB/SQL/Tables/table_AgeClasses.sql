USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AgeClasses')
    CREATE TABLE [dbo].[AgeClasses]
    (
	    [AgeClassID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [Number] INT NOT NULL UNIQUE,  
        [DeciduousMidAge] INT NOT NULL,
        [ConiferousMidAge] INT NOT NULL
    )