USE [forest]

GO
CREATE VIEW [dbo].[view_TreeQualityGroupsTotal]
AS
SELECT [TG].[ForestryID] AS [ForestryID],
    [TG].[ForestryName] AS [ForestryName],
    [TG].[TreeSpeciesID] AS [TreeSpeciesID],
    [TG].[TreeSpeciesName] AS [TreeSpeciesName],
    [TG].[QualityClassID] AS [QualityClassID],
    [TG].[QualityClass] AS [QualityClass],
    SUM([TG].[Area]) AS [Area],
    SUM([TG].[Volume]) AS [Volume]
FROM [dbo].[view_TreeGroups] AS [TG]
GROUP BY [TG].[ForestryID], [TG].[ForestryName], [TG].[TreeSpeciesID], [TG].[TreeSpeciesName], [TG].[QualityClassID], [TG].[QualityClass]
GO