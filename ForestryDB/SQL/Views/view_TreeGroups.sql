USE [forest]

GO
CREATE VIEW [dbo].[view_TreeGroups]
AS
SELECT [Fo].[ForestryID] AS [ForestryID],
    [Fo].[Name] AS [ForestryName],
    [TS].[TreeSpeciesID] AS [TreeSpeciesID],
    [TS].[Name] AS [TreeSpeciesName],
    [TS].[IsDeciduous] AS [IsDeciduous],
    [QC].[QualityClassID] AS [QualityClassID],
    [QC].[Number] AS [QualityClass],
    [QC].[IsHigh] AS [IsHigh],
    [AC].[AgeClassID] AS [AgeClassID],
    [AC].[Number] AS [AgeClass],
    [TA].[Area] AS [Area],
    [TA].[Volume] AS [Volume],
    [TQ].[SectionID] AS [SectionID]
FROM [dbo].[Forestries] AS [Fo]
    JOIN [dbo].[TreeQualityGroups] AS [TQ]
        ON [Fo].[ForestryID] = [TQ].[ForestryID]
    JOIN [dbo].[TreeSpecies] AS [TS]
        ON [TQ].[TreeSpeciesID] = [TS].[TreeSpeciesID]
    JOIN [dbo].[QualityClasses] AS [QC]
        ON [TQ].[QualityClassID] = [QC].[QualityClassID]
    JOIN [dbo].[TreeAgeGroups] AS [TA]
        ON [TQ].[TreeQualityGroupID] = [TA].[TreeQualityGroupID]
    JOIN [dbo].[AgeClasses] AS [AC]
        ON [TA].[AgeClassID] = [AC].[AgeClassID]
GO