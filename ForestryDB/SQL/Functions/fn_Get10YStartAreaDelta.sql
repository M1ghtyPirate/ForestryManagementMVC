
USE [forest]

GO
CREATE FUNCTION [dbo].[fn_Get10YStartAreaDelta] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
    DECLARE @AreaDelta FLOAT

    SET @AreaDelta = 
        (
            SELECT MAX([Area])
            FROM [dbo].[view_SectionFelling10YAGStartAreas]
            WHERE [SectionID] = @SectionID
        )
        -
        (
            SELECT MIN([Area])
            FROM [dbo].[view_SectionFelling10YAGStartAreas]
            WHERE [SectionID] = @SectionID
        )

    RETURN @AreaDelta
END
GO

--DROP FUNCTION [fn_Get10YStartAreaDelta]