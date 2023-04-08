USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingOperationalPeriod] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @OperationalArea FLOAT
	DECLARE @MinDif FLOAT
	DECLARE @Period FLOAT

	SELECT @OperationalArea = [dbo].[fn_GetSectionOperationalArea](@SectionID)

	DECLARE @Fellings TABLE
	(
		[Area] FLOAT
	)

	INSERT INTO @Fellings
	VALUES ([dbo].[fn_GetFellingRipeArea](@SectionID)),
		([dbo].[fn_GetFellingAgeFirstArea](@SectionID)),
		([dbo].[fn_GetFellingAgeSecondArea](@SectionID)),
		([dbo].[fn_GetFellingAvgGrowthArea](@SectionID)),
		([dbo].[fn_GetFellingStateArea](@SectionID)),
		([dbo].[fn_GetFellingCycleArea](@SectionID))

	SELECT @MinDif = MIN(ABS(20 - @OperationalArea / [Area]))
	FROM @Fellings

	SELECT @Period = @OperationalArea / [Area]
	FROM @Fellings
	WHERE ABS(20 - @OperationalArea / [Area]) = @MinDif

	RETURN @Period
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingOperationalPeriod]