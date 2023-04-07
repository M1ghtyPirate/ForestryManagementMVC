USE [forest]

GO
CREATE VIEW [dbo].[view_SectionsTotal]
AS
SELECT [TG].[ForestryID] AS [ForestryID],
    [TG].[ForestryName] AS [ForestryName],
    [Se].[SectionID] AS [SectionID],
    [Se].[Name] AS [SectionName],
    [dbo].[fn_GetSectionTreeQualityGroups]([Se].[SectionID]) AS [TreeQualityGroups],
    SUM([TG].[Area]) AS [Area],
    SUM([TG].[Volume]) AS [Volume],
    [dbo].[fn_GetAvgSectionQuality]([Se].[SectionID]) AS [AvgQuality],
    [dbo].[fn_IsSectionHighTier]([Se].[SectionID]) AS [IsHigh],
    [dbo].[fn_IsSectionDeciduous]([Se].[SectionID]) AS [IsDeciduous],
    [dbo].[fn_GetAvgSectionAge]([Se].[SectionID]) AS [AvgAge],
    [dbo].[fn_GetSectionTreeSpecies]([Se].[SectionID]) AS [TreeSpeciesID],
    [dbo].[fn_GetTreeSpeciesName]([dbo].[fn_GetSectionTreeSpecies]([Se].[SectionID])) AS [TreeSpeciesName],
    [dbo].[fn_GetRipeAge]([dbo].[fn_GetSectionTreeSpecies]([Se].[SectionID]), [dbo].[fn_GetAvgSectionQuality]([Se].[SectionID])) AS [RipeAge],
    CASE
        WHEN [dbo].[fn_IsSectionHighTier]([Se].[SectionID]) = 1 THEN [dbo].[fn_GetTechnicalAge]([dbo].[fn_GetSectionTreeSpecies]([Se].[SectionID]), [dbo].[fn_GetAvgSectionQuality]([Se].[SectionID]))
        ELSE NULL
    END AS [TechnicalAge]
     
FROM [dbo].[view_TreeGroups] AS [TG]
    JOIN [dbo].[Sections] AS [Se]
        ON [TG].[SectionID] = [Se].[SectionID]
GROUP BY [TG].[ForestryID], [TG].[ForestryName], [Se].[SectionID], [Se].[Name]
GO

--DROP VIEW [dbo].[view_SectionsTotal]