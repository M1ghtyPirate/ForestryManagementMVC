USE [forest]

GO
CREATE VIEW [dbo].[view_ForestryInfo]
AS
SELECT [Fo].[ForestryID] AS [ForestryID],
    [Fo].[Name] AS [ForestryName],
    [Fo].[AuthorID] AS [AuthorID],
    [Us].[Login] AS [AuthorLogin],
    [Fo].[CreationDate] AS [CreationDate],
    [Fo].[EditDate] AS [EditDate],
    [Fo].[IsShared] AS [IsShared]
FROM [dbo].[Forestries] AS [Fo]
    JOIN [dbo].[Users] AS [Us]
        ON [Fo].AuthorID = [Us].[UserID]
GO