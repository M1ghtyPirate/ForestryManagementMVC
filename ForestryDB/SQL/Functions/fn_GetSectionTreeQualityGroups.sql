USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetSectionTreeQualityGroups] (@SectionID UNIQUEIDENTIFIER)
RETURNS NVARCHAR(4000)
AS
BEGIN
	DECLARE @TreeQualityGroups NVARCHAR(4000)

	;WITH [QualityGroups] AS
	(
		SELECT DISTINCT [TG].[QualityClass],
			[TG].[TreeSpeciesName]
		FROM [dbo].[view_TreeGroups] AS [TG]
		WHERE [TG].[SectionID] = @SectionID
	)

	SELECT @TreeQualityGroups =  
			CASE 
				WHEN (@TreeQualityGroups IS NULL) THEN ([TreeSpeciesName] + ' ' + CAST([QualityClass] AS NVARCHAR(4000)))
				WHEN (@TreeQualityGroups LIKE ('%' + [TreeSpeciesName] + '%')) THEN (@TreeQualityGroups + ' ' + CAST([QualityClass] AS NVARCHAR(4000)))
				ELSE (@TreeQualityGroups + ' ' + [TreeSpeciesName] + ' ' + CAST([QualityClass] AS NVARCHAR(4000)))
			END
	FROM [QualityGroups]

	RETURN @TreeQualityGroups
END
GO