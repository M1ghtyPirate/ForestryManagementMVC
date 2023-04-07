USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TreeQualityGroups')
    CREATE TABLE [dbo].[TreeQualityGroups]
    (
	    [TreeQualityGroupID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [ForestryID] UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES [dbo].[Forestries] ([ForestryID]),
        [TreeSpeciesID] UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES [dbo].[TreeSpecies] ([TreeSpeciesID]),
        [QualityClassID] UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES [dbo].[QualityClasses] ([QualityClassID]),
        [SectionID] UNIQUEIDENTIFIER FOREIGN KEY REFERENCES [dbo].[Sections] ([SectionID]),
        CONSTRAINT [chk_UniqueQualityGroups] UNIQUE([ForestryID], [TreeSpeciesID], [QualityClassID])
    )