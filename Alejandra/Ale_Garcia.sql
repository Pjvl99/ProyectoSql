drop database EjemploCarros;
use proyecto2;
select*from caja;
select*from compras;
select*from Productos;
select*from ventas;

#Vista de la disponiblidad de Collares y sus precios segun el diseño
drop view if exists Collares;
create view Collares as 
select Productid, Tipo, Producto, Cantidad, Preciounitario from Productos 
where Tipo = "Collar"; 

select * from Collares;

#Vista de la disponiblidad de Pulseras y sus precios segun el diseño
drop view if exists Pulseras;
create view Pulseras as 
select Productid, Tipo, Producto, Cantidad, Preciounitario from Productos 
where Tipo = "Pulsera"; 

select * from Pulseras;

#Vista de la disponiblidad de Pulseras y sus precios segun el diseño
drop view if exists Aretes;
create view Aretes as 
select Productid, Tipo, Producto, Cantidad, Preciounitario from Productos 
where Tipo = "Aretes"; 

select * from Aretes;

#Vista de la disponiblidad de Llaveros y sus precios segun el diseño
drop view if exists Llaveros;
create view Llaveros as 
select Productid, Tipo, Producto, Cantidad, Preciounitario from Productos 
where Tipo = "Llavero"; 

select * from Llaveros;

#Vista de la disponiblidad de Adornos y sus precios segun el diseño
drop view if exists Adornos;
create view Adornos as 
select Productid, Tipo, Producto, Cantidad, Preciounitario from Productos 
where Tipo = "Adorno"; 

select * from Adornos;

#Sirve para calcular la diferencia entre Ingresos y Egresos
alter table caja
add Saldo int(15) generated always as (caja.Ingresos - caja.Egresos);

#Sirve para ver si hubo pérdida en el día
alter table caja
add TipoSaldo varchar(15) generated always as (if(Saldo < 0, "Pérdida", ""));


#Vista que muestra los las fechas (por día) en las que se registró pérdida  
Drop View if exists Fechas_Con_Pérdida;

Create View Fechas_Con_Pérdida As
Select Fecha, Saldo From caja Where Saldo < 0;

Select * From Fechas_Con_Pérdida;

#Sirve calcular los ingresos estimados (considerando la cantidad de unidades disponibles y el precio unitario del producto)
alter table Productos
add Ingresos_Estimados int generated always as (Productos.Cantidad * Productos.Preciounitario);


#Vista que muestra los ingresos netos por mes de la empresa para 2021
Drop View if exists Ingresos_Netos_Mes_2021;

Create View Ingresos_Netos_Mes_2021 as
Select Month(Fecha) As Mes, Sum(Saldo) As Ingresos From caja 
Where Year(Fecha) = "2021" Group By Month(Fecha); 

Select*From Ingresos_Netos_Mes_2021;

