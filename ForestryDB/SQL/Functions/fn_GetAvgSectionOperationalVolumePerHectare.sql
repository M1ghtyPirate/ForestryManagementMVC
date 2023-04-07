USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetAvgSectionOperationalVolumePerHectare] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MainFellingAgeClass INT
	DECLARE @OperationalVolume FLOAT
	DECLARE @OperationalArea FLOAT

	SET @MainFellingAgeClass = [dbo].[fn_GetMainFellingAgeClass](@SectionID)

	SELECT @OperationalVolume = SUM([AG].[Volume]), 
		@OperationalArea = SUM([AG].[Area])
	FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID AND [AG].[AgeClass] >= @MainFellingAgeClass

	RETURN @OperationalVolume / @OperationalArea
END
GO

--DROP FUNCTION [dbo].[fn_GetAvgSectionOperationalVolumePerHectare]