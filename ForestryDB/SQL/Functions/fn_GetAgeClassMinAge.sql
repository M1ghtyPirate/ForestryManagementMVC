USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetAgeClassMinAge] (@TargetAgeClass INT, @IsDeciduous BIT)
RETURNS INT
AS
BEGIN
	DECLARE @MinAge INT

	SELECT @MinAge = (([ConiferousMidAge] - 10) * ~@IsDeciduous + ([DeciduousMidAge] - 5) * @IsDeciduous) + 1
    FROM [dbo].[AgeClasses]
	WHERE [Number] = @TargetAgeClass

	RETURN @MinAge
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingClassAreaDif]