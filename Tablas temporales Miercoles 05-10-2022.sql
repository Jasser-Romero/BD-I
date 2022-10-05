

-- CTE ( Common Table Expressions )

-- A diferencia de las anteriores, este tipo de tabla temporal 
-- solo puede ser utilizado durante la ejecución del bloque de código y 
-- solo en una ocasión después de haber declarado el CTE.

use SFCIB

select *  from Municipios

;WITH nombreMun  ( Identificar , Nombre)
AS
(
       SELECT Id_Mun, NombreMun FROM Municipios
)
SELECT * FROM nombreMun


-- VARIABLES TIPO TABLA

-- Desde hace algunas versiones de SQL SERVER, se agregó la variable 
-- tipo TABLA, al igual que los CTE, solo están vigente durante la 
-- ejecución del bloque de código.

DECLARE @RegMun TABLE( Ident INT, Datos NVARCHAR(45) )

INSERT INTO @RegMun
SELECT Id_Mun, NombreMun FROM Municipios

SELECT * FROM @RegMun


-- tabla temporal con manejo de version del sistema
CREATE TABLE dbo.Trabajador   
(    
  [EmployeeID] int NOT NULL PRIMARY KEY CLUSTERED   
  , [Name] nvarchar(100) NOT NULL  
  , [Position] varchar(100) NOT NULL   
  , [Department] varchar(100) NOT NULL  
  , [Address] nvarchar(1024) NOT NULL  
  , [AnnualSalary] decimal (10,2) NOT NULL  
  , [ValidFrom] datetime2 (2) GENERATED ALWAYS AS ROW START  
  , [ValidTo] datetime2 (2) GENERATED ALWAYS AS ROW END  
  , PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)  
 )    
 WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.TrabajadorHistory));
 
 insert into Trabajador(EmployeeID, Name, Position,Department,
 Address, AnnualSalary)   values('1190',
 'Reynaldo Castaño','Docente Titular 140','Informatica','Managua',
 520000)

 select * from Trabajador

 insert into Trabajador(EmployeeID, Name, Position,Department,
 Address, AnnualSalary)   values('1184',
 'Evelyn Espinoza','Docente Titular 140','Informatica','Managua',
 550000)

 update Trabajador set AnnualSalary=600000 where EmployeeID='1190'

 select * from TrabajadorHistory

  update Trabajador set AnnualSalary=800000 where EmployeeID='1190'


  --tabla temporal cliente

  create table dbo.Cliente(
  Id_Cliente int not null primary key clustered,
  PNC nvarchar(15) not null,
  SNC nvarchar(15),
  PAC nvarchar(15) not null,
  SAC nvarchar(15),
  DirC nvarchar(75) not null,
  Id_Mun int foreign key references Municipios(Id_Mun),
  TelC char(8) check(TelC like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  EstadoC bit default 1 not null,
  Id_Facultad char(3) foreign key references Facultad(Id_Facultad),
  ValidFrom datetime2 (2) GENERATED ALWAYS AS ROW START,
  ValidTo datetime2 (2) GENERATED ALWAYS AS ROW END,
  Period For System_Time (ValidFrom, ValidTo)
  )
  with(System_Versioning = on(History_Table = dbo.ClienteHistory))

  insert into Cliente(Id_Cliente, PNC, SNC, PAC, SAC, DirC, TelC, EstadoC,Id_Facultad)
  values ('01', 'Luis', 'Fernando', 'Flores', '', 'El Salvador', '83123135', 1, '01')

  select * from Cliente

  update Cliente set Id_Mun = 1 where Id_Cliente = 1

  select * from ClienteHistory

  drop table Clientes

  create table dbo.Proveedor(
  Id_Prov int not null primary key clustered,
  NombreProv nvarchar(35) not null,
  DirProv nvarchar(70) not null,
  Id_Mun int foreign key references Municipios(Id_Mun),
  TelC char(8) check(TelC like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  EstadoC bit default 1 not null,
  Id_Facultad char(3) foreign key references Facultad(Id_Facultad),
  ValidFrom datetime2 (2) GENERATED ALWAYS AS ROW START,
  ValidTo datetime2 (2) GENERATED ALWAYS AS ROW END,
  Period For System_Time (ValidFrom, ValidTo)
  )
  with(System_Versioning = on(History_Table = dbo.ClienteHistory))

  d