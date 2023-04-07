USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingCycleVolume] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @CycleVolume FLOAT

	SET @CycleVolume = [dbo].[fn_GetFellingCycleArea](@SectionID) * [dbo].[fn_GetAvgSectionOperationalVolumePerHectare](@SectionID)

	RETURN @CycleVolume
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingCycleVolume]