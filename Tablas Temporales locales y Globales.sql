-- Tablas Temporales
-- Tabla Temporal Local
use SFCIB

create table #Usuarios(
Id_Usuario int identity(1,1) primary key not null,
LoginU nvarchar(35) not null,
PassU varbinary(8000) not null
)

insert into #Usuarios values('Ecespinoza',1101010)


select * from #Usuarios

-- Tabla Temporal Local
create table ##Usuarios(
Id_Usuario int identity(1,1) primary key not null,
LoginU nvarchar(35) not null,
PassU varbinary(8000) not null
)

insert into ##Usuarios values('Ecespinoza',1101010)


select * from ##Usuarios