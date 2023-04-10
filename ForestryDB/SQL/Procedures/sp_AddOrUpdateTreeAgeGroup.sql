USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AddOrUpdateTreeAgeGroup] (@TreeQualityGroupID UNIQUEIDENTIFIER, @AgeClassID UNIQUEIDENTIFIER, @Area FLOAT, @Volume FLOAT, @TreeAgeGroupID UNIQUEIDENTIFIER OUT)
AS
BEGIN
	DECLARE @TreeAgeGroupIDs TABLE ([ID] UNIQUEIDENTIFIER)
	DECLARE @GroupExists INT

	SELECT @GroupExists = COUNT(*)
	FROM [dbo].[TreeAgeGroups]
	WHERE [TreeQualityGroupID] = @TreeAgeGroupID AND [AgeClassID] = @AgeClassID

	IF @GroupExists > 0
		UPDATE [dbo].[TreeAgeGroups]
		SET [Area] = @Area, [Volume] = @Volume
		OUTPUT inserted.[TreeAgeGroupID] INTO @TreeAgeGroupIDs
		WHERE [TreeQualityGroupID] = @TreeQualityGroupID AND [AgeClassID] = @AgeClassID
	ELSE
		INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID], [AgeClassID], [Area], [Volume])
		OUTPUT inserted.[TreeAgeGroupID] INTO @TreeAgeGroupIDs
		VALUES (@TreeQualityGroupID, @AgeClassID, @Area, @Volume)

	SELECT @TreeAgeGroupID = [ID] FROM @TreeAgeGroupIDs
END

--DROP PROCEDURE [dbo].[sp_AddOrUpdateTreeAgeGroup]