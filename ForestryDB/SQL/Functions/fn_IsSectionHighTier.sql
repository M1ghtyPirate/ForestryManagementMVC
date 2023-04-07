USE [forest]

GO
CREATE FUNCTION [dbo].[fn_IsSectionHighTier] (@SectionID UNIQUEIDENTIFIER)
RETURNS BIT
AS
BEGIN
	DECLARE @LowTierAreas INT

	SELECT @LowTierAreas = COUNT(*)
	FROM [dbo].[view_TreeGroups] AS [TG]
	WHERE [TG].[SectionID] = @SectionID AND [TG].[IsHigh] = 0

	RETURN 
		CASE
			WHEN @LowTierAreas = 0 THEN 1
			ELSE 0
		END
END
GO