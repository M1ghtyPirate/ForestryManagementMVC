USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AssignSection] (@SectionID UNIQUEIDENTIFIER, @ForestryID UNIQUEIDENTIFIER, @TreeSpeciesID UNIQUEIDENTIFIER, @QualityClassID UNIQUEIDENTIFIER)
AS
BEGIN
	UPDATE [dbo].[TreeQualityGroups]
	SET [SectionID] = @SectionID
	WHERE [ForestryID] = @ForestryID AND [TreeSpeciesID] = @TreeSpeciesID AND [QualityClassID] = @QualityClassID
END