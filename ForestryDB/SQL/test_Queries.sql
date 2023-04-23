﻿INSERT INTO Users (Login, Password)
VALUES ('TestL', 'TestP')

DROP TABLE Forestries
DROP TABLE ForestAreas
DROP TABLE NonForestAreas
DROP TABLE AgeClasses
DROP TABLE QualityClasses
DROP TABLE TreeGroups
DROP TABLE TreeSpecies
DROP TABLE TreeGrowthRate
DROP TABLE TreeProductOutput


ALTER TABLE [dbo].[TreeSpecies]
ADD [OptimalFellingAge] INT NOT NULL

DELETE FROM [dbo].[TreeSpecies]

ALTER TABLE [dbo].[TreeSpecies]
DROP COLUMN [OptimalFellingAge]

ALTER TABLE [dbo].[TreeSpecies]
ADD [FellingAgeHigh] INT NOT NULL,
	[FellingAgeLow] INT NOT NULL

ALTER TABLE [dbo].[NonForestAreas]
DROP COLUMN [Total]

ALTER TABLE [dbo].[NonForestAreas]
DROP CONSTRAINT DF__NonForest__Marsh__2EDAF651

ALTER TABLE [dbo].[NonForestAreas]
DROP COLUMN [Marsh]

ALTER TABLE [dbo].[NonForestAreas]
ADD [Swamp] FLOAT DEFAULT(0)

ALTER TABLE [dbo].[NonForestAreas]
ADD [Total] AS [Field] + [Pasture] + [Water] + [Road] + [House] + [Swamp] + [Other]

ALTER TABLE [dbo].[TreeSpecies]
DROP COLUMN [FellingAgeHigh], [FellingAgeLow]

SELECT 12 + 12

DROP VIEW [dbo].[view_TreeGroups]

ALTER TABLE [dbo].[ForestAreas]
DROP COLUMN [Total]

ALTER TABLE [dbo].[ForestAreas]
DROP CONSTRAINT [DF__ForestAre__Fores__208CD6FA]

ALTER TABLE [dbo].[ForestAreas]
DROP COLUMN [Forest]

ALTER TABLE [dbo].[ForestAreas]
ADD [Forest] AS [dbo].[fn_GetTotalForestArea]([ForestryID])

ALTER TABLE [dbo].[ForestAreas]
DROP COLUMN [ForestTEST]

ALTER TABLE [dbo].[ForestAreas]
ADD [Total] AS [Forest] + [Felling] + [Burnt] + [Empty] + [Thin]

ALTER TABLE [dbo].[ForestAreas]
ADD [TotalNonForest] AS [Felling] + [Burnt] + [Empty] + [Thin]

ALTER TABLE [dbo].[ForestAreas]
ADD [Total] AS [dbo].[fn_GetTotalForestArea]([ForestryID]) + [Felling] + [Burnt] + [Empty] + [Thin]

DROP VIEW [dbo].[view_ForestryTreeSpecies]

DROP VIEW [dbo].[view_ForestryTreeSpeciesTotal]

SELECT [TreeSpeciesName], [dbo].[fn_GetDefaultSectionName]([TreeSpeciesID], [QualityClassID]), [dbo].[fn_GetDefaultSectionName]([TreeSpeciesID], [QualityClassID]) FROM [dbo].[view_TreeGroups] AS [TG]

ALTER TABLE [dbo].[Sections]
DROP CONSTRAINT [FK__Sections__MainSp__339FAB6E]

ALTER TABLE [dbo].[Sections]
DROP COLUMN [MainSpeciesID], [IsHigh]

SELECT [dbo].[fn_GetFellingClassAreaDif]('7609ef11-869a-410f-9bed-fc22a187ff6f', 7)

SELECT [dbo].[fn_GetMainFellingAgeClass]('1d6464ad-394f-4208-a756-7e94608b845a')
SELECT [dbo].[fn_GetMainFellingAgeClass]('92b2f1ff-a4f2-491f-9bfb-b745838b0aa2')
SELECT [dbo].[fn_GetMainFellingAgeClass]('98240a8e-edcf-4b5d-8008-023b6b1753d9')
SELECT [dbo].[fn_GetMainFellingAgeClass]('7609ef11-869a-410f-9bed-fc22a187ff6f')

SELECT [dbo].[fn_GetAvgOperationalVolumePerHectare]('92b2f1ff-a4f2-491f-9bfb-b745838b0aa2')

SELECT [dbo].[fn_GetFellingOperationalPeriod]('1d6464ad-394f-4208-a756-7e94608b845a')
SELECT [dbo].[fn_GetFellingOperationalPeriod]('92b2f1ff-a4f2-491f-9bfb-b745838b0aa2')
SELECT [dbo].[fn_GetFellingOperationalPeriod]('98240a8e-edcf-4b5d-8008-023b6b1753d9')
SELECT [dbo].[fn_GetFellingOperationalPeriod]('7609ef11-869a-410f-9bed-fc22a187ff6f')

SELECT [dbo].[fn_Get10YFellingPart]('7609ef11-869a-410f-9bed-fc22a187ff6f')

DECLARE @ForestryID UNIQUEIDENTIFIER
EXEC [dbo].[sp_AddForestry] N'TEST_FORESTRY', '6c96a53d-e3ae-4994-99cd-cd3bdb363c19', @ForestryID OUT
SELECT @ForestryID

UPDATE [dbo].[Forestries]
SET [IsShared] = 0

ALTER TABLE [dbo].[Forestries]
DROP CONSTRAINT [DF__Forestrie__IsSha__119F9925]

ALTER TABLE [dbo].[Forestries]
DROP COLUMN [IsShared]

ALTER TABLE [dbo].[Forestries]
ADD [IsShared] BIT NOT NULL DEFAULT 0

ALTER TABLE [dbo].[ForestAreas]
DROP CONSTRAINT [DF__ForestAre__IsSha__5090EFD7]

ALTER TABLE [dbo].[ForestAreas]
DROP COLUMN [IsShared]

ALTER TABLE [dbo].[Users]
ADD [IsAdmin] BIT NOT NULL DEFAULT 0

ALTER TABLE [dbo].[ForestAreas]
DROP CONSTRAINT [DF__ForestAre__IsAdm__5DEAEAF5] 

ALTER TABLE [dbo].[ForestAreas]
DROP COLUMN [IsAdmin] 

UPDATE [dbo].[Users] 
SET [IsAdmin] = 1
WHERE [Login] = N'admin'

ALTER TABLE [dbo].[Users]
ADD [PasswordHashed] BINARY(32) NOT NULL DEFAULT 0

ALTER TABLE [dbo].[Users]
DROP COLUMN [PasswordHashed]

ALTER TABLE [dbo].[Users]
DROP CONSTRAINT [DF__Users__PasswordH__5FD33367]

ALTER TABLE [dbo].[Users]
DROP COLUMN [Password]

ALTER TABLE [dbo].[Users]
DROP CONSTRAINT [DF__Users__PasswordH__5FD33367]