USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AddSection] (@ForestryID UNIQUEIDENTIFIER, @SectionName NVARCHAR(256), @SectionID UNIQUEIDENTIFIER OUT)
AS
BEGIN
	DECLARE @SectionIDs TABLE ([ID] UNIQUEIDENTIFIER)

	INSERT INTO [dbo].[Sections] ([Name])
	OUTPUT inserted.[SectionID] INTO @SectionIDs
	VALUES (@SectionName)

	SELECT @SectionID = [ID] FROM @SectionIDs
END

--DROP PROCEDURE [dbo].[sp_AddSection]