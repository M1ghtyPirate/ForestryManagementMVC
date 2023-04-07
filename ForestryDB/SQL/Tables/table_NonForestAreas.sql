USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='NonForestAreas')
    CREATE TABLE [dbo].[NonForestAreas]
    (
	    [NonForestAreaID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [ForestryID] UNIQUEIDENTIFIER NOT NULL UNIQUE FOREIGN KEY REFERENCES [dbo].[Forestries] ([ForestryID]),  
        [Field] FLOAT
            DEFAULT(0),  
        [Pasture] FLOAT
            DEFAULT(0), 
        [Water] FLOAT
            DEFAULT(0), 
        [Road] FLOAT
            DEFAULT(0),
        [House] FLOAT
            DEFAULT(0),
        [Swamp] FLOAT
            DEFAULT(0),
        [Other] FLOAT
            DEFAULT(0),
        [Total] AS [Field] + [Pasture] + [Water] + [Road] + [House] + [Swamp] + [Other]
    )