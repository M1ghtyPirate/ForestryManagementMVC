USE [forest]

GO
CREATE VIEW [dbo].[view_SectionFellingAgeGroups]
AS
SELECT [AG].[ForestryID] AS [ForestryID],
    [AG].[ForestryName] AS [ForestryName],
    [AG].[SectionID] AS [SectionID],
    [AG].[SectionName] AS [SectionName],
    [AG].[AgeClassID] AS [AgeClassID],
    [AG].[AgeClass] AS [AgeClass],
    [dbo].[fn_IsSectionDeciduous]([AG].[SectionID]) AS [IsDeciduous],
    CASE
        WHEN  [dbo].[fn_IsSectionDeciduous]([AG].[SectionID]) = 1 THEN [AC].[DeciduousMidAge]
        ELSE [AC].[ConiferousMidAge]
    END AS [Age],
    [AG].[Area] AS [Area],
    [AG].[Volume] AS [Volume],
    [AG].[Volume] / 
    (
        CASE
            WHEN  [dbo].[fn_IsSectionDeciduous]([AG].[SectionID]) = 1 THEN [AC].[DeciduousMidAge]
            ELSE [AC].[ConiferousMidAge]
        END
    ) AS [AvgGrowth] 
FROM [dbo].[view_SectionAgeGroups] AS [AG]
    JOIN [dbo].[AgeClasses] AS [AC]
        ON [AG].[AgeClassID] = [AC].[AgeClassID]
GO

--DROP VIEW [dbo].[view_SectionFellingAgeGroups]