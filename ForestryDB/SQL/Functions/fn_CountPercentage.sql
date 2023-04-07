USE [forest]

GO
CREATE FUNCTION [dbo].[fn_CountPercentage] (@Value FLOAT, @Total FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Percentage FLOAT

    SET @Percentage = 100 * @Value / @Total

    RETURN @Percentage
END
GO