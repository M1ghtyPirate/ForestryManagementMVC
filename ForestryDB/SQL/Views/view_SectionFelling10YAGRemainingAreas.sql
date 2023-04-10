USE [forest]

GO
CREATE VIEW [dbo].[view_SectionFelling10YAGRemainingAreas]
AS
SELECT [AG].[ForestryID] AS [ForestryID],
    [AG].[ForestryName] AS [ForestryName],
    [AG].[SectionID] AS [SectionID],
    [AG].[SectionName] AS [SectionName],
    [AG].[AgeClassID] AS [AgeClassID],
    [AG].[AgeClass] AS [AgeClass],
    [AG].[IsDeciduous] AS [IsDeciduous],
    [AG].[Area] - ISNULL([FA].[Area], 0) AS [Area] 
FROM [dbo].[view_SectionFelling10YAGStartAreas] AS [AG]
    LEFT JOIN [dbo].[view_SectionFelling10YAGFellingAreas] AS [FA]
        ON [AG].[SectionID] = [FA].[SectionID] AND [AG].[AgeClassID] = [FA].[AgeClassID]
GO

--DROP VIEW [dbo].[view_SectionFelling10YAGRemainingAreas]