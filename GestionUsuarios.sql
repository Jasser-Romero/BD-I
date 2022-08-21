-- Crear BD en blanco
create database SICIF
-- abrir la BD
use SICIF

create table Proveedor(
Id_prov int identity(1,1) primary key not null,
NombreProv nvarchar(40) not null,
DirP nvarchar(50) not null
)

insert into Proveedor values('GRUMA','Carretera a Masaya'),
('FEMSA','Carretera Norte')

select * from Proveedor

-- Usuario Administrador
sp_addlogin 'Evelyn','Ecespinoza2022*','SICIF'
sp_addsrvrolemember 'Evelyn','sysadmin'
sp_adduser 'Evelyn','Phd'
sp_addrolemember 'db_ddladmin','Phd'

-- Usuario solo lectura
sp_addlogin 'Estudiantes','ESistemas2022*','SICIF'
sp_addsrvrolemember 'Estudiantes','processadmin'
use SICIF
sp_adduser 'Estudiantes','Estudiantes'
sp_addrolemember 'db_denydatawriter','Estudiantes'
sp_addrolemember 'db_datareader','Estudiantes'

revoke create table, create view, create procedure to Estudiantes

deny insert, delete, update on Proveedor to Estudiantes

-- Usuario solo escritura
sp_addlogin 'Cajero','Cajero2022*','SICIF'
sp_addsrvrolemember 'Cajero','processadmin'
use SICIF
sp_adduser 'Cajero','Cajero'
sp_addrolemember 'db_denydatareader','Cajero'
sp_addrolemember 'db_datawriter','Cajero'

revoke create table, create view, create procedure to Cajero

deny select on Proveedor to Cajero

-- Usuario L/E
sp_addlogin 'Docente','Docente2022*','SICIF'
sp_addsrvrolemember 'Docente','dbcreator'
sp_adduser 'Docente','DUNI'
sp_addrolemember 'db_datawriter','DUNI'
sp_addrolemember 'db_datareader','DUNI'

revoke create table, create view, create procedure to DUNI