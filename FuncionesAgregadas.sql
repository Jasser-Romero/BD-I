--Funciones agregadas
-- sum, count, avg, min, max, var, stdev

select count(CodProd) as CantReg,
sum(existp) as CantP, avg(preciop) as PrecioProm,
min(preciop) as PrecioMin, max(preciop) as PrecioMax,
var(preciop) as VarianzaP, stdev(preciop) as DesvP from Productos

create view FAgregadas as
select count(CodProd) as CantReg,
sum(existp) as CantP, avg(preciop) as PrecioProm,
min(preciop) as PrecioMin, max(preciop) as PrecioMax,
var(preciop) as VarianzaP, stdev(preciop) as DesvP from Productos

select * from FAgregadas

-- Funciones Standard del sistema
-- 1.- Fecha/Hora
-- 1.1.- getdate(): Retorna la fecha y la hora del sistema

select getdate() as FechaHoraActual

-- 1.2.- Year(): Retorna la fecha y la hora del sistema
select year(GETDATE()) as AñoActual,
year('19710619') as MiAñoNac

--1.2.- Month(): Retorna el mes de una fecha
select month(getdate()) as MesActual,
month('19710619') as MiMesNac

--1.3.- Day(): Retorna el dia de una fecha
select day(getdate()) as DiaActual,
day('19710619') as MiDiaNac

--1.5.- datediff():  Diferenciar fechas
select DATEDIFF(year,'19710619', getdate()) as EdadA,
DATEDIFF(month, '19710619', getdate()) as EdadM,
DATEDIFF(week, '19710619', getdate()) as EdadS,
DATEDIFF(day, '19710619', getdate()) as EdadD,
DATEDIFF(hour, '19710619', getdate()) as EdadH

--1.6.- dateadd(): Sumar fechas
select dateadd(day, 10, getdate()) as DiezDD

--1.7.- datename()
Select DATENAME(year, getdate()) as AñoActual,
DATENAME(month, getdate()) as MesActual,
DATENAME(day, getdate()) as DiaActual,
DATENAME(DAYOFYEAR, getdate()) as DiaDelAño,
DATENAME(WEEKDAY, getdate()) as DiaSemana

--1.8.- datepart()
select DATEPART(year, getdate()) as AñoActual

--2.- Cadena
-- 2.1.- len(): Devuelve la longitud de una cadena
select len(NombreProd) as LNP from Productos

-- 2.2.- Char(): Devuelve el caracter a partir de su codigo ascii
select char(209) as Caract

-- 2.3.- ASCII(): Devuelve el codigo ASCII de un caracter
select ascii('Ñ') as ValorAscii

-- 2.4.- lower(): Transforma una cadena a minuscula
select lower('LUIS FERNANDO') as Minus

--2.5.- upper(): Transforma una cadena a mayuscula
select upper('luis fernando') as Mayus

--2.6.- substring(): Abstraer una subcadena de una cadena
select SUBSTRING('2025-0988U', 6, 5) as Num,
SUBSTRING('001-021280-1015F', 5, 6) as FechNac

--2.7.- charindex(): Coincidencia a partir de un indice
DECLARE @document VARCHAR(64);  
SELECT @document = 'Reflectors are vital safety' +  
                   ' components of your bicycle.';  
SELECT CHARINDEX('bicycle', @document) as Indice

--2.8.- concat(): Concatenar cadenas
SELECT CONCAT ( 'Happy ', 'Birthday ', 11, '/', '25' ) AS Result

--2.9.- reverse(): Revierte una cadena
select reverse('Luis') as NomInvert

--2.10.- left(): Valores a partir de una posicion izquierda
select left('Msc. en computacion',8) as ParteIzq

--2.11.- right(): Valores a partir de una posicion derecha
select right('Msc. en computacion',8) as ParteDer

--2.12.- LTrim(): Elimina espacios en blanco a la izquierda
SELECT LTRIM('     Five spaces are at the beginning of this string.') as EnunciadoIzq

--2.13.- RTrim(): Elimina espacios en blanco a la derecha
SELECT RTRIM('Removes trailing spaces.   ') as EnunciadoDer

--3.- Convertir
--Cast, Convert, Parse, Try_Parse, Try_Convert, Try_Cast

--3.1- Cast
declare @año as int
set @año=(select cast(substring('001-021280-1015F', 9, 2) as int) as AñoNac)
print @año

--3.2.- Convert
declare @año2 as int
set @año2=(select convert(int, substring('001-021280-1015F', 9, 2)) as AñoNac)
print @año2

--3.3.- Parse
SELECT PARSE('Monday, 13 December 2010' AS datetime2 USING 'en-US') AS Result