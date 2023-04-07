USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingCycleArea] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
	DECLARE @TotalArea FLOAT
	DECLARE @Age INT
	DECLARE @Area FLOAT
	DECLARE @IsDeciduous BIT

	SELECT @TotalArea = SUM([AG].[Area])
	FROM [dbo].[view_SectionFellingAgeGroups] AS [AG]
	WHERE [AG].[SectionID] = @SectionID

	SET @IsDeciduous = [dbo].[fn_IsSectionDeciduous](@SectionID)

	SELECT @Age = ([AgeClasses].[ConiferousMidAge] * ~@IsDeciduous + [AgeClasses].[DeciduousMidAge] * @IsDeciduous)
	FROM [dbo].[AgeClasses]
	WHERE [Number] = [dbo].[fn_GetMainFellingAgeClass](@SectionID)

	RETURN @TotalArea / @Age
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingCycleArea]