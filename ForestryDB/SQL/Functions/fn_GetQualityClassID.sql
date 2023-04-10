USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetQualityClassID] (@QualityClass INT)
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @QualityClassID UNIQUEIDENTIFIER

    SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = @QualityClass

    RETURN @QualityClassID
END
GO

--DROP FUNCTION [dbo].[fn_GetQualityClassID]