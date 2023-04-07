USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetTreeQualityGroupID] (@ForestryID UNIQUEIDENTIFIER, @TreeSpeciesName NVARCHAR(256), @QualityClass INT)
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @TreeSpeciesID UNIQUEIDENTIFIER
    DECLARE @QualityClassID UNIQUEIDENTIFIER
    DECLARE @TreeQualityGroupID UNIQUEIDENTIFIER

    SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = @TreeSpeciesName
    SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = @QualityClass

    SELECT @TreeQualityGroupID = [TreeQualityGroupID] 
    FROM [dbo].[TreeQualityGroups] 
    WHERE [ForestryID] = @ForestryID 
        AND [TreeSpeciesID] = @TreeSpeciesID 
        AND [QualityClassID] = @QualityClassID

    RETURN @TreeQualityGroupID
END
GO