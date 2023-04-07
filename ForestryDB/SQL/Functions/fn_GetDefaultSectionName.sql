USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetDefaultSectionName] (@TreeSpeciesID UNIQUEIDENTIFIER, @QualityClassID UNIQUEIDENTIFIER)
RETURNS NVARCHAR(256)
AS
BEGIN
    DECLARE @SectionName NVARCHAR(256)
    DECLARE @IsHigh BIT

    SELECT @SectionName = [Name] FROM [dbo].[TreeSpecies] WHERE [TreeSpeciesID] = @TreeSpeciesID
    SELECT @IsHigh = [IsHigh] FROM [dbo].[QualityClasses] WHERE [QualityClassID] = @QualityClassID

    SET @SectionName += 
        CASE @IsHigh
            WHEN 1 THEN N'. Высокобонитетная секция.'
            ELSE N'. Низкобонитетная секция.'
        END

    RETURN @SectionName
END
GO