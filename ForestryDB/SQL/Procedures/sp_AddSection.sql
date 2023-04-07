USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AddSection] (@SectionName NVARCHAR(256), @ForestryID UNIQUEIDENTIFIER, @TreeSpeciesID UNIQUEIDENTIFIER, @QualityClassID UNIQUEIDENTIFIER)
AS
BEGIN
	DECLARE @SectionID UNIQUEIDENTIFIER

	INSERT INTO [dbo].[Sections] ([Name])
	OUTPUT inserted.[SectionID] INTO @SectionID
	VALUES (@SectionName)

	UPDATE [dbo].[TreeQualityGroups]
	SET [SectionID] = @SectionID
	WHERE [ForestryID] = @ForestryID AND [TreeSpeciesID] = @TreeSpeciesID AND [QualityClassID] = @QualityClassID
END