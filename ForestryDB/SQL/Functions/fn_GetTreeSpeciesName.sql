USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetTreeSpeciesName] (@TreeSpeciesID UNIQUEIDENTIFIER)
RETURNS NVARCHAR(256)
AS
BEGIN
    DECLARE @TreeSpeciesName NVARCHAR(256)

    SELECT @TreeSpeciesName = [Name] FROM [dbo].[TreeSpecies] WHERE [TreeSpeciesID] = @TreeSpeciesID

    RETURN @TreeSpeciesName
END
GO