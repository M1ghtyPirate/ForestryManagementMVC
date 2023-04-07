USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetAgeClassID] (@AgeClass INT)
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @AgeClassID UNIQUEIDENTIFIER

    SELECT @AgeClassID = [AgeClassID] FROM [dbo].[AgeClasses] WHERE [Number] = @AgeClass

    RETURN @AgeClassID
END
GO