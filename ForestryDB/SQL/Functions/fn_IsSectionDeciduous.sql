USE [forest]

GO
CREATE FUNCTION [dbo].[fn_IsSectionDeciduous] (@SectionID UNIQUEIDENTIFIER)
RETURNS BIT
AS
BEGIN
	DECLARE @ConiferousAreas INT

	SELECT @ConiferousAreas = COUNT(*)
	FROM [dbo].[view_TreeGroups] AS [TG]
	WHERE [TG].[SectionID] = @SectionID AND [TG].[IsDeciduous] = 0

	RETURN 
		CASE
			WHEN @ConiferousAreas = 0 THEN 1
			ELSE 0
		END
END
GO