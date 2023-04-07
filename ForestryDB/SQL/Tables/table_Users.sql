USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users')
    CREATE TABLE [dbo].[Users]
    (
	    [UserID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [Login] NVARCHAR(256) NOT NULL
            CONSTRAINT [UC_Login] UNIQUE,  
        [Password] NVARCHAR(256) NOT NULL,
        [Email] NVARCHAR(254),
        [RegDate] DATETIME
            DEFAULT (GETDATE()),
        [LoginDate] DATETIME
    )