USE [forest]

GO
CREATE VIEW [dbo].[view_SectionsFellingVariants]
AS
SELECT [AG].[ForestryID] AS [ForestryID],
    [AG].[ForestryName] AS [ForestryName],
    [AG].[SectionID] AS [SectionID],
    [AG].[SectionName] AS [SectionName],
    SUM([AG].[Area]) AS [Area],
    SUM([AG].[Volume]) AS [Volume],
    SUM([AG].[AvgGrowth]) AS [AvgGrowth],
    [dbo].[fn_GetAgeClassMinAge]([dbo].[fn_GetMainFellingAgeClass]([AG].[SectionID]), [dbo].[fn_IsSectionDeciduous]([AG].[SectionID])) AS [MainFellingAge],
    [dbo].[fn_GetMainFellingAgeClass]([AG].[SectionID]) AS [MainFellingAgeClass],
    [dbo].[fn_GetAvgSectionOperationalVolumePerHectare]([AG].[SectionID]) AS [AvgOperationalVolumePerHectare],
    [dbo].[fn_GetOverdueSectionVolume]([AG].[SectionID]) AS [OverdueVolume],
    [dbo].[fn_GetOverdueSectionArea]([AG].[SectionID]) AS [OverdueArea],
    [dbo].[fn_GetFellingRipeArea]([AG].[SectionID]) AS [FellingRipeArea],
    [dbo].[fn_GetFellingRipeVolume]([AG].[SectionID]) AS [FellingRipeVolume],
    [dbo].[fn_GetFellingAgeFirstArea]([AG].[SectionID]) AS [FellingAgeFirstArea],
    [dbo].[fn_GetFellingAgeFirstVolume]([AG].[SectionID]) AS [FellingAgeFirstVolume],
    [dbo].[fn_GetFellingAgeSecondArea]([AG].[SectionID]) AS [FellingAgeSecondArea],
    [dbo].[fn_GetFellingAgeSecondVolume]([AG].[SectionID]) AS [FellingAgeSecondVolume],
    [dbo].[fn_GetFellingAvgGrowthArea]([AG].[SectionID]) AS [FellingAvgGrowthArea],
    SUM([AG].[AvgGrowth]) AS [FellingAvgGrowthVolume],
    [dbo].[fn_GetFellingStateArea]([AG].[SectionID]) AS [FellingStateArea],
    [dbo].[fn_GetFellingStateVolume]([AG].[SectionID]) AS [FellingStateVolume],
    [dbo].[fn_GetFellingCycleArea]([AG].[SectionID]) AS [FellingCycleArea],
    [dbo].[fn_GetFellingCycleVolume]([AG].[SectionID]) AS [FellingCycleVolume]
FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
GROUP BY [AG].[ForestryID], [AG].[ForestryName], [AG].[SectionID], [AG].[SectionName]
GO

--DROP VIEW [dbo].[view_SectionsFellingVariants]