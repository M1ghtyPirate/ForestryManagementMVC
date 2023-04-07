IF NOT EXISTS (SELECT * FROM master.sys.databases WHERE name='forest')
CREATE DATABASE forest   
    ON (FILENAME = 'E:\Guest\POLITECH\session5-2022\ВКР\ForestryManagementMVC\ForestryDB\SQL\DataBase\forest.mdf'),   
    (FILENAME = 'E:\Guest\POLITECH\session5-2022\ВКР\ForestryManagementMVC\ForestryDB\SQL\DataBase\forest_Log.ldf')   
    FOR ATTACH;

--EXEC sp_detach_db 'forest', 'true';