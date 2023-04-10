USE [forest]

GO
CREATE VIEW [dbo].[view_SectionFelling10YAGStartAreas]
AS
SELECT ISNULL([AG].[ForestryID], [dbo].[fn_GetForestryIDBySectionID]([SC].[SectionID])) AS [ForestryID],
    ISNULL([AG].[ForestryName],
            (
                SELECT [Name]
                FROM [dbo].[Forestries]
                WHERE [ForestryID] = [dbo].[fn_GetForestryIDBySectionID]([SC].[SectionID])  
            )) AS [ForestryName],
    [SC].[SectionID] AS [SectionID],
    [SC].[Name] AS [SectionName],
    [SC].[AgeClassID] AS [AgeClassID],
    [SC].[Number] AS [AgeClass],
    ISNULL([AG].[IsDeciduous], [dbo].[fn_IsSectionDeciduous]([SC].[SectionID])) AS [IsDeciduous],
    ISNULL([AG].[Area], 0) AS [Area] 
FROM (
        SELECT [SectionID], [Name], [AgeClassID], [Number] 
        FROM [dbo].[Sections] 
            CROSS JOIN [dbo].[AgeClasses]
    ) AS [SC]
    LEFT JOIN [dbo].[view_SectionFellingAgeGroups] AS [AG]
        ON [SC].[SectionID] = [AG].[SectionID] AND [SC].[AgeClassID] = [AG].[AgeClassID]
GO

--DROP VIEW [dbo].[view_SectionFelling10YAGStartAreas]