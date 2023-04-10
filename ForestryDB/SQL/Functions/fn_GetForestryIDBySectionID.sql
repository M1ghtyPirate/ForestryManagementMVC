USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetForestryIDBySectionID] (@SectionID UNIQUEIDENTIFIER)
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @ForestryID UNIQUEIDENTIFIER

    SELECT @ForestryID = [QG].[ForestryID] 
    FROM 
        (
            SELECT DISTINCT [ForestryID], [SectionID]
            FROM [dbo].[TreeQualityGroups]
        ) AS [QG]
        JOIN [dbo].[Sections] AS [Se]
            ON [QG].[SectionID] = [Se].[SectionID]
    WHERE [Se].[SectionID] = @SectionID

    RETURN @ForestryID
END
GO

--DROP FUNCTION [dbo].[fn_GetForestryIDBySectionID]