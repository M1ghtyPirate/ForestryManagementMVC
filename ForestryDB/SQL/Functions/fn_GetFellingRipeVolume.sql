USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingRipeVolume] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MainFellingAgeClass INT
	DECLARE @AgeClassPeriod INT
	DECLARE @OperationalVolume FLOAT

	SET @MainFellingAgeClass = [dbo].[fn_GetMainFellingAgeClass](@SectionID)
	SET @AgeClassPeriod = 
		CASE
			WHEN [dbo].[fn_IsSectionDeciduous](@SectionID) = 1 THEN 10
			ELSE 20
		END

	SELECT @OperationalVolume = SUM([AG].[Volume])
	FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID AND [AG].[AgeClass] >= @MainFellingAgeClass

	RETURN @OperationalVolume / @AgeClassPeriod
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingRipeVolume]