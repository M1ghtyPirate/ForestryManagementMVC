USE [forest]

GO
CREATE VIEW [dbo].[view_SectionFelling10YTotalAreas]
AS
SELECT [SA].[ForestryID] AS [ForestryID],
    [SA].[ForestryName] AS [ForestryName],
    [SA].[SectionID] AS [SectionID],
    [SA].[SectionName] AS [SectionName],
    [dbo].[fn_GetMainFellingAgeClass]([SA].[SectionID]) AS [MainFellingAgeClass],
    [dbo].[fn_GetAgeClassMinAge]([dbo].[fn_GetMainFellingAgeClass]([SA].[SectionID]), [SA].[IsDeciduous]) AS [MainFellingAge],
    [dbo].[fn_GetFellingOperationalArea]([SA].[SectionID]) AS [FellingOperationalArea],
    [dbo].[fn_GetFellingOperationalArea]([SA].[SectionID]) * 10 AS [10YFellingOperationalArea],
    [SA].[IsDeciduous] AS [IsDeciduous],
    SUM([SA].[Area]) AS [StartArea],
    [dbo].[fn_GetSectionOperationalArea]([SA].[SectionID]) AS [OperationalArea],
    [dbo].[fn_Get10YFellingPart]([SA].[SectionID]) AS [10YFellingPart],
    [dbo].[fn_GetSectionOperationalArea]([SA].[SectionID]) * [dbo].[fn_Get10YFellingPart]([SA].[SectionID]) AS [10YFellingArea],
    SUM([RA].[Area]) AS [ResultArea],
    [dbo].[fn_Get10YStartAreaDelta]([SA].[SectionID]) AS [StartAreaDelta],
    [dbo].[fn_Get10YResultAreaDelta]([SA].[SectionID]) AS [ResultAreaDelta]
FROM [dbo].[view_SectionFelling10YAGStartAreas] AS [SA]
    JOIN [dbo].[view_SectionFelling10YAGResultAreas] AS [RA]
     ON [SA].[SectionID] = [RA].[SectionID] AND [SA].[AgeClassID] = [RA].[AgeClassID]
GROUP BY [SA].[ForestryID], [SA].[ForestryName], [SA].[SectionID], [SA].[SectionName], [SA].[IsDeciduous]
GO

--DROP VIEW [dbo].[view_SectionFelling10YTotalAreas]