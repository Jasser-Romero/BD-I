-- CURSORES
use SFCIB

select * from Clientes

DECLARE ClientesL CURSOR  
    FOR SELECT * FROM Clientes  
OPEN ClientesL  
FETCH NEXT FROM ClientesL  

select * from Municipios

SET NOCOUNT ON  
  
DECLARE @Id_Mun INT, @NombreMun NVARCHAR(50)  
  
PRINT '-------- Lista de Municipios --------'  
  
DECLARE M CURSOR FOR   
SELECT Id_Mun, NombreMun  
FROM Municipios  

  
OPEN M
  
FETCH NEXT FROM M   
INTO @Id_Mun, @NombreMun  
  
WHILE @@FETCH_STATUS = 0  
BEGIN  
    PRINT ' '  
    SELECT NombreMun from Municipios 
  
        -- Get the next vendor.  
    FETCH NEXT FROM M 
    INTO @Id_Mun, @NombreMun  
END   
CLOSE M  
DEALLOCATE M 

select @@SERVERNAME as Nombre_Servidor,
@@SERVICENAME as Nombre_Servicio