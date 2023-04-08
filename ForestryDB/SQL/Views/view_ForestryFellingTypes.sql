USE [forest]

GO
CREATE VIEW [dbo].[view_ForestryFellingTypes]
AS
SELECT [SF].[ForestryID] AS [ForestryID],
    [SF].[ForestryName] AS [ForestryName],
    SUM([SF].[FellingOperationalVolume]) AS [FellingOperationalVolume],
    SUM([SF].[Area]) AS [Area],
    SUM([SF].[FellingOperationalVolume]) / SUM([SF].[Area]) AS [OperationalVolumePerHectare],
    SUM([SF].[AvgGrowth]) AS [AvgGrowth],
    SUM([SF].[AvgGrowth]) / SUM([SF].[Area]) AS [AvgGrowthPerHectare],
    CASE
        WHEN SUM([SF].[FellingOperationalVolume]) / SUM([SF].[Area]) > SUM([SF].[AvgGrowth]) / SUM([SF].[Area]) THEN N'Истощение запаса'
        WHEN SUM([SF].[FellingOperationalVolume]) / SUM([SF].[Area]) < SUM([SF].[AvgGrowth]) / SUM([SF].[Area]) THEN N'Накапливание запаса'
        ELSE N'Рубка по приросту'
    END AS [FellingType]
FROM [dbo].[view_SectionFellingTypes] AS [SF]
GROUP BY [SF].[ForestryID], [SF].[ForestryName]
GO

--DROP VIEW [dbo].[view_ForestryFellingTypes]