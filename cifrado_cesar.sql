--Cifrado Cesar:Es un tipo de cifrado por sustitución en el que una letra en el texto original
--es reemplazada por otra letra que se encuentra un número fijo de posiciones más adelante en el alfabeto.
--El numero de desplazamientos utlizados por el emperador Cesar era de 3 espacios hacia la derecha,
--El script esta preparado para usar por defecto ese numero de desplazamientos, sino se le brinda el valor a esta variable del SP (Store Procedure).

--Creamos la Base de Datos que utilizaremos para el ejercicio.
USE [master]
GO
IF EXISTS (SELECT * FROM sysdatabases WHERE NAME= 'CIFRADO_CESAR')
DROP DATABASE CIFRADO_CESAR
GO
CREATE DATABASE CIFRADO_CESAR
GO
USE CIFRADO_CESAR
GO

--Condicion que me permite eliminar el SP SP_Cifrado_Cesar si ya existe.
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..SP_Cifrado_Cesar')) 
DROP PROC SP_Cifrado_Cesar
GO
--Creamos Procedimiento Almacenado que nos permitira realizar el Cifrado del Cesar.
CREATE PROCEDURE SP_Cifrado_Cesar(@Frase VARCHAR(MAX),@Skip INT = 3)
AS
BEGIN
-------------------------------------------------------------
DECLARE @Ascii TABLE (Id INT,Letter CHAR(1),Number int)
DECLARE @Length INT = 27
--
SET @Skip=@Skip%@Length

--Creacion y almacenamiento de alfabeto mediante CTE (incluye recursividad)
;WITH data
AS 
(
SELECT 0 id,CAST('A' AS CHAR(1)) letter,Ascii('A') number
UNION ALL
SELECT a.id+1 id,
       CASE WHEN a.letter='N' THEN CAST('Ñ' AS CHAR(1))
            WHEN a.letter='Ñ' THEN CAST('O' AS CHAR(1))
            ELSE CHAR(a.number+1) 
       END letter,
       CASE WHEN a.letter='N' THEN ASCII('Ñ')
            WHEN a.letter='Ñ' THEN ASCII('O')
            ELSE a.number+1 
       END number
FROM   data a     
WHERE  a.letter<>'Z'
)
--
INSERT INTO @Ascii
SELECT *
FROM DATA
-------------------------------------------------------------
DECLARE @i INT=1
DECLARE @NewAscii INT
DECLARE @NewFrase VARCHAR(MAX)

--Bucle para recorrer la palabra que se quiere cifrar.
WHILE @i<=LEN(@Frase)
	BEGIN
		  SET @i=@i+1
		  --
		  DECLARE @Char CHAR(1) = UPPER(SUBSTRING(@Frase,@i-1,1))
		  --
		  IF EXISTS(SELECT 'x' FROM @Ascii a WHERE a.Letter=@Char)
		  BEGIN
				SELECT @NewAscii= CASE 
											 WHEN (a.Id+@Skip)<0 THEN @Length+(a.Id+@Skip)
											 ELSE (a.Id+@Skip)%@Length
										 END  
				FROM @Ascii a WHERE a.Letter=@Char
				PRINT @NewAscii
				--                                   
				SELECT @NewFrase=isnull(@NewFrase,'')+
									   (SELECT a.Letter FROM @Ascii a WHERE a.Id=@NewAscii)
		  END
		  ELSE
				SELECT @NewFrase=isnull(@NewFrase,'')+@Char
	END
--
SELECT 1 IdColumna,@Frase Frase 
--UNION //Si se quiere ver en un solo select habilita el UNION
SELECT 2 IdColumna,@NewFrase FraseCifrada
END

--Ejecucion del SP
EXEC SP_Cifrado_Cesar 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ'
GO
EXEC SP_Cifrado_Cesar 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ', - 1
GO
EXEC SP_Cifrado_Cesar 'Cesar', 1
