USE [forest]

GO
CREATE VIEW [dbo].[view_SectionFelling10YAGResultAreas]
AS
SELECT [MA].[ForestryID] AS [ForestryID],
    [MA].[ForestryName] AS [ForestryName],
    [MA].[SectionID] AS [SectionID],
    [MA].[SectionName] AS [SectionName],
    [MA].[AgeClassID] AS [AgeClassID],
    [MA].[AgeClass] AS [AgeClass],
    [MA].[IsDeciduous] AS [IsDeciduous],
    CASE
        WHEN [MA].[AgeClass] > 1 THEN [MA].[Area]
        ELSE [MA].[Area] + 
            (
                SELECT  SUM([Area])
                FROM [dbo].[view_SectionFelling10YAGAreas]
                WHERE [SectionID] = [MA].[SectionID]
            )
    END AS [Area] 
FROM [dbo].[view_SectionFelling10YAGMovementAreas] AS [MA]
GO

--DROP VIEW [dbo].[view_SectionFelling10YAGResultAreas]