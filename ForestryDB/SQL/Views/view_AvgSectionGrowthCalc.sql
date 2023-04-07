USE [forest]

GO
CREATE VIEW [dbo].[view_AvgSectionGrowthCalc]
AS
SELECT [TS].[TreeSpeciesID] AS [TreeSpeciesID],
    [TS].[Name] AS [TreeSpeciesName],
    [QC].[QualityClassID] AS [QualityClassID],
    [QC].[Number] AS [QualityClass],
    [GR].[Age] AS [Age],
    [GR].[AvgHeight] AS [AvgHeight],
    [GR].[AvgDiameter] AS [AvgDiameter],
    [GR].[AvgGrowth] AS [AvgGrowth],
    [GR].[CurrentGrowth] AS [CurrentGrowth],
    [GR].[VolumePerHectare] AS [VolumePerHectare],
    [dbo].[fn_GetLargeOutputPercent]([TS].[TreeSpeciesID], [AvgDiameter], [AvgHeight]) AS [LargeOutputPercent],
    [GR].[VolumePerHectare] * [dbo].[fn_GetLargeOutputPercent]([TS].[TreeSpeciesID], [AvgDiameter], [AvgHeight]) / 100 AS [LargeVolume],
    [GR].[VolumePerHectare] * [dbo].[fn_GetLargeOutputPercent]([TS].[TreeSpeciesID], [AvgDiameter], [AvgHeight]) / 100 / [GR].[Age] AS [LargeAvgGrowth],
    [dbo].[fn_GetMediumOutputPercent]([TS].[TreeSpeciesID], [AvgDiameter], [AvgHeight]) AS [MediumOutputPercent],
    [GR].[VolumePerHectare] * [dbo].[fn_GetMediumOutputPercent]([TS].[TreeSpeciesID], [AvgDiameter], [AvgHeight]) / 100 AS [MediumVolume],
    [GR].[VolumePerHectare] * [dbo].[fn_GetMediumOutputPercent]([TS].[TreeSpeciesID], [AvgDiameter], [AvgHeight]) / 100 / [GR].[Age] AS [MediumAvgGrowth],
    [GR].[VolumePerHectare] * [dbo].[fn_GetLargeOutputPercent]([TS].[TreeSpeciesID], [AvgDiameter], [AvgHeight]) / 100 / [GR].[Age] + [GR].[VolumePerHectare] * [dbo].[fn_GetMediumOutputPercent]([TS].[TreeSpeciesID], [AvgDiameter], [AvgHeight]) / 100 / [GR].[Age] AS [AvgProductGrowth]
FROM [dbo].[GrowthRate] AS [GR]
    JOIN [dbo].[TreeSpecies] AS [TS]
        ON [GR].[TreeSpeciesID] = [TS].[TreeSpeciesID]
    JOIN [dbo].[QualityClasses] AS [QC]
        ON [GR].[QualityClassID] = [QC].[QualityClassID]
GO

--DROP VIEW [dbo].[view_AvgSectionGrowthCalc]