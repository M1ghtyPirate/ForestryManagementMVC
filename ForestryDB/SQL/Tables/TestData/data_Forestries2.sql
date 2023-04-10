USE [forest]

--Лесничество

DECLARE @ForestryID UNIQUEIDENTIFIER

EXEC [dbo].[sp_AddForestry] N'Ладвинское - 2', '6c96a53d-e3ae-4994-99cd-cd3bdb363c19', @ForestryID OUTPUT

--Лесные территории

EXEC [dbo].[sp_AddOrUpdateForestAreas] @ForestryID, 3092, 400, 0, 0, NULL

--Нелесные территории

EXEC [dbo].[sp_AddOrUpdateNonForestAreas] @ForestryID, 12, 204, 1333, 340, 281, 7967, 0, NULL

--Группы насаждений

DECLARE @TreeSpeciesID UNIQUEIDENTIFIER
DECLARE @TreeQualityGroupID UNIQUEIDENTIFIER
DECLARE @QualityClassID UNIQUEIDENTIFIER
DECLARE @AgeClassID UNIQUEIDENTIFIER
DECLARE @TreeSpeciesName NVARCHAR(256)
DECLARE @QualityClass INT

--SET @TreeSpeciesID = [dbo].[fn_GetTreeSpeciesID](N'Сосна')
SET @TreeSpeciesName = N'Сосна'
--SET @QualityClassID = [dbo].[fn_GetQualityClassID](2)

SET @QualityClass = 2

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 1, 6, 0, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 2, 11, 1270, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 3, 51, 11370, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 4, 32, 6470, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 18, 4680, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 6, 32, 6470, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 6, 0),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 11, 1270),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 51, 11370),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 32, 6470),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 18, 4680),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 32, 6470)

--SET @QualityClassID = [dbo].[fn_GetQualityClassID](3)

SET @QualityClass = 3

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 1, 235, 8500, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 2, 458, 39390, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 3, 475, 57380, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 4, 116, 23840, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 30, 7720, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 6, 91, 24900, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 7, 37, 10850, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 8, 120, 36360, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 235, 8500),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 458, 39390),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 475, 57380),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 116, 23840),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 30, 7720),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 91, 24900),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 37, 10850),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 120, 36360)

--SET @QualityClassID = [dbo].[fn_GetQualityClassID](4)

SET @QualityClass = 4

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 1, 86, 1800, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 2, 63, 2540, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 3, 207, 16000, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 4, 80, 6180, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 31, 5760, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 6, 202, 42390, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 7, 202, 50200, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 8, 659, 156320, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 86, 1800),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 63, 2540),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 207, 16000),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 80, 6180),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 31, 5760),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 202, 42390),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 202, 50200),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 659, 156320)

--SET @QualityClassID = [dbo].[fn_GetQualityClassID](5)

SET @QualityClass = 5

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 1, 20, 0, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 2, 78, 2490, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 3, 117, 4200, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 4, 481, 26100, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 470, 20930, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 6, 245, 22590, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 7, 165, 17860, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 8, 837, 104690, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 20, 0),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 78, 2490),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 117, 4200),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 481, 26100),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 470, 20930),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 245, 22590),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 165, 17860),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 837, 104690)

--SET @TreeSpeciesID = [dbo].[fn_GetTreeSpeciesID](N'Ель')
SET @TreeSpeciesName = N'Ель'
--SET @QualityClassID = [dbo].[fn_GetQualityClassID](2)
SET @QualityClass = 2

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 2, 13, 1140, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 3, 194, 35480, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 4, 117, 28660, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 82, 26740, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 13, 1140),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 194, 35480),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 117, 28660),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 82, 26740)

--SET @QualityClassID = [dbo].[fn_GetQualityClassID](3)

SET @QualityClass = 3

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 1, 725, 6900, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 2, 550, 40630, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 3, 1023, 116880, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 4, 1982, 309720, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 897, 200830, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 6, 294, 73670, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 7, 310, 80130, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 8, 5283, 1323480, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 725, 6900),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 550, 40630),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 1023, 116880),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 1982, 309720),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 897, 200830),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 294, 73670),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 310, 80130),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 5283, 1323480)

--SET @QualityClassID = [dbo].[fn_GetQualityClassID](4)

SET @QualityClass = 4

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 1, 35, 0, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 2, 90, 3020, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 3, 793, 77840, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 4, 1105, 109070, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 630, 90560, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 6, 670, 127160, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 7, 494, 109240, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 8, 3034, 649440, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 35, 0),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 90, 3020),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 793, 77840),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 1105, 109070),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 630, 90560),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 670, 127160),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 494, 109240),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 3034, 649440)

--SET @QualityClassID = [dbo].[fn_GetQualityClassID](5)

SET @QualityClass = 5

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 2, 3, 240, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 3, 38, 2340, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 4, 1215, 39190, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 361, 26500, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 6, 293, 26780, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 7, 212, 23730, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 8, 773, 36270, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 3, 240),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 38, 2340),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 1215, 39190),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 361, 26500),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 293, 26780),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 212, 23730),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 773, 36270)

--SET @TreeSpeciesID = [dbo].[fn_GetTreeSpeciesID](N'Береза')
SET @TreeSpeciesName = N'Береза'
--SET @QualityClassID = [dbo].[fn_GetQualityClassID](1)

SET @QualityClass = 1

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 5, 950, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 5, 950)

--SET @QualityClassID = [dbo].[fn_GetQualityClassID](2)

SET @QualityClass = 2

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 3, 95, 6430, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 4, 121, 11180, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 74, 10240, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 6, 58, 10540, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 7, 33, 8130, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 8, 40, 13560, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 95, 6430),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 121, 11180),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 74, 10240),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 58, 10540),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 33, 8130),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 40, 13560)

--SET @QualityClassID = [dbo].[fn_GetQualityClassID](3)

SET @QualityClass = 3

EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 2, 272, 6130, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 3, 80, 5430, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 4, 280, 27500, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 5, 415, 51140, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 6, 224, 44010, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 7, 394, 64320, NULL
EXEC [dbo].[sp_AddOrUpdateTreeGroup] @ForestryID, @TreeSpeciesName, @QualityClass, 8, 265, 89500, NULL

--EXEC [dbo].[sp_AddTreeQualityGroup] @ForestryID, @TreeSpeciesID, @QualityClassID, @TreeQualityGroupID OUTPUT

--INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
--        [AgeClassID],
--        [Area],
--        [Volume])
--VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 272, 6130),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 80, 5430),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 280, 27500),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 415, 51140),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 224, 44010),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 394, 64320),
--    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 265, 89500)

--Секции

DECLARE @SectionID UNIQUEIDENTIFIER

EXEC [dbo].[sp_AddSection] @ForestryID, N'Хвойная высокобонитетная 2.', @SectionID OUTPUT

SET @TreeSpeciesID = [dbo].[fn_GetTreeSpeciesID](N'Сосна')
SET @QualityClassID = [dbo].[fn_GetQualityClassID](2)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SET @QualityClassID = [dbo].[fn_GetQualityClassID](3)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SET @TreeSpeciesID = [dbo].[fn_GetTreeSpeciesID](N'Ель')
SET @QualityClassID = [dbo].[fn_GetQualityClassID](2)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SET @QualityClassID = [dbo].[fn_GetQualityClassID](3)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

EXEC [dbo].[sp_AddSection] @ForestryID, N'Сосновая низкобонитетная 2.', @SectionID OUTPUT

SET @TreeSpeciesID = [dbo].[fn_GetTreeSpeciesID](N'Сосна')
SET @QualityClassID = [dbo].[fn_GetQualityClassID](4)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SET @QualityClassID = [dbo].[fn_GetQualityClassID](5)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

EXEC [dbo].[sp_AddSection] @ForestryID, N'Еловая низкобонитетная 2.', @SectionID OUTPUT

SET @TreeSpeciesID = [dbo].[fn_GetTreeSpeciesID](N'Ель')
SET @QualityClassID = [dbo].[fn_GetQualityClassID](4)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SET @QualityClassID = [dbo].[fn_GetQualityClassID](5)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

EXEC [dbo].[sp_AddSection] @ForestryID, N'Березовая высокобонитетная 2.', @SectionID OUTPUT

SET @TreeSpeciesID = [dbo].[fn_GetTreeSpeciesID](N'Береза')
SET @QualityClassID = [dbo].[fn_GetQualityClassID](1)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SET @QualityClassID = [dbo].[fn_GetQualityClassID](2)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID

SET @QualityClassID = [dbo].[fn_GetQualityClassID](3)

EXEC [dbo].[sp_AssignSection] @SectionID, @ForestryID, @TreeSpeciesID, @QualityClassID