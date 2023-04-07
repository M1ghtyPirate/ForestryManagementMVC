USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingAvgGrowthVolume] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @Volume FLOAT

	SELECT @Volume = SUM([AvgGrowth])
	FROM [dbo].[view_SectionFellingAgeGroups]
	WHERE [SectionID] = @SectionID

	RETURN @Volume
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingAvgGrowthVolume]