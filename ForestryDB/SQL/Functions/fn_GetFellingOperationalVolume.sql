USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingOperationalVolume] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @OperationalVolume FLOAT
	DECLARE @MinDif FLOAT
	DECLARE @Volume FLOAT

	SELECT @OperationalVolume = [dbo].[fn_GetSectionOperationalVolume](@SectionID)

	DECLARE @Fellings TABLE
	(
		[Volume] FLOAT
	)

	INSERT INTO @Fellings
	VALUES ([dbo].[fn_GetFellingRipeVolume](@SectionID)),
		([dbo].[fn_GetFellingAgeFirstVolume](@SectionID)),
		([dbo].[fn_GetFellingAgeSecondVolume](@SectionID)),
		([dbo].[fn_GetFellingAvgGrowthVolume](@SectionID)),
		([dbo].[fn_GetFellingStateVolume](@SectionID)),
		([dbo].[fn_GetFellingCycleVolume](@SectionID))

	SELECT @MinDif = MIN(ABS(20 - @OperationalVolume / [Volume]))
	FROM @Fellings

	SELECT @Volume = [Volume]
	FROM @Fellings
	WHERE ABS(20 - @OperationalVolume / [Volume]) = @MinDif

	RETURN @Volume
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingOperationalVolume]