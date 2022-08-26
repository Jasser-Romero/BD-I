use SFCIB

select * from Deptos

insert into Deptos values('Managua'),('Masaya'),
('Granada')

select * from Municipios

insert into Municipios values('Ciudad Sandino',1),
('Tipitapa',1),('Nindiri',2),('Veracruz',2),
('Diria',3),('Nandaime',3)

select * from Proveedor

insert into Proveedor values('Bimbo','Carretera Masaya',
'22556545',1,1),('Femsa','Carretera Norte','85745421',
1,1)

select * from Productos

insert into Productos values('01','Bimbolete','Pan dulce',
20,12,1,1),('02','Pinguino','Dulce',30,10,1,1),
('03','Coca cola 12 onzas','gaseosa',15,24,1,2),
('04','HiC te','te',20,48,1,2)

--ALGEBRA RELACIONAL

-- OPERACIONES CONJUNTISTA
--1.- UNION
-- A: Proveedor B: Productos
-- A U B
select NombreProv, DirProv, TelProv, EstadoProv,
Id_Mun, CodProd, NombreProd, DescProd, preciop,
existp, EstadoProd from Proveedor full join
Productos on Proveedor.Id_Prov=Productos.Id_Prov

create view EjUnion
as
select NombreProv, DirProv, TelProv, EstadoProv,
Id_Mun, CodProd, NombreProd, DescProd, preciop,
existp, EstadoProd from Proveedor full join
Productos on Proveedor.Id_Prov=Productos.Id_Prov

select * from EjUnion

--2.- Intercepcion
-- A: Proveedor B: Productos
-- A ? B
select NombreProv, DirProv, TelProv, NombreProd,
DescProd, preciop, existp from Proveedor inner join
Productos on Proveedor.Id_Prov=Productos.Id_Prov

create view EjInt
as
select NombreProv, DirProv, TelProv, NombreProd,
DescProd, preciop, existp from Proveedor inner join
Productos on Proveedor.Id_Prov=Productos.Id_Prov

select * from EjInt

-- OPERACIONES RELACIONALES
--1.- PROYECCION
-- A: Proveedor B: Productos
-- ?<NombreProd, preciop, existp>(Productos)
select NombreProd,preciop,existp from Productos

create view Ej1Proy
as
select NombreProd, preciop, existp from Productos

select * from Ej1Proy

-- ?<NombreProv,NombreProd, preciop, existp>(Proveedor-Productos)
select NombreProv, NombreProd, preciop, existp from Proveedor
inner join Productos on Proveedor.Id_Prov=Productos.Id_Prov

create view Ej2ProynT
as
select NombreProv, NombreProd, preciop, existp from Proveedor
inner join Productos on Proveedor.Id_Prov=Productos.Id_Prov

select * from Ej2ProynT

--2.- SELECCION
-- A: Proveedor B: Productos
-- ?<preciop>=10 y preciop<=25>(Productos)

select * from Productos where preciop between 10 and 25

create view EjSels
as
select * from Productos where preciop between 10 and 25

select * from EjSels

--3.- SELECCION COMBINADA CON PROYECCION
-- A: Proveedor B: Productos
-- ?<NombreProv, NombreProd, preciop>(?<preciop>=10 y preciop<=25>
-- (Productos))(Proveedor-Productos)

select NombreProv, NombreProd, preciop from 
Proveedor inner join Productos on Proveedor.Id_Prov=Productos.Id_Prov
where preciop between 10 and 25

create view CombPS as
select NombreProv, NombreProd, preciop from 
Proveedor inner join Productos on Proveedor.Id_Prov=Productos.Id_Prov
where preciop between 10 and 25

select * from CombPS

--4.- REUNION THETA
-- A: Proveedor B: Productos
-- R<A ? B>
select NombreProv, NombreProd, preciop from Proveedor inner join
Productos on Proveedor.Id_Prov=Productos.Id_Prov

create view EjRT
as
select NombreProv, NombreProd, preciop from Proveedor inner join
Productos on Proveedor.Id_Prov=Productos.Id_Prov

select * from EjRT

--5.- EQUIREUNION
-- A: Productos
select NombreProd,preciop from Productos where preciop=20

create view EjEQR
as
select NombreProd,preciop from Productos where preciop=20

select * from EjEQR