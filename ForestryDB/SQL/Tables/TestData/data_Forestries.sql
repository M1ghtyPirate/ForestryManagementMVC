USE [forest]

INSERT INTO [dbo].[Forestries] ([Name],  
        [AuthorID],
        [IsShared])
VALUES (N'Ладвинское', (SELECT [UserID] FROM [dbo].[Users] WHERE [Login] = N'admin'), 0)