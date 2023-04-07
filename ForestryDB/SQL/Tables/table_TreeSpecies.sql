USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TreeSpecies')
    CREATE TABLE [dbo].[TreeSpecies]
    (
	    [TreeSpeciesID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [Name] NVARCHAR(256) NOT NULL UNIQUE,  
        [IsDeciduous] BIT NOT NULL,
        [OperationalAgeClass] INT NOT NULL,
        [OptimalFellingAge] INT NOT NULL
    )