USE [forest]

GO
CREATE FUNCTION [dbo].[fn_CountPercentage] (@Value FLOAT, @Total FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Percentage FLOAT

    IF @Total = 0 RETURN NULL

    SET @Percentage = 100 * @Value / @Total

    RETURN @Percentage
END
GO

--DROP FUNCTION [dbo].[fn_CountPercentage]