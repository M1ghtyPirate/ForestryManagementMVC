USE [forest]

GO
CREATE VIEW [dbo].[view_ForestryAreas]
AS
SELECT [Fo].[ForestryID] AS [ForestryID],
    [Fo].[Name] AS [ForestryName],
    [FA].[Forest] AS [Forest],
    [FA].[Felling] AS [Felling],
    [FA].[Burnt] AS [Burnt],
    [FA].[Empty] AS [Empty],
    [FA].[Thin] AS [Thin],
    [FA].[TotalNonForest] AS [NonForestForest],
    [FA].[Forest] + [FA].[TotalNonForest] AS [TotalForest],
    [NF].[Field] AS [Field],
    [NF].[Pasture] AS [Pasture],
    [NF].[Water] AS [Water],
    [NF].[Road] AS [Road],
    [NF].[House] AS [House],
    [NF].[Swamp] AS [Swamp],
    [NF].[Other] AS [Other],
    [NF].[Total] AS [TotalNonForest],
    [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total] AS [TotalArea]
FROM [dbo].[Forestries] AS [Fo]
    JOIN [dbo].[ForestAreas] AS [FA]
        ON [Fo].[ForestryID] = [FA].[ForestryID]
    JOIN [dbo].[NonForestAreas] AS [NF]
        ON [Fo].[ForestryID] = [NF].[ForestryID]
GO