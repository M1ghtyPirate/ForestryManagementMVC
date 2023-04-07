USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetOverdueSectionArea] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MainFellingAgeClass INT
	DECLARE @OverdueArea FLOAT

	SET @MainFellingAgeClass = [dbo].[fn_GetMainFellingAgeClass](@SectionID)

	SELECT @OverdueArea = SUM([AG].[Area])
	FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID AND [AG].[AgeClass] >= @MainFellingAgeClass + 2

	RETURN @OverdueArea
END
GO

--DROP FUNCTION [dbo].[fn_GetOverdueSectionArea]