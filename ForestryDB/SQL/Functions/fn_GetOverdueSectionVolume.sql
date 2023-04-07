USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetOverdueSectionVolume] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MainFellingAgeClass INT
	DECLARE @OverdueVolume FLOAT

	SET @MainFellingAgeClass = [dbo].[fn_GetMainFellingAgeClass](@SectionID)

	SELECT @OverdueVolume = SUM([AG].[Volume])
	FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID AND [AG].[AgeClass] >= @MainFellingAgeClass + 2

	RETURN @OverdueVolume
END
GO

--DROP FUNCTION [dbo].[fn_GetOverdueSectionVolume]