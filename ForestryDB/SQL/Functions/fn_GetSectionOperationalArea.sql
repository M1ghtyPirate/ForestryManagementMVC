USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetSectionOperationalArea] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MainFellingAgeClass INT
	DECLARE @OperationalArea FLOAT

	SET @MainFellingAgeClass = [dbo].[fn_GetMainFellingAgeClass](@SectionID)

	SELECT @OperationalArea = SUM([AG].[Area])
	FROM [dbo].[view_SectionAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID AND [AG].[AgeClass] >= @MainFellingAgeClass

	RETURN @OperationalArea
END
GO

--DROP FUNCTION [dbo].[fn_GetSectionOperationalArea]