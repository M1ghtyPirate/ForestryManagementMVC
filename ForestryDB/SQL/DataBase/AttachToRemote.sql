IF NOT EXISTS (SELECT * FROM master.sys.databases WHERE name='forest')
CREATE DATABASE forest   
    ON (FILENAME = N'/var/opt/mssql/data/forest.mdf'),   
    (FILENAME = N'/var/opt/mssql/data/forest_Log.ldf')   
    FOR ATTACH;

--EXEC sp_detach_db 'forest', 'true';