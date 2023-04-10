
USE [forest]

GO
CREATE FUNCTION [dbo].[fn_Get10YFellingPart] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Part FLOAT

    SET @Part = [dbo].[fn_GetFellingOperationalArea](@SectionID) * 10 / [dbo].[fn_GetSectionOperationalArea](@SectionID)

    RETURN @Part
END
GO

--DROP FUNCTION [fn_Get10YFellingPart]