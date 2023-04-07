USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='QualityClasses')
    CREATE TABLE [dbo].[QualityClasses]
    (
	    [QualityClassID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [Number] INT NOT NULL UNIQUE,  
        [IsHigh] BIT NOT NULL
    )