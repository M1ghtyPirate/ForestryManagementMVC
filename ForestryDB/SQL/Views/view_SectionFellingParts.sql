USE [forest]

GO
CREATE VIEW [dbo].[view_SectionFellingParts]
AS
SELECT [SP].[ForestryID] AS [ForestryID],
    [SP].[ForestryName] AS [ForestryName],
    [SP].[SectionID] AS [SectionID],
    [SP].[SectionName] AS [SectionName],
    [SP].[FellingOperationalArea] AS [FellingOperationalArea],
    [SP].[FellingOperationalVolume] AS [FellingOperationalVolume],
    100 * [SP].[FellingOperationalArea] / [FP].[FellingOperationalArea] AS [AreaPercent],
    100 * [SP].[FellingOperationalVolume] / [FP].[FellingOperationalVolume] AS [VolumePercent]
FROM [dbo].[view_SectionsFellingPeriods] AS [SP]
    JOIN [dbo].[view_ForestryFellingPeriods] AS [FP]
        ON [SP].[ForestryID] = [FP].[ForestryID]
GO

--DROP VIEW [dbo].[view_SectionFellingParts]