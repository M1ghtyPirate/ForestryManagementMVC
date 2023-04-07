USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingAvgGrowthArea] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @AvgGrowth FLOAT
	DECLARE @Area FLOAT

	SELECT @AvgGrowth = SUM([AG].[AvgGrowth])
	FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID

	SET @Area = @AvgGrowth / [dbo].[fn_GetAvgSectionOperationalVolumePerHectare](@SectionID)

	RETURN @Area
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingAvgGrowthArea]