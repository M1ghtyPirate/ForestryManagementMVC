USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetTotalForestArea] (@ForestryID UNIQUEIDENTIFIER)
RETURNS FLOAT
AS
BEGIN
    DECLARE @TotalForestArea FLOAT

    SELECT @TotalForestArea = SUM([dbo].[view_TreeGroups].[Area]) 
    FROM [dbo].[view_TreeGroups] 
    WHERE [dbo].[view_TreeGroups].[ForestryID] = @ForestryID

    RETURN @TotalForestArea
END
GO