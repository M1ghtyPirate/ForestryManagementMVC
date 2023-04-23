USE [forest]

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='EmailCreditentials')
    CREATE TABLE [dbo].[EmailCreditentials]
    (
	    [EmailCreditentialsID] UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY, 
        [Email] NVARCHAR(254) NOT NULL,
        [Username] NVARCHAR(254) NOT NULL,
        [Password] NVARCHAR(1000) NOT NULL,
        [SMTPHost] NVARCHAR(1000) NOT NULL,
        [SMTPPort] INT NOT NULL,
        [EnableSSL] BIT NOT NULL,
        [EmailType] INT NOT NULL
            CONSTRAINT [UC_EmailType] UNIQUE,
    )
--DROP TABLE [dbo].[EmailCreditentials]