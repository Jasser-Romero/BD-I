create function CifradoPlayfair(
@entrada nvarchar(max),
@clave nvarchar(25))
returns nvarchar(max)
as
begin
--El primer paso es suprimir los espacios en blanco y opcionalmente pasamos la frase y 
-- clave a mayusculas.
SELECT @entrada = REPLACE(@entrada,' ','')
SET @entrada = UPPER(@entrada)
SELECT @clave = REPLACE(@clave,' ','')
SET @clave=UPPER(@clave)
declare @SalidaEncriptada as nvarchar(max)
--Seguidamente generamos los poligramas aplicando las reglas y los almacenamos en una 
-- variable de tabla.
DECLARE @poligrama TABLE(Idp INT IDENTITY(1,1), par NVARCHAR(2) NOT NULL)
DECLARE @tam int,@pos INT
SET @tam=LEN(@entrada)
SET @pos=1
WHILE @pos<=@tam
BEGIN
 IF (@pos+1)>@tam
  INSERT INTO @poligrama(par)VALUES(SUBSTRING (@entrada,@pos,1)+'X')
 ELSE
  IF SUBSTRING (@entrada,@pos,1)=SUBSTRING (@entrada,@pos+1,1)
   INSERT INTO @poligrama(par)VALUES(SUBSTRING (@entrada,@pos,1)+'X')
  ELSE
   INSERT INTO @poligrama(par)VALUES(SUBSTRING (@entrada,@pos,2))
 SET @pos=@pos+2
END
-- Ahora procederemos aplicamos la regla a la contraseña eliminaremos los caracteres repetidos.
DECLARE @claveReducida NVARCHAR(25)
SET @tam=LEN(@clave)
SET @pos=1
SET @claveReducida=''
WHILE @pos<=@tam
BEGIN
 IF CHARINDEX(SUBSTRING(@clave,@pos,1),@claveReducida)=0
  SET @claveReducida=@claveReducida+SUBSTRING(@clave,@pos,1)
  SET @pos = @pos +1
END
--El siguiente paso es crear la matriz de encriptación (de intercambio) de caracteres.
--Los primeros elementos de la matriz deben ser los caracteres de la clave:
DECLARE @Matriz TABLE (FILA TINYINT, COLUMNA TINYINT, LETRA NVARCHAR(1))
DECLARE @fmz TINYINT, @cmz TINYINT
SET @pos = 1
SET @tam = LEN(@claveReducida)
SET @fmz=1
WHILE @fmz<=5 AND @pos<=@tam
BEGIN
 SET @cmz=1
 WHILE @cmz<=5 AND @pos<=@tam
 BEGIN
  INSERT INTO @Matriz(FILA, COLUMNA, LETRA)
  VALUES(@fmz,@cmz,SUBSTRING(@claveReducida,@pos,1))
  SET @pos = @pos + 1
  SET @cmz= @cmz + 1
 END
 SET @fmz= @fmz + 1
END
-- Debe completarse la fila inconclusa con caracteres del alfabeto que no esten en la clave.
--GENERAR EL ALFABETO
DECLARE @iL tinyint, @MaxiL tinyint
--MAYUSCULAS
SET @iL = 65
SET @MaxiL = 90
--minusculas
--SET @iL = 97
--SET @MaxiL = 122
WHILE @cmz<=5
BEGIN
 WHILE @iL <= @MaxiL AND @cmz<=5
 BEGIN
  IF CHAR(@iL) <> 'J' AND NOT EXISTS(SELECT * FROM @Matriz m WHERE m.LETRA = CHAR(@iL))
  BEGIN
   INSERT INTO @Matriz(FILA, COLUMNA, LETRA)
   VALUES(@fmz,@cmz,CHAR(@iL))
   --
   SET @cmz= @cmz + 1
  END
  SET @iL = @iL + 1
 END
END
-- Una vez hecho esto se completa la matriz al igual que el caso anterior excluyendo las J
WHILE @fmz<=5 AND (@iL<=@MaxiL)
BEGIN
 SET @cmz=1
 WHILE @cmz<=5 AND (@iL<=@MaxiL)
 BEGIN
  IF CHAR(@iL) <> 'J' AND NOT EXISTS(SELECT * FROM @Matriz m WHERE m.LETRA = CHAR(@iL))
  BEGIN
   INSERT INTO @Matriz(FILA, COLUMNA, LETRA)
   VALUES(@fmz,@cmz,CHAR(@iL))
   --
   SET @cmz= @cmz + 1
  END
 --
  SET @iL = @iL + 1
 END
 SET @fmz= @fmz + 1
END
--Ahora que se ha construido la matriz procedemos al intercambio de caracteres aplicando las reglas:
DECLARE @pgCount INT,@pgRow INT, @fila1 TINYINT, @fila2 TINYINT, @columna1 TINYINT, @columna2 TINYINT, @temp TINYINT
DECLARE @car1 NVARCHAR(1), @car2 NVARCHAR(1),@ncar1 NVARCHAR(1),@ncar2 NVARCHAR(1)
 
SELECT @pgCount = COUNT(*) FROM @poligrama p
SET @pgRow = 1
SET @SalidaEncriptada = ''
 
WHILE @pgRow <= @pgCount
BEGIN
 --obtener los caracteres
 SELECT @car1 = SUBSTRING(p.par,1,1),@car2=SUBSTRING(p.par,2,1) FROM @poligrama p
 WHERE p.Idp = @pgRow
 --sustituir j por i
 
 if @car1 = 'J'
 SET @car1 = 'I'
 if @car2 = 'J'
 SET @car2 = 'I'
 
 --obtener la posicion de los caracteres en la matriz
 SELECT @fila1=m.FILA, @columna1 = m.COLUMNA FROM @Matriz m WHERE m.LETRA = @car1;
 SELECT @fila2=m.FILA, @columna2 = m.COLUMNA FROM @Matriz m WHERE m.LETRA = @car2;
 --APLICAR REGLAS
 IF @fila1=@fila2 --misma fila
 BEGIN
  IF @columna1<5
  BEGIN
   SET @columna1 = @columna1 +1
  END
  ELSE
  BEGIN
   SET @columna1 = 1
  END
 --
  IF @columna2<5
  BEGIN
   SET @columna2 = @columna2 +1
  END
  ELSE
  BEGIN
   SET @columna2 = 1
  END
 END
ELSE
BEGIN
 IF @columna1=@columna2 -- misma columna
 BEGIN
  IF @fila1<5
  BEGIN
   SET @fila1 = @fila1 +1
  END
  ELSE
  BEGIN
   SET @fila1 = 1
  END
  --
  IF @fila2<5
  BEGIN
   SET @fila2 = @fila2 +1
  END
  ELSE
  BEGIN
   SET @fila2 = 1
  END
 END
 ELSE
  BEGIN
   SET @temp = @columna1
   SET @columna1 = @columna2
   SET @columna2 = @temp
  END
END
--Obtener caracter 1
SELECT @ncar1=m.LETRA FROM @Matriz m WHERE m.FILA = @fila1 AND m.COLUMNA = @columna1;
--Obtener caracter 2
SELECT @ncar2=m.LETRA FROM @Matriz m WHERE m.FILA = @fila2 AND m.COLUMNA = @columna2;
 


SET @SalidaEncriptada = @SalidaEncriptada + @ncar1 + @ncar2
SET @pgRow = @pgRow + 1
END
RETURN @SalidaEncriptada
end

-- Ahora probamos

create procedure Ejecutar
as
declare @resultado as nvarchar(max)
set @resultado=dbo.CifradoPlayfair('ATAQUE CERO HORAS','NORIA') 
print @resultado 

Ejecutar

