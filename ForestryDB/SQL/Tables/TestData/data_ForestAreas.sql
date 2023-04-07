USE [forest]

INSERT INTO [dbo].[ForestAreas] ([ForestryID], 
		[Felling], 
		[Burnt], 
		[Empty],
		[Thin])
VALUES ((SELECT TOP(1) [ForestryID] FROM [dbo].[Forestries] WHERE [Name] = N'Ладвинское'), 3092, 400, 0, 0)