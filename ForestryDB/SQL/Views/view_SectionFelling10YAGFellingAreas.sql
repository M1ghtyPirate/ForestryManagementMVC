USE [forest]

GO
CREATE VIEW [dbo].[view_SectionFelling10YAGFellingAreas]
AS
SELECT [AG].[ForestryID] AS [ForestryID],
    [AG].[ForestryName] AS [ForestryName],
    [AG].[SectionID] AS [SectionID],
    [AG].[SectionName] AS [SectionName],
    [AG].[AgeClassID] AS [AgeClassID],
    [AG].[AgeClass] AS [AgeClass],
    [AG].[IsDeciduous] AS [IsDeciduous],
    [AG].[Area] * [dbo].[fn_Get10YFellingPart]([AG].[SectionID]) AS [Area] 
FROM [dbo].[view_SectionFelling10YAGStartAreas] AS [AG]
WHERE [AG].[AgeClass] >= [dbo].[fn_GetMainFellingAgeClass]([AG].[SectionID])
GO

--DROP VIEW [dbo].[view_SectionFelling10YAGFellingAreas]