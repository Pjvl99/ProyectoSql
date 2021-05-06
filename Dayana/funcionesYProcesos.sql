# Función que muestra el producto más vendido en un mes
Use proyecto2;

Drop function if exists Mas_vendido;
Delimiter $$
Create Function Mas_Vendido(Fecha Date)
Returns Int
deterministic begin
	Declare Producto_Mas_Vendido Int Default 0;
    Declare MesDespues Date Default date_add(Fecha, interval 1 month);
    If Exists(SELECT *FROM ventas WHERE Fecha < MesDespues)Then
    SELECT  MAX(cantidad) into Producto_Mas_Vendido FROM Ventas
	Where Fecha < MesDespues;
End If;
    Return Producto_Mas_Vendido;
    End $$
Delimiter $$
#####################################################

# Funcion para mantener sencillo o que cantidad de efectivo deberiamos manejar para dar vuelto
Drop function if exists Metodo_mas_usado;
Delimiter $$
Create Function Metodo_mas_usado(Fecha Date)
Returns Int
deterministic begin
	Declare Resu Int Default 0;
	Declare MesDespues Date Default date_add(Fecha, interval 1 month);
    If Exists(SELECT *FROM ventas WHERE Fecha < MesDespues)Then
    SELECT Distinct Count(Metodo_Pago) into Resu FROM Ventas
    Where Fecha < MesDespues;
End If;

    Return Resu;
    End $$
Delimiter $$

############################################################################

# Funcion si existe un producto en especifico 
 
Delimiter $$
Create Function Cantidad_de_Productos(ProductoExistente VarChar (100)) 
Returns Bool
deterministic begin
	Declare CantidadProducto Bool;
    If Exists(SELECT *FROM productos WHERE Existencia = "Si" and ProductoExistente = Producto) then 
    CantidadProducto = True
    else CantidadProducto = False
End If;
    Return CantidadProducto;
    End 
Delimiter $$
###############################################################################

#Procedimiento que sugiere realizar un descuento al cliente que pague con Tarjeta de crédito

Drop Procedure If Exists Descuentos;
Delimiter $$
Create Procedure Descuentos (Fecha Date)
Begin
Select Cliente, Total From Ventas Where Metodo_Pago = "Tarjeta de credito"
Group by Cliente;
End $$
Delimiter ;


############################################################################
#Procedimiento que indica cual tipo de producto fue el menos vendido para hacer alguna promocion del mismo
#muestra la suma de las ventas por tipo
Drop Procedure If Exists Ofertas;
Delimiter $$
Create Procedure Ofertas (Fecha Date)
Begin
Declare MesDespues Date Default date_add(Fecha, interval 1 month);
Select Productos.Tipo, Sum(Ventas.Total) From Ventas inner Join Productos on Productos.Producto = Ventas.Producto
Where Fecha < MesDespues
Group by Tipo;
End $$
Delimiter ;

###################################
#Procedimiento que me muestre el cliente mas frecuente del ano
Delimiter $$
Create Procedure ClienteFrecuente (Fecha Date)
Begin 
Declare AnoDespues Date Default date_add(Fecha, interval 1 year);
Select Count(Cliente) AS ClienteFrecuente FROM Ventas
Where Fecha < AnoDespues
Group by Cliente;
End $$
Delimiter ;

############################################################################










