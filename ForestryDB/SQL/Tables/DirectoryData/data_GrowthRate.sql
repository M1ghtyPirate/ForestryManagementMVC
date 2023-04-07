USE [forest]

DECLARE @TreeSpeciesID UNIQUEIDENTIFIER

DECLARE @QualityClassID UNIQUEIDENTIFIER

SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = N'Сосна'

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 2

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 20, 6.1, 6.6, 60, 3.0, 3.0),
    (@TreeSpeciesID, @QualityClassID, 30, 9.1, 7.6, 98, 3.3, 3.8),
    (@TreeSpeciesID, @QualityClassID, 40, 11.9, 10.2, 141, 3.5, 4.3),
    (@TreeSpeciesID, @QualityClassID, 50, 14.6, 12.7, 187, 3.7, 4.6),
    (@TreeSpeciesID, @QualityClassID, 60, 17.1, 16.0, 234, 3.9, 4.7),
    (@TreeSpeciesID, @QualityClassID, 70, 19.2, 20.3, 277, 4.0, 4.3),
    (@TreeSpeciesID, @QualityClassID, 80, 21.0, 21.0, 318, 4.0, 4.1),
    (@TreeSpeciesID, @QualityClassID, 90, 22.6, 24.2, 354, 3.9, 3.6),
    (@TreeSpeciesID, @QualityClassID, 100, 24.1, 26.2, 385, 3.8, 3.1),
    (@TreeSpeciesID, @QualityClassID, 110, 25.3, 27.9, 411, 3.7, 2.6),
    (@TreeSpeciesID, @QualityClassID, 120, 26.2, 29.5, 431, 3.6, 2.0),
    (@TreeSpeciesID, @QualityClassID, 130, 26.8, 30.5, 445, 3.4, 1.4),
    (@TreeSpeciesID, @QualityClassID, 140, 27.4, 31.2, 455, 3.2, 1.0)

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 3

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 20, 4.9, 6.1, 46, 2.3, 2.3),
    (@TreeSpeciesID, @QualityClassID, 30, 7.6, 7.4, 78, 2.6, 3.2),
    (@TreeSpeciesID, @QualityClassID, 40, 10.4, 9.1, 111, 2.8, 3.3),
    (@TreeSpeciesID, @QualityClassID, 50, 12.8, 11.4, 150, 3.0, 3.9),
    (@TreeSpeciesID, @QualityClassID, 60, 15.2, 14.0, 188, 3.1, 3.8),
    (@TreeSpeciesID, @QualityClassID, 70, 17.4, 17.7, 224, 3.2, 3.6),
    (@TreeSpeciesID, @QualityClassID, 80, 19.2, 18.6, 257, 3.2, 3.3),
    (@TreeSpeciesID, @QualityClassID, 90, 20.7, 21.3, 287, 3.2, 3.0),
    (@TreeSpeciesID, @QualityClassID, 100, 21.9, 22.9, 311, 3.1, 2.4),
    (@TreeSpeciesID, @QualityClassID, 110, 22.9, 24.4, 330, 3.0, 1.9),
    (@TreeSpeciesID, @QualityClassID, 120, 23.8, 25.9, 347, 2.9, 1.7),
    (@TreeSpeciesID, @QualityClassID, 130, 24.4, 26.7, 360, 2.8, 1.3),
    (@TreeSpeciesID, @QualityClassID, 140, 25.0, 27.7, 367, 2.6, 0.7)

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 4

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 20, 0, 0, 36, 1.8, 1.8),
    (@TreeSpeciesID, @QualityClassID, 30, 6.7, 6.3, 61, 2.0, 2.5),
    (@TreeSpeciesID, @QualityClassID, 40, 9.1, 7.9, 90, 2.2, 2.9),
    (@TreeSpeciesID, @QualityClassID, 50, 11.3, 9.9, 120, 2.4, 3.0),
    (@TreeSpeciesID, @QualityClassID, 60, 13.4, 11.2, 149, 2.5, 2.9),
    (@TreeSpeciesID, @QualityClassID, 70, 15.2, 14.0, 174, 2.5, 2.5),
    (@TreeSpeciesID, @QualityClassID, 80, 16.8, 15.7, 194, 2.3, 2.0),
    (@TreeSpeciesID, @QualityClassID, 90, 18.3, 17.8, 211, 2.3, 1.7),
    (@TreeSpeciesID, @QualityClassID, 100, 19.2, 19.0, 222, 2.2, 1.0),
    (@TreeSpeciesID, @QualityClassID, 110, 19.8, 20.1, 233, 2.1, 0.8),
    (@TreeSpeciesID, @QualityClassID, 120, 20.4, 21.1, 238, 2.0, 0.5),
    (@TreeSpeciesID, @QualityClassID, 130, 21.8, 21.0, 240, 1.8, 0.2)

SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = N'Ель'

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 2

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 20, 5.5, 5.8, 52, 2.6, 2.6),
    (@TreeSpeciesID, @QualityClassID, 30, 8.2, 8.1, 93, 3.1, 4.1),
    (@TreeSpeciesID, @QualityClassID, 40, 11.3, 11.0, 138, 3.4, 4.5),
    (@TreeSpeciesID, @QualityClassID, 50, 14.3, 14.2, 187, 3.7, 5.1),
    (@TreeSpeciesID, @QualityClassID, 60, 17.1, 16.5, 237, 3.9, 5.0),
    (@TreeSpeciesID, @QualityClassID, 70, 19.2, 19.6, 283, 4.0, 4.6),
    (@TreeSpeciesID, @QualityClassID, 80, 21.3, 22.1, 326, 4.1, 4.3),
    (@TreeSpeciesID, @QualityClassID, 90, 23.2, 24.4, 367, 4.1, 4.1),
    (@TreeSpeciesID, @QualityClassID, 100, 25.0, 26.7, 405, 4.0, 3.8),
    (@TreeSpeciesID, @QualityClassID, 110, 26.2, 28.5, 441, 4.0, 3.6),
    (@TreeSpeciesID, @QualityClassID, 120, 27.1, 29.8, 472, 3.9, 3.1),
    (@TreeSpeciesID, @QualityClassID, 130, 27.7, 30.2, 495, 3.8, 2.3),
    (@TreeSpeciesID, @QualityClassID, 140, 28.3, 30.7, 514, 3.7, 1.9)

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 3

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 20, 4.6, 5.3, 38, 1.9, 1.9),
    (@TreeSpeciesID, @QualityClassID, 30, 6.7, 7.1, 72, 2.4, 3.4),
    (@TreeSpeciesID, @QualityClassID, 40, 9.4, 9.7, 110, 2.7, 3.8),
    (@TreeSpeciesID, @QualityClassID, 50, 12.2, 12.0, 148, 3.0, 3.8),
    (@TreeSpeciesID, @QualityClassID, 60, 14.6, 14.2, 188, 3.1, 4.0),
    (@TreeSpeciesID, @QualityClassID, 70, 16.8, 16.5, 226, 3.2, 3.8),
    (@TreeSpeciesID, @QualityClassID, 80, 18.6, 18.7, 260, 3.2, 3.4),
    (@TreeSpeciesID, @QualityClassID, 90, 20.1, 20.8, 289, 3.2, 2.9),
    (@TreeSpeciesID, @QualityClassID, 100, 21.3, 22.7, 314, 3.1, 2.5),
    (@TreeSpeciesID, @QualityClassID, 110, 22.6, 24.4, 335, 3.0, 2.1),
    (@TreeSpeciesID, @QualityClassID, 120, 23.5, 25.3, 354, 3.0, 1.9),
    (@TreeSpeciesID, @QualityClassID, 130, 24.1, 25.8, 367, 2.9, 1.3),
    (@TreeSpeciesID, @QualityClassID, 140, 24.4, 262.2, 376, 2.7, 0.9)

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 4

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 20, 0, 0, 26, 1.3, 1.3),
    (@TreeSpeciesID, @QualityClassID, 30, 5.5, 6.1, 53, 1.8, 2.7),
    (@TreeSpeciesID, @QualityClassID, 40, 7.9, 8.1, 82, 2.0, 2.9),
    (@TreeSpeciesID, @QualityClassID, 50, 10.4, 10.2, 115, 2.3, 3.3),
    (@TreeSpeciesID, @QualityClassID, 60, 12.5, 12.0, 144, 2.6, 2.9),
    (@TreeSpeciesID, @QualityClassID, 70, 14.3, 13.8, 167, 2.4, 2.3),
    (@TreeSpeciesID, @QualityClassID, 80, 15.5, 15.5, 189, 2.4, 2.2),
    (@TreeSpeciesID, @QualityClassID, 90, 16.5, 17.3, 207, 2.3, 1.8),
    (@TreeSpeciesID, @QualityClassID, 100, 17.4, 19.6, 222, 2.2, 1.5),
    (@TreeSpeciesID, @QualityClassID, 110, 18.0, 20.0, 233, 2.1, 1.1),
    (@TreeSpeciesID, @QualityClassID, 120, 18.6, 20.8, 239, 2.0, 0.6),
    (@TreeSpeciesID, @QualityClassID, 130, 18.9, 21.3, 242, 1.3, 0.3)

SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = N'Береза'

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 2

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 20, 8.6, 6.3, 72, 3.6, 3.6),
    (@TreeSpeciesID, @QualityClassID, 30, 11.6, 8.6, 108, 3.6, 3.6),
    (@TreeSpeciesID, @QualityClassID, 40, 14.3, 11.9, 146, 3.6, 3.8),
    (@TreeSpeciesID, @QualityClassID, 50, 16.8, 15.0, 186, 3.7, 4.0),
    (@TreeSpeciesID, @QualityClassID, 60, 19.2, 18.3, 227, 3.8, 4.1),
    (@TreeSpeciesID, @QualityClassID, 70, 21.6, 21.1, 265, 3.8, 3.8),
    (@TreeSpeciesID, @QualityClassID, 80, 23.5, 23.1, 297, 3.7, 3.2),
    (@TreeSpeciesID, @QualityClassID, 90, 24.7, 24.6, 317, 3.5, 2.0),
    (@TreeSpeciesID, @QualityClassID, 100, 25.3, 26.2, 331, 3.3, 1.4)

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 3

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 20, 7.0, 5.6, 56, 2.8, 2.8),
    (@TreeSpeciesID, @QualityClassID, 30, 9.8, 7.6, 86, 2.9, 3.0),
    (@TreeSpeciesID, @QualityClassID, 40, 12.5, 10.4, 116, 2.9, 3.0),
    (@TreeSpeciesID, @QualityClassID, 50, 14.9, 13.0, 150, 3.0, 3.4),
    (@TreeSpeciesID, @QualityClassID, 60, 17.4, 15.7, 181, 3.0, 3.1),
    (@TreeSpeciesID, @QualityClassID, 70, 19.2, 18.0, 210, 3.0, 2.9),
    (@TreeSpeciesID, @QualityClassID, 80, 20.4, 19.8, 232, 2.9, 2.2),
    (@TreeSpeciesID, @QualityClassID, 90, 21.3, 21.8, 244, 2.7, 1.2),
    (@TreeSpeciesID, @QualityClassID, 100, 21.9, 22.3, 248, 2.5, 0.4)

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 4

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 20, 6.1, 5.1, 45, 2.2, 2.2),
    (@TreeSpeciesID, @QualityClassID, 30, 8.5, 6.9, 68, 2.3, 2.3),
    (@TreeSpeciesID, @QualityClassID, 40, 11.0, 8.9, 92, 2.3, 2.4),
    (@TreeSpeciesID, @QualityClassID, 50, 12.1, 10.9, 117, 2.3, 2.5),
    (@TreeSpeciesID, @QualityClassID, 60, 15.2, 13.0, 140, 2.3, 2.3),
    (@TreeSpeciesID, @QualityClassID, 70, 16.8, 15.0, 159, 2.3, 1.9),
    (@TreeSpeciesID, @QualityClassID, 80, 18.0, 16.3, 171, 2.1, 2.1),
    (@TreeSpeciesID, @QualityClassID, 90, 18.6, 17.8, 176, 2.0, 0.5)

SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = N'Осина'

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 2

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 10, 5.3, 4.6, 40, 4.0, 4.0),
    (@TreeSpeciesID, @QualityClassID, 20, 9.4, 8.0, 90, 5.0, 4.5),
    (@TreeSpeciesID, @QualityClassID, 30, 13.1, 11.2, 145, 5.5, 4.8),
    (@TreeSpeciesID, @QualityClassID, 40, 16.4, 14.6, 201, 5.6, 5.0),
    (@TreeSpeciesID, @QualityClassID, 50, 18.9, 17.3, 253, 5.2, 5.1),
    (@TreeSpeciesID, @QualityClassID, 60, 20.9, 19.6, 297, 4.4, 5.0),
    (@TreeSpeciesID, @QualityClassID, 70, 22.3, 21.3, 332, 3.5, 4.7),
    (@TreeSpeciesID, @QualityClassID, 80, 23.5, 22.6, 357, 2.5, 4.5),
    (@TreeSpeciesID, @QualityClassID, 90, 24.0, 23.5, 372, 1.5, 4.2)

SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = 3

INSERT INTO [dbo].[GrowthRate] ([TreeSpeciesID],
        [QualityClassID],
        [Age],
        [AvgHeight],
        [AvgDiameter],
        [VolumePerHectare],
        [AvgGrowth],
        [CurrentGrowth])
VALUES (@TreeSpeciesID, @QualityClassID, 10, 4.3, 3.8, 28, 2.8, 2.8),
    (@TreeSpeciesID, @QualityClassID, 20, 7.9, 6.8, 70, 4.2, 3.5),
    (@TreeSpeciesID, @QualityClassID, 30, 11.2, 9.7, 116, 4.6, 3.9),
    (@TreeSpeciesID, @QualityClassID, 40, 14.2, 12.3, 162, 4.6, 4.0),
    (@TreeSpeciesID, @QualityClassID, 50, 16.4, 14.6, 203, 4.1, 4.0),
    (@TreeSpeciesID, @QualityClassID, 60, 18.1, 16.2, 235, 3.2, 3.9),
    (@TreeSpeciesID, @QualityClassID, 70, 19.2, 17.6, 260, 2.5, 3.7),
    (@TreeSpeciesID, @QualityClassID, 80, 20.1, 18.5, 278, 1.8, 3.5)