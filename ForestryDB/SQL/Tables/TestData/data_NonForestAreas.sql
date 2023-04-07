USE [forest]

INSERT INTO [dbo].[NonForestAreas] ([ForestryID],  
        [Field],  
        [Pasture], 
        [Water], 
        [Road],
        [House],
        [Swamp],
        [Other])
VALUES ((SELECT TOP(1) [ForestryID] FROM [dbo].[Forestries] WHERE [Name] = N'Ладвинское'), 12, 204, 1333, 340, 281, 7967, 0)