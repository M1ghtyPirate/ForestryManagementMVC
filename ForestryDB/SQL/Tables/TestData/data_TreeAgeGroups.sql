USE [forest]

DECLARE @ForestryID UNIQUEIDENTIFIER
DECLARE @TreeQualityGroupID UNIQUEIDENTIFIER

SELECT TOP(1) @ForestryID = [ForestryID] FROM [dbo].[Forestries] WHERE [Name] = N'Ладвинское'
SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Сосна', 2)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 6, 0),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 11, 1270),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 51, 11370),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 32, 6470),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 18, 4680),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 32, 6470)

SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Сосна', 3)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 235, 8500),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 458, 39390),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 475, 57380),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 116, 23840),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 30, 7720),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 91, 24900),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 37, 10850),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 120, 36360)

SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Сосна', 4)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 86, 1800),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 63, 2540),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 207, 16000),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 80, 6180),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 31, 5760),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 202, 42390),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 202, 50200),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 659, 156320)

SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Сосна', 5)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 20, 0),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 78, 2490),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 117, 4200),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 481, 26100),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 470, 20930),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 245, 22590),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 165, 17860),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 837, 104690)

SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Ель', 2)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 13, 1140),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 194, 35480),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 117, 28660),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 82, 26740)

SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Ель', 3)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 725, 6900),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 550, 40630),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 1023, 116880),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 1982, 309720),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 897, 200830),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 294, 73670),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 310, 80130),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 5283, 1323480)

SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Ель', 4)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](1), 35, 0),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 90, 3020),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 793, 77840),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 1105, 109070),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 630, 90560),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 670, 127160),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 494, 109240),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 3034, 649440)

SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Ель', 5)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 3, 240),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 38, 2340),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 1215, 39190),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 361, 26500),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 293, 26780),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 212, 23730),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 773, 36270)

SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Береза', 1)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 5, 950)

SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Береза', 2)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 95, 6430),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 121, 11180),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 74, 10240),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 58, 10540),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 33, 8130),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 40, 13560)

SET @TreeQualityGroupID = [dbo].[fn_GetTreeQualityGroupID](@ForestryID, N'Береза', 3)

INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID],
        [AgeClassID],
        [Area],
        [Volume])
VALUES (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](2), 272, 6130),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](3), 80, 5430),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](4), 280, 27500),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](5), 415, 51140),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](6), 224, 44010),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](7), 394, 64320),
    (@TreeQualityGroupID, [dbo].[fn_GetAgeClassID](8), 265, 89500)