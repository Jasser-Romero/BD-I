CREATE TABLE ValueTable (id INT);  
BEGIN TRANSACTION;  
       INSERT INTO ValueTable VALUES(1);  
       INSERT INTO ValueTable VALUES(2);  
COMMIT;  

select * from ValueTable

use Northwind

select * from Region

insert into Region values(5, 'Atlantico Norte'),
(6,'Caribe sur')

BEGIN TRANSACTION;  
DELETE FROM Region  
    WHERE RegionID = 5;  
COMMIT;  

-- Tabla Cuentas(Corriente(Cordobas-Dolares), Ahorro
-- (Cordobas-Dolares))
-- CuentaHabiente(Natural, Juridico)
-- Movimientos de Cuentas(Fecha, Tipo Movimiento(Deposito,
-- Retiro, Pago,  Debito automatico, Transferencias(al mismo banco,
-- ACH)), Monto, Saldo)
-- Consulta Estado de Cuenta
-- Implementar a parte de todo lo abordado
-- Tran explicitas.
-- 

