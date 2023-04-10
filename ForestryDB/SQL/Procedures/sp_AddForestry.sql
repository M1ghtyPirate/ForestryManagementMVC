USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AddForestry] (@ForestryName NVARCHAR(256), @AuthorID UNIQUEIDENTIFIER, @ForestryID UNIQUEIDENTIFIER OUT)
AS
BEGIN
	DECLARE @ForestryIDs TABLE ([ID] UNIQUEIDENTIFIER)

	INSERT INTO [dbo].[Forestries] ([Name], [AuthorID])
	OUTPUT inserted.[ForestryID] INTO @ForestryIDs
	VALUES (@ForestryName, @AuthorID)

	SELECT @ForestryID = [ID] FROM @ForestryIDs
END

--DROP PROCEDURE [dbo].[sp_AddForestry]