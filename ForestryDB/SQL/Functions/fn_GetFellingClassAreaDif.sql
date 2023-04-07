USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetFellingClassAreaDif] (@SectionID UNIQUEIDENTIFIER, @TargetAgeClass int)
RETURNS FLOAT
AS
BEGIN
	DECLARE @AreaDif FLOAT

	SELECT @AreaDif = ABS(
        (
            SELECT SUM([Area])
            FROM [dbo].[view_SectionAgeGroups]
            WHERE [SectionID] = @SectionID AND ([AgeClass] = @TargetAgeClass OR [AgeClass] = @TargetAgeClass + 1)
        ) 
        - 
        (
            SELECT SUM([Area])
            FROM [dbo].[view_SectionAgeGroups]
            WHERE [SectionID] = @SectionID
        ) / @TargetAgeClass
    )

	RETURN @AreaDif
END
GO

--DROP FUNCTION [dbo].[fn_GetFellingClassAreaDif]