
USE [forest]

GO
CREATE FUNCTION [dbo].[fn_Get10YResultAreaDelta] (@SectionID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
    DECLARE @AreaDelta FLOAT

    SET @AreaDelta = 
        (
            SELECT MAX([Area])
            FROM [dbo].[view_SectionFelling10YAGResultAreas]
            WHERE [SectionID] = @SectionID
        )
        -
        (
            SELECT MIN([Area])
            FROM [dbo].[view_SectionFelling10YAGResultAreas]
            WHERE [SectionID] = @SectionID
        )

    RETURN @AreaDelta
END
GO

--DROP FUNCTION [fn_Get10YResultAreaDelta]