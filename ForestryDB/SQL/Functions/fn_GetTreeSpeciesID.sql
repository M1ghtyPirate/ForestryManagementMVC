USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetTreeSpeciesID] (@TreeSpeciesName NVARCHAR(256))
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @TreeSpeciesID UNIQUEIDENTIFIER

    SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = @TreeSpeciesName

    RETURN @TreeSpeciesID
END
GO