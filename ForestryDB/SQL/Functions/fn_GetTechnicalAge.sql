USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetTechnicalAge] (@TreeSpeciesID UNIQUEIDENTIFIER, @Quality FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MaxProductGrowth FLOAT
	DECLARE @QualityClassID UNIQUEIDENTIFIER
    DECLARE @MinQualityDif FLOAT
    DECLARE @TechnicalAge INT

    SELECT @MinQualityDif = MIN(ABS(@Quality - [SG].[QualityClass])) 
    FROM [dbo].[view_AvgSectionGrowthCalc] AS [SG]
    WHERE [SG].[TreeSpeciesID] = @TreeSpeciesID

    SELECT @QualityClassID = [SG].[QualityClassID]
    FROM [dbo].[view_AvgSectionGrowthCalc] AS [SG]
    WHERE [SG].[TreeSpeciesID] = @TreeSpeciesID AND ABS(@Quality - [SG].[QualityClass]) = @MinQualityDif

    SELECT @MaxProductGrowth = MAX([SG].[AvgProductGrowth])
    FROM [dbo].[view_AvgSectionGrowthCalc] AS [SG]
    WHERE [SG].[TreeSpeciesID] = @TreeSpeciesID AND [SG].[QualityClassID] = @QualityClassID

    SELECT @TechnicalAge = [SG].[Age]
    FROM [dbo].[view_AvgSectionGrowthCalc] AS [SG]
    WHERE [SG].[TreeSpeciesID] = @TreeSpeciesID AND [SG].[QualityClassID] = @QualityClassID AND [SG].[AvgProductGrowth] = @MaxProductGrowth

	RETURN @TechnicalAge
END
GO

--DROP FUNCTION [dbo].[fn_GetTechnicalAge]