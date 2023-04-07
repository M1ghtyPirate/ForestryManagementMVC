USE [forest]

DECLARE @ForestryID UNIQUEIDENTIFIER
DECLARE @TreeSpeciesID UNIQUEIDENTIFIER
DECLARE @QualityClassID UNIQUEIDENTIFIER
DECLARE @QualityClass INT
DECLARE @TreeNames TABLE ([Name] NVARCHAR(256))

SELECT TOP(1) @ForestryID = [ForestryID] FROM [dbo].[Forestries] WHERE [Name] = N'Ладвинское'

INSERT INTO @TreeNames ([Name])
VALUES (N'Сосна'), (N'Ель'), (N'Береза')

DECLARE @TreeName NVARCHAR(256)

DECLARE TSNAME_CURSOR CURSOR
	LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR
SELECT [Name] FROM @TreeNames

OPEN TSNAME_CURSOR
	FETCH NEXT FROM TSNAME_CURSOR INTO @TreeName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @TreeSpeciesID = [TreeSpeciesID] FROM [dbo].[TreeSpecies] WHERE [Name] = @TreeName
		SET @QualityClass = 1
		WHILE @QualityClass < 6
		BEGIN
			IF @QualityClass = 1 AND @TreeName = N'Ель'
			BEGIN
				SET @QualityClass += 1
				CONTINUE
			END
			IF @QualityClass > 3 AND @TreeName = N'Береза' BREAK
			SELECT @QualityClassID = [QualityClassID] FROM [dbo].[QualityClasses] WHERE [Number] = @QualityClass
			INSERT INTO [dbo].[TreeQualityGroups] ([ForestryID],
					[TreeSpeciesID],
					[QualityClassID])
			VALUES (@ForestryID, @TreeSpeciesID, @QualityClassID)
			SET @QualityClass += 1 
		END
		FETCH NEXT FROM TSNAME_CURSOR INTO @TreeName
	END
CLOSE TSNAME_CURSOR
DEALLOCATE TSNAME_CURSOR