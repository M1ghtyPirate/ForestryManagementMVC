USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetAvgForestryGrowth] (@ForestryID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @AvgGrowth FLOAT

	;WITH [GrowthAreas] AS 
	(
		SELECT SUM([TG].[Area]) * SUM([TG].[Volume]) / [dbo].[fn_GetAvgAge](@ForestryID, [TG].[TreeSpeciesID]) AS [GrowthPart],
			SUM([TG].[Area]) AS [GrowthArea]
		FROM [dbo].[view_TreeGroups] AS [TG]
		WHERE [TG].[ForestryID] = @ForestryID
		GROUP BY [TG].[TreeSpeciesID]
	)

	SELECT @AvgGrowth = SUM([GrowthPart]) / SUM([GrowthArea])
	FROM [GrowthAreas]

	RETURN @AvgGrowth
END
GO