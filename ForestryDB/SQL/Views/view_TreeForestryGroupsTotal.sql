USE [forest]

GO
CREATE VIEW [dbo].[view_TreeForestryGroupsTotal]
AS
SELECT [TG].[ForestryID] AS [ForestryID],
    [TG].[ForestryName] AS [ForestryName],
    SUM([TG].[Area]) AS [Area],
    SUM([TG].[Volume]) AS [Volume]
FROM [dbo].[view_TreeGroups] AS [TG]
GROUP BY [TG].[ForestryID], [TG].[ForestryName]
GO