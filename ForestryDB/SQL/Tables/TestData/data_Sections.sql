USE [forest]

DECLARE @SectionIDs TABLE ([SectionID] UNIQUEIDENTIFIER, [Name] NVARCHAR(256))
DECLARE @SectionID UNIQUEIDENTIFIER
DECLARE @ForestryID UNIQUEIDENTIFIER
DECLARE @TreeSpeciesID UNIQUEIDENTIFIER
DECLARE @QualityClassID UNIQUEIDENTIFIER

SELECT TOP(1) @ForestryID = [ForestryID] FROM [dbo].[Forestries] WHERE [Name] = N'Ладвинское'

INSERT INTO [dbo].[Sections] ([Name])
OUTPUT inserted.[SectionID], inserted.[Name] INTO @SectionIDs
VALUES (N'Хвойная высокобонитетная.'),
	(N'Еловая низкобонитетная.'),
	(N'Сосновая низкобонитетная.'),
	(N'Березовая высокобонитетная.')

SELECT @SectionID = [SectionID] FROM @SectionIDs WHERE [Name] = N'Хвойная высокобонитетная.'

SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = N'Сосна'

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 1
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 2
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 3
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = N'Ель'

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 1
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 2
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 3
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @SectionID = [SectionID] FROM @SectionIDs WHERE [Name] = N'Еловая низкобонитетная.'

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 4
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 5
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 6
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @SectionID = [SectionID] FROM @SectionIDs WHERE [Name] = N'Сосновая низкобонитетная.'

SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = N'Сосна'

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 4
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 5
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 6
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @SectionID = [SectionID] FROM @SectionIDs WHERE [Name] = N'Березовая высокобонитетная.'

SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = N'Береза'

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 1
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 2
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 3
EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID