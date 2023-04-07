USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetMainFellingAgeClass] (@SectionID UNIQUEIDENTIFIER)
RETURNS INT
AS
BEGIN
    DECLARE @TechnicalAge INT
    DECLARE @RipeAge INT
    DECLARE @OptimalFellingAge INT
    DECLARE @TargetAge INT
    DECLARE @TargetAgeClass INT
    DECLARE @MainFellingAgeClass INT
    DECLARE @IsDeciduous BIT
    DECLARE @TreeSpeciesID UNIQUEIDENTIFIER
    DECLARE @MinAgeDif INT
    DECLARE @MinAreaDif FLOAT

    SELECT @TechnicalAge = [TechnicalAge], @RipeAge = [RipeAge], @IsDeciduous = [IsDeciduous], @TreeSpeciesID = [TreeSpeciesID] 
    FROM [dbo].[view_SectionsTotal] 
    WHERE [SectionID] = @SectionID

    SELECT @OptimalFellingAge = [OptimalFellingAge] 
    FROM [dbo].[TreeSpecies] 
    WHERE [TreeSpeciesID] = @TreeSpeciesID

    SET @TargetAge = ISNULL(@TechnicalAge, @OptimalFellingAge)

    SELECT @MinAgeDif = MIN(ABS(@TargetAge - ([ConiferousMidAge] * ~@IsDeciduous + [DeciduousMidAge] * @IsDeciduous))) 
    FROM [dbo].[AgeClasses]

    SELECT @TargetAgeClass = MIN([Number]) 
    FROM [dbo].[AgeClasses] 
    WHERE ABS(@TargetAge - ([ConiferousMidAge] * ~@IsDeciduous + [DeciduousMidAge] * @IsDeciduous)) = @MinAgeDif
    
    DECLARE @AreaDifByClass TABLE
    (
        [TargetAgeClass] INT,
        [AreaDif] FLOAT,
        [MainFellingAge] INT
    )

    INSERT INTO @AreaDifByClass
    VALUES (@TargetAgeClass - 1, [dbo].[fn_GetFellingClassAreaDif](@SectionID, @TargetAgeClass - 1), [dbo].[fn_GetAgeClassMinAge](@TargetAgeClass - 1, @IsDeciduous)),
        (@TargetAgeClass, [dbo].[fn_GetFellingClassAreaDif](@SectionID, @TargetAgeClass),  [dbo].[fn_GetAgeClassMinAge](@TargetAgeClass, @IsDeciduous)),
        (@TargetAgeClass + 1, [dbo].[fn_GetFellingClassAreaDif](@SectionID, @TargetAgeClass + 1),  [dbo].[fn_GetAgeClassMinAge](@TargetAgeClass + 1, @IsDeciduous))

    SELECT @MinAreaDif = MIN([AreaDif])
    FROM @AreaDifByClass
    WHERE  [AreaDif] IS NOT NULL AND [MainFellingAge] >= @RipeAge
    
    SELECT @MainFellingAgeClass = MIN([TargetAgeClass])
    FROM @AreaDifByClass
    WHERE  [AreaDif]  = @MinAreaDif

	RETURN @MainFellingAgeClass
END
GO

--DROP FUNCTION [dbo].[fn_GetMainFellingAgeClass]