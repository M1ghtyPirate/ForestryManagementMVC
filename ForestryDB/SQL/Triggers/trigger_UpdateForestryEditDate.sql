USE [forest]

CREATE TRIGGER [dbo].[trigger_UpdateForestryEditDate]
ON [dbo].[ForestAreas]
AFTER INSERT, UPDATE, DELETE
AS
	
GO 