USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ProductOutput')
    CREATE TABLE [dbo].[ProductOutput]
    (
	    [ProductOutputID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [TreeSpeciesID] UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES [dbo].[TreeSpecies] ([TreeSpeciesID]),
        [AvgDiameter] FLOAT NOT NULL,
        [AvgHeight] FLOAT NOT NULL,
        [LargePercent] FLOAT 
            DEFAULT(0),
        [MediumPercent1] FLOAT 
            DEFAULT(0),
        [MediumPercent2] FLOAT
            DEFAULT(0),
        [MediumPercentTotal] AS ([MediumPercent1] + [MediumPercent2]),
        CONSTRAINT [chk_UniqueProductionOutput] UNIQUE([TreeSpeciesID], [AvgHeight], [AvgDiameter]),
        CONSTRAINT [chk_CorrectPercent] 
            CHECK (([LargePercent] BETWEEN 0 AND 100) 
                AND ([MediumPercent1] BETWEEN 0 AND 100) 
                AND ([MediumPercent2] BETWEEN 0 AND 100))
    )