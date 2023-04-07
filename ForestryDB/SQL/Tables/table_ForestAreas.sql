USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ForestAreas')
    CREATE TABLE [dbo].[ForestAreas]
    (
	    [ForestAreaID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [ForestryID] UNIQUEIDENTIFIER NOT NULL UNIQUE FOREIGN KEY REFERENCES [dbo].[Forestries] ([ForestryID]),  
        [Forest] AS [dbo].[fn_GetTotalForestArea]([ForestryID]),  
        [Felling] FLOAT
            DEFAULT(0), 
        [Burnt] FLOAT
            DEFAULT(0), 
        [Empty] FLOAT
            DEFAULT(0),
        [Thin] FLOAT
            DEFAULT(0),
        [TotalNonForest] AS [Felling] + [Burnt] + [Empty] + [Thin],
        [Total] AS [dbo].[fn_GetTotalForestArea]([ForestryID]) + [Felling] + [Burnt] + [Empty] + [Thin]
    )