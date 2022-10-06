--Cursor actualizar precio

--Actualizar precio
declare @CodProd 

declare ActPrecio cursor
	for select preciop, precioc from Productos p, Det_Compras dc
	where p.CodProd = dc.CodProd

drop ActPrecio
open ActPrecio
Fetch next from ActPrecio

--open ActPrecio

--Fetch next from ActPrecio
--Into @CodProd

create procedure UpdtPrecios
@CP char(5),
@PC float,
@PP float
as
declare @codprod as char(5)
set @codprod = (select CodProd from Productos where CodProd = @CP)
if (@PP <= 0 or @PC <= 0)
begin
	print 'El valor no puede ser menor o igual a 0'
end
else
begin
	if (@CP = @codprod)
	begin
		if(@PC > @PP)
		begin
			set nocount on


		end
		else
		begin
			print 'El precio del producto no se actualizara'
		end
	end
	else
	begin
		print 'No se encontro el producto'
	end
end