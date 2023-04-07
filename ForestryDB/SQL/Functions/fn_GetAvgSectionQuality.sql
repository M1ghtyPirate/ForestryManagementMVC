USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetAvgSectionQuality] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @AvgQuality FLOAT

	;WITH [QualityAreas] AS 
	(
		SELECT SUM([TG].[Area]) * [QC].[Number] AS [QualityPart],
			SUM([TG].[Area]) AS [QualityArea]
		FROM [dbo].[view_TreeGroups] AS [TG]
			JOIN [dbo].[QualityClasses] AS [QC]
				ON [TG].[QualityClassID] = [QC].[QualityClassID]
		WHERE [TG].[SectionID] = @SectionID
		GROUP BY [TG].[QualityClassID], [QC].[Number]
	)

	SELECT @AvgQuality = SUM([QualityPart]) / SUM([QualityArea])
	FROM [QualityAreas]

	RETURN @AvgQuality
END
GO