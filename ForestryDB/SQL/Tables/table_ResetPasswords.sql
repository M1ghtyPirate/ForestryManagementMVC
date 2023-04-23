USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ResetPasswords')
    CREATE TABLE [dbo].[ResetPasswords]
    (
	    [ResetPasswordID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [UserID] UNIQUEIDENTIFIER NOT NULL 
            FOREIGN KEY REFERENCES [dbo].[Users] ([UserID])
            CONSTRAINT [UC_UserID] UNIQUE,
        [ResetPasswordHashed] BINARY(32) NOT NULL,
        [GenerationDate] DATETIME
            DEFAULT (GETDATE())
    )
--DROP TABLE [dbo].[ResetPasswords]