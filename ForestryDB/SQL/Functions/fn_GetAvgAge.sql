USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetAvgAge] (@ForestryID UNIQUEIDENTIFIER, @TreeSpeciesID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @IsDeciduous BIT
	DECLARE @AvgAge FLOAT

	SELECT @IsDeciduous = [IsDeciduous] FROM [dbo].[TreeSpecies] WHERE [TreeSpeciesID] = @TreeSpeciesID

	;WITH [AgeAreas] AS 
	(
		SELECT SUM([TG].[Area]) * ([AC].[DeciduousMidAge] * @IsDeciduous + [AC].[ConiferousMidAge] * ~@IsDeciduous) AS [AgePart],
			SUM([TG].[Area]) AS [AgeArea]
		FROM [dbo].[view_TreeGroups] AS [TG]
			JOIN [dbo].[AgeClasses] AS [AC]
				ON [TG].[AgeClassID] = [AC].[AgeClassID]
		WHERE [TG].[ForestryID] = @ForestryID AND [TG].[TreeSpeciesID] = @TreeSpeciesID
		GROUP BY [TG].[AgeClassID], [AC].[DeciduousMidAge], [AC].[ConiferousMidAge]
	)
	SELECT @AvgAge = SUM([AgePart]) / SUM([AgeArea])
	FROM [AgeAreas]

	RETURN @AvgAge
END
GO