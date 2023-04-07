USE [forest]

GO
CREATE FUNCTION [dbo].[fn_GetLargeOutputPercent] (@TreeSpeciesID UNIQUEIDENTIFIER, @Diameter FLOAT, @Height FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @MinDiameterDif FLOAT
	DECLARE @MinHeightDif FLOAT
	DECLARE @LargePercent FLOAT

	SELECT @MinDiameterDif = MIN(ABS(@Diameter - [AvgDiameter]))
	FROM [dbo].[ProductOutput]
	WHERE [TreeSpeciesID] = @TreeSpeciesID

	SELECT @MinHeightDif = MIN(ABS(@Height - [AvgHeight]))
	FROM [dbo].[ProductOutput]
	WHERE [TreeSpeciesID] = @TreeSpeciesID AND ABS(@Diameter - [AvgDiameter]) = @MinDiameterDif

	SELECT @LargePercent = [LargePercent]
	FROM [dbo].[ProductOutput]
	WHERE [TreeSpeciesID] = @TreeSpeciesID AND ABS(@Diameter - [AvgDiameter]) = @MinDiameterDif AND ABS(@Height - [AvgHeight]) = @MinHeightDif

	RETURN @LargePercent
END
GO