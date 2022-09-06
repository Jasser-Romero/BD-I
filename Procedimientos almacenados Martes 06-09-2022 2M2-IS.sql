use SFCIB

-- Procedimiento Almacenado
-- CRUD: Ingresar, Dar baja, modificar,
-- buscar y listar
select * from Deptos

alter table Deptos add EstadoD bit default 1

update Deptos set EstadoD=1

create procedure NDpto
@ND nvarchar(48)
as
declare @nde as nvarchar(48)
set @nde=(select NombreDpto from Deptos
where NombreDpto=@ND)
if(@ND='')
begin
  print 'No puede ser nulo'
end
else
begin
  if(@ND=@nde)
  begin
    print 'Dpto duplicado'
  end
  else
  begin
    insert into Deptos values(@ND,1)
  end
end

select * from Deptos

NDpto 'Leon'

--Dar baja
create procedure BDpto
@ID int
as
declare @iddept as int
set @iddept=(select Id_Dptos from Deptos where Id_Dptos=@ID)
if(@iddept=@ID)
begin
  update Deptos set EstadoD=0 where Id_Dptos=@ID
end
else
begin
  print 'Dpto no encontrado'
end

BDpto 4

select * from Deptos

-- Insercion Municipios
create procedure NMun
@NM nvarchar(45),
@IDD int
as
declare @iddept as int
set @iddept=(select Id_Dptos from Deptos where Id_Dptos=@IDD)
if(@NM='')
begin
  print 'No puede ser nulo'
end
else
begin
  if(@IDD=@iddept)
  begin
    insert into Municipios values(@NM,@IDD)
  end
  else
  begin
    print 'Dpto no registrado'
  end
end

select * from Municipios

NMun 'Leon',4

-- Buscar Depto
create procedure BuscarD
@ID int
as
declare @idd as int
set @idd=(select Id_Dptos from Deptos where Id_Dptos=@ID)
if(@ID=@idd)
begin
  select * from Deptos where Id_Dptos=@ID
end
else
begin
  print 'Depto no encontrado'
end

BuscarD 2

--Listar Deptos
create procedure ListarD
as
select * from Deptos where EstadoD=1

ListarD

-- Modificacion o Actualizacion
create procedure MDpto
@ID int,
@ND nvarchar(48)
as
declare @idd as int
set @idd=(select Id_Dptos from Deptos where Id_Dptos=@ID)
if(@idd=@ID)
begin
  if(@ND='')
  begin
    print 'No puede ser nulo'
  end
  else
  begin
    update Deptos set NombreDpto=@ND where Id_Dptos=@ID and EstadoD=1
  end
end
else
begin
  print 'Dpto no encontrado'
end

MDpto 4,'Matagalpa'

select * from Deptos

backup database SFCIB to disk='D:\SFCIB.bak'