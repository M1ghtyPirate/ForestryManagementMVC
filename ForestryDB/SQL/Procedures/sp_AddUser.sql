USE [forest]

GO
CREATE PROCEDURE [dbo].[sp_AddUser] (@Login NVARCHAR(256), @Password NVARCHAR(256), @Email NVARCHAR(256), @UserID UNIQUEIDENTIFIER OUT)
AS
BEGIN
	DECLARE @UserIDs TABLE ([ID] UNIQUEIDENTIFIER)

	INSERT INTO [dbo].[Users] ([Login], [Password], [Email])
	OUTPUT inserted.[UserID] INTO @UserIDs
	VALUES (@Login, @Password, @Email)

	SELECT @UserID = [ID] FROM @UserIDs
END

--DROP PROCEDURE [dbo].[sp_AddUser]