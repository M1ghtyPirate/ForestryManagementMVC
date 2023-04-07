USE [forest]

INSERT INTO [dbo].[Users] ([Login],
        [Password],
        [Email])
VALUES (N'admin', N'admin', N'admin@admin'),
    (N'testUser1', N'123', N'tesuser1@admin'),
    (N'testUser2', N'123', N'tesuser2@admin'),
    (N'testUser3', N'123', N'tesuser3@admin')