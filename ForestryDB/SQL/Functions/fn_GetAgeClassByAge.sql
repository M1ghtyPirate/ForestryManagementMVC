USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetAgeClassByAge] (@Age FLOAT, @IsDeciduous BIT)
RETURNS INT
AS
BEGIN
    DECLARE @AgeClass INT
    DECLARE @MinAgeDif FLOAT

    SELECT @MinAgeDif = MIN(ABS(@Age - ([ConiferousMidAge] * ~@IsDeciduous + [DeciduousMidAge] * @IsDeciduous))) 
    FROM [dbo].[AgeClasses]

    SELECT @AgeClass = MIN([Number]) 
    FROM [dbo].[AgeClasses] 
    WHERE ABS(@Age - ([ConiferousMidAge] * ~@IsDeciduous + [DeciduousMidAge] * @IsDeciduous)) = @MinAgeDif

    RETURN @AgeClass
END
GO

--DROP FUNCTION [dbo].[fn_GetAgeClassByAge]