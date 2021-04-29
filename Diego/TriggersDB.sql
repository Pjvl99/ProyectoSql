Use proyecto2;
DROP TRIGGER IF EXISTS Verificarcantidad;
DELIMITER ##
CREATE TRIGGER Verificarcantidad BEFORE INSERT ON ventas FOR EACH ROW
BEGIN 
	Declare Producto INT;
    Declare unidades int;
	Declare Mensaje TEXT;
	Select Salesid into Producto From ventas;
	Select Cantidad into unidades from Producto where Salesid = Producto;
	if(unidades<new.Cantidad) then
		Set Mensaje = CONCAT("No se cuentan con suficientes unidades ", Producto);
		Signal SQLState '45000'
		Set MESSAGE_TEXT = Mensaje;
	End If;
END ##
DELIMITER ;

DROP TRIGGER IF EXISTS actualizarprecio;
DELIMITER ##
CREATE TRIGGER actualizarprecio 
    BEFORE UPDATE ON Productos
    FOR EACH ROW
BEGIN
 INSERT INTO Productos
 SET action = 'update',
     new.Preciounitario = new.Preciounitario;
END ##
DELIMITER ;

DROP TRIGGER IF EXISTS Productosinstock;
CREATE TRIGGER Productosinstock
AFTER DELETE
ON Productos FOR EACH ROW
UPDATE Cantidad 
SET total = total - old.Cantidad;
