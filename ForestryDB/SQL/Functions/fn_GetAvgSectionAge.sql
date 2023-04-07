USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetAvgSectionAge] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @IsDeciduous BIT
	DECLARE @AvgAge FLOAT

	SELECT @IsDeciduous = [dbo].[fn_IsSectionDeciduous](@SectionID)

	;WITH [AgeAreas] AS 
	(
		SELECT SUM([TG].[Area]) * ([AC].[DeciduousMidAge] * @IsDeciduous + [AC].[ConiferousMidAge] * ~@IsDeciduous) AS [AgePart],
			SUM([TG].[Area]) AS [AgeArea]
		FROM [dbo].[view_TreeGroups] AS [TG]
			JOIN [dbo].[AgeClasses] AS [AC]
				ON [TG].[AgeClassID] = [AC].[AgeClassID]
		WHERE [TG].[SectionID] = @SectionID
		GROUP BY [TG].[AgeClassID], [AC].[DeciduousMidAge], [AC].[ConiferousMidAge]
	)
	SELECT @AvgAge = SUM([AgePart]) / SUM([AgeArea])
	FROM [AgeAreas]

	RETURN @AvgAge
END
GO