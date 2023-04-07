USE [forest]

GO
CREATE VIEW [dbo].[view_TreeForestryAgeGroupsTotal]
AS
SELECT [TG].[ForestryID] AS [ForestryID],
    [TG].[ForestryName] AS [ForestryName],
    [TG].[AgeClassID] AS [AgeClassID],
    [TG].[AgeClass] AS [AgeClass],
    SUM([TG].[Area]) AS [Area],
    SUM([TG].[Volume]) AS [Volume]
FROM [dbo].[view_TreeGroups] AS [TG]
GROUP BY [TG].[ForestryID], [TG].[ForestryName], [TG].[AgeClassID], [TG].[AgeClass]
GO