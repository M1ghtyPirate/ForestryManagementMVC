USE [forest]

GO
CREATE VIEW [dbo].[view_ForestryTreeSpeciesTotal]
AS
SELECT [ForestryID],
	[ForestryName],
	SUM([Area]) AS [Area],
	[dbo].[fn_GetAvgForestryQuality]([ForestryID]) AS [AvgQuality],
	SUM([Volume]) AS [Volume],
	SUM([Volume]) / SUM([Area]) AS [AvgVolume],
	[dbo].[fn_GetAvgForestryGrowth]([ForestryID]) AS [AvgGrowth],
	[dbo].[fn_GetAvgForestryGrowthPerHectare]([ForestryID]) AS [AvgGrowthPerHectare],
	[dbo].[fn_GetForestryOperationalArea]([ForestryID]) AS [OperationalArea],
	[dbo].[fn_GetForestryOperationalVolume]([ForestryID]) AS [OperationalVolume],
	[dbo].[fn_GetForestryOperationalVolume]([ForestryID]) / [dbo].[fn_GetForestryOperationalArea]([ForestryID]) AS [AvgOperationalVolume]
FROM [dbo].[view_TreeGroups] AS [TG]
GROUP BY [TG].[ForestryID], [TG].[ForestryName]
GO