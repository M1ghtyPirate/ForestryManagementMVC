USE [forest]

GO
CREATE VIEW [dbo].[view_SectionsFellingPeriods]
AS
SELECT [TG].[ForestryID] AS [ForestryID],
    [TG].[ForestryName] AS [ForestryName],
    [Se].[SectionID] AS [SectionID],
    [Se].[Name] AS [SectionName],
    [dbo].[fn_GetSectionOperationalArea]([Se].[SectionID]) AS [OperationalArea],
    [dbo].[fn_GetSectionOperationalVolume]([Se].[SectionID]) AS [OperationalVolume],
    [dbo].[fn_GetFellingOperationalArea]([Se].[SectionID]) AS [FellingOperationalArea],
    [dbo].[fn_GetFellingOperationalVolume]([Se].[SectionID]) AS [FellingOperationalVolume],
    [dbo].[fn_GetFellingOperationalPeriod]([Se].[SectionID]) AS [FellingOperationalPeriod]
FROM [dbo].[view_TreeGroups] AS [TG]
    JOIN [dbo].[Sections] AS [Se]
        ON [TG].[SectionID] = [Se].[SectionID]
GROUP BY [TG].[ForestryID], [TG].[ForestryName], [Se].[SectionID], [Se].[Name]
GO

--DROP VIEW [dbo].[view_SectionsFellingPeriods]