USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AddOrUpdateNonForestAreas] (@ForestryID UNIQUEIDENTIFIER, @Field FLOAT, @Pasture FLOAT, @Water FLOAT, @Road FLOAT, @House FLOAT, @Swamp FLOAT, @Other FLOAT, @NonForestAreaID UNIQUEIDENTIFIER OUT)
AS
BEGIN
	DECLARE @NonForestAreaIDs TABLE ([ID] UNIQUEIDENTIFIER)
	DECLARE @GroupExists INT

	SELECT @GroupExists = COUNT(*)
	FROM [dbo].[NonForestAreas]
	WHERE [ForestryID] = @ForestryID

	IF @GroupExists > 0
		UPDATE [dbo].[NonForestAreas]
		SET [Field] = @Field, [Pasture] = @Pasture, [Water] = @Water, [Road] = @Road, [House] = @House, [Swamp] = @Swamp, [Other] = @Other
		OUTPUT inserted.[NonForestAreaID] INTO @NonForestAreaIDs
		WHERE [ForestryID] = @ForestryID
	ELSE
		INSERT INTO [dbo].[NonForestAreas] ([ForestryID], [Field], [Pasture], [Water], [Road], [House], [Swamp], [Other])
		OUTPUT inserted.[NonForestAreaID] INTO @NonForestAreaIDs
		VALUES (@ForestryID, @Field, @Pasture, @Water, @Road, @House, @Swamp, @Other)

	SELECT @NonForestAreaID = [ID] FROM @NonForestAreaIDs
END

--DROP PROCEDURE [dbo].[sp_AddOrUpdateNonForestAreas]