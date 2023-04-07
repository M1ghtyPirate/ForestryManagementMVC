USE [forest]

INSERT INTO [dbo].[TreeSpecies] ([Name],  
        [IsDeciduous],
        [OperationalAgeClass],
        [OptimalFellingAge])
VALUES (N'Сосна', 0, 5, 101),
    (N'Ель', 0, 5, 101),
    (N'Береза', 1, 7, 61),
    (N'Осина', 1, 5, 41),
    (N'Ольха', 1, 5, 41),
    (N'Липа', 1, 5, 81)