USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetRipeAge] (@TreeSpeciesID UNIQUEIDENTIFIER, @Quality FLOAT)
RETURNS INT
AS
BEGIN
    DECLARE @QualityClass INT
    DECLARE @QualityClassID UNIQUEIDENTIFIER
    DECLARE @RipeAge INT
    DECLARE @MaxAvgGrowth FLOAT
    DECLARE @MinGrowthDif FLOAT
    DECLARE @GrowthRateID UNIQUEIDENTIFIER
    DECLARE @MinQualityDif FLOAT

    SELECT @MinQualityDif = MIN(ABS(@Quality - [QC].[Number])) 
    FROM [dbo].[GrowthRate] AS [GR]
        JOIN [dbo].[QualityClasses] AS [QC]
            ON [GR].[QualityClassID] = [QC].[QualityClassID]
    WHERE [GR].[TreeSpeciesID] = @TreeSpeciesID

    SELECT @QualityClass = MAX([QC].[Number])
    FROM [dbo].[GrowthRate] AS [GR]
        JOIN [dbo].[QualityClasses] AS [QC]
            ON [GR].[QualityClassID] = [QC].[QualityClassID]
    WHERE [GR].[TreeSpeciesID] = @TreeSpeciesID AND ABS(@Quality - [QC].[Number]) = @MinQualityDif

    SELECT @QualityClassID = [QC].[QualityClassID]
    FROM [dbo].[QualityClasses] AS [QC]
    WHERE [QC].[Number] = @QualityClass

    SELECT @MaxAvgGrowth = MAX([GR].[AvgGrowth])
    FROM [dbo].[GrowthRate] AS [GR]
    WHERE [GR].[TreeSpeciesID] = @TreeSpeciesID AND [GR].[QualityClassID] = @QualityClassID

    SELECT @MinGrowthDif = MIN(ABS([AvgGrowth] - [CurrentGrowth]))
    FROM [dbo].[GrowthRate] AS [GR]
    WHERE [GR].[TreeSpeciesID] = @TreeSpeciesID AND [GR].[QualityClassID] = @QualityClassID AND [GR].[AvgGrowth] = @MaxAvgGrowth

    SELECT @RipeAge = MIN([Age])
    FROM [dbo].[GrowthRate] AS [GR]
    WHERE [GR].[TreeSpeciesID] = @TreeSpeciesID AND [GR].[QualityClassID] = @QualityClassID AND [GR].[AvgGrowth] = @MaxAvgGrowth AND ABS([AvgGrowth] - [CurrentGrowth]) = @MinGrowthDif

    RETURN @RipeAge
END
GO

--DROP FUNCTION [dbo].[fn_GetRipeAge]