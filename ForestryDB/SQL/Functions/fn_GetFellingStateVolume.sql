USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingStateVolume] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MainFellingAgeClass INT
	DECLARE @OperationalVolume FLOAT

	SET @MainFellingAgeClass = [dbo].[fn_GetMainFellingAgeClass](@SectionID)

	SELECT @OperationalVolume = SUM([AG].[Volume])
	FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID AND [AG].[AgeClass] >= @MainFellingAgeClass + 2

	RETURN @OperationalVolume / 10
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingStateVolume]