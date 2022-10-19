create database Cifrado

use Cifrado

create table Usuarios(
Id_usuario int identity(1,1) primary key not null,
Nombre_usuario nvarchar(50) not null,
Contraseña nvarchar(50) not null
)

create procedure NuevoUsuario
@NU nvarchar(50),
@C nvarchar(50)
as
INSERT INTO USUARIOS
VALUES (@NU, 
        ENCRYPTBYPASSPHRASE('C1traseña',@C))

select * from Usuarios

NuevoUsuario 'Evelyn','ecea'

SELECT  Nombre_usuario, CONVERT(VARCHAR(300),
       DECRYPTBYPASSPHRASE('C1traseña',Contraseña))
FROM USUARIOS

INSERT INTO USUARIOS
VALUES ('Aldeamedia', 
        ENCRYPTBYPASSPHRASE('C1traseña','MiContraseña'))
GO

create table usuario_cur(
id bigint identity(1,1) primary key not null,
nombre varchar(50) not null,
apellidos varchar(50) not null,
email varchar(30) not null,
contraseña varbinary(8000) not null
)

CREATE FUNCTION [dbo].[fnColocaClave]
(
    @clave VARCHAR(25)
)
RETURNS VarBinary(8000)
AS
BEGIN

    DECLARE @pass AS VarBinary(8000)
    ------------------------------------
    ------------------------------------
    SET @pass = ENCRYPTBYPASSPHRASE('dbCurso09',@clave)--dbCurso09 es la llave para cifrar el campo.
    ------------------------------------
    ------------------------------------
    RETURN @pass

END

INSERT INTO USUARIO_CUR (nombre, apellidos, email, contraseña)
VALUES('Evelyn','Espinoza','evelynespinoza71@hotmail.com',dbo.fnColocaClave('MscComputacion'))

SELECT *
FROM USUARIO_CUR

CREATE FUNCTION fnLeeClave
(
    @clave VARBINARY(8000)
)
RETURNS VARCHAR(25)
AS
BEGIN

    DECLARE @pass AS VARCHAR(25)
    ------------------------------------
    ------------------------------------
    --Se descifra el campo aplicandole la misma llave con la que se cifro dbCurso09
    SET @pass = DECRYPTBYPASSPHRASE('dbCurso09',@clave)
    ------------------------------------
    ------------------------------------
    RETURN @pass

END

SELECT id, nombre, apellidos, email, dbo.fnLeeClave(contraseña) as Contraseña
FROM USUARIO_CUR

-- usando PwdEncrypt

insert into usuario_cur values('Paola','Zuniga','paolita@yahoo.es',PwdEncrypt('mihijita'))

select * from usuario_cur


-- Comparando la contraseña para determinar si es usuario valido.

Select *
From usuario_cur
Where
nombre = 'Paola' and
PwdCompare('mihijita1',contraseña) = 1

-- En este caso si no regresa registros el password es incorrecto.
