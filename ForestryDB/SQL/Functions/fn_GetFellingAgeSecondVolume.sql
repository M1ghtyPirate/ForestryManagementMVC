USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingAgeSecondVolume] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @AgeFirstArea FLOAT

	SET @AgeFirstArea = [dbo].[fn_GetFellingAgeSecondArea](@SectionID) * [dbo].[fn_GetAvgSectionOperationalVolumePerHectare](@SectionID)

	RETURN @AgeFirstArea
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingAgeSecondVolume]