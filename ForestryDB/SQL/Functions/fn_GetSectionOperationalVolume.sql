USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetSectionOperationalVolume] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MainFellingAgeClass INT
	DECLARE @OperationalVolume FLOAT

	SET @MainFellingAgeClass = [dbo].[fn_GetMainFellingAgeClass](@SectionID)

	SELECT @OperationalVolume = SUM([AG].[Volume])
	FROM [dbo].[view_SectionAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID AND [AG].[AgeClass] >= @MainFellingAgeClass

	RETURN @OperationalVolume
END
GO

--DROP FUNCTION [dbo].[fn_GetSectionOperationalVolume]