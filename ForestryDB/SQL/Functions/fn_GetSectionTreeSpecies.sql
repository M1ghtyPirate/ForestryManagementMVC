USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetSectionTreeSpecies] (@SectionID UNIQUEIDENTIFIER)
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @MainSpeciesID UNIQUEIDENTIFIER

	;WITH [TreeAreas] AS 
	(
		SELECT [TG].[TreeSpeciesID],
			SUM([TG].[Area]) AS [Area]
		FROM [dbo].[view_TreeGroups] AS [TG]
		WHERE [TG].[SectionID] = @SectionID
		GROUP BY [TG].[TreeSpeciesID], [TG].[TreeSpeciesName]
	)

	SELECT @MainSpeciesID = [TreeSpeciesID]
	FROM [TreeAreas]
	WHERE [Area] = 
		(
			SELECT MAX([Area])
			FROM [TreeAreas]
		)

	RETURN @MainSpeciesID
END
GO