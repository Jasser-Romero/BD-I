use SFCIB

select * from Compras
select * from Pedidos
select * from Proveedor

create procedure NPedido
@IDP int
as
declare @idprov as int
set @idprov=(select Id_Prov from
Proveedor where Id_Prov=@IDP)
if(@idprov=@IDP)
begin
  insert into Pedidos values(getdate(),
  @IDP,0,0,1)
end
else
begin
  print 'Provedor no registrado'
end

NPedido 1

select * from Pedidos

create trigger ActP
on Det_Pedidos
after insert
as
  

  update Pedidos set SubTotalP=(select sum(subtp)
  from inserted),TotalP=((select sum(subtp) from inserted)*1.15) from Pedidos pe, Det_Pedidos
  dp where pe.Id_Pedido=dp.Id_Pedido


create procedure NDPe
@IDP int,
@CP char(5),
@cpe int,
@pp float
as
declare @idpe as int
set @idpe=(select Id_Pedido from Pedidos where
Id_Pedido=@IDP)
declare @codp as char(5)
set @codp=(select CodProd from Productos where
CodProd=@CP)
if(@idpe=@IDP)
begin
  if(@CP='')
  begin
    print 'No puede ser nulo'
  end
  else
  begin
    if(@CP=@codp)
	begin
	  if(@cpe>0 and @pp>0)
	  begin
	    insert into Det_Pedidos values(@IDP,@CP,
		@cpe,(@cpe*@pp),@pp)
	  end
	  else
	  begin
	     print 'Cantidad y precio no pueden ser - ni 0'
	  end
	end
	else
	begin
	  print 'Producto no registrado'
	end
  end
end
else
begin
  print 'Pedido no registrado'
end

select * from Productos

NDPe 1,'04',5,20

select * from Det_Pedidos
select * from Pedidos

create procedure NCompra
@IDC char(5),
@FC datetime,
@IDP int
as
declare @idco as char(5)
set @idco=(select Id_Compras from Compras
where Id_Compras=@IDC)
declare @idped as int
set @idped=(select Id_Pedido from Pedidos
where Id_Pedido=@IDP)
if(@IDC='')
begin
  print 'Compra no puede ser nula'
end
else
begin
   if(@idco=@IDC)
   begin
     print 'Compra ya registrada'
   end
   else
   begin
     if(@idped=@IDP)
	 begin
	   insert into Compras values(@IDC,
	   @FC,@IDP,0,0)
	 end
	 else
	 begin
	   print 'Pedido no registrado'
	 end
   end
end

create trigger ActInvC
on Det_Compras
after insert
as  
  declare @cp as float
  set @cp=(select CodProd from inserted)

  declare @pp as float
  set @pp=(select preciop from Productos
  where CodProd=@cp)

  declare @pc as float
  set @pc=(select precioc from inserted)

  update Compras set subtotalc=(select sum(subtcom)
  from inserted),totalc=((select sum(subtcom) from inserted)*1.15) from Compras c, Det_Compras
  dc where c.Id_Compras=dc.Id_Compras

  update Productos set existp=existp +
  (select cantc from inserted) from inserted dc,
  Productos p where p.CodProd=dc.CodProd

  if(@pp>=@pc)
  begin
    update Productos set preciop=@pc*1.1
	where Productos.CodProd=@cp

  end
  

create procedure NDC
@IDC char(5),
@CP char(5),
@cc int,
@pc float
as
declare @idco as char(5)
set @idco=(select Id_Compras from
Compras where Id_Compras=@IDC)
declare @codp as char(5)
set @codp=(select CodProd from Productos
where CodProd=@CP)
if(@IDC=@idco)
begin
  if(@CP=@codp)
  begin
    if(@pc>0 and @cc>0)
	begin
	  insert into Det_Compras values(@IDC,
	  @CP, @cc,@pc,(@pc*@cc))
	end
	else
	begin
	  print 'Precio y cantidad no pueden ser - ni 0'
	end
  end
  else
  begin
     print 'Producto no registrado'
  end
end
else
begin
   print ' Compra no registrada'
end

backup database SFCIB to disk='D:\SFCIB.bak'
  
  
