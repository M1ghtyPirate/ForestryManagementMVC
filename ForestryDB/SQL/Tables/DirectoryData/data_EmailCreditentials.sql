USE [forest]

INSERT INTO [dbo].[EmailCreditentials] 
(
        [Email],
        [Username],
        [Password],
        [SMTPHost],
        [SMTPPort],
        [EnableSSL],
        [EmailType]
)
VALUES (N'forestrymvc2023@rambler.ru', N'forestrymvc2023@rambler.ru', N'P@ssw0rd', N'smtp.rambler.ru', 587, 1, 0)