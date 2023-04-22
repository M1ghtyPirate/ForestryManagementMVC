USE [forest]

GO
CREATE VIEW [dbo].[view_SectionsMainFellingAgeCalc]
AS
SELECT [ST].[ForestryID] AS [ForestryID],
    [ST].[ForestryName] AS [ForestryName],
    [ST].[SectionID] AS [SectionID],
    [ST].[SectionName] AS [SectionName],
    [ST].[Area] AS [Area],
    [ST].[Volume] AS [Volume],
    [ST].[TechnicalAge] AS [TechnicalAge],
    [TS].[OptimalFellingAge] AS [OptimalFellingAge],
    ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]) AS [TargetAge],
    [dbo].[fn_GetAgeClassByAge](ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]), [ST].[IsDeciduous]) AS [TargetClass],
    [ST].[RipeAge] AS [RipeAge],
    [ST].[Area] / ([dbo].[fn_GetAgeClassByAge](ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]), [ST].[IsDeciduous]) - 1) AS [LowerClassTargetArea],
    [dbo].[fn_GetFellingClassAreaDif]([ST].[SectionID], [dbo].[fn_GetAgeClassByAge](ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]), [ST].[IsDeciduous]) - 1) AS [LowerClassAreaDiff],
    [dbo].[fn_GetAgeClassMinAge]([dbo].[fn_GetAgeClassByAge](ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]), [ST].[IsDeciduous]) - 1, [ST].[IsDeciduous]) AS [LowerClassMainFellingAge],
    [ST].[Area] / [dbo].[fn_GetAgeClassByAge](ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]), [ST].[IsDeciduous]) AS [TargetClassTargetArea],
    [dbo].[fn_GetFellingClassAreaDif]([ST].[SectionID], [dbo].[fn_GetAgeClassByAge](ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]), [ST].[IsDeciduous])) AS [TargetClassAreaDiff],
    [dbo].[fn_GetAgeClassMinAge]([dbo].[fn_GetAgeClassByAge](ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]), [ST].[IsDeciduous]), [ST].[IsDeciduous]) AS [TargetClassMainFellingAge],
    [ST].[Area] / ([dbo].[fn_GetAgeClassByAge](ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]), [ST].[IsDeciduous]) + 1) AS [HigherClassTargetArea],
    [dbo].[fn_GetFellingClassAreaDif]([ST].[SectionID], [dbo].[fn_GetAgeClassByAge](ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]), [ST].[IsDeciduous]) + 1) AS [HigherClassAreaDiff],
    [dbo].[fn_GetAgeClassMinAge]([dbo].[fn_GetAgeClassByAge](ISNULL([ST].[TechnicalAge], [TS].[OptimalFellingAge]), [ST].[IsDeciduous]) + 1, [ST].[IsDeciduous]) AS [HigherClassMainFellingAge],
    [dbo].[fn_GetAgeClassMinAge]([dbo].[fn_GetMainFellingAgeClass]([ST].[SectionID]), [dbo].[fn_IsSectionDeciduous]([ST].[SectionID])) AS [MainFellingAge],
    [dbo].[fn_GetMainFellingAgeClass]([ST].[SectionID]) AS [MainFellingAgeClass]
FROM [dbo].[view_SectionsTotal] AS [ST]
    JOIN [dbo].[TreeSpecies] AS [TS]
        ON [ST].[TreeSpeciesID] = [TS].[TreeSpeciesID]
GO


--DROP VIEW [dbo].[view_SectionsMainFellingAgeCalc]