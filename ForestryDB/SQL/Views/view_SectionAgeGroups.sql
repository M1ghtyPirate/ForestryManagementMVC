USE [forest]

GO
CREATE VIEW [dbo].[view_SectionAgeGroups]
AS
SELECT [TG].[ForestryID] AS [ForestryID],
    [TG].[ForestryName] AS [ForestryName],
    [Se].[SectionID] AS [SectionID],
    [Se].[Name] AS [SectionName],
    [TG].[AgeClassID] AS [AgeClassID],
    [TG].[AgeClass] AS [AgeClass],
    SUM([TG].[Area]) AS [Area],
    SUM([TG].[Volume]) AS [Volume]
FROM [dbo].[view_TreeGroups] AS [TG]
    JOIN [dbo].[Sections] AS [Se]
        ON [TG].[SectionID] = [Se].[SectionID]
GROUP BY [TG].[ForestryID], [TG].[ForestryName], [Se].[SectionID], [Se].[Name], [TG].[AgeClassID], [TG].[AgeClass]
GO