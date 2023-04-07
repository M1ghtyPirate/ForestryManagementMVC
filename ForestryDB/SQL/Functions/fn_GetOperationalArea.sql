USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetOperationalArea] (@ForestryID UNIQUEIDENTIFIER, @TreeSpeciesID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @OperationalAgeClass FLOAT
	DECLARE @OperationalArea FLOAT

	SELECT @OperationalAgeClass = [OperationalAgeClass] FROM [dbo].[TreeSpecies] WHERE [TreeSpeciesID] = @TreeSpeciesID

	SELECT @OperationalArea = SUM([TG].[Area])
	FROM [dbo].[view_TreeGroups] AS [TG]
		JOIN [dbo].[AgeClasses] AS [AC]
			ON [TG].[AgeClassID] = [AC].[AgeClassID]
	WHERE [TG].[ForestryID] = @ForestryID AND [TG].[TreeSpeciesID] = @TreeSpeciesID AND [AC].[Number] >= @OperationalAgeClass

	RETURN @OperationalArea
END
GO