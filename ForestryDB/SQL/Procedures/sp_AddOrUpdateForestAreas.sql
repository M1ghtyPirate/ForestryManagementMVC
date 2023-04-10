USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AddOrUpdateForestAreas] (@ForestryID UNIQUEIDENTIFIER, @Felling FLOAT, @Burnt FLOAT, @Empty FLOAT, @Thin FLOAT, @ForestAreaID UNIQUEIDENTIFIER OUT)
AS
BEGIN
	DECLARE @ForestAreaIDs TABLE ([ID] UNIQUEIDENTIFIER)
	DECLARE @GroupExists INT

	SELECT @GroupExists = COUNT(*)
	FROM [dbo].[ForestAreas]
	WHERE [ForestryID] = @ForestryID

	IF @GroupExists > 0
		UPDATE [dbo].[ForestAreas]
		SET [Felling] = @Felling, [Burnt] = @Burnt, [Empty] = @Empty, [Thin] = @Thin
		OUTPUT inserted.[ForestAreaID] INTO @ForestAreaIDs
		WHERE [ForestryID] = @ForestryID
	ELSE
		INSERT INTO [dbo].[ForestAreas] ([ForestryID], [Felling], [Burnt], [Empty], [Thin])
		OUTPUT inserted.[ForestAreaID] INTO @ForestAreaIDs
		VALUES (@ForestryID, @Felling, @Burnt, @Empty, @Thin)

	SELECT @ForestAreaID = [ID] FROM @ForestAreaIDs
END

--DROP PROCEDURE [dbo].[sp_AddOrUpdateForestAreas]