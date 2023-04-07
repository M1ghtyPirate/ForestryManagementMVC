USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetForestryOperationalVolume] (@ForestryID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @OperationalVolume FLOAT

	SET @OperationalVolume = 0

	SELECT @OperationalVolume += [dbo].[fn_GetOperationalVolume](@ForestryID, [TG].[TreeSpeciesID])
	FROM [dbo].[view_TreeGroups] AS [TG]
	WHERE [TG].[ForestryID] = @ForestryID
	GROUP BY [TG].[TreeSpeciesID]

	RETURN @OperationalVolume
END
GO