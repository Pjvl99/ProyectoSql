
Use proyecto2;

Create table Productos(
Productid varchar(10),
Producto varchar(100) Primary Key,
Cantidad int,
Tipo Varchar(100),
Preciounitario real,
Existencia varchar(3) Not null, check(Existencia = 'No' or Existencia = 'Si'));

Create table ventas(
Salesid varchar(10) Primary Key,
Fecha_Venta Date not null,
Cliente varchar(100) not null,
Cantidad int,
Producto varchar(100),
Total real not null,
Metodo_Pago varchar(100) not null,
Foreign Key(Producto) references Productos(Producto));


Create table compras(
id varchar(10) Primary key,
Producto varchar(100),
Cantidad int,
Fecha date,
Total real,
Foreign key (Producto) references Productos(Producto));

Create table caja(
Fecha date,
Ingresos real,
Egresos real);
