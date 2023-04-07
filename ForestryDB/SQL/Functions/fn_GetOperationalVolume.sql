USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetOperationalVolume] (@ForestryID UNIQUEIDENTIFIER, @TreeSpeciesID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @OperationalAgeClass FLOAT
	DECLARE @OperationalVolume FLOAT

	SELECT @OperationalAgeClass = [OperationalAgeClass] FROM [dbo].[TreeSpecies] WHERE [TreeSpeciesID] = @TreeSpeciesID

	SELECT @OperationalVolume = SUM([TG].[Volume])
	FROM [dbo].[view_TreeGroups] AS [TG]
		JOIN [dbo].[AgeClasses] AS [AC]
			ON [TG].[AgeClassID] = [AC].[AgeClassID]
	WHERE [TG].[ForestryID] = @ForestryID AND [TG].[TreeSpeciesID] = @TreeSpeciesID AND [AC].[Number] >= @OperationalAgeClass

	RETURN @OperationalVolume
END
GO