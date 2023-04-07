USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingStateArea] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MainFellingAgeClass INT
	DECLARE @OperationalArea FLOAT

	SET @MainFellingAgeClass = [dbo].[fn_GetMainFellingAgeClass](@SectionID)

	SELECT @OperationalArea = SUM([AG].[Area])
	FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID AND [AG].[AgeClass] >= @MainFellingAgeClass + 2

	RETURN @OperationalArea / 10
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingStateArea]