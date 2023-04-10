USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AddTreeQualityGroup] (@ForestryID UNIQUEIDENTIFIER, @TreeSpeciesID UNIQUEIDENTIFIER, @QualityClassID UNIQUEIDENTIFIER, @TreeQualityGroupID UNIQUEIDENTIFIER OUT)
AS
BEGIN
	DECLARE @TreeQualityGroupIDs TABLE ([ID] UNIQUEIDENTIFIER)

	INSERT INTO [dbo].[TreeQualityGroups] ([ForestryID], [TreeSpeciesID], [QualityClassID])
	OUTPUT inserted.[TreeQualityGroupID] INTO @TreeQualityGroupIDs
	VALUES (@ForestryID, @TreeSpeciesID, @QualityClassID)

	SELECT @TreeQualityGroupID = [ID] FROM @TreeQualityGroupIDs
END

--DROP PROCEDURE [dbo].[sp_AddTreeQualityGroup]