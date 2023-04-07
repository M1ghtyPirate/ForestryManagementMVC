USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='GrowthRate')
    CREATE TABLE [dbo].[GrowthRate]
    (
	    [GrowthRateID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [TreeSpeciesID] UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES [dbo].[TreeSpecies] ([TreeSpeciesID]),
        [QualityClassID] UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES [dbo].[QualityClasses] ([QualityClassID]),
        [Age] INT NOT NULL,
        [AvgHeight] FLOAT NOT NULL,
        [AvgDiameter] FLOAT NOT NULL,
        [VolumePerHectare] FLOAT NOT NULL,
        [AvgGrowth] FLOAT NOT NULL,
        [CurrentGrowth] FLOAT
            DEFAULT(0),
        CONSTRAINT [chk_UniqueGrowthRate] UNIQUE([TreeSpeciesID], [QualityClassID], [Age])
    )