USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingAgeFirstArea] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MainFellingAgeClass INT
	DECLARE @AgeClassPeriod INT
	DECLARE @OperationalArea FLOAT

	SET @MainFellingAgeClass = [dbo].[fn_GetMainFellingAgeClass](@SectionID)
	SET @AgeClassPeriod = 
		CASE
			WHEN [dbo].[fn_IsSectionDeciduous](@SectionID) = 1 THEN 20
			ELSE 40
		END

	SELECT @OperationalArea = SUM([AG].[Area])
	FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID AND [AG].[AgeClass] >= @MainFellingAgeClass - 1

	RETURN @OperationalArea / @AgeClassPeriod
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingAgeFirstArea]