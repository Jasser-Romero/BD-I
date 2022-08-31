create database SFCIB

RESTORE DATABASE SFCIB
    FROM DISK = 'F:\SFCIB.bak'
    WITH REPLACE,
    MOVE 'SFCIB' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.CCBB10\MSSQL\DATA\SFCIB_Data.mdf',
    MOVE 'SFCIB_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.CCBB10\MSSQL\DATA\SFCIB_Log.ldf'