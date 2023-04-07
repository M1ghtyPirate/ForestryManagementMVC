USE [forest]

GO
CREATE VIEW [dbo].[view_ForestryTreeSpecies]
AS
SELECT [ForestryID],
	[ForestryName],
	[TreeSpeciesID],
	[TreeSpeciesName],
	SUM([Area]) AS [Area],
	[dbo].[fn_GetAvgQuality]([ForestryID], [TreeSpeciesID]) AS [AvgQuality],
	[dbo].[fn_GetAvgAge]([ForestryID], [TreeSpeciesID]) AS [AvgAge],
	SUM([Volume]) AS [Volume],
	SUM([Volume]) / SUM([Area]) AS [AvgVolume],
	SUM([Volume]) / [dbo].[fn_GetAvgAge]([ForestryID], [TreeSpeciesID]) AS [AvgGrowth],
	SUM([Volume]) / [dbo].[fn_GetAvgAge]([ForestryID], [TreeSpeciesID]) / SUM([Area]) AS [AvgGrowthPerHectare],
	[dbo].[fn_GetOperationalArea]([ForestryID], [TreeSpeciesID]) AS [OperationalArea],
	[dbo].[fn_GetOperationalVolume]([ForestryID], [TreeSpeciesID]) AS [OperationalVolume],
	[dbo].[fn_GetOperationalVolume]([ForestryID], [TreeSpeciesID]) / [dbo].[fn_GetOperationalArea]([ForestryID], [TreeSpeciesID]) AS [AvgOperationalVolume]
FROM [dbo].[view_TreeGroups] AS [TG]
GROUP BY [TG].[ForestryID], [TG].[ForestryName], [TG].[TreeSpeciesID], [TG].[TreeSpeciesName]
GO