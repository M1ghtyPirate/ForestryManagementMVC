USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AddOrUpdateTreeGroup] (@ForestryID UNIQUEIDENTIFIER, @TreeSpeciesName NVARCHAR(256), @QualityClass INT, @AgeClass INT, @Area FLOAT, @Volume FLOAT, @TreeAgeGroupID UNIQUEIDENTIFIER OUT)
AS
BEGIN
	DECLARE @TreeSpeciesID UNIQUEIDENTIFIER

	SET @TreeSpeciesID = [dbo].[fn_GetTreeSpeciesID](@TreeSpeciesName)
	
	IF (@QualityClass < 1 OR @QualityClass > 6) OR (@AgeClass < 1 OR @AgeClass > 8) OR @TreeSpeciesID IS NULL
		RETURN

	DECLARE @TreeQualityGroupIDs TABLE ([ID] UNIQUEIDENTIFIER)
	DECLARE @QualityClassID UNIQUEIDENTIFIER
	DECLARE @AgeClassID UNIQUEIDENTIFIER
	DECLARE @TreeQualityGroupID UNIQUEIDENTIFIER

	SET @QualityClassID = [dbo].[fn_GetQualityClassID](@QualityClass)
	SET @AgeClassID = [dbo].[fn_GetAgeClassID](@AgeClass)

	SELECT @TreeQualityGroupID = [TreeQualityGroupID]
	FROM [dbo].[TreeQualityGroups]
	WHERE [ForestryID] = @ForestryID AND [TreeSpeciesID] = @TreeSpeciesID AND [QualityClassID] = @QualityClassID

	IF @TreeQualityGroupID IS NULL
	BEGIN
		INSERT INTO [dbo].[TreeQualityGroups] ([ForestryID], [TreeSpeciesID], [QualityClassID])
		OUTPUT inserted.[TreeQualityGroupID] INTO @TreeQualityGroupIDs
		VALUES (@ForestryID, @TreeSpeciesID, @QualityClassID)

		SELECT @TreeQualityGroupID = [ID] FROM @TreeQualityGroupIDs
	END

	EXEC [dbo].[sp_AddOrUpdateTreeAgeGroup] @TreeQualityGroupID, @AgeClassID, @Area, @Volume, @TreeAgeGroupID
END

--DROP PROCEDURE [dbo].[sp_AddOrUpdateTreeGroup]