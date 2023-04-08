USE [forest]

GO
CREATE VIEW [dbo].[view_ForestryFellingPeriods]
AS
SELECT [SF].[ForestryID] AS [ForestryID],
    [SF].[ForestryName] AS [ForestryName],
    SUM([SF].[OperationalArea]) AS [OperationalArea],
    SUM([SF].[OperationalVolume]) AS [OperationalVolume],
    SUM([SF].[FellingOperationalArea]) AS [FellingOperationalArea],
    SUM([SF].[FellingOperationalVolume]) AS [FellingOperationalVolume],
    SUM([SF].[OperationalArea]) / SUM([SF].[FellingOperationalArea]) AS [FellingOperationalPeriod]
FROM [dbo].[view_SectionsFellingPeriods] AS [SF]
GROUP BY [SF].[ForestryID], [SF].[ForestryName]
GO

--DROP VIEW [dbo].[view_ForestryFellingPeriods]