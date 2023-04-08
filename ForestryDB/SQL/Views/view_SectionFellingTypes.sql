USE [forest]

GO
CREATE VIEW [dbo].[view_SectionFellingTypes]
AS
SELECT [AG].[ForestryID] AS [ForestryID],
    [AG].[ForestryName] AS [ForestryName],
    [AG].[SectionID] AS [SectionID],
    [AG].[SectionName] AS [SecionName],
    [dbo].[fn_GetFellingOperationalVolume]([AG].[SectionID]) AS [FellingOperationalVolume],
    SUM([AG].[Area]) AS [Area],
    [dbo].[fn_GetFellingOperationalVolume]([AG].[SectionID]) / SUM([AG].[Area]) AS [OperationalVolumePerHectare],
    SUM([AG].[AvgGrowth]) AS [AvgGrowth],
    SUM([AG].[AvgGrowth]) / SUM([AG].[Area]) AS [AvgGrowthPerHectare],
    CASE
        WHEN [dbo].[fn_GetFellingOperationalVolume]([AG].[SectionID]) / SUM([AG].[Area]) > SUM([AG].[AvgGrowth]) / SUM([AG].[Area]) THEN N'Истощение запаса'
        WHEN [dbo].[fn_GetFellingOperationalVolume]([AG].[SectionID]) / SUM([AG].[Area]) < SUM([AG].[AvgGrowth]) / SUM([AG].[Area]) THEN N'Накапливание запаса'
        ELSE N'Рубка по приросту'
    END AS [FellingType]
FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
GROUP BY [AG].[ForestryID], [AG].[ForestryName], [AG].[SectionID], [AG].[SectionName]
GO

--DROP VIEW [dbo].[view_SectionFellingTypes]