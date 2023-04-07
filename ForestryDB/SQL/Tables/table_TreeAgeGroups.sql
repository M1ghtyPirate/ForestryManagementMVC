USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TreeAgeGroups')
    CREATE TABLE [dbo].[TreeAgeGroups]
    (
	    [TreeAgeGroupID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [TreeQualityGroupID] UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES [dbo].[TreeQualityGroups] ([TreeQualityGroupID]),
        [AgeClassID] UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES [dbo].[AgeClasses] ([AgeClassID]),
        [Area] FLOAT
            DEFAULT(0),
        [Volume] FLOAT
            DEFAULT(0),
        CONSTRAINT [chk_UniqueAgeGroups] UNIQUE([TreeQualityGroupID], [AgeClassID])
    )