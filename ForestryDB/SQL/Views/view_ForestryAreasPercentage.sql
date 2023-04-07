USE [forest]

GO
CREATE VIEW [dbo].[view_ForestryAreasPercentage]
AS
SELECT [Fo].[ForestryID] AS [ForestryID],
    [Fo].[Name] AS [ForestryName],
    [dbo].[fn_CountPercentage]([FA].[Forest], [FA].[Forest] + [FA].[TotalNonForest]) AS [ForestLocal],
    [dbo].[fn_CountPercentage]([FA].[Forest], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [ForestTotal],
    [dbo].[fn_CountPercentage]([FA].[Felling], [FA].[Forest] + [FA].[TotalNonForest]) AS [FellingLocal],
    [dbo].[fn_CountPercentage]([FA].[Felling], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [FellingTotal],
    [dbo].[fn_CountPercentage]([FA].[Burnt], [FA].[Forest] + [FA].[TotalNonForest]) AS [BurntLocal],
    [dbo].[fn_CountPercentage]([FA].[Burnt], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [BurntTotal],
    [dbo].[fn_CountPercentage]([FA].[Empty], [FA].[Forest] + [FA].[TotalNonForest]) AS [EmptyLocal],
    [dbo].[fn_CountPercentage]([FA].[Empty], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [EmptyTotal],
    [dbo].[fn_CountPercentage]([FA].[Thin], [FA].[Forest] + [FA].[TotalNonForest]) AS [ThinLocal],
    [dbo].[fn_CountPercentage]([FA].[Thin], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [ThinTotal],
    [dbo].[fn_CountPercentage]([FA].[TotalNonForest], [FA].[Forest] + [FA].[TotalNonForest]) AS [NonForestForestLocal],
    [dbo].[fn_CountPercentage]([FA].[TotalNonForest], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [NonForestForestTotal],
    100 AS [TotalForestLocal],
    [dbo].[fn_CountPercentage]([FA].[Forest] + [FA].[TotalNonForest], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [TotalForestTotal],
    [dbo].[fn_CountPercentage]([NF].[Field], [NF].[Total]) AS [FieldLocal],
    [dbo].[fn_CountPercentage]([NF].[Field], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [FieldTotal],
    [dbo].[fn_CountPercentage]([NF].[Pasture], [NF].[Total]) AS [PastureLocal],
    [dbo].[fn_CountPercentage]([NF].[Pasture], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [PastureTotal],
    [dbo].[fn_CountPercentage]([NF].[Water], [NF].[Total]) AS [WaterLocal],
    [dbo].[fn_CountPercentage]([NF].[Water], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [WaterTotal],
    [dbo].[fn_CountPercentage]([NF].[Road], [NF].[Total]) AS [RoadLocal],
    [dbo].[fn_CountPercentage]([NF].[Road], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [RoadTotal],
    [dbo].[fn_CountPercentage]([NF].[House], [NF].[Total]) AS [HouseLocal],
    [dbo].[fn_CountPercentage]([NF].[House], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [HouseTotal],
    [dbo].[fn_CountPercentage]([NF].[Swamp], [NF].[Total]) AS [SwampLocal],
    [dbo].[fn_CountPercentage]([NF].[Swamp], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [SwampTotal],
    [dbo].[fn_CountPercentage]([NF].[Other], [NF].[Total]) AS [OtherLocal],
    [dbo].[fn_CountPercentage]([NF].[Other], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [OtherTotal],
    100 AS [TotalNonForestLocal],
    [dbo].[fn_CountPercentage]([NF].[Total], [FA].[Forest] + [FA].[TotalNonForest] + [NF].[Total]) AS [TotalNonForestTotal],
    0 AS [TotalAreaLocal],
    100 AS [TotalAreaTotal]
FROM [dbo].[Forestries] AS [Fo]
    JOIN [dbo].[ForestAreas] AS [FA]
        ON [Fo].[ForestryID] = [FA].[ForestryID]
    JOIN [dbo].[NonForestAreas] AS [NF]
        ON [Fo].[ForestryID] = [NF].[ForestryID]
GO