USE [forest]

GO
CREATE VIEW [dbo].[view_SectionFelling10YAGMovementAreas]
AS
SELECT [AG].[ForestryID] AS [ForestryID],
    [AG].[ForestryName] AS [ForestryName],
    [AG].[SectionID] AS [SectionID],
    [AG].[SectionName] AS [SectionName],
    [AG].[AgeClassID] AS [AgeClassID],
    [AG].[AgeClass] AS [AgeClass],
    [AG].[IsDeciduous] AS [IsDeciduous],
    CASE
        WHEN [AG].[IsDeciduous] = 0 THEN 
            ISNULL((
                SELECT [Area] 
                FROM [dbo].[view_SectionFelling10YAGRemainingAreas] AS [AG2] 
                WHERE [AG2].[SectionID] = [AG].[SectionID] AND [AG2].[AgeClass] = [AG].[AgeClass] - 1
            ), 0) * 0.5 + 
            CASE 
                WHEN [AG].[AgeClass] < 8 THEN [AG].[Area] * 0.5
                ELSE [AG].[Area]
            END
        ELSE 
            ISNULL((
                SELECT [Area] 
                FROM [dbo].[view_SectionFelling10YAGRemainingAreas] AS [AG2] 
                WHERE [AG2].[SectionID] = [AG].[SectionID] AND [AG2].[AgeClass] = [AG].[AgeClass] - 1
            ), 0) + 
            CASE 
                WHEN [AG].[AgeClass] < 8 THEN 0
                ELSE [AG].[Area]
            END
    END AS [Area] 
FROM [dbo].[view_SectionFelling10YAGRemainingAreas] AS [AG]
GO

--DROP VIEW [dbo].[view_SectionFelling10YAGMovementAreas]