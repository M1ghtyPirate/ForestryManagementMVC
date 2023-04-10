USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AddTreeAgeGroup] (@TreeQualityGroupID UNIQUEIDENTIFIER, @AgeClassID UNIQUEIDENTIFIER, @Area FLOAT, @Volume FLOAT, @TreeAgeGroupID UNIQUEIDENTIFIER OUT)
AS
BEGIN
	DECLARE @TreeAgeGroupIDs TABLE ([ID] UNIQUEIDENTIFIER)

	INSERT INTO [dbo].[TreeAgeGroups] ([TreeQualityGroupID], [AgeClassID], [Area], [Volume])
	OUTPUT inserted.[TreeAgeGroupID] INTO @TreeAgeGroupIDs
	VALUES (@TreeQualityGroupID, @AgeClassID, @Area, @Volume)

	SELECT @TreeAgeGroupID = [ID] FROM @TreeAgeGroupIDs
END

--DROP PROCEDURE [dbo].[sp_AddTreeAgeGroup]