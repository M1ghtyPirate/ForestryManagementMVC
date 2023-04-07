USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetForestryOperationalArea] (@ForestryID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @OperationalArea FLOAT

	SET @OperationalArea = 0

	SELECT @OperationalArea += [dbo].[fn_GetOperationalArea](@ForestryID, [TG].[TreeSpeciesID])
	FROM [dbo].[view_TreeGroups] AS [TG]
	WHERE [TG].[ForestryID] = @ForestryID
	GROUP BY [TG].[TreeSpeciesID]

	RETURN @OperationalArea
END
GO